
#!/bin/bash
set -e

#SBATCH --job-name=nucmer_job
#SBATCH --output=nucmer_output_%j.log
#SBATCH --error=nucmer_error_%j.log
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --time=02:00:00
#SBATCH --mem=8GB


# I activated ee282 earlier so this isnt needed now
#conda activate ee282

# installed on interactive node so this isnt needed
# Installs the appropriate program
#conda install -c bioconda mummer

# Split the FlyBase sequence into contig assembly by splitting at the Ns
faSplitByN ../../dmel-all-chromosome-r6.48.fasta.gz dmel.contig.fasta 10

# Splits my assembly into a contig assembly by splitting at the Ns.
faSplitByN ISO1_assembly.bp.p_ctg.fasta ISO1_contig.fasta 10

# Use NUCmer for alignment
mummer-4.0.0rc1/nucmer -p ../../output/figures dmel.contig.fasta ISO1_contig.fasta 2> nucmer_error.log

# Filter the delta file
mummer-4.0.0rc1/delta-filter -1 output.delta > filtered.delta

# Generate a dotplot
mummerplot --png --large --prefix output filtered.delta
