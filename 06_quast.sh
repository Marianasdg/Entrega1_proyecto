#!/usr/bin/env bash
set -euo pipefail

IN="data/spades"
OUT="assembly/quast"

mkdir -p "${OUT}"

echo "==> Corriendo QUAST para comparar ensamblajes..."

quast.py \
    "${IN}/contigs_raw.fasta" \
    "${IN}/scaffolds_raw.fasta" \
    "${IN}/contigs_trimmed.fasta" \
    "${IN}/scaffolds_trimmed.fasta" \
    -o "${OUT}" \
    --threads 12

echo "==> Resultados disponibles en ${OUT}/report.html"
