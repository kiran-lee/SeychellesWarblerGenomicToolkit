#!/bin/bash

#SBATCH --job-name=mergefiltervcf
#SBATCH --output=mergefiltervcf.log
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=4
#SBATCH --mem-per-cpu=2G
#SBATCH --time=30:00:00
#SBATCH --mail-user=kgllee1@sheffield.ac.uk
#SBATCH --mail-type=all

#SBATCH -A molecolb
#SBATCH -p molecolb

source ~/.bash_profile

#merge all plates
bcftools merge -l vcffilestomerge -o allplatesmergedextrasamples.vcf.gz -O z

#get only biallelic snps
bcftools view -m2 -M2 -v snps allplatesmergedextrasamples.vcf.gz > allplatesmergedextrasamplesbiallelic.vcf.gz -O z


#rename chromosomes (don't do this as it complicates things later down the line)
#echo "ENA|OU383783|OU383783.1_RagTag chr10" >> chr_name_conv.txt
#echo "ENA|OU383784|OU383784.1_RagTag chr11" >> chr_name_conv.txt
#echo "ENA|OU383785|OU383785.1_RagTag chr12" >> chr_name_conv.txt
#echo "ENA|OU383786|OU383786.1_RagTag chr13" >> chr_name_conv.txt
#echo "ENA|OU383787|OU383787.1_RagTag chr14" >> chr_name_conv.txt
#echo "ENA|OU383788|OU383788.1_RagTag chr15" >> chr_name_conv.txt
#echo "ENA|OU383789|OU383789.1_RagTag chr16" >> chr_name_conv.txt
#echo "ENA|OU383790|OU383790.1_RagTag chr17" >> chr_name_conv.txt
#echo "ENA|OU383791|OU383791.1_RagTag chr18" >> chr_name_conv.txt
#echo "ENA|OU383792|OU383792.1_RagTag chr19" >> chr_name_conv.txt
#echo "ENA|OU383773|OU383773.1_RagTag chr1" >> chr_name_conv.txt
#echo "ENA|OU383793|OU383793.1_RagTag chr20" >> chr_name_conv.txt
#echo "ENA|OU383794|OU383794.1_RagTag chr21" >> chr_name_conv.txt
#echo "ENA|OU383796|OU383796.1_RagTag chr22" >> chr_name_conv.txt
#echo "ENA|OU383797|OU383797.1_RagTag chr23" >> chr_name_conv.txt
#echo "ENA|OU383798|OU383798.1_RagTag chr24" >> chr_name_conv.txt
#echo "ENA|OU383800|OU383800.1_RagTag chr25" >> chr_name_conv.txt
#echo "ENA|OU383799|OU383799.1_RagTag chr26" >> chr_name_conv.txt
#echo "ENA|OU383801|OU383801.1_RagTag chr27" >> chr_name_conv.txt
#echo "ENA|OU383802|OU383802.1_RagTag chr28" >> chr_name_conv.txt
#echo "ENA|OU383803|OU383803.1_RagTag chr29" >> chr_name_conv.txt
#echo "ENA|OU383774|OU383774.1_RagTag chr2" >> chr_name_conv.txt
#echo "ENA|OU383775|OU383775.1_RagTag chr3" >> chr_name_conv.txt
#echo "ENA|OU383777|OU383777.1_RagTag chr4" >> chr_name_conv.txt
#echo "ENA|OU383778|OU383778.1_RagTag chr5" >> chr_name_conv.txt
#echo "ENA|OU383779|OU383779.1_RagTag chr6" >> chr_name_conv.txt
#echo "ENA|OU383780|OU383780.1_RagTag chr7" >> chr_name_conv.txt
#echo "ENA|OU383781|OU383781.1_RagTag chr8" >> chr_name_conv.txt
#echo "ENA|OU383782|OU383782.1_RagTag chr9" >> chr_name_conv.txt
#echo "ENA|OU383795|OU383795.1_RagTag chr31" >> chr_name_conv.txt
#echo "ENA|OU383776|OU383776.1_RagTag chr30" >> chr_name_conv.txt

#bcftools annotate --rename-chrs chr_name_conv.txt allplatesmergedextrasamplesbiallelicmaf0.05.vcf.gz > allplatesmergedextrasamplesbiallelicmaf0.05renamedchromosomes.vcf.gz -O z

#check renaming chromosomes worked
#bcftools view --header-only allplatesmergedextrasamplesbiallelicmaf0.05renamedchromosomes.vcf.gz | grep "##contig"