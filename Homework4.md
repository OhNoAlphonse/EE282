# Homework 4- Kayla Raygoza

## Summarize partitions of a genome assembly

### Download genome
wget https://ftp.flybase.net/releases/FB2022_05/dmel_r6.48/fasta/dmel-all-chrommosome-r6.48.fasta.gz

### File Integrity - downloads checksum file
wget https://ftp.flybase.net/releases/FB2022_05/dmel_r6.48/fasta/md5sum.txt
md5sum --check <(grep dmel-all-chromosome-r6.48.fasta.gz md5sum.txt)

### Define input and output files
gunzip dmel-all-chromosome-r6.48.fasta.gz
SHORT_SEQ_OUTPUT="short_sequences.fasta"
LONG_SEQ_OUTPUT="long_sequences.fasta"

### Partition the genome
bioawk -c fastx '{ if (length($seq) <= 100000) { print ">"$name"\n"$seq } }' dmel-all-chromosome-r6.48.fasta > $SHORT_SEQ_OUTPUT

bioawk -c fastx '{ if (length($seq) > 100000) { print ">"$name"\n"$seq } }' dmel-all-chromosome-r6.48.fasta > $LONG_SEQ_OUTPUT

### Function to calculate statistics
calculate_stats() {
    FILE=$1
    	echo "File: $FILE"
	echo "Total nucleotides: $(bioawk -c fastx '{ sum += length($seq) } END { print sum }' $FILE)"
	echo "Total Ns: $(bioawk -c fastx '{ gsub(/[^N]/, "", $seq); sum += length($seq) } END { print sum }' $FILE)"
	echo "Total sequences: $(bioawk -c fastx 'END { print NR }' $FILE)"

 echo
}

## Calculate statistics for both partitions
calculate_stats $SHORT_SEQ_OUTPUT
calculate_stats $LONG_SEQ_OUTPUT



## Answers:
**Short sequences: (File: short_sequences.fasta)**
1. Total number of nucleotides: 617804

2. Total number of Ns: 662593

3. Total number of sequences: 1863


**Long sequences (File: long_sequences.fasta**
1. Total number of nucleotides: 137547960

2. Total number of Ns: 490385

3. Total number of sequences: 7

_Scripts found in: myrepos/ee282/code/scripts/hw4_genome_summary.sh_

# Plots made in Rstudio, script at end of this .md

## calculate sequence statistics before moving to R

**GC ccontent**
- for sequences ≤ 100kb:
bioawk -c fastx '{if (length($seq) <= 100000) print $name, length($seq), gc($seq)}' dmel-all-chromosome-r6.48.fasta > sequences_short.tsv
- for sequences > 100kb
bioawk -c fastx '{if (length($seq) > 100000) print $name, length($seq), gc($seq)}' dmel-all-chromosome-r6.48.fasta > sequences_long.tsv

**cumulative sequence size**
- for sequences ≤ 100kb
bioawk -c fastx '{if (length($seq) <= 100000) print length($seq)}' dmel-all-chromosome-r6.48.fasta | sort -nr > cumulative_short.txt
- for sequences > 100kb
bioawk -c fastx '{if (length($seq) > 100000) print length($seq)}' dmel-all-chromosome-r6.48.fasta | sort -nr > cumulative_long.txt

_Scripts found in myrepos/ee282/code/scripts/hw4_plots_calc_

**Short sequences**
![Short sequence GC%](https://github.com/OhNoAlphonse/EE282/blob/main/output/figures/ShortSequenceGCDist.png)
![Short Cumulative Curve](https://github.com/OhNoAlphonse/EE282/blob/main/output/figures/ShortCumulativeCurve.png)
![Short Sequence Length Distribution](https://github.com/OhNoAlphonse/EE282/blob/main/output/figures/Rplot.png)

**Long sequence**
![Long sequence GC%](https://github.com/OhNoAlphonse/EE282/blob/main/output/figures/LongSequenceGCDist.png)
![Long Cumulative Curve](https://raw.githubusercontent.com/OhNoAlphonse/EE282/main/output/figures/LongCumulativeCurve.png)
![Long Sequence Length Distribution](https://github.com/OhNoAlphonse/EE282/blob/main/output/figures/LongSequenceLengthDistribution.png)


_R Scripts found in: the end of this .md file_


## Genome Assembly
_Scripts found in:myrepos/ee282/code/scripts/homework4_hifiAssembly.sh_
_Assebled genome found in myrepos/ee282/data/processed/ISO1_assembly.bp.p_ctg.fastsa_

## Assembly Assessment
### N50
N50 of my assembly: 21715751
N50 of refrence contig: 21.5 Mb

_scripts found in myrepos/ee282/code/scripts/homework4_assemblycomparison_

### Plot
Unable to produce contiguity plot, even with the help of my lab's two bioinformaticians. :(
_scripts found in scripts/homework4_assemblycomparison_

### Compleasm

compleasm run -a ISO1_assembly.bp.p_ctg.fasta -o output -t 16 -l /data/homezvol2/krraygoz/myrepos/ee282/code/scripts/mb_downloads/diptera_odb10 2> compleasm_error.log

### hifiasm Assembly:
S:99.63%, 3273
D:0.24%, 8
F:0.00%, 0
I:0.00%, 0
M:0.12%, 4
N:3285

## Download lineage: 0.00(s)
## Run miniprot: 58.62(s)
## Analyze miniprot: 131.07(s)
## Total runtime: 189.69(s)

### Reference genome
compleasm run -a dmel-all-chromosome-r6.36.fasta -o output -t 16 -l /data/homezvol2/krraygoz/myrepos/ee282/code/scripts/mb_downloads/diptera_odb10 2> compleasm_error.log

S:99.63%, 3273
D:0.24%, 8
F:0.00%, 0
I:0.00%, 0
M:0.12%, 4
N:3285

## Download lineage: 0.00(s)
## Run miniprot: 0.00(s)
## Analyze miniprot: 79.95(s)
## Total runtime: 79.95(s)

_received help during office hours! Thank you Harsh!_
_Scripts found in: myrepos/ee282/code/scripts/homework4_compleasm

# Extra Credit
># Split the FlyBase sequence into contig assembly by splitting at the Ns
>faSplitByN ../../dmel-all-chromosome-r6.48.fasta.gz dmel.contig.fasta 10
>
># Splits my assembly into a contig assembly by splitting at the Ns.
>faSplitByN ISO1_assembly.bp.p_ctg.fasta ISO1_contig.fasta 10
>
># Use NUCmer for alignment
>mummer-4.0.0rc1/nucmer -p ../../output/figures dmel.contig.fasta ISO1_contig.fasta 2> nucmer_error$
>
># Filter the delta file
>mummer-4.0.0rc1/delta-filter -1 output.delta > filtered.delta
>
># Generate a dotplot
>mummerplot --png --large --prefix output filtered.delta

_I was only able to get part of this to work_
_Successfuly created dmel.contig.fasta, ISO1_contig.fasta, and output.delta. all in code/scripts.
_script found in: code/scripts/homework4_ExtraCredit.sh_






## R script used to make plots:
># Load libraries
>library(ggplot2)
>
># Load the data
>setwd("C:/Users/raygo/OneDrive/Academics/PhD Classes and TAing/Bioinformatics")
>list.files("C:/Users/raygo/OneDrive/Academics/PhD Classes and TAing/Bioinformatics")
>
>short_data <- read.table("sequences_short.tsv", header = FALSE, col.names = c("Name", "Length", "GC"))
>long_data <- read.table("sequences_long.tsv", header = FALSE, col.names = c("Name", "Length", "GC"))
>
># Load cumulative data
>cumulative_short <- scan("cumulative_short.txt")
>cumulative_long <- scan("cumulative_long.txt")
>
>
>####Create plots
>
>#Sequence Length Distribution
># Short sequences
>ggplot(short_data, aes(x = Length)) +
>  geom_histogram(bins = 30, fill = "blue", color = "black") +
>  scale_x_log10() + 
>  labs(title = "Sequence Length Distribution (≤ 100kb)", x = "Length (log scale)", y = "Count") +
>  theme_minimal()
>
># Long sequences
>ggplot(long_data, aes(x = Length)) +
>  geom_histogram(bins = 30, fill = "green", color = "black") +
>  scale_x_log10() + 
>  labs(title = "Sequence Length Distribution (> 100kb)", x = "Length (log scale)", y = "Count") +
>  theme_minimal()
>
>
># Sequence GC% distribution
># Short sequences
>ggplot(short_data, aes(x = GC)) +
>  geom_histogram(bins = 30, fill = "blue", color = "black") +
>  labs(title = "GC% Distribution (≤ 100kb)", x = "GC%", y = "Count") +
>  theme_minimal()
>
># Long sequences
>ggplot(long_data, aes(x = GC)) +
>  geom_histogram(bins = 30, fill = "green", color = "black") +
>  labs(title = "GC% Distribution (> 100kb)", x = "GC%", y = "Count") +
>  theme_minimal()
>
>
>#Cumulative sequence sizes
>#sort and 
>#short_data <- short_data[order(-short_data$Length), ]
>long_data <- long_data[order(-long_data$Length), ]
>
>short_data$cumulative <- cumsum(short_data$Length)
>long_data$cumulative <- cumsum(long_data$Length)
>
>#short sequences
>ggplot(short_data, aes(x = 1:nrow(short_data), y = cumulative)) +
>  geom_step() +
>  labs(
>    x = "Sequence Index (sorted by length)",
>    y = "Cumulative Sequence Size",
>    title = "Cumulative Sequence Size (Short Sequences ≤ 100kb)"
>  ) +
>  theme_minimal()
>
>#Long sequences
>ggplot(long_data, aes(x = 1:nrow(long_data), y = cumulative)) +
>  geom_step() +
>  labs(
>    x = "Sequence Index (sorted by length)",
>    y = "Cumulative Sequence Size",
>    title = "Cumulative Sequence Size (Long Sequences > 100kb)"
>  ) +
>  theme_minimal()
>
># Short sequences
>plot(cumsum(cumulative_short), type = "l", col = "blue", lwd = 2,
>     xlab = "Number of Sequences", ylab = "Cumulative Length",
>     main = "Cumulative Sequence Size (≤ 100kb)")
>
># Long sequences
>plot(cumsum(cumulative_long), type = "l", col = "green", lwd = 2,
>     xlab = "Number of Sequences", ylab = "Cumulative Length",
>     main = "Cumulative Sequence Size (> 100kb)")

