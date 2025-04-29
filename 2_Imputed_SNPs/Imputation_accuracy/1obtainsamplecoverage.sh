#!/bin/bash

#SBATCH --job-name=combinesamplescoverage
#SBATCH --output=combinesamplescoverage.log
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=10
#SBATCH --mem=1GB
#SBATCH --time=1:00:00
#SBATCH --mail-type=all

#to submit jobs on molecol priority queue

#SBATCH -A molecolb
#SBATCH -p molecolb

source ~/.bash_profile

#first you need to cd into the directory of the plate of samples

#this produces a coverage of all bam files
for f in ./Clean_aligned/[0-9]*_all_mapped_rehead.bam;
do FBASE=$(basename $f);
BASE=${FBASE%all_mapped_rehead.bam};
samtools depth -a ./Clean_aligned/${BASE}all_mapped_rehead.bam   |  awk '{sum+=$3} END { print FILENAME,sum/NR}';
done

tail -n +16 coverage.log > coverage.txt
sed 's/^..//' coverage.txt > coveragenew.txt

#this script links coverage to the sample name
for f in ./Clean_aligned/[0-9]*_all_mapped_rehead.bam;
do FBASE=$(basename $f); 
BASE=${FBASE%all_mapped_rehead.bam}; 
echo $FBASE;
done > samples.txt

paste samples.txt coveragenew.txt > samplescoverage.txt

sed 's/\t/ /' samplescoverage.txt > samplescoveragenew.txt

#this script links coverage to the sample filepath
for f in Clean_aligned/[0-9]*_all_mapped_rehead.bam;
do echo "$(cd "$(dirname "$1")" && pwd -P)/$(basename "$1")"$f;
done > samplesfilename.txt

paste samplesfilename.txt coveragenew.txt > samplesfilenamecoverage.txt

sed 's/\t/ /' samplesfilenamecoverage.txt > samplesfilenamecoveragenew.txt
