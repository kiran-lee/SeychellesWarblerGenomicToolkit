#!/bin/bash

# ==============================================================================
# SLURM SCRIPT FOR HYBRID MITOGENOME ASSEMBLY WITH UNICYCLER
#
# Description:
# This script performs a hybrid assembly using both long PacBio reads and
# short Illumina reads to resolve the complex mitochondrial genome.
#
# --- INSTRUCTIONS ---
#
# 1. Ensure your filtered PacBio and Illumina reads exist.
# 2. Create a new conda environment for Unicycler:
#    conda create -n unicycler_env -c bioconda unicycler -y
# 3. Save this script as 'run_unicycler_hybrid.sh'.
# 4. Make it executable: chmod +x run_unicycler_hybrid.sh
# 5. Submit the job to SLURM: sbatch run_unicycler_hybrid.sh
#
# ==============================================================================

# --- SLURM DIRECTIVES ---
#SBATCH --job-name=unicycler_mtdna_conservative
#SBATCH --output=unicycler_mtdna_conservative.log
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=16
#SBATCH --mem=64G   # Unicycler can be memory-intensive
#SBATCH --time=48:00:00
#SBATCH -A molecolb
#SBATCH -p molecolb

# --- SCRIPT SETUP ---
source ~/.bash_profile
# Activate the dedicated environment for Unicycler
conda activate circlator_env

echo "Job started on $(date)"
echo "Running on node: $(hostname)"
echo

# --- DEFINE FILE PATHS ---
# The filtered, high-accuracy Illumina reads
ILLUMINA_READS_1="meta_pool_filtering/mtdna_only_R1.repaired.fastq.gz"
ILLUMINA_READS_2="meta_pool_filtering/mtdna_only_R2.repaired.fastq.gz"

# The filtered, long PacBio reads
PACBIO_READS="pacbio_mtdna_filter/pacbio_mtdna_reads.fastq.gz"

# Define the output directory for Unicycler
OUTPUT_DIR="unicycler_hybrid_assembly_conservative"

# --- CHECK FOR INPUT FILES ---
if [ ! -s "$ILLUMINA_READS_1" ] || [ ! -s "$ILLUMINA_READS_2" ]; then
    echo "ERROR: Input Illumina reads not found in meta_pool_filtering/"
    exit 1
fi
if [ ! -s "$PACBIO_READS" ]; then
    echo "ERROR: Input PacBio reads not found in pacbio_mtdna_filter/"
    exit 1
fi

# --- RUN UNICYCLER ---
echo "Starting hybrid assembly with Unicycler..."

unicycler -1 "${ILLUMINA_READS_1}" \
          -2 "${ILLUMINA_READS_2}" \
          -l "${PACBIO_READS}" \
          -o "${OUTPUT_DIR}" \
          --threads "${SLURM_NTASKS_PER_NODE}" \
          --mode conservative

echo "-> Unicycler finished."
echo

# --- FINAL CHECK ---
FINAL_ASSEMBLY="${OUTPUT_DIR}/assembly.fasta"
if [ -s "$FINAL_ASSEMBLY" ]; then
    echo
    echo "--- SUCCESS! ---"
    echo "Successfully assembled the hybrid mitogenome."
    # Unicycler often produces multiple contigs, we need to find the circular one
    CIRCULAR_CONTIGS=$(grep -c 'circular=true' "${FINAL_ASSEMBLY}")
    if [ "$CIRCULAR_CONTIGS" -gt 0 ]; then
        echo "Found ${CIRCULAR_CONTIGS} circular contig(s) in the output."
        echo "The final assembly is located at: ${FINAL_ASSEMBLY}"
    else
        echo "WARNING: Unicycler finished but did not produce a circular contig. Manual inspection of ${FINAL_ASSEMBLY} is needed."
    fi
else
    echo
    echo "--- FAILURE ---"
    echo "ERROR: Unicycler did not produce an assembly.fasta file. Please check the log."
fi

echo
echo "Job ended on $(date)"

