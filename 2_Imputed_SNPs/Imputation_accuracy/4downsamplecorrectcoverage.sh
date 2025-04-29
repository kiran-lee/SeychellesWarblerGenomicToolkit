#!/bin/bash

#SBATCH --job-name=downsample
#SBATCH --output=downsample.log
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=2
#SBATCH --mem-per-cpu=1G
#SBATCH --time=2:00:00
#SBATCH --mail-user=kgllee1@sheffield.ac.uk
#SBATCH --mail-type=all
#SBATCH --array=1-57

##Downsample high coverage files

source ~/.bash_profile

#old script disused cut -sd'/' -f2 cov_x_sw_renamed > cov_x_sw_renamed2

sample=`sed -n ${SLURM_ARRAY_TASK_ID}p downsamplescalingnew | awk '{print $1}'`
multiplemeanx=`sed -n ${SLURM_ARRAY_TASK_ID}p downsamplescalingnew | awk '{print $2}'`
multiple1x=`sed -n ${SLURM_ARRAY_TASK_ID}p downsamplescalingnew | awk '{print $3}'`
multiple01x=`sed -n ${SLURM_ARRAY_TASK_ID}p downsamplescalingnew | awk '{print $4}'`

cp $sample .

mkdir subsamp

## Subsample to 2.6x
samtools view -@ 20 -bh -s ${multiplemeanx} ${sample} > "${sample}.2.6x.bam"
samtools index "${sample}.2.6x.bam"

## Subsample to 1x
samtools view -@ 20 -bh -s ${multiple1x} ${sample} > "${sample}.1x.bam"
samtools index "${sample}.1x.bam"

## Subsample to 0.1x
samtools view -@ 20 -bh -s ${multiple01x} ${sample} > "${sample}.0.1x.bam"
samtools index "${sample}.0.1x.bam"

#add rg tags to downsampled samples for STITCH

module use /usr/local/modulefiles/staging/eb/all/
module load Java/17.0.6
module load SAMtools/1.9-foss-2018b

for i in `ls *x.bam`

        do
          	java -jar ~/software/picard/build/libs/picard.jar AddOrReplaceReadGroups \
                I=$i \
                O=rg$i \
                RGID=4 \
                RGLB=lib1 \
                RGPL=illumina \
                RGPU=unit1 \
                RGSM=20 ;
                samtools index rg$(basename $i) ;


done