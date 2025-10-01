#!/usr/bin/env bash
set -euo pipefail

IN_RAW="../data/fastq"
IN_TRIM="../data/trimmed"
OUT="assembly/spades"
FINAL="data/spades"

mkdir -p "${OUT}" "${FINAL}"

# MODIFICAR SEGÚN CARACTERÍSTICAS DEL COMPUTADOR 
THREADS=12
MEM=14

READ1_RAW="${IN_RAW}/anc_R1.fastq.gz"
READ2_RAW="${IN_RAW}/anc_R2.fastq.gz"

echo "==> Ensamblando lecturas SIN trimming..."
spades.py \
    -1 "${READ1_RAW}" \
    -2 "${READ2_RAW}" \
    -t "${THREADS}" \
    -m "${MEM}" \
    --careful \
    -o "${OUT}/raw"

cp "${OUT}/raw/contigs.fasta" "${FINAL}/contigs_raw.fasta"
cp "${OUT}/raw/scaffolds.fasta" "${FINAL}/scaffolds_raw.fasta"

READ1_TRIM="${IN_TRIM}/anc_R1.trim.fastq.gz"
READ2_TRIM="${IN_TRIM}/anc_R2.trim.fastq.gz"

echo "==> Ensamblando lecturas CON trimming..."
spades.py \
    -1 "${READ1_TRIM}" \
    -2 "${READ2_TRIM}" \
    -t "${THREADS}" \
    -m "${MEM}" \
    --careful \
    -o "${OUT}/trimmed"

cp "${OUT}/trimmed/contigs.fasta" "${FINAL}/contigs_trimmed.fasta"
cp "${OUT}/trimmed/scaffolds.fasta" "${FINAL}/scaffolds_trimmed.fasta"

echo "==> Ensamblajes finalizados y guardados en ${FINAL}"
