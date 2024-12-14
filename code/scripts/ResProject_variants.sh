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
head -10 IJONaive_vs_IJOLarge.snps

#Convert to CSV to use in ggplot
awk 'NR > 5 { print $1 "," $2 "," $3 "," $4 "," (($3 == ".") ? "Insertion" : ($4 == ".") ? "Deletion" : "SNP") }' IJONaive_vs_IJOLarge.snps > IJONaive_vs_IJOLarge.csv
head IJONaive_vs_IJOLarge.csv
sed -i '1iReference_Position,Ref_Base,Query_Base,Query_Position,Type' IJONaive_vs_IJOLarge.csv
head IJONaive_vs_IJOLarge.csv


#plot variants in ggplot using the following:

# Load required libraries
#library(ggplot2)

#set working directory
#setwd("C:/Users/raygo/OneDrive/Academics/PhD Classes and TAing/Bioinformatics/Project")


# Set the path to your CSV file
#file_path <- "C:/Users/raygo/OneDrive/Academics/PhD Classes and TAing/Bioinformatics/Project/IJONaive_vs_IJOLarge.csv"

# Read in the CSV file
#snps_data <- read.csv(file_path)

# Check the structure of the data
#str(snps_data)

# Ensure the data has the necessary columns for plotting
# Assuming your CSV file has columns: Position, Reference, Variant, and some measure of significance (e.g., Score)

# Check data structure
#print(colnames(snps_data))

#ggplot(snps_data, aes(x = Query_Position)) +
#  geom_histogram(binwidth = 1000) +
#  #ylim(0, 100) +
#  labs(x = "Genomic Position", y = "Variant Count") +
#  ggtitle("Variant Density Plot")

##Visualizing variant density along a single chromosome
# Log10 transformed for easier visualization
#ggplot(snps_data, aes(x = Query_Position)) +
#  geom_histogram(binwidth = 1000) +
#  #ylim(0, 100) +
#  labs(x = "Genomic Position", y = "Variant Count") +
#  ggtitle("Variant Density Plot") +
#  scale_y_log10()

#ggsave("log_variantdensityplot.png")#, width=12, height=12)

