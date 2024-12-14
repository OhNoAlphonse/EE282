#!/bin/bash

#!/bin/bash
#SBATCH --job-name=ResProject_QC
#SBATCH --error=ProjectQC_error.log
#SBATCH --time=6:00:00
#SBATCH --cpus-per-task=16
#SBATCH --mem=64G

set -e

mamba activate ee282

#Install nanoplot and check to make sure it was downloaded
#install nanoplot: pip3 install NanoPlot
#NanoPlot --version

# Create output directories for each genome and condition
#mkdir -p ~/output/nanoplots/nanoplot_Naive_unprocessed
mkdir -p ~/output/nanoplots/nanoplot_Large_unprocessed
mkdir -p ~/output/nanoplots/nanoplot_Small_unprocessed
mkdir -p ~/output/nanoplots/nanoplot_Naive_clean
mkdir -p ~/output/nanoplots/nanoplot_Large_clean
mkdir -p ~/output/nanoplots/nanoplot_Small_clean

# Run NanoPlot for unprocessed files
#NanoPlot --fastq IJONaive_raw.fastq.gz --outdir ~/output/nanoplots/nanoplot_Naive_unprocessed --verbose
NanoPlot --fastq IJOResLarge_raw.fastq.gz --outdir ~/output/nanoplots/nanoplot_Large_unprocessed --verbose
NanoPlot --fastq IJOResSmall_raw.fastq.gz --outdir ~/output/nanoplots/nanoplot_Small_unprocessed --verbose


# run porechop to trim adapters from nanopore sequencing reads
#porechop -i IJONaive_raw.fastq.gz -o IJONaive_processed.fastq.gz --verbosity 2
porechop -i IJOResLarge_raw.fastq.gz -o IJOResLarge_processed.fastq.gz --verbosity 2
porechop -i IJOResSmall_raw.fastq.gz -o IJOResSmall_processed.fastq.gz --verbosity 2

# Run flitlong to filter the sequencing data
#./Filtlong/bin/filtlong --min_length 1000 --keep_percent 90 IJONaive_processed.fastq.gz > IJONaive_clean.fastq
./Filtlong/bin/filtlong --min_length 1000 --keep_percent 90 IJOResLarge_processed.fastq.gz > IJOResLarge_clean.fastq
./Filtlong/bin/filtlong --min_length 1000 --keep_percent 90 IJOResSmall_processed.fastq.gz > IJOResSmall_clean.fastq

# Cleaned files placeholder
CLEANED_NAIVE="IJONaive_clean.fastq"
CLEANED_LARGE="IJOResLarge_clean.fastq"
CLEANED_SMALL="IJOResSmall_clean.fastq"

# Run NanoPlot for cleaned files
NanoPlot --fastq $CLEANED_NAIVE --outdir ~/output/nanoplots/nanoplot_Naive_clean --verbose
NanoPlot --fastq $CLEANED_LARGE --outdir ~/output/nanoplots/nanoplot_Large_clean --verbose
NanoPlot --fastq $CLEANED_SMALL --outdir ~/output/nanoplots/nanoplot_Small_clean --verbose

