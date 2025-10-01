#!/usr/bin/env bash
# Script de mapeo de lecturas evolucionadas contra el genoma ancestral
set -e

# ===========================
# Configuración
# ===========================
GENOMA="data/spades/scaffolds_trimmed.fasta"
OUT="mapping"
THREADS=4

# Lecturas evolucionadas (ajustado a los nombres REALES)
EV1_R1="/home/marisdg04/bioinformatica/proyecto/data/fastq/evol1_R1.fastq.gz"
EV1_R2="/home/marisdg04/bioinformatica/proyecto/data/fastq/evol1_R2.fastq.gz"

EV2_R1="/home/marisdg04/bioinformatica/proyecto/data/fastq/evol2_R1.fastq.gz"
EV2_R2="/home/marisdg04/bioinformatica/proyecto/data/fastq/evol2_R2.fastq.gz"

mkdir -p "${OUT}"

# ===========================
# Indexar genoma
# ===========================
echo ">>> Indexando genoma ancestral con BWA..."
bwa index "${GENOMA}"

# ===========================
# Función para mapear cada evolución
# ===========================
mapear() {
    R1=$1
    R2=$2
    PREFIX=$3

    echo ">>> Alineando ${PREFIX}..."
    bwa mem -t "${THREADS}" "${GENOMA}" "${R1}" "${R2}" > "${OUT}/${PREFIX}.sam"

    echo ">>> Convirtiendo SAM → BAM..."
    samtools view -bS "${OUT}/${PREFIX}.sam" > "${OUT}/${PREFIX}.bam"

    echo ">>> Ordenando BAM..."
    samtools sort "${OUT}/${PREFIX}.bam" -o "${OUT}/${PREFIX}.sorted.bam"

    echo ">>> Indexando BAM..."
    samtools index "${OUT}/${PREFIX}.sorted.bam"

    echo ">>> Calculando estadísticas..."
    samtools flagstat "${OUT}/${PREFIX}.sorted.bam" > "${OUT}/${PREFIX}.flagstat.txt"
    samtools stats "${OUT}/${PREFIX}.sorted.bam" > "${OUT}/${PREFIX}.stats.txt"

    echo "✔ Listo: ${OUT}/${PREFIX}.sorted.bam y ${OUT}/${PREFIX}.sorted.bam.bai"
}

# ===========================
# Ejecutar para Evo1 y Evo2
# ===========================
mapear "${EV1_R1}" "${EV1_R2}" "evo1"
mapear "${EV2_R1}" "${EV2_R2}" "evo2"

echo ">>> Mapeo terminado. Archivos disponibles en ${OUT}/"
