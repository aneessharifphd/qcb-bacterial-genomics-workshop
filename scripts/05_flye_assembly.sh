#!/bin/bash
# Usage: ./05_flye_assembly.sh <long_read_accession>
ACCESSION=$1
mkdir -p results logs
flye \
--nano-raw data/${ACCESSION}_1_trimmed.fastq.gz \
--genome-size 4m \
--out-dir results/${ACCESSION}_flye \
--threads 10 \
2>&1 | tee logs/${ACCESSION}_flye.log
