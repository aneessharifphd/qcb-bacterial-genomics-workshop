#!/bin/bash
trimmomatic PE -phred33 \
  ERR019289_1.fastq ERR019289_4.fastq \
  ERR019289_1.trimmed.fastq ERR019289_1.unpaired.fastq \
  ERR019289_2.trimmed.fastq ERR019289_2.unpaired.fastq \
  ILLUMINACLIP:$CONDA_PREFIX/share/trimmomatic-0.40-0/adapters/TruSeq3-PE.fa:2:30:10 \
  LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36
