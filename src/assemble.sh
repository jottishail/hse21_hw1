#!/bin/bash

set -eux

frac=$1
seed=1705
THREADS=${THREADS:-1}  # по умолчанию 1 поток

logfile=assemble_$frac.log

rm -rf out_*  # файлы из 1-й части, если они остались

if [ ! -d data ]; then
    mkdir data
    seqtk sample -s$seed assembly/oil_R1.fastq 5000000 > data/R1_sample.fastq
    seqtk sample -s$seed assembly/oil_R2.fastq 5000000 > data/R2_sample.fastq
    seqtk sample -s$seed assembly/oilMP_S4_L001_R1_001.fastq 1500000 > data/R1_MP_sample.fastq
    seqtk sample -s$seed assembly/oilMP_S4_L001_R2_001.fastq 1500000 > data/R2_MP_sample.fastq
fi

mkdir -p partial_data
for file in $(ls data); do
    seqtk sample -s$seed data/$file $frac > partial_data/$file
done

platanus_trim -t $THREADS partial_data/R?_sample.fastq 2>>$logfile
platanus_internal_trim -t $THREADS partial_data/R?_MP_sample.fastq 2>>$logfile
rm partial_data/*.fastq

platanus assemble -t $THREADS -f partial_data/R?_sample.fastq.trimmed 2>>$logfile
platanus scaffold -t $THREADS -c out_contig.fa -IP1 partial_data/R{1,2}_sample.fastq.trimmed -OP2 partial_data/R{1,2}_MP_sample.fastq.int_trimmed 2>>$logfile
rm *.tsv *Bubble.fa

platanus gap_close -t $THREADS -c out_scaffold.fa -IP1 partial_data/R{1,2}_sample.fastq.trimmed -OP2 partial_data/R{1,2}_MP_sample.fastq.int_trimmed  2>>$logfile
rm -r partial_data/

mv out_gapClosed.fa scaffolds_$frac.fasta
rm out_*
