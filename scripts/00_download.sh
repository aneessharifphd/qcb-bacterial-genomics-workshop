#!/bin/bash
# Usage: ./00_download.sh <accession>
mkdir -p data
ACCESSION=$1
wget -c "ftp://ftp.sra.ebi.ac.uk/vol1/fastq/${ACCESSION:0:6}/0${ACCESSION: -2}/${ACCESSION}/${ACCESSION}_1.fastq.gz" -P data/
wget -c "ftp://ftp.sra.ebi.ac.uk/vol1/fastq/${ACCESSION:0:6}/0${ACCESSION: -2}/${ACCESSION}/${ACCESSION}_2.fastq.gz" -P data/
