#!/bin/bash

#SBATCH --job-name=trim
#SBATCH --output=trim.log
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=4
#SBATCH --mem-per-cpu=8G
#SBATCH --time=48:00:00
#SBATCH --mail-user=kgllee1@sheffield.ac.uk
#SBATCH --mail-type=all

#to submit jobs on molecol priority queue 
#SBATCH -A molecolb
#SBATCH -p molecolb

source /usr/local/extras/Genomics/.bashrc

cp /fastdata/bop21kgl/SNPsPipeline/TruSeq3-PE-2.fa .
mkdir Trimmed_seqs


for f in Raw/Sample*/*"R1"*".fastq.gz";
do FBASE=$(basename $f)
        BASE=${FBASE%R1*.fastq.gz}
        trimmomatic PE -threads 4 -phred33 \
        Raw/Sample*/${BASE}R1*.fastq.gz \
        Raw/Sample*/${BASE}R2*.fastq.gz \
        Trimmed_seqs/${BASE}_trimmed_paired_R1.fastq.gz \
        Trimmed_seqs/${BASE}_trimmed_unpaired_R1.fastq.gz \
        Trimmed_seqs/${BASE}_trimmed_paired_R2.fastq.gz \
        Trimmed_seqs/${BASE}_trimmed_unpaired_R2.fastq.gz \
        ILLUMINACLIP:TruSeq3-PE-2.fa:2:30:12 SLIDINGWINDOW:4:30 MINLEN:80
done
