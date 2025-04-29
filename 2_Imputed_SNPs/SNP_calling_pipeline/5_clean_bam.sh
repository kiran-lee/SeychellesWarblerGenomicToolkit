#!/bin/bash

#SBATCH --job-name=Clean_bam_ragtag
#SBATCH --output=Clean_bam_ragtag.log
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=4
#SBATCH --mem-per-cpu=8GB
#SBATCH --time=48:00:00
#SBATCH --mail-user=kgllee1@sheffield.ac.uk
#SBATCH --mail-type=all
#SBATCH -A molecolb
#SBATCH -p molecolb

source /usr/local/extras/Genomics/.bashrc


# make new directories for flagstat reports and cleaned bam files
mkdir Flagstat
mkdir Clean_aligned

# run flagstat to check mapping efficiency
# use samtools to remove all unmapped reads from the bam (using the -F 4 flag option)
# rerun flagstat to check read numbers in clean bam files

for f in ./Aligned_ragtag/*_paired.bam;
do FBASE=$(basename $f)
        BASE=${FBASE%_paired.bam}
        samtools flagstat ./Aligned_ragtag/${BASE}_paired.bam > ./Flagstat/${BASE}.flagstat
        samtools view -F 4 -b ./Aligned_ragtag/${BASE}_paired.bam > ./Clean_aligned/${BASE}_all_mapped.bam
        samtools flagstat ./Clean_aligned/${BASE}_all_mapped.bam > ./Flagstat/${BASE}_mapped.flagstat
done
