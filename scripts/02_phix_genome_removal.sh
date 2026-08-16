#!/bin/bash
# Usage: ./02_phix_genome_removal.sh <SRR_or_ERR_accession>
# Requires: bowtie2, wget. Input: data/<ACCESSION>_{1,2}.trimmed.fastq.gz
#           and data/<ACCESSION>_{1,2}.unpaired.fastq.gz (from 01_trim.sh)

set -e   # stop immediately if any command fails, instead of limping on

if [ -z "$1" ]; then
  echo "Error: no accession provided."
  echo "Usage: ./02_phix_genome_removal.sh <SRR_or_ERR_accession>"
  exit 1
fi

ACCESSION=$1
mkdir -p data results/"${ACCESSION}" logs references

TRIM1="data/${ACCESSION}_1.trimmed.fastq.gz"
TRIM2="data/${ACCESSION}_2.trimmed.fastq.gz"
UNPAIRED1="data/${ACCESSION}_1.unpaired.fastq.gz"
UNPAIRED2="data/${ACCESSION}_2.unpaired.fastq.gz"
UNPAIRED_COMBINED="data/${ACCESSION}_unpaired_combined.fastq.gz"

# Shared across all datasets — do NOT put this inside a per-accession folder
PHIX_REF="references/NC_001422.fna"
PHIX_INDEX="references/phix_index"

LOG="logs/${ACCESSION}_phix_removal.log"

echo "=== PhiX removal for ${ACCESSION} — $(date) ===" | tee "${LOG}"

# --- Step 0: sanity check inputs exist ---
for f in "${TRIM1}" "${TRIM2}" "${UNPAIRED1}" "${UNPAIRED2}"; do
  if [ ! -s "${f}" ]; then
    echo "Error: expected input file missing or empty: ${f}" | tee -a "${LOG}"
    exit 1
  fi
done

# --- Step 1: get the PhiX reference genome (only if not already present) ---
if [ ! -s "${PHIX_REF}" ]; then
  echo "Downloading PhiX reference genome (NC_001422)..." | tee -a "${LOG}"
  wget -q -O "${PHIX_REF}" \
    "https://eutils.ncbi.nlm.nih.gov/entrez/eutils/efetch.fcgi?db=nuccore&id=NC_001422&rettype=fasta&retmode=text"
else
  echo "PhiX reference already present, skipping download." | tee -a "${LOG}"
fi

# --- Step 2: build Bowtie2 index (only if not already built) ---
if [ ! -s "${PHIX_INDEX}.1.bt2" ]; then
  echo "Building Bowtie2 index for PhiX..." | tee -a "${LOG}"
  bowtie2-build "${PHIX_REF}" "${PHIX_INDEX}" >> "${LOG}" 2>&1
else
  echo "Bowtie2 index already built, skipping." | tee -a "${LOG}"
fi

# --- Step 3: combine unpaired reads into one file ---
echo "Combining unpaired reads..." | tee -a "${LOG}"
cat "${UNPAIRED1}" "${UNPAIRED2}" > "${UNPAIRED_COMBINED}"

# --- Step 4: QC — check what fraction of UNPAIRED reads are PhiX contamination ---
echo "Checking PhiX contamination in unpaired reads..." | tee -a "${LOG}"
bowtie2 -x "${PHIX_INDEX}" \
  -U "${UNPAIRED_COMBINED}" \
  -S results/"${ACCESSION}"/phix_unpaired_mapped.sam \
  2>&1 | tee -a "${LOG}"

# --- Step 5: align PAIRED trimmed reads against PhiX, keep only non-PhiX reads ---
echo "Aligning paired reads against PhiX and removing matches..." | tee -a "${LOG}"
bowtie2 -x "${PHIX_INDEX}" \
  -1 "${TRIM1}" \
  -2 "${TRIM2}" \
  --un-conc-gz "data/${ACCESSION}_noPhiX.fastq.gz" \
  -S results/"${ACCESSION}"/phix_paired_mapped.sam \
  2>&1 | tee -a "${LOG}"

# --- Step 6: rename Bowtie2's default output names to something clear ---
# Note: bowtie2 --un-conc-gz inserts .1/.2 BEFORE the .gz extension,
# e.g. "prefix.fastq.gz" -> "prefix.fastq.1.gz" and "prefix.fastq.2.gz"
mv "data/${ACCESSION}_noPhiX.fastq.1.gz" "data/${ACCESSION}_1.clean.fastq.gz"
mv "data/${ACCESSION}_noPhiX.fastq.2.gz" "data/${ACCESSION}_2.clean.fastq.gz"

echo "=== Done. Clean reads: data/${ACCESSION}_1.clean.fastq.gz , data/${ACCESSION}_2.clean.fastq.gz ===" | tee -a "${LOG}"
echo "Full log saved to ${LOG}"
