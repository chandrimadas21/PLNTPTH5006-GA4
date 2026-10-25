#!/bin/bash
set -euo pipefail

# Run TrimGalore on paired-end R1 and R2 FASTQ files and run FastQC on the trimmed reads
# Usage: bash scripts/trimgalore.sh <R1 FASTQ file> <R2 FASTQ file> <output dir>

# TrimGalore container
CONTAINER=oras://community.wave.seqera.io/library/trim-galore:2.3.0--a56e49e832976df4

# Copy the placeholder variables
fastq_r1="$1"
fastq_r2="$2"
outdir="$3"

# Initial logging
echo "Starting script trimgalore.sh"
date
echo "R1 FASTQ file:   $fastq_r1"
echo "R2 FASTQ file:   $fastq_r2"
echo "Output dir:      $outdir"
echo

# Check that both input FASTQ files exist
if [[ ! -f "$fastq_r1" ]]; then
    echo "Error: R1 FASTQ file not found: $fastq_r1" >&2
    exit 1
fi
if [[ ! -f "$fastq_r2" ]]; then
    echo "Error: R2 FASTQ file not found: $fastq_r2" >&2
    exit 1
fi

# Create the output dir if needed
mkdir -p "$outdir"

# Run TrimGalore
apptainer exec "$CONTAINER" trim_galore \
    --paired \
    --output_dir "$outdir" \
    --fastqc \
    "$fastq_r1" "$fastq_r2"

# Final logging
echo
echo "Successfully finished script trimgalore.sh"
date