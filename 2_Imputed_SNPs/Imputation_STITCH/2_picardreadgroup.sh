#!/bin/bash

#SBATCH --job-name=picardreadgroupsindex
#SBATCH --output=picardreadgroupsindex.log
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=2
#SBATCH --mem-per-cpu=5G
#SBATCH --time=8:00:00
#SBATCH --mail-user=kgllee1@sheffield.ac.uk
#SBATCH --mail-type=all

#to submit jobs on molecol priority queue
# #SBATCH -A molecolb
# #SBATCH -p molecolb

module use /usr/local/modulefiles/staging/eb/all/
module load Java/17.0.6
module load SAMtools/1.9-foss-2018b

#first cd into the directory of the aligned .bam files

for i in ./Clean_aligned/`ls [0-9]*_rehead.bam`

        do
          	java -jar ~/software/picard/build/libs/picard.jar AddOrReplaceReadGroups \
                I=$i \
                O=rg$i \
                RGID=4 \
                RGLB=lib1 \
                RGPL=illumina \
                RGPU=unit1 \
                RGSM=20 ;
                samtools index ./Clean_aligned/rg$(basename $i) ;


done