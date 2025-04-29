#!/bin/bash
#SBATCH --job-name=plinktobed
#SBATCH --output=plinktobed.log
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=4
#SBATCH --mem-per-cpu=8G
#SBATCH --time=60:00:00
#SBATCH --mail-user=kgllee1@sheffield.ac.uk
#SBATCH --mail-type=all
#to submit jobs on molecol priority queue
#SBATCH -A molecolb
#SBATCH -p molecolb

source /usr/local/extras/Genomics/.bashrc

plink \
  --allow-extra-chr \
  --const-fid 0 \
  --make-bed \
  --out biallelicmaf \
  --vcf allplatesmergedextrasamplesbiallelicmaf0.05.vcf.gz
