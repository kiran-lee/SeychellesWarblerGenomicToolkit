#!/bin/bash

#SBATCH --job-name=downsample
#SBATCH --output=downsample.log
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=4
#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=2G
#SBATCH --time=6:00:00
#SBATCH --mail-user=kgllee1@sheffield.ac.uk
#SBATCH --mail-type=all
#SBATCH --array=1-23

##Downsample high coverage files

source ~/.bash_profile


sample=`sed -n ${SLURM_ARRAY_TASK_ID}p downsamplescalingnew | awk '{print $1}'`
multiple01x=`sed -n ${SLURM_ARRAY_TASK_ID}p downsamplescalingnew | awk '{print $2}'`

cp $sample .

mkdir subsamp

## Subsample to 0.1x                                                             
samtools view -@ 20 -bh -s ${multiple01x} ${sample} > "${sample}.0.1x.bam"
samtools index "${sample}.0.1x.bam"
