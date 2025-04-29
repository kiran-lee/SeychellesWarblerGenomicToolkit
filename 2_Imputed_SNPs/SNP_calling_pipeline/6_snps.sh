#!/bin/bash

#SBATCH --job-name=SNPs
#SBATCH --output=SNPs.log
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=4
#SBATCH --mem-per-cpu=8GB
#SBATCH --time=200:00:00
#SBATCH --mail-user=kgllee1@sheffield.ac.uk
#SBATCH --mail-type=all
#SBATCH -A molecolb
#SBATCH -p molecolb

source /usr/local/extras/Genomics/.bashrc

## make new directories for vcf file and cleaned file
mkdir VCF

# replace commas in fasta file headers(bcftools has problems with commas )
sed 's/,/_/g' /fastdata/bop21kgl/Genome/ragtag.scaffold.fasta > /fastdata/bop21kgl/Genome/ragtag.scaffold2.fasta

# index genome file for bcftools to use
samtools faidx /fastdata/bop21kgl/Genome/ragtag.scaffold2.fasta

# replace commas in bam files

for f in ./Clean_aligned/*_all_mapped.bam;
do FBASE=$(basename $f)
	BASE=${FBASE%_all_mapped.bam}
	samtools view -H ./Clean_aligned/${BASE}_all_mapped.bam \
	| sed "s/,/_/g" \
	| samtools reheader - ./Clean_aligned/${BASE}_all_mapped.bam \
	> ./Clean_aligned/${BASE}_all_mapped_rehead.bam
done

# Make file of list of bam files
ls ./Clean_aligned/*rehead.bam > ./bamFiles.txt


# run bcftools mpileup
##-Ou: ouput an uncompressed bam file. This is the option to use when piping the output to another command for optimum 
performance/speed.
##–max-depth 10000: the maximum number of sequences considered per position
##-q 20: filter out alignments with mapping quality <20
##-Q 20: filter out bases with QS < 20
##-P ILLUMINA: use Illumina platform for indels
##-a FORMAT/DP,FORMAT/AD: output depth and allelic depth
##-f specify the genome reference file, which must be faidx-indexed
##-b list of input bam alignment files
# pipe output and call snps
##-m: use the multiallelic caller
##-v: output variants only
##-P 1e-6: prior for expected substitution rate
##-f GQ: output genotype quality
##-O b: output in compressed VCF format

bcftools mpileup -Ou \
--max-depth 10000 -q 20 -Q 20 \
-P ILLUMINA -a FORMAT/DP,FORMAT/AD \
-f /fastdata/bop21kgl/Genome/ragtag.scaffold2.fasta \
-b ./bamFiles.txt | \
bcftools call -mv -P 1e-6 -f GQ \
-O z -o ./VCF/SW_ragtag.vcf.gz
