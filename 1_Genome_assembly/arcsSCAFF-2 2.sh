#!/bin/bash
#Settings for the Sun Grid Engine
# run time for job in hours:mins:sec (max 168:0:0, jobs with hurt < 8:0:0 have priority)
#$ -l h_rt=167:59:59
# request memory for job (default 4G, max 32G)
#$ -l rmem=12G
#$ -q molecosh.q
#$ -P molecosh
# number of processors to use (max 48)
#$ -pe openmp 12
# give the job a name (optional):
#$-N newarcs0204SCAFF
#
module load apps/python/conda
module load dev/gcc/8.2
source activate arcsuse
export PATH=$PATH:/data/bop16cl/arcs_src/Arcs
export PATH=$PATH:/data/bop16cl/tigmint/bin
export PATH=$PATH:/data/bop16cl/Charlotte_links/links_v1.8.5/
export TMPDIR=/fastdata/bop16cl/

cd /fastdata/bop16cl/arcsmake0204
/data/bop16cl/arcs_src/Examples/arcs-make arcs-tigmint draft=normalizedmaskedSWgenomescaffolds reads=barcoded2