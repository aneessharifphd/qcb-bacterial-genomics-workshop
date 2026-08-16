# SRR32861756 — Day 3: PhiX Removal

## Command
Ran via `scripts/02_phix_genome_removal.sh SRR32861756`

## Results
- Unpaired reads checked: 60,525 — 0.00% aligned to PhiX
- Paired reads checked: 3,088,296 pairs — 0.00% aligned to PhiX
- Conclusion: no PhiX contamination detected

## Comparison to ERR019289
Same result as ERR019289 (0% PhiX). Suggests source data (SRA/ENA) is
pre-filtered for PhiX before deposition — this step may be a formality
for future datasets from the same source, but worth keeping as a
verification step.

## Output
Clean reads ready for assembly:
- data/SRR32861756_1.clean.fastq.gz
- data/SRR32861756_2.clean.fastq.gz
