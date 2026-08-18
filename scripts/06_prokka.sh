#!/bin/bash
# Usage: ./06_prokka.sh <ACCESSION>

if [-z "$1"]; then
 echo "Error: No ACCESSION provided"
 echo "Usage: ./06_prokka.sh <ACCESSION>"
 exit 1

fi
ACCESSION=$1

prokka \
--outdir "results/annotation/${ACCESSION}" \
--prefix "${ACCESSION}" \
--locustag "${AACESSION}" \
--genus Vibrio \
--species cholerae \
--strain "${ACCESSION}" \
--cpus 10 \
--force \
"results/${ACCESSION}/unicycler.output/assembly.fasta" \
2>&1 | tee logs/${ACCESSION}_prokka.log
