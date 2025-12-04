#!/bin/bash
#Settings for the Sun Grid Engine

# run time for job in hours:mins:sec (max 168:0:0, jobs with h_rt < 8:0:0 have priority)

#$ -l h_rt=671:59:59
# request memory for job (default 2G, max 256G)

#$ -l rmem=4G
#$ -q molecol-extra.q
#$ -P molecol-extra

# number of processors to use (max 48)

#$ -pe openmp 16
module load apps/python/conda
module load dev/gcc/8.2
source activate arcsuse
bwa index /fastdata/bop16cl/Pilontrial3rdround.fasta
bwa mem -M -t 16 /fastdata/bop16cl/Pilontrial3rdround.fasta /fastdata/bop16cl/11848_Burke_Terry/raw_data/20191028/CN_SW_pool/191021_A00291_0223_AHM77MDMXX_1_11848BT0005L01_1.fastq /fastdata/bop16cl/11848_Burke_Terry/raw_data/20191028/CN_SW_pool/191021_A00291_0223_AHM77MDMXX_1_11848BT0005L01_2.fastq > SWCN3rdscaff_pilon4th.sam
