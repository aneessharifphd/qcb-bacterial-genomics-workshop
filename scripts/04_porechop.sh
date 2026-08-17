#!/bin/bash
# Usage: ./04_porechop.sh <long_read_accession>
ACCESSION=$1
mkdir -p data
porechop \
-i "data/${ACCESSION}.fastq.gz" \
-o "data/${ACCESSION}_trimmed.fastq.gz" \
--threads 8
2>&1 | tee logs/${ACCESSION}_porechop.log
