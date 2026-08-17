# SRR32861756 — Day 4: Short-read Assembly (Unicycler)

## Command
Ran via `scripts/03_assembly.sh SRR32861756`

## Results
- Contigs: [73]
- Total assembly length (bp): [3900565]
- Circular contigs: N/A

## Environments

- Unicycler version: [v0.5.1]
- Installed via: `conda create -n unicycler -c bioconda -c conda-forge unicycler`
- Full environment snapshot: `envs/unicycler.yml`


## Comparison to ERR019289
- ERR019289 (53bp short reads): 314 contigs, highly fragmented
- SRR32861756 (this run, short-read only): [73] contigs

## Notes
(Now 73 contigs are obtained and N50=389289)
