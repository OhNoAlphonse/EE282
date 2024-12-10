#!/bin/bash

##Calculate sequence statistics before moving to R


#GC content
- for sequences ≤ 100kb:
bioawk -c fastx '{if (length($seq) <= 100000) print $name, length($seq), gc($seq)}' dmel-all-chromosome-r6.48.fasta > sequences_short.tsv

- for sequences > 100kb
bioawk -c fastx '{if (length($seq) > 100000) print $name, length($seq), gc($seq)}' dmel-all-chromosome-r6.48.fasta > sequences_long.tsv


#Cumulative Sequence Sizes
- for sequences ≤ 100kb
bioawk -c fastx '{if (length($seq) <= 100000) print length($seq)}' dmel-all-chromosome-r6.48.fasta | sort -nr > cumulative_short.txt

- for sequences > 100kb
bioawk -c fastx '{if (length($seq) > 100000) print length($seq)}' dmel-all-chromosome-r6.48.fasta | sort -nr > cumulative_long.txt

