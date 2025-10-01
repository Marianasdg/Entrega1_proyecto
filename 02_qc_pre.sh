#!/usr/bin/env bash
set -euo pipefail

# Carpeta de entrada donde están los .fastq.gz
IN="data/fastq"

# Carpeta de salida para resultados de QC
OUT="qc/pre"
mkdir -p "${OUT}"

# Ejecutar FastQC en los seis archivos
fastqc -o "${OUT}" -t 4 \
  "${IN}/anc_R1.fastq.gz" \
  "${IN}/anc_R2.fastq.gz" \
  "${IN}/evol1_R1.fastq.gz" \
  "${IN}/evol1_R2.fastq.gz" \
  "${IN}/evol2_R1.fastq.gz" \
  "${IN}/evol2_R2.fastq.gz"

# Ejecutar MultiQC para resumir los resultados
multiqc -o "${OUT}" "${OUT}"

echo "[OK] QC inicial en ${OUT}"