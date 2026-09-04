#!/bin/bash

#Settings for the Sun Grid Engine

# run time for job in hours:mins:sec (max 168:0:0, jobs with h_rt < 8:0:0 have priority)

#$ -l h_rt=671:59:59
# request memory for job (default 2G, max 256G)

#$ -l rmem=8G
#$ -q molecosh.q
#$ -P molecosh

# number of processors to use (max 48)

#$ -pe openmp 8

/home/bop16cl/.conda/pkgs/pbccs-4.1.0-0/bin/ccs /fastdata/bop16cl/SW_PB/m54154_180503_160118.subreads.bam /fastdata/bop16cl/m54154_180503_160118_CCS.bam