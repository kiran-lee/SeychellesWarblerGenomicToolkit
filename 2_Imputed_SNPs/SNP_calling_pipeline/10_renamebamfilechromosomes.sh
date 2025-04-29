#!/bin/bash

#SBATCH --job-name=changebamfilechromosomes
#SBATCH --output= changebamfilechromosomes.log
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=4
#SBATCH --mem-per-cpu=8GB
#SBATCH --time=48:00:00
#SBATCH --mail-user=kgllee1@sheffield.ac.uk
#SBATCH --mail-type=all
#SBATCH -A molecolb
#SBATCH -p molecolb

source /usr/local/extras/Genomics/.bashrc

for file in *.bam
do
  filename=`echo $file | cut -d "." -f 1`
  samtools view -H $file | \
      sed -e 's/SN:ENA|OU383773|OU383773.1_RagTag/SN:1/' | sed -e 's/SN:ENA|OU383774|OU383774.1_RagTag/SN:2/' | \
      sed -e 's/SN:ENA|OU383775|OU383775.1_RagTag/SN:3/' | sed -e 's/SN:ENA|OU383776|OU383776.1_RagTag/SN:31/' | \
      sed -e 's/SN:ENA|OU383777|OU383777.1_RagTag/SN:4/' | sed -e 's/SN:ENA|OU383778|OU383778.1_RagTag/SN:5/' | \
      sed -e 's/SN:ENA|OU383779|OU383779.1_RagTag/SN:6/' | sed -e 's/SN:ENA|OU383780|OU383780.1_RagTag/SN:7/' | \
      sed -e 's/SN:ENA|OU383781|OU383781.1_RagTag/SN:8/' | sed -e 's/SN:ENA|OU383782|OU383782.1_RagTag/SN:9/' | \
      sed -e 's/SN:ENA|OU383783|OU383783.1_RagTag/SN:10/' | sed -e 's/SN:ENA|OU383784|OU383784.1_RagTag/SN:11/' | \
      sed -e 's/SN:ENA|OU383785|OU383785.1_RagTag/SN:12/' | sed -e 's/SN:ENA|OU383786|OU383786.1_RagTag/SN:13/' | \
      sed -e 's/SN:ENA|OU383787|OU383787.1_RagTag/SN:14/' | sed -e 's/SN:ENA|OU383788|OU383788.1_RagTag/SN:15/' | \
      sed -e 's/SN:ENA|OU383789|OU383789.1_RagTag/SN:16/' | sed -e 's/SN:ENA|OU383790|OU383790.1_RagTag/SN:17/' | \
      sed -e 's/SN:ENA|OU383791|OU383791.1_RagTag/SN:18/' | sed -e 's/SN:ENA|OU383792|OU383792.1_RagTag/SN:19/' | \
      sed -e 's/SN:ENA|OU383793|OU383793.1_RagTag/SN:20/' | sed -e 's/SN:ENA|OU383794|OU383794.1_RagTag/SN:21/' | \
      sed -e 's/SN:ENA|OU383795|OU383795.1_RagTag/SN:30/' | sed -e 's/SN:ENA|OU383796|OU383796.1_RagTag/SN:22/' | \
      sed -e 's/SN:ENA|OU383797|OU383797.1_RagTag/SN:23/' | sed -e 's/SN:ENA|OU383798|OU383798.1_RagTag/SN:24/' | \
      sed -e 's/SN:ENA|OU383799|OU383799.1_RagTag/SN:26/' | sed -e 's/SN:ENA|OU383800|OU383800.1_RagTag/SN:25/' | \
      sed -e 's/SN:ENA|OU383801|OU383801.1_RagTag/SN:27/' | sed -e 's/SN:ENA|OU383802|OU383802.1_RagTag/SN:28/' | \
      sed -e 's/SN:MT/SN:chrM/' | samtools reheader - $file > ${filename}_chr.bam
done