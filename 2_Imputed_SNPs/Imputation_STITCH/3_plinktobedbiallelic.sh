#!/bin/bash
#SBATCH --job-name=plinktobedbiallelic
#SBATCH --output=plinktobedbiallelic.log
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=4
#SBATCH --mem-per-cpu=2G
#SBATCH --time=6:00:00
#SBATCH --mail-user=kgllee1@sheffield.ac.uk
#SBATCH --mail-type=all
#to submit jobs on molecol priority queue
#SBATCH -A molecolb
#SBATCH -p molecolb

source /usr/local/extras/Genomics/.bashrc

plink \
  --allow-extra-chr \
  --chr-set 29 \
  --const-fid 0 \
  --make-bed \
  --out biallelic \
  --vcf allplatesmergedextrasamplesbiallelic.vcf.gz

