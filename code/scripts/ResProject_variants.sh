#!/bin/bash
#SBATCH --job-name=IJO_variants
#SBATCH --output=IJOmummer_output.log
#SBATCH --error=IJOmummer__error.lo
#SBATCH -A CLASS_EE282
#SBATCH -p standard
#SBATCH --time=8:00:00
#SBATCH --cpus-per-task=16
#SBATCH --mem=32G

Set e-

#Download mummer
#Mamba install mummer

#use nucmer to align sequences
#nucmer --prefix=IJONaive_vs_IJOLarge IJONaive_simplified.fasta IJOLarge_simplified.fasta


#this worked!!!

#filter the alignments to focus on regions of interest
#delta-filter -r -q IJONaive_vs_IJOLarge.delta > IJONaive_vs_IJOLarge.filtered.delta


#This worked!! 

#use show-snps to create a variant list of SNPS and other variations
show-snps -Clr IJONaive_vs_IJOLarge.filtered.delta > IJONaive_vs_IJOLarge.snps




#Later:
#Convert to CSV to use in ggplot
#awk

#plot variants in ggplot using the following:
