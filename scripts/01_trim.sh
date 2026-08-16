#!/bin/bash
# Usage: ./01_trim.sh <SRR_or_ERR_accession>

if [ -z "$1" ]; then
  echo "Error: no accession provided."
  echo "Usage: ./01_trim.sh <SRR_or_ERR_accession>"
  exit 1
fi

ACCESSION=$1

trimmomatic PE -phred33 \
  "data/${ACCESSION}_1.fastq.gz" "data/${ACCESSION}_2.fastq.gz" \
  "data/${ACCESSION}_1.trimmed.fastq.gz" "data/${ACCESSION}_1.unpaired.fastq.gz" \
  "data/${ACCESSION}_2.trimmed.fastq.gz" "data/${ACCESSION}_2.unpaired.fastq.gz" \
  ILLUMINACLIP:$CONDA_PREFIX/share/trimmomatic-0.40-0/adapters/TruSeq3-PE.fa:2:30:10 \
  LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36
