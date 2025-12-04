#!/bin/bash
#Settings for the Sun Grid Engine

# run time for job in hours:mins:sec (max 168:0:0, jobs with h_rt < 8:0:0 have priority)

#$ -l h_rt=671:59:59
# request memory for job (default 2G, max 256G)

#$ -l rmem=16G
#$ -q molecol.q
#$ -P molecol

# number of processors to use (max 48)

#$ -pe openmp 16
export PATH=/fastdata-sharc/bop16cl/longranger-2.2.2:$PATH
longranger basic --id=10XR004 --fastqs=/fastdata-sharc/bop16cl/Sample_1_1-R004_SW_6840,/fastdata-sharc/bop16cl/Sample_1_2-R004_SW_6840,/fastdata-sharc/bop16cl/Sample_1_3-R004_SW_6840,/fastdata-sharc/bop16cl/Sample_1_4-R004_SW_6840 --sample=1_1-R004_SW_6840,1_2-R004_SW_6840,1_3-R004_SW_6840,1_4-R004_SW_6840