#!/bin/bash

set -e

mamba activate ee282

#Install nanoplot and check to make sure it was downloaded
#install nanoplot: pip3 install NanoPlot
#NanoPlot --version

# Create output directories for each genome and condition
mkdir -p ~/output/nanoplots/nanoplot_Naive_unprocessed
mkdir -p ~/output/nanoplots/nanoplot_Large_unprocessed
mkdir -p ~/output/nanoplots/nanoplot_Small_unprocessed
mkdir -p ~/output/nanoplots/nanoplot_Naive_clean
mkdir -p ~/output/nanoplots/nanoplot_Large_clean
mkdir -p ~/output/nanoplots/nanoplot_Small_clean

# Run NanoPlot for unprocessed files
NanoPlot --fastq IJONaive_raw.fastq.gz --outdir ~/output/nanoplots/nanoplot_Naive_unprocessed --verbose
NanoPlot --fastq IJOResLarge_raw.fastq.gz --outdir ~/output/nanoplots/nanoplot_Large_unprocessed --verbose
NanoPlot --fastq IJOResSmall_raw.fastq.gz --outdir ~/output/nanoplots/nanoplot_Small_unprocessed --verbose


# run porechop to trim adapters from nanopore sequencing reads
porechop -i IJONaive_raw.fastq.gz -o IJONaive_processed.fastq.gz --verbosity 2

# Run flitlong to filter the sequencing data
-o IJONaive_clean.fastq.gz

# Cleaned files placeholder (replace these with the actual cleaned file names later)
CLEANED_NAIVE="IJONaive_clean.fastq.gz"
CLEANED_LARGE="IJOResLarge_clean.fastq.gz"
CLEANED_SMALL="IJOResSmall_clean.fastq.gz"

# Run NanoPlot for cleaned files
NanoPlot --fastq $CLEANED_NAIVE --outdir ~/output/nanoplots/nanoplot_Naive_clean --verbose
NanoPlot --fastq $CLEANED_LARGE --outdir ~/output/nanoplots/nanoplot_Large_clean --verbose
NanoPlot --fastq $CLEANED_SMALL --outdir ~/output/nanoplots/nanoplot_Small_clean --verbose

