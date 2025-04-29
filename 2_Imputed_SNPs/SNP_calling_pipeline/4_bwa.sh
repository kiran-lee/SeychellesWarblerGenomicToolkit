#!/bin/bash

#SBATCH --job-name=Bwa_ragtag
#SBATCH --output=Bwa_ragtag.log
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=4
#SBATCH --mem-per-cpu=2G
#SBATCH --time=372:00:00
#SBATCH --mail-user=kgllee1@sheffield.ac.uk
#SBATCH --mail-type=all
#SBATCH -A molecolb
#SBATCH -p molecolb


source /usr/local/extras/Genomics/.bashrc

mkdir Aligned_ragtag

#cp /fastdata/bop21kgl/genome/ragtag_output/ragtag.scaffold.fasta /fastdata/bop21kgl/April2022/genome/

# index file to be used by bwa
# only need to run once
# bwa index /fastdata/bop21kgl/Genome/ragtag.scaffold.fasta

# align paired reads using bwa mem and output as bam file using samtools
for f in ./Trimmed_seqs/*_trimmed_paired_R1.fastq.gz;
do              FBASE=$(basename $f)
        BASE=${FBASE%_trimmed_paired_R1.fastq.gz}
        bwa mem -t 4 \
                /fastdata/bop21kgl/Genome/ragtag.scaffold.fasta \
                ./Trimmed_seqs/${BASE}_trimmed_paired_R1.fastq.gz \
                ./Trimmed_seqs/${BASE}_trimmed_paired_R2.fastq.gz| \
                samtools sort -o ./Aligned_ragtag/${BASE}_paired.bam
done

# combine single end reads into one file
# align unpaired reads using bwa mem and output as bam file using samtools
# merge paired and unpaired alignments


for f in ./Trimmed_seqs/*_trimmed_unpaired_R1.fastq.gz;
do 		FBASE=$(basename $f)
        BASE=${FBASE%_trimmed_unpaired_R1.fastq.gz}
        zcat ./Trimmed_seqs/${BASE}_trimmed_unpaired_R1.fastq.gz \
	     ./Trimmed_seqs/${BASE}_trimmed_unpaired_R2.fastq.gz > \
	     ./Trimmed_seqs/${BASE}_trimmed_unpaired_both.fastq.gz
        bwa mem -t 4 \
		/fastdata/bop21kgl/Genome/ragtag.scaffold.fasta \
		./Trimmed_seqs/${BASE}_trimmed_unpaired_both.fastq.gz| \
		samtools sort -o ./Aligned_ragtag/${BASE}_unpaired.bam
		samtools merge -@ 4 ./Aligned_ragtag/${BASE}_all.bam \
	        ./Aligned_ragtag/${BASE}_paired.bam \
		./Aligned_ragtag/${BASE}_unpaired.bam
done

