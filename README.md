# Seychelles warbler genomic toolkit

Scripts and commands to create a genomic toolkit to study Seychelles warblers. 
Scripts were run on Sheffield University HPCs. These HPCs uses the SLURM queueing system, therefore core/RAM/runtimes in .sh scripts are specified in SLURM format. 

This includes:
1) Reference genome
2) SNPs from short read 150bp Illumina whole-genome sequencing of ~1900 Seychelles warblers that have been imputed for missing genotypes by STITCH.
3) Sample verification by genomic sex and pedigree assignment

![A ringed Seychelles warbler](Other/20210528-IMG_0515.jpeg)

Poster summarising the toolkit presented at NorthernBug14, Huddersfield: https://docs.google.com/presentation/d/1OCoMiTgyUYtz5R5Uk7KwS7_Gr2fNfv7L/edit?slide=id.p1#slide=id.p1


## 1 Reference genome

Scripts to create the reference genome.

Useful output files:
Chromosome-assembled reference genome: [![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.14717915.svg)](https://doi.org/10.5281/zenodo.14717915)


## 2 Imputed SNPs

### SNP_calling_pipeline
1. raw.xlsx: Download links to all sequenced plates.

2. main_submission_multi.sh : An array job that requires sequenced plate number ID as input to quality check (fastqc.sh), trim reads (trimmomatic.sh), align read to the reference genome (bwa.sh), filter mapped reads (clean_bam.sh) , call SNPs (snps.sh) and add read group data to .bam files (picardreadgroup.sh).

3. mergefiltervcf.sh : Merge samples from all plates, subset for SNPs for biallelic only and MAF > 0.05.


### Imputation STITCH

1. plinktobedbiallelic.sh: Convert .vcf file to .bed file.
2. getpos.sh: Get snp position list and split by chromosome for STITCH to use.
3. picardreadgroup.sh: Add read group data to alligned .bam files and then index output. You must cd into the relevant directory containing aligned .bam files first.
4. multichromosomedownsampledstitchimputationscript.sh: Array job submission to perform imputation, using STITCH for all 31 chromosomes (each of the 31 stitch*.r scripts),  for all 1922 samples (bamlistrg.txt) and their respective names (bamlist.txt).

### Imputation_accuracy

1. obtainsamplecoverage.sh: Get coverage per sample. You must cd into the relevant directory containing aligned .bam files first.

2. decimalscoverage.sh: Concatenate coverage of all samples, convert coverage into decimals and sort samples on coverage (coverageallsorted.txt).

3. coveragedownsampling.R : Choose best coverage samples and output a file with  for each sample, the scaling factor to multiply to get to 2.6x coverage (downsamplescalingnew).

4. downsamplecorrectcoverage.sh: Downsample best coverage samples to 2.6x by scaling factor  (downsamplescalingnew).

5. makestitchrscriptfordownsamples.sh: Make .r script  to impute downsampled individuals for each of the 31 chromosomes, borrowing script using in 2_Imputation_STITCH.

6. getsampleslist.sh: Create file listing downsampled samples, including filepaths (bamlistrgdownsampled.txt) and their names (bamlistdownsampled) to impute, in order to assess accuracy. N.B. Before this, you must first use picard to add read group data to the .bam files of downsampled samples and then need to index these, see picardreadgroup.sh in 2_Imputation_STITCH for how to do this.

7. multichromosomedownsampledstitchimputationscript.sh: array job submission to perform imputation, using STITCH for all 31 chromosomes (each of the 31 stitch*downsampled.r scripts),  for all 1922 samples (bamlistrgdownsampled.txt) and their respective names (bamlistdownsampled.txt), with 23 of the highest coverage samples being downsampled to 2.6x coverage.

8. imputationaccuracy.sh : List of commands to compare in 23 high coverage samples (downsampled2.6) non-imputed genotypes to their respective downsampled, then imputed genotypes and outputting concordance per chromosome in one file (meanconcordance).

9.  choosereferencepanel.sh: Commands to obtain a reference panel of higher coverage, unrelated repeat samples.

10.  checkreferencepanel.sh: Script used to verify the repeated samples are indeed genetically related despite my rustiness in the wet lab (answer is yes)

11.  mergereferencepanel.R: This script takes the higher coverage repeat samples and merges them with the previously sequenced samples, that have been verified as duplicates using script as in 10checkaccuracy.sh to output a set of commmands used in 12mergereference.sh

12.   mergereference.sh: Commands to merge  higher coverage repeat samples with the previously sequenced samples, that have been verified as duplicates, for a final round of imputation

Useful output files:
Imputed whole-genome sequences: [![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.14717915.svg)](https://doi.org/10.5281/zenodo.14717915)


## 3 Sample verification and analysis

Data needed to link verify sequenced samples, by genomic sex assignment and pedigree assignment using sequoia. Also script to for analyses and figures in the manuscript and their outputs.

Useful output files:
SeychellesWarblerTraitsCorrected.xlsx: All sample-verified sequenced birds in the Seychelles warbler database (BirdID), the plate number they were sequenced on (Plate), sequences sample name as named by Liverpool University (SeqID), sequencing coverage (Coverage), tube number of sample used to link SeqID to BirdID (ID), whether the ID used was BloodID or BloodTubeNumber (Identifier), lifespan (Lifespan), year of birth (BirthYear), year it was last seen (LastSeenYear), lifetime offspring produced (ReproductiveOutput)

PedigreeCorredted.xlsx: A pedigree using sequoia.

relatednesscorrected.grm and relatednesscorrected.grm.id (and relatednesscorrected.log): Genomic relatedness matrix of all samples from imputed SNPs, calculated using PLINK's GCTA tool.

sw_eggnog_gff.tsv: Functional annotation of the reference genome using GALBA.
