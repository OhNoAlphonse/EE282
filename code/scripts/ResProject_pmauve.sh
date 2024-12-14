#!/bin/bash
#SBATCH --job-name=PMauve_IJOcomparisons
#SBATCH --output=PMauve_output.log
#SBATCH --error=PMauve__error.lo
#SBATCH -A CLASS_EE282
#SBATCH -p standard
#SBATCH --time=8:00:00
#SBATCH --cpus-per-task=16
#SBATCH --mem=32G

set -e

#Install pmauve
#mamba install progressivemauve

#check for dashes - 
#grep '-' IJONaive_assembled.fasta

#clean the - out of the fasta
#awk '/^>/ {print ">seq" ++i} !/^>/ {print}' IJONaive_assembled.fasta > IJONaive_simplified.fasta
#awk '/^>/ {print ">seq" ++i} !/^>/ {print}' IJOLarge_assembled.fasta > IJOLarge_simplified.fasta
#awk '/^>/ {print ">seq" ++i} !/^>/ {print}' IJOSmall_assembled.fasta > IJOSmall_simplified.fasta


# Remove the metadata
#awk '/^>/ {if (seq) print seq; seq=""} /^[^>]/ {seq=seq$0} END {print seq}' IJONaive_assembled.fasta > IJONaive_cleaned.fasta

# Roundabout way of doing tis but oh well
#awk '/^>/ {if (seq) print seq; print ">seq" ++i; seq=""} /^[^>]/ {seq=seq$0} END {print seq}' IJONaive_NoMetadata.fasta > IJONaive_renamed.fasta
#awk '/^>/ {if (seq) print seq; print ">seq" ++i; seq=""} /^[^>]/ {seq=seq$0} END {print seq}' IJOLarge_NoMetadata.fasta > IJOLarge_renamed.fasta
#awk '/^>/ {if (seq) print seq; print ">seq" ++i; seq=""} /^[^>]/ {seq=seq$0} END {print seq}' IJOSmall_NoMetadata.fasta > IJOSmall_renamed.fasta

#Naive vs Large on the simplified data :)
progressiveMauve --output=myrepos/ee282/output/pmauve/IJONaive_vs_Large/alignment.xmfa IJONaive_simplified.fasta IJOLarge_simplified.fasta
#progressiveMauve --output=ee282/output/pmauve/IJONaive_vs_Small/alignment.xmfa IJONaive_simplified.fasta IJOSmall_simplified.fasta
#progressiveMauve --output=/output/pmauve/IJOSmall_vs_Large/alignment.xmfa IJOSmall_simplified.fasta IJOLarge_simplified.fasta



#try this if simplified doesnt work:
#progressiveMauve --output=myrepos/ee282/output/pmauve/IJONaive_vs_Large/alignment.xmfa IJONaive_renamed.fasta IJOLarge_renamed.fasta

#old:
#progressiveMauve --output=myrepos/ee282/output/pmauve/IJONaive_vs_Large/alignment.xmfa IJONaive_simplified.fasta IJOLarge_simplified.fasta

#Naive vs Small
#progressiveMauve --output=myrepos/ee282/output/pmauve/IJONaive_vs_Small/alignment.xmfa IJONaive_simplified.fasta IJOSmall_simplified.fasta

#Small vs Large
#progressiveMauve --output=myrepos/ee282/output/pmauve/IJOSmall_vs_Large/alignment.xmfa IJOSmall_simplified.fasta IJOLarge_simplified.fasta
