# Day 1: QC, Trimming, PhiX Removal

## Dataset
- SRA accession: ERR019289 (Vibrio cholerae, public SRA)
- Read length: 53bp (short — caused fragmented assembly later, see day2 notes)

## Steps
1. Downloaded reads via `fasterq-dump`
2. Trimmed adapters/quality with Trimmomatic — 94.89% pairs survived
3. Removed PhiX contamination with Bowtie2 — 0% aligned (already clean)

## Key lesson learned
Short reads (53bp) caused 314-contig fragmented assembly with Unicycler.
Repeats longer than read length can't be resolved. Need 100bp+ reads for
a clean bacterial genome assembly.
