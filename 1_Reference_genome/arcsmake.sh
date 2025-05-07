
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
module load apps/python/conda
module load dev/gcc/8.2
source activate arcs2
export PATH=$PATH:/data/bop16cl/arcs_src
export PATH=$PATH:/data/bop16cl/tigmint/bin
export PATH=$PATH:/data/bop16cl/Charlotte_links/links_v1.8.5/
export TMPDIR=/fastdata/bop16cl/

cd /fastdata/bop16cl/arcsmake2503
/data/bop16cl/arcs_src/Examples/arcs-make arcs-tigmint draft=normalizedmaskedSWgenome reads=barcoded