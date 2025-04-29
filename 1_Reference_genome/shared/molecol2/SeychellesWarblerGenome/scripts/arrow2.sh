#!/bin/bash

#Settings for the Sun Grid Engine

# run time for job in hours:mins:sec (max 168:0:0, jobs with h_rt < 8:0:0 have priority)

#$ -l h_rt=671:59:59
# request memory for job (default 2G, max 256G)

#$ -l rmem=32G
#$ -q molecosh.q
#$ -P molecosh

# number of processors to use (max 48)

#$ -pe openmp 12
#source /usr/local/extras/Genomics/apps/falcon/current/fc_env/bin/activate

/data/bop16cl/smrtlink/install/smrtlink-release_5.1.0.26412/bundles/smrttools/smrtcmds/bin/arrow /fastdata/bop16cl/pbalignfiles/SWcanupb.bam -j 12 -r /fastdata/bop16cl/SWnew/SWnew.contigs.fasta -o variantspbALL2.gff -o consensuspbALL2.fasta -o consensuspbALL2.fastq 

