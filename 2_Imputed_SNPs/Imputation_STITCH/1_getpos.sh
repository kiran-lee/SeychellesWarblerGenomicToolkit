#!/bin/bash

#SBATCH --job-name=pos
#SBATCH --output=pos.log
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=4
#SBATCH --mem-per-cpu=2G
#SBATCH --time=30:00:00
#SBATCH --mail-user=kgllee1@sheffield.ac.uk
#SBATCH --mail-type=all

#SBATCH -A molecolb
#SBATCH -p molecolb

source ~/.bash_profile

# get pos.txt file for stitch
awk '{print $1,$4,$5,$6}' biallelic.bim > biallelicsnplist.txt

#replace space with tab
sed -e 's/ /\t/g' biallelicsnplist.txt > pos.txt

#list chromosomes in file
awk -F ' ' '{print $1}' pos.txt | sort | uniq -c

#split pos.txt file for each chromosome
awk '{F=substr($0,1,12)".txt";print >> F;close(F)}' pos.txt