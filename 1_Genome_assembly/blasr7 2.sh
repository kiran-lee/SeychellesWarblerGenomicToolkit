#$ -l h_rt=671:59:59
# request memory for job (default 2G, max 256G)

#$ -l rmem=32G
#$ -q molecosh.q
#$ -P molecosh

# number of processors to use (max 48)

#$ -pe openmp 1
#source /usr/local/extras/Genomics/apps/falcon/current/fc_env/bin/activate

/data/bop16cl/smrtlink/install/smrtlink-release_5.1.0.26412/bundles/smrttools/smrtcmds/bin/blasr /fastdata/bop16cl/bam/m54154_180424_161947.subreads.bam /fastdata/bop16cl/SWnew/SWnew.contigs.fasta --bam --out SWnewblasr7.bam