#!/bin/bash
#SBATCH --job-name=compleasm_job
#SBATCH --time=24:00:00
#SBATCH --nodes=1
#SBATCH --cpus-per-rask=16

source /pub/krraygoz/miniforge3/etc/profile.d/conda.sh
source /pub/krraygoz/miniforge3/etc/profile.d/mamba.sh
mamba activate compleasom

compleasm run -a ISO1_assembly.bp.p_ctg.fasta -o output/tables -t 16 -l diptera_odb10
