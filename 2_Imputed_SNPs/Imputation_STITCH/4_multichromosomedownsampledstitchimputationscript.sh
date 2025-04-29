#!/bin/bash

#SBATCH --job-name=multichromosomedownsampledstitchimpute
#SBATCH --output=multichromosomedownsampledstitchimpute.log
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=4
#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=10G
#SBATCH --time=240:00:00
#SBATCH --mail-user=kgllee1@sheffield.ac.uk
#SBATCH --mail-type=all
#SBATCH --array=1-31%5

#SBATCH -A molecolb
#SBATCH -p molecolb

source ~/.bash_profile

FILES=(stitch*.r)
FILE=${FILES[$SLURM_ARRAY_TASK_ID]}
OUTFILE=$(basename ${FILE%.bam}).out

eval "$(/home/bop21kgl/miniconda3/bin/conda shell.bash hook)"
conda init
conda activate my-stitch-env
R CMD BATCH $FILE stitch.r.o$OUTFILE

