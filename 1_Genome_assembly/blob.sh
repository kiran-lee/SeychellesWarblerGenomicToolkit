#!/bin/bash

# ==============================================================================
# SLURM SCRIPT TO FILTER EXISTING BLOBTOOLKIT RESULTS AND GENERATE PLOTS
#
# Description:
# This script takes the pre-computed coverage and BLAST results, filters out
# scaffolds shorter than 1000 bp, and then creates the final BlobToolKit plot.
#
# --- INSTRUCTIONS ---
# 1. Ensure you are in the main results directory ('parallel_blobtoolkit_results').
# 2. Make sure 'coverage.bam' and 'blast_results/all_hits.tsv' files exist.
# 3. Submit this script: sbatch filter_and_plot.sh
#
# ==============================================================================

# --- SLURM DIRECTIVES ---
#SBATCH --job-name=blob_filter_plot
#SBATCH --output=slurm_logs/blob_filter_plot.log
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=8
#SBATCH --mem=64G
#SBATCH --time=02:00:00
#SBATCH -A molecolb
#SBATCH -p molecolb

# --- SCRIPT SETUP ---
source ~/.bash_profile
conda activate blobtoolkit_env

echo "--- Starting Final Filtering and Plotting Workflow ---"
echo "Job started on $(date)"

# --- USER INPUT ---
INITIAL_ASSEMBLY="../pilon_reference/Pilontrial4thround.fasta"
COVERAGE_BAM="coverage.bam"
MERGED_HITS_FILE="blast_results/all_hits.tsv"
TAXONOMY_FILES_DIR="../"
TAXONOMY_NODES="${TAXONOMY_FILES_DIR}/nodes.dmp"
TAXONOMY_NAMES="${TAXONOMY_FILES_DIR}/names.dmp"
MIN_SCAFFOLD_LENGTH=1000
BLOBTOOLS_EXEC="/home/bop21kgl/.conda/envs/blobtoolkit_env/bin/blobtools"

# --- SCRIPT LOGIC ---

# Step 1: Create a filtered FASTA file and lists of scaffolds to KEEP
echo "[1/6] Filtering assembly to keep scaffolds > ${MIN_SCAFFOLD_LENGTH} bp..."
FILTERED_ASSEMBLY="assembly.filtered.fasta"
SCAFFOLDS_TO_KEEP_LIST="scaffolds_to_keep.txt"
SCAFFOLDS_TO_KEEP_BED="scaffolds_to_keep.bed"

samtools faidx "${INITIAL_ASSEMBLY}"
awk -v min_len="${MIN_SCAFFOLD_LENGTH}" '$2 >= min_len {print $1}' "${INITIAL_ASSEMBLY}.fai" > "${SCAFFOLDS_TO_KEEP_LIST}"
awk -v min_len="${MIN_SCAFFOLD_LENGTH}" 'BEGIN{OFS="\t"} $2 >= min_len {print $1, "0", $2}' "${INITIAL_ASSEMBLY}.fai" > "${SCAFFOLDS_TO_KEEP_BED}"

# *** THE CRUCIAL FIX: Create the filtered FASTA file ***
samtools faidx "${INITIAL_ASSEMBLY}" -r "${SCAFFOLDS_TO_KEEP_LIST}" > "${FILTERED_ASSEMBLY}"
echo "-> Created filtered assembly with $(wc -l < ${SCAFFOLDS_TO_KEEP_LIST}) scaffolds."
echo

# Step 2: Filter the BLAST hits file
echo "[2/6] Filtering BLAST hits file..."
FILTERED_HITS_FILE="blast_results/all_hits.filtered.tsv"
grep -Fwf "${SCAFFOLDS_TO_KEEP_LIST}" "${MERGED_HITS_FILE}" > "${FILTERED_HITS_FILE}"
echo "-> Filtered hits file created."
echo

# Step 3: Filter the Coverage BAM file
echo "[3/6] Filtering coverage BAM file..."
FILTERED_BAM_FILE="coverage.filtered.bam"
samtools view -@ "${SLURM_NTASKS_PER_NODE}" -b -L "${SCAFFOLDS_TO_KEEP_BED}" "${COVERAGE_BAM}" > "${FILTERED_BAM_FILE}"
samtools index "${FILTERED_BAM_FILE}"
echo "-> Filtered BAM file created."
echo

# Step 4: Create BlobDir using the FULLY FILTERED inputs
echo "[4/6] Creating BlobToolKit directory..."
OUTPUT_PREFIX="Seychelles_Warbler_Contamination_Filtered"
# *** THE CRUCIAL FIX: Use the filtered assembly as the main input ***
${BLOBTOOLS_EXEC} create -i "${FILTERED_ASSEMBLY}" \
                 -b "${FILTERED_BAM_FILE}" \
                 -t "${FILTERED_HITS_FILE}" \
                 --nodes "${TAXONOMY_NODES}" \
                 --names "${TAXONOMY_NAMES}" \
                 -o "${OUTPUT_PREFIX}" \
                 --title "Seychelles Warbler Contamination Screen (Filtered)"
echo "-> BlobDir created."
echo

# Step 5: Generate Plots
echo "[5/6] Generating plots..."
${BLOBTOOLS_EXEC} view -i "${OUTPUT_PREFIX}/blobDB.json" -r all
${BLOBTOOLS_EXEC} plot -i "${OUTPUT_PREFIX}/blobDB.json"
echo "-> Plotting complete."
echo

# Step 6: Final Check
echo "[6/6] Final check..."
if [ -f "${OUTPUT_PREFIX}/blobDB.plot.blob.png" ]; then
    echo "--- SUCCESS! ---"
    echo "Final plot created at: ${OUTPUT_PREFIX}/blobDB.plot.blob.png"
else
    echo "--- FAILURE ---"
    echo "ERROR: Final plot was not created. Please check the log."
fi

echo "Job ended on $(date)"


