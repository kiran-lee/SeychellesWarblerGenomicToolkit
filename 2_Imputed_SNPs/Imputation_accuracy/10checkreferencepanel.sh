#!/bin/bash

#SBATCH --job-name=checkreferencepanel
#SBATCH --output=checkreferencepanel.log
#SBATCH --nodes=1
#SBATCH --mem=16G
#SBATCH --time=1:00:00
#SBATCH --mail-user=kgllee1@sheffield.ac.uk
#SBATCH --mail-type=all

source ~/.bash_profile

#don't do awk '{print $2}' referencesequences > referencepanel

#don't do bcftools view /fastdata/bop21kgl/RawData/allplates/mergedimputedchromosomes.vcf.gz -S referencepanel -o referencepanel.vcf.gz -O z

bcftools index /fastdata/bop21kgl/RawData/allplates/allplatesmergedextrasamplescorrect.vcf.gz
bcftools index /fastdata/bop21kgl/RawData/LIMS202103/VCF/SW_ragtag.vcf.gz

bcftools merge /fastdata/bop21kgl/RawData/allplates/allplatesmergedextrasamplescorrect.vcf.gz  /fastdata/bop21kgl/RawData/LIMS202103/VCF/SW_ragtag.vcf.gz -Oz -o oldnewreferencepanel.vcf.gz

plink --allow-extra-chr --chr-set 29 --vcf oldnewreferencepanel.vcf.gz --make-bed --out oldnewreferencepanel --const-fid 0 
plink2 --allow-extra-chr  --bfile oldnewreferencepanel --make-king-table --king-table-filter 0.3 --make-bed --out duplicatereferencepairs0.3

#remove na in columns
awk '!/na/' duplicatereferencepairs0.3.kin0 > duplicatereferencepairs0.3na.kin0
awk '{$5=$6=$7=$8=""; print $0}' duplicatereferencepairs0.3na.kin0 > duplicatereferencepairs0.3na1.kin0