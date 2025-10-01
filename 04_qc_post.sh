#!/usr/bin/env bash
set -euo pipefail

IN="data/trimmed"    # fastq filtrados
OUT="qc/post"        # salida QC post-trimming
mkdir -p "${OUT}"

# Verifica que existan archivos fastq.gz en la carpeta
ls "${IN}"/*.fastq.gz > /dev/null

# FastQC post-trimming
fastqc -o "${OUT}" -t 4 "${IN}"/*.fastq.gz

# MultiQC: combina fastqc + reportes de fastp
multiqc "${OUT}" "qc/fastp" -o "${OUT}"

echo "[OK] QC post-trimming completado en ${OUT}"
