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
--locustag "${ACCESSION}" \
--genus Vibrio \
--species vulnificus \
--strain "${ACCESSION}" \
--cpus 10 \
--force \
"../results/Vcholerae_genomes/${ACCESSION}.fasta" \
2>&1 | tee logs/${ACCESSION}_prokka.log
