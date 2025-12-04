#!/bin/bash

#Settings for the Sun Grid Engine

#run time for job in hours:mins:sec (max 168:0:0, jobs with h_rt < 8:0:0 have priority)

#$ -l h_rt=671:59:59
# request memory for job (default 2G, max 256G)

#$ -l rmem=8G
#$ -P molecosh
#$ -q molecosh.q
# give the job a name (optional):
#$-N buscoplotpilonvertandaves
# number of processors to use (max 48)
#$ -pe openmp 16
module load apps/python/conda
module load dev/gcc/8.2
source activate arcsuse
cd /fastdata/bop16cl
python3 /usr/local/extras/Genomics/apps/busco/current/scripts/generate_plot.py -wd /fastdata/bop16cl/Final_Genome/BUSCO/Pilon_summary_vert
python3 /usr/local/extras/Genomics/apps/busco/current/scripts/generate_plot.py -wd /fastdata/bop16cl/Final_Genome/BUSCO/Pilon_summary_aves