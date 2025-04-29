#!/bin/bash

#SBATCH --job-name=choosereferencepanel
#SBATCH --output=choosereferencepanel.log
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=4
#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=2G
#SBATCH --time=6:00:00
#SBATCH --mail-user=kgllee1@sheffield.ac.uk
#SBATCH --mail-type=all

#Commands to generate high coverage reference panel for assessing imputation accuracy

source ~/.bash_profile

#pick  top 13.0% (250/1922) coverage (>4.45x) samples
plink \
  --allow-extra-chr \
  --bfile mergedimputedchromosomes \
  --keep best250coverageformattedsampleskeepplink.txt \
  --make-bed
  --out best250

#subset for unrelated individuals to a degree of at least 2nd-degree relationships
plink2 --allow-extra-chr --bfile best250 --king-cutoff 0.1 --make-bed --out unrelated2nddegree250


