#!/bin/bash

# ==============================================================================
# SLURM SCRIPT FOR STAGE 1: ISOLATE PACBIO MITOCHONDRIAL READS
#
# Description:
# This script maps all PacBio subreads against a reference mitogenome and
# extracts the aligned reads into a clean FASTQ file. This is the first step
# in a hybrid assembly workflow.
#
# --- INSTRUCTIONS ---
#
# 1. PREPARE SEED FILE:
#    Make sure your seed file ('orientalreedwarblermtdna.fasta') is in the
#    same directory as this script.
#
# 2. RUN THIS SCRIPT:
#    sbatch run_pacbio_filter.sh
#
# ==============================================================================

# --- SLURM DIRECTIVES ---
#SBATCH --job-name=pacbio_mtdna_filter
#SBATCH --output=pacbio_mtdna_filter.log
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=16  # pbalign can use many threads
#SBATCH --mem=64G             # Request a good amount of memory
#SBATCH --time=48:00:00
#SBATCH -A molecolb
#SBATCH -p molecolb

# --- SCRIPT SETUP ---
source ~/.bash_profile
# Activate a conda environment that has PacBio tools (pb-CpG-tools) and samtools
conda activate pacbio

echo "Job started on $(date)"
echo "Running on node: $(hostname)"
echo

# --- DEFINE FILE PATHS ---
PACBIO_DIR="/fastdata/bo1hxh_shared/SW_PB/"
SEED_FILE="/home/bop21kgl/.GetOrganelle/SeedDatabase/animal_mt.fasta"
OUTPUT_DIR="pacbio_mtdna_filter"
mkdir -p "$OUTPUT_DIR"

# --- STEP 1: CREATE FILE-OF-FILENAMES (FOFN) ---
echo "[1/5] Creating a list of input PacBio BAM files..."
FOFN_FILE="${OUTPUT_DIR}/input.fofn"
find "${PACBIO_DIR}" -name "*.subreads.bam" > "${FOFN_FILE}"
NUM_FILES=$(cat "${FOFN_FILE}" | wc -l)
echo "-> Found ${NUM_FILES} BAM files."
echo

# --- STEP 2: INDEX PACBIO BAMS ---
echo "[2/5] Indexing all PacBio BAM files (this may take a while)..."
# This loop indexes each BAM file if an index doesn't already exist
while read -r bam_file; do
    if [ ! -f "${bam_file}.pbi" ]; then
        echo "   -> Indexing ${bam_file}..."
        pbindex "${bam_file}"
    else
        echo "   -> Index for ${bam_file} already exists. Skipping."
    fi
done < "${FOFN_FILE}"
echo "-> All BAM files are indexed."
echo

# --- STEP 3: ALIGN SUBREADS TO MITOGENOME ---
echo "[3/5] Aligning all subreads to the seed mitogenome with pbalign..."
ALIGNED_BAM="${OUTPUT_DIR}/pacbio_reads_aligned_to_mtdna.bam"
pbalign --nproc "${SLURM_NTASKS_PER_NODE}" \
        "${FOFN_FILE}" \
        "${SEED_FILE}" \
        "${ALIGNED_BAM}"
echo "-> Alignment complete."
echo

# --- STEP 4: FILTER FOR MAPPED READS ---
echo "[4/5] Filtering alignment to keep only mapped reads..."
FILTERED_BAM="${OUTPUT_DIR}/pacbio_mtdna_reads.bam"
# -F 4 flag means we keep everything EXCEPT unmapped reads
samtools view -b -F 4 "${ALIGNED_BAM}" > "${FILTERED_BAM}"
echo "-> Filtering complete."
echo

# --- STEP 5: CONVERT FILTERED BAM TO FASTQ ---
echo "[5/5] Converting final BAM to FASTQ format..."
FINAL_FASTQ="${OUTPUT_DIR}/pacbio_mtdna_reads.fastq.gz"
samtools fastq "${FILTERED_BAM}" | gzip > "${FINAL_FASTQ}"
echo "-> Conversion complete."
echo

# --- FINAL CHECK & CLEANUP ---
rm "${ALIGNED_BAM}" # Remove large intermediate alignment file

if [ -s "$FINAL_FASTQ" ]; then
    echo
    echo "--- SUCCESS! ---"
    echo "Successfully isolated PacBio mitochondrial reads."
    echo "The final output file is: ${FINAL_FASTQ}"
else
    echo
    echo "--- FAILURE ---"
    echo "ERROR: The final FASTQ file is empty. Please check the log."
fi

echo
echo "Job ended on $(date)"

