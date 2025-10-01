#!/usr/bin/env bash
set -euo pipefail

IN="data/fastq"          # carpeta de los fastq crudos
OUTD="data/trimmed"      # salida de fastq ya filtrados
QCD="qc/fastp"           # reportes de fastp
mkdir -p "${OUTD}" "${QCD}"

########################################
# Illumina paired-end
########################################
fastp \
  -i "${IN}/anc_R1.fastq.gz" -I "${IN}/anc_R2.fastq.gz" \
  -o "${OUTD}/anc_R1.trim.fastq.gz" \
  -O "${OUTD}/anc_R2.trim.fastq.gz" \
  --detect_adapter_for_pe \
  --qualified_quality_phred 20 \
  --length_required 30 \
  --cut_front --cut_tail --cut_mean_quality 20 \
  --thread 4 \
  --html "${QCD}/fastp_anc.html" \
  --json "${QCD}/fastp_anc.json"

fastp \
  -i "${IN}/evol1_R1.fastq.gz" -I "${IN}/evol1_R2.fastq.gz" \
  -o "${OUTD}/evol1_R1.trim.fastq.gz" \
  -O "${OUTD}/evol1_R2.trim.fastq.gz" \
  --detect_adapter_for_pe \
  --qualified_quality_phred 20 \
  --length_required 30 \
  --cut_front --cut_tail --cut_mean_quality 20 \
  --thread 4 \
  --html "${QCD}/fastp_evol1.html" \
  --json "${QCD}/fastp_evol1.json"

fastp \
  -i "${IN}/evol2_R1.fastq.gz" -I "${IN}/evol2_R2.fastq.gz" \
  -o "${OUTD}/evol2_R1.trim.fastq.gz" \
  -O "${OUTD}/evol2_R2.trim.fastq.gz" \
  --detect_adapter_for_pe \
  --qualified_quality_phred 20 \
  --length_required 30 \
  --cut_front --cut_tail --cut_mean_quality 20 \
  --thread 4 \
  --html "${QCD}/fastp_evol2.html" \
  --json "${QCD}/fastp_evol2.json"

echo "[OK] Trimming con fastp completado. FASTQ limpios en ${OUTD}, reportes en ${QCD}"