#!/bin/bash
# Usage: ./script/03_assembly.sh <SRR_or_ERR_ACCESSION>
ACCESSION=$1
mkdir -p results/${ACCESSION}
unicycler \
-1 data/${ACCESSION}_1.clean.fastq.gz \
-2 data/${ACCESSION}_2.clean.fastq.gz \
-s data/${ACCESSION}_unpaired_combined.fastq.gz \
-o results/${ACCESSION}/unicycler.output \
-t 10 \
--spades_options "-m 6144" \
2>&1 | tee logs/${ACCESSION}_assembly.log
