#!/bin/bash
#Settings for the Sun Grid Engine
# run time for job in hours:mins:sec (max 168:0:0, jobs with hurt < 8:0:0 have priority)
#$ -l h_rt=167:59:59
# request memory for job (default 4G, max 32G)
#$ -l rmem=4G
# number of processors to use (max 48)
#$ -pe openmp 8
# give the job a name (optional):
#$-N BUSCO_1scaff_vert
export TMPDIR=/fastdata-sharc/bop16cl/
/usr/local/community/Genomics/apps/busco/3.1.0/busco -i /fastdata-sharc/bop16cl/1scaffrename.fasta -o BUSCO_1scaff_vert -m geno -l /usr/local/community/Genomics/apps/busco/3.1.0/lineages/eukaryota/vertebrata_odb9 -sp chicken -c 8
