#!/bin/bash
#SBATCH --job-name=ResProject_Annotation
#SBATCH -A CLASS_EE282
#SBATCH -p standard
#SBATCH --error=ProjectAnnotation_error.log
#SBATCH --time=72:00:00
#SBATCH --cpus-per-task=30
#SBATCH --mem=64G

set -e

#Already downloaded seqtk and prokka

#Convert to fasta
#seqtk seq -A IJONaive_assembled.fastq.gz > IJONaive_assembled.fasta
#seqtk seq -A IJOLarge_assembled.fastq.gz > IJOLarge_assembled.fasta
#seqtk seq -A IJOSmall_assembled.fastq.gz > IJOSmall_assembled.fasta

#name the individual contigs so prokka doesnt get confused
#awk '/^>/ {print ">contig"++i} !/^>/ {print}' IJONaive_assembled.fasta > IJONaive_assembled_renamed.fasta
#awk '/^>/ {print ">contig"++i} !/^>/ {print}' IJOLarge_assembled.fasta > IJOLarge_assembled_renamed.fasta
#awk '/^>/ {print ">contig"++i} !/^>/ {print}' IJOSmall_assembled.fasta > IJOSmall_assembled_renamed.fasta

#Annotate assembled genomes with prokka 
prokka --outdir ~/myrepos/ee282/output/prokka_Naive --prefix IJONaive_annotated --genus Eschericia --species coli --cpus 30 --fast --force IJONaive_assembled_renamed.fasta > IJONaiveprokka.log 2>&1

#prokka --outdir ~/myrepos/ee282/output/prokka_Large --prefix IJOLarge_annotated --genus Eschericia --species coli --force IJOLarge_assembled_renamed.fasta

#prokka --outdir ~/myrepos/ee282/output/prokka_Small --prefix IJOSmall_annotated --genus Eschericia --species coli --force IJOSmall_assembled_renamed.fasta

