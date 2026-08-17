#!/bin/bash
# Usage: ./05_canu_assembly.sh <long_read_sequence>
ACCESSION=$1
mkdir -p results
canu -p vc -d results/${ACCESSION}_canu genomesize=4m \
 -nanopore-raw data/${ACCESSION}_1_trimmed.fastq.gz \
maxThreads=10 maxMemory=8 useGrid=false \
stopOnReadQuality=false
2>&1 | tee logs/${ACCESSION}_canu.log
