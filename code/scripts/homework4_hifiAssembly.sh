#!/bin/bash
#SBATCH --job-name=hifiasm_assembly
#SBATCH --output=hifiasm_output.log
#SBATCH --error=hifiasm_error.log
#SBATCH --time=2:00:00
#SBATCH --cpus-per-task=16
#SBATCH --mem=64G

source /pub/krraygoz/miniforge3/etc/profile.d/conda.sh
source /pub/krraygoz/miniforge3/etc/profile.d/mamba.sh
mamba activate ee282

# Run hifiasm
hifiasm -o /data/homezvol2/krraygoz/myrepos/ee282/data/processed/ISO1_assembly -t 16 /data/homezvol2/krraygoz/myrepos/ee282/data/raw/ISO1_Hifi_AdaptorRem.40X.fasta.gz


#after I ran sbatch Homework4_hifiAssembly.sh, I used squeue to see the status
#I also used cat hifiasm_error.log to keep an eye out for errors

##Convert to fasta file
awk '/^S/{print ">"$2"\n"$3}' /data/homezvol2/krraygoz/myrepos/ee282/data/processed/ISO1_assembly.bp.p_ctg.gfa > ISO1_assembly.bp.p_ctg.fasta


#used head to check the fasta file and it looks how I expected it to look

#Bioawk to get the sizes of the contigs
bioawk -c fastx '{print length($seq)}' /data/homezvol2/krraygoz/myrepos/ee282/data/processed/ISO1_assembly.bp.p_ctg.fasta > contig_sizes.txt

# Sort the contig sizes in descending order
sort -n -r contig_sizes.txt > sorted_sizes.txt

# Calculate the total length of the assembly
total_length=$(awk '{sum+=$1} END {print sum}' sorted_sizes.txt)

# Calculate half the total length
half_length=$(echo "$total_length / 2" | bc)

# Find the N50 by summing the contigs until reaching half the total length
sum=0
n50=0
while read size; do
    sum=$((sum + size))
    if [ $sum -ge $half_length ]; then
        n50=$size
        break
    fi
done < sorted_sizes.txt

echo "N50: $n50"

