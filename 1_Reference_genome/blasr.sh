#!/bin/bash

#Settings for the Sun Grid Engine

# run time for job in hours:mins:sec (max 168:0:0, jobs with h_rt < 8:0:0 have priority)

#$ -l h_rt=671:59:59
# request memory for job (default 2G, max 256G)

#$ -l rmem=32G
#$ -q molecosh.q
#$ -P molecosh

# number of processors to use (max 48)

#$ -pe openmp 1
#source /usr/local/extras/Genomics/apps/falcon/current/fc_env/bin/activate

/data/bop16cl/smrtlink/install/smrtlink-release_5.1.0.26412/bundles/smrttools/smrtcmds/bin/blasr /fastdata/bop16cl/bam/m54154_180419_084622.subreads.bam /fastdata/bop16cl/SWnew/SWnew.contigs.fasta --bam --out SWnewblasr3.bam

/data/bop16cl/smrtlink/install/smrtlink-release_5.1.0.26412/bundles/smrttools/smrtcmds/bin/blasr /fastdata/bop16cl/bam/m54154_180419_185630.subreads.bam /fastdata/bop16cl/SWnew/SWnew.contigs.fasta --bam --out SWnewblasr4.bam

/data/bop16cl/smrtlink/install/smrtlink-release_5.1.0.26412/bundles/smrttools/smrtcmds/bin/blasr /fastdata/bop16cl/bam/m54154_180423_153237.subreads.bam /fastdata/bop16cl/SWnew/SWnew.contigs.fasta --bam --out SWnewblasr5.bam

/data/bop16cl/smrtlink/install/smrtlink-release_5.1.0.26412/bundles/smrttools/smrtcmds/bin/blasr /fastdata/bop16cl/bam/m54154_180424_014156.subreads.bam /fastdata/bop16cl/SWnew/SWnew.contigs.fasta --bam --out SWnewblasr6.bam

/data/bop16cl/smrtlink/install/smrtlink-release_5.1.0.26412/bundles/smrttools/smrtcmds/bin/blasr /fastdata/bop16cl/bam/m54154_180424_161947.subreads.bam /fastdata/bop16cl/SWnew/SWnew.contigs.fasta --bam --out SWnewblasr7.bam

/data/bop16cl/smrtlink/install/smrtlink-release_5.1.0.26412/bundles/smrttools/smrtcmds/bin/blasr /fastdata/bop16cl/bam/m54154_180425_022951.subreads.bam /fastdata/bop16cl/SWnew/SWnew.contigs.fasta --bam --out SWnewblasr8.bam

/data/bop16cl/smrtlink/install/smrtlink-release_5.1.0.26412/bundles/smrttools/smrtcmds/bin/blasr /fastdata/bop16cl/bam/m54154_180426_125852.subreads.bam /fastdata/bop16cl/SWnew/SWnew.contigs.fasta --bam --out SWnewblasr9.bam

/data/bop16cl/smrtlink/install/smrtlink-release_5.1.0.26412/bundles/smrttools/smrtcmds/bin/blasr /fastdata/bop16cl/bam/m54154_180426_231011.subreads.bam /fastdata/bop16cl/SWnew/SWnew.contigs.fasta --bam --out SWnewblasr10.bam

/data/bop16cl/smrtlink/install/smrtlink-release_5.1.0.26412/bundles/smrttools/smrtcmds/bin/blasr /fastdata/bop16cl/bam/m54154_180427_130817.subreads.bam /fastdata/bop16cl/SWnew/SWnew.contigs.fasta --bam --out SWnewblasr11.bam

/data/bop16cl/smrtlink/install/smrtlink-release_5.1.0.26412/bundles/smrttools/smrtcmds/bin/blasr /fastdata/bop16cl/bam/m54154_180427_232024.subreads.bam /fastdata/bop16cl/SWnew/SWnew.contigs.fasta --bam --out SWnewblasr12.bam

/data/bop16cl/smrtlink/install/smrtlink-release_5.1.0.26412/bundles/smrttools/smrtcmds/bin/blasr /fastdata/bop16cl/bam/m54154_180428_135054.subreads.bam /fastdata/bop16cl/SWnew/SWnew.contigs.fasta --bam --out SWnewblasr13.bam

/data/bop16cl/smrtlink/install/smrtlink-release_5.1.0.26412/bundles/smrttools/smrtcmds/bin/blasr /fastdata/bop16cl/bam/m54154_180429_000350.subreads.bam /fastdata/bop16cl/SWnew/SWnew.contigs.fasta --bam --out SWnewblasr14.bam

/data/bop16cl/smrtlink/install/smrtlink-release_5.1.0.26412/bundles/smrttools/smrtcmds/bin/blasr /fastdata/bop16cl/bam/m54154_180429_101956.subreads.bam /fastdata/bop16cl/SWnew/SWnew.contigs.fasta --bam --out SWnewblasr15.bam

/data/bop16cl/smrtlink/install/smrtlink-release_5.1.0.26412/bundles/smrttools/smrtcmds/bin/blasr /fastdata/bop16cl/bam/m54154_180429_203602.subreads.bam /fastdata/bop16cl/SWnew/SWnew.contigs.fasta --bam --out SWnewblasr16.bam

/data/bop16cl/smrtlink/install/smrtlink-release_5.1.0.26412/bundles/smrttools/smrtcmds/bin/blasr /fastdata/bop16cl/bam/m54154_180502_112233.subreads.bam /fastdata/bop16cl/SWnew/SWnew.contigs.fasta --bam --out SWnewblasr17.bam

/data/bop16cl/smrtlink/install/smrtlink-release_5.1.0.26412/bundles/smrttools/smrtcmds/bin/blasr /fastdata/bop16cl/bam/m54154_180502_213824.subreads.bam /fastdata/bop16cl/SWnew/SWnew.contigs.fasta --bam --out SWnewblasr18.bam

/data/bop16cl/smrtlink/install/smrtlink-release_5.1.0.26412/bundles/smrttools/smrtcmds/bin/blasr /fastdata/bop16cl/bam/m54154_180503_160118.subreads.bam /fastdata/bop16cl/SWnew/SWnew.contigs.fasta --bam --out SWnewblasr19.bam

/data/bop16cl/smrtlink/install/smrtlink-release_5.1.0.26412/bundles/smrttools/smrtcmds/bin/blasr /fastdata/bop16cl/bam/m54154_180504_020952.subreads.bam /fastdata/bop16cl/SWnew/SWnew.contigs.fasta --bam --out SWnewblasr20.bam

