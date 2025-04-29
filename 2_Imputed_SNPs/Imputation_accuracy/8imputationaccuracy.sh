#!/bin/bash

#SBATCH --job-name=multichromosomedownsampledimputationaccuracy
#SBATCH --output=multichromosomedownsampledimputationaccuracy.log
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=4
#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=10G
#SBATCH --time=168:00:00
#SBATCH --mail-user=kgllee1@sheffield.ac.uk
#SBATCH --mail-type=all
#SBATCH --array=1-31%4

#SBATCH -A molecolb
#SBATCH -p molecolb

source ~/.bash_profile

FILES=(stitch*.vcf.gz)
FILE=${FILES[$SLURM_ARRAY_TASK_ID]}
BASENAME="${FILE#*.*}"
PREFIX="${BASENAME%%.*}"
CHROMOSOME="${BASENAME%.vcf*}"
OUTFILE=$(basename ${FILE%.bam}).out

#Prepare test dataset
##Rename downsampled imputed vcf file so as not to confuse it with the non-downsampled imputed vcf file
cp $FILE $PREFIX.downsampled.vcf.gz

##Get list of SNPs from only downsampled imputed vcf chromosome
bcftools index $PREFIX.downsampled.vcf.gz
bcftools query -f '%CHROM\t%POS\n' $PREFIX.downsampled.vcf.gz > snplist$PREFIX

##Subset only best 23 coverage (>8x) individuals from imputed called SNPs
bcftools view $PREFIX.downsampled.vcf.gz -S downsampled2.6 -o $PREFIX.downsampledsubsetted.vcf.gz -O z
bcftools index $PREFIX.downsampledsubsetted.vcf.gz

#Prepare truth dataset
#Subset only best 23 coverage (>8x) individuals from non-imputed called SNPs. Only need to do once, so I have hashed it out.
#bcftools view allplatesmergedextrasamples.vcf.gz -S bestcoverage -o allplatesmergedextrasamplesbestcoverage.vcf.gz -O z
#bcftools index allplatesmergedextrasamplesbestcoverage.vcf.gz

##Subset chromosomes
bcftools view allplatesmergedextrasamplesbestcoverage.vcf.gz -r \
$CHROMOSOME \
-o "allplatesmergedextrasamplesbestcoverage$PREFIX.vcf.gz" -O z

##Subset non-missing SNPs, present in all individuals
bcftools view "allplatesmergedextrasamplesbestcoverage$PREFIX.vcf.gz" -g ^miss > "allplatesmergedextrasamplesbestcoverage$PREFIX.filteredmissing.vcf.gz" -O z
bcftools index "allplatesmergedextrasamplesbestcoverage$PREFIX.filteredmissing.vcf.gz"

##Subset for SNPs that got imputed
bcftools view -T "snplist$PREFIX" "allplatesmergedextrasamplesbestcoverage$PREFIX.filteredmissing.vcf.gz" > "allplatesmergedextrasamplesbestcoverage$PREFIX.filteredmissingrefiltered.vcf.gz" -O z
bcftools index "allplatesmergedextrasamplesbestcoverage$PREFIX.filteredmissingrefiltered.vcf.gz"

##Subset test dataset for SNPs that were non-missing in truth set
bcftools query -f '%CHROM\t%POS\n' "allplatesmergedextrasamplesbestcoverage$PREFIX.filteredmissingrefiltered.vcf.gz" > truthsnplist$PREFIX
bcftools view -T "truthsnplist$PREFIX" $PREFIX.downsampledsubsetted.vcf.gz > $PREFIX.downsampledsubsettedrefiltered.vcf.gz -O z
bcftools index "$PREFIX.downsampledsubsettedrefiltered.vcf.gz"

##Make a sample comparison file for bcftools gtcheck. Only need to do once.
#bcftools query -l allplatesmergedextrasamplesbestcoverage$PREFIX.filteredmissingrefiltered.vcf.gz
#bcftools query -l $PREFIX.downsampledsubsetted.vcf.gz 
##Put these outputs into a tab separated list called gtchecksamples (see bcftools documentation). I did this manually.

#Check discordance using bcftools gtcheck
bcftools gtcheck -P gtchecksamples -g allplatesmergedextrasamplesbestcoverage$PREFIX.filteredmissingrefiltered.vcf.gz $PREFIX.downsampledsubsettedrefiltered.vcf.gz -e 0 > discordance$PREFIX.txt

#output mean concordance per chromosome
cut -f4,6 discordance$PREFIX.txt > ndiscordant$PREFIXrowsdeleted.txt
sed -e '1,13d' ndiscordant$PREFIXrowsdeleted.txt > ndiscordant$PREFIX.txt
awk '{ $3 = ($2 - $1)/$2 } 1' ndiscordant$PREFIX.txt > ndiscordantproportion$PREFIX.txt
awk '{ sum += $3; n++ } END { print FILENAME; if (n > 0) print sum / n;}' ndiscordantproportion$PREFIX.txt >> meanconcordance

