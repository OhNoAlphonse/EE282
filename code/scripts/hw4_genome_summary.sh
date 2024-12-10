#!/bin/bash

# Summarize Genome Assembly

## Downloading file
wget https://ftp.flybase.net/releases/FB2022_05/dmel_r6.48/fasta/dmel-all-chromosome-r6.48.fasta.gz


## File Integrity - downloads checksum file
wget https://ftp.flybase.net/releases/FB2022_05/dmel_r6.48/fasta/md5sum.txt
md5sum --check <(grep dmel-all-chromosome-r6.48.fasta.gz md5sum.txt)

## Define input and output files
gunzip dmel-all-chromosome-r6.48.fasta.gz
SHORT_SEQ_OUTPUT="short_sequences.fasta"
LONG_SEQ_OUTPUT="long_sequences.fasta"

## Partition the genome
bioawk -c fastx '{ if (length($seq) <= 100000) { print ">"$name"\n"$seq } }' dmel-all-chromosome-r6.48.fasta > $SHORT_SEQ_OUTPUT
bioawk -c fastx '{ if (length($seq) > 100000) { print ">"$name"\n"$seq } }' dmel-all-chromosome-r6.48.fasta > $LONG_SEQ_OUTPUT

## Function to calculate statistics
calculate_stats() {
    FILE=$1
    echo "File: $FILE"
    echo "Total nucleotides: $(bioawk -c fastx '{ sum += length($seq) } END { print sum }' $FILE)"
    echo "Total Ns: $(bioawk -c fastx '{ gsub(/[^N]/, "", $seq); sum += length($seq) } END { print sum }' $FILE)"
    echo "Total sequences: $(bioawk -c fastx 'END { print NR }' $FILE)"
    echo
}

## Calculate statistics for both partitions
calculate_stats $SHORT_SEQ_OUTPUT
calculate_stats $LONG_SEQ_OUTPUT

## Use files in R to create plots -R script and plots in Homework4.md
