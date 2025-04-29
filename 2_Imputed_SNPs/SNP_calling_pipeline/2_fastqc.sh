#!/bin/bash

#SBATCH --job-name=fastqc
#SBATCH --output=fastqc.log
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=2
#SBATCH --mem-per-cpu=4GB
#SBATCH --time=20:00:00


source /usr/local/extras/Genomics/.bashrc


mkdir fastqc
mkdir fastqc/fastqc_F

for f in $(find ./Raw  -name *"R1"*".fastq.gz");
do fastqc $f -o ./fastqc/fastqc_F
done

/usr/local/community/Genomics/apps/miniconda/envs/multiqc/bin/multiqc ./fastqc/fastqc_F -o ./fastqc/fastqc_F/multiqc


mkdir fastqc/fastqc_R

for f in $(find ./Raw  -name *"R2"*".fastq.gz");
do fastqc $f -o ./fastqc/fastqc_R
done

/usr/local/community/Genomics/apps/miniconda/envs/multiqc/bin/multiqc ./fastqc/fastqc_R -o ./fastqc/fastqc_R/multiqc
