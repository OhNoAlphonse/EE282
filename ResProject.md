# Final Project

Author: Kayla Raygoza


To understand how bacteria acquire resistance to phages, I compared the genomes of an ancestral Escherichia coli strain (IJO) to a resistant mutant strain that forms large colonies (IJO_Large). 

## Methods
### Data used for bioinformatic project
 
The DNA of one clinical Escherichia coli isolate (IJONaive) and one evolved phage-resistant mutant (IJOLarge) were extracted and sent to Plasmidsaurus for sequencing. Consensus sequences of Oxford Nanopore and Illumina reads were downloaded from the Plasmidsaurus website (Figure 1). Quality control (QC) metrics for each of the two bacterial genomes were also provided by Plasmidsaurus and compared to basic statistics calculated with prokka (figure 2). The provided read quality plot for the Naive E. coli isolate was compared to a Nanoplot generated independently to ensure consistency and validate QC metrics (Figure 3). Compleasm was then used to further analyze the Naive isolate, comparing it to other genomes within the Enterobacterales order to assess assembly quality and completeness.

![Figure 1: Workflow](https://github.com/OhNoAlphonse/EE282/blob/main/output/figures/better_workflow.png) <br>
![Table 1: Statistics provided by Plasmidsaurus (left) and calculated with prokka (right)](https://github.com/OhNoAlphonse/EE282/blob/main/output/figures/plasmidsaurus%20v%20prokka.png) <br>
![Figure 2: QC comparison Nanoplot vs Plasmidsarus](https://github.com/OhNoAlphonse/EE282/blob/main/output/figures/n50%20comparison.png) <br>
![Figure 3: Nanoplot (left) and Plasmidsaurus read quality plot (right)](https://github.com/OhNoAlphonse/EE282/blob/main/output/figures/n50%20comparison.png) <br>

### Alignment and Variant Analysis
Before annotating the pre-assembled genomes, 'seqtk' was used to convert the  IJO Naive genomes from .fastq.gz files them into .fasta files for downstream use. I used 'awk '/^>/ {print ">contig"++i} !/^>/ {print}' ' to rename the individual contigs so it was more conducive to prokka's workflow. When running prokka, I specified the species Eshericia coli, added cpu's as the annotation was taking longer than expected, and specified that it should go "fast" and skip superfluous steps. <br>
To align the genomes of IJO Naive and IJO Large, progressiveMauve was installed, 'awk' was used to remove the dashes (-) from the dataset, 'awk' was used to remove the metadata and create a simplified .fasta file. Unfortunately, pmauve was not successful and I instead used mummer/nucmer to align my genomes.
Nucmer was used to align the genomes of the IJO Naive and IJO Large isolates. The resulting delta files were filtered to retain high-confidence alignments. The filtering criteria included maintaining high percent identity (≥90%) to focus on reliable matches while excluding noisy or weak alignments. Short alignments (<1000 bp) were removed to avoid considering fragmented or less meaningful matches. Additionally, alignments were simplified to ensure that each region of the query genome aligned to the best-matching region of the reference genome, eliminating redundant or overlapping matches. Filtered delta files were then converted to .csv format using awk for downstream analysis. Histograms were created in RStudio using ggplot to visualize the distribution of genomic variants across the isolates. A second ggplot was made after log transforming the data using 'scale_y_log10()'.

## Results
### QC

The Nanoplot generated from our sequencing data closely mirrors the shape and characteristics of the reference Nanoplot provided by Plasmidsaurus, affirming the reliability of the sequencing data quality and characteristics. Compleasm analysis revealed a well-assembled genome, with 99.32% (437 out of 440 contigs) attributed to duplications and only 0.68% (3 contigs) being incomplete (Table 1). No misassemblies, insertions, or gaps were detected, underscoring the assembly's high accuracy. Also, prokka annotation results were consistent with Plasmidsaurus, identifying the same contig count and sequence length. Interestingly, the Prokka-generated .gff file was 1,983,675 KB, while the .gff from Plasmidsaurus was 2,037 KB.

![Table 1: Compleasm of IJO Naive vs Enterobacterales](https://github.com/OhNoAlphonse/EE282/blob/main/output/figures/compleasm_table.png) <br>

### Annotation and Mutation Analysis
Variant analysis revealed (Figure 4) distinct SNP distribution patterns across the genome. Early genome positions demonstrated a high density of mutations, with a pronounced peak around position 2000. Later genome positions showed fewer SNPs and reduced annotations, indicating higher conservation, with no SNPs detected between positions 7400-7900, highlighting a stable region. Focusing on positions 1 to 20,000, where the greatest number of SNPs was observed, I used a  simple GFF viewer (http://gff.molgenrug.nl/) to visualize the annotated genome of IJONaive provided by Plasmidsaurus since the prokka annotation file was too large to visualize. Notable genes found in this reason were genes for: Fluoroquinolone-acetylating aminoglycoside 6’-N-acetyl transferase,2 translesion error prone dna polymerases, 3 antirestriction proteins, StbC, StbB, and StbA.

![Figure 4: Variant density plot (left) and log transformed variant density plot (right)](https://github.com/OhNoAlphonse/EE282/blob/main/output/figures/VariantDensityPlots.png) <br>
![Figure 5: Annotated Region of interest](https://github.com/OhNoAlphonse/EE282/blob/main/output/figures/Screenshot%202024-12-13%20191858.png) <br>

## Discussion

The genome for the resistant mutant that forms large colonies (IJO Large) is much smaller than the ancestral strain (IJO Naive), supporting the idea that larger genomes come with fitness costs. While it seems counterintuitive that the genome shrank as the bacteria evolved resistance to a phage, it is likely explained by the fact that there were far fewer selective pressures put upon the bacteria in a laboratory setting which can lead to streamlining of the genome (1, 2).
Annotated genes in SNP-dense regions (between positions 0 to 20,000), included fluoroquinolone-acetylating aminoglycoside 6’-N-acetyl transferase, which is involved in antibiotic resistance; Translesion Error-Prone DNA Polymerase, which may allow for higher levels of point mutations (3); and StbC, StdB, and StbA, which are often involved in stress response (4). There were also 3 different antirestriciton genes. These genes code for proteins that can interfere with the phage's ability to degrade the host's restriction-modification system, a common bacterial defense mechanism (5). The conserved genomic regions with no SNPs, notably between positions 7,400 and 7,900, could point to areas of evolutionary stability. These stable regions may indicate essential functional roles or structural importance, as evolutionary pressures likely act to maintain their integrity. The identification of SNP-dense regions, conserved genomic stability, and genes of functional interest lays the groundwork for further exploration of bacterial resistance and adaptability mechanisms.


## Scripts used
Nanoplot: ResProject_QC.sh
Compleasm: ResProject_compleasm
prokka: ResProject_Annotation.sh
unsuccessful progressivemauve: ResProject_ProgressiveMauve
Mummer, variant calling, ggplot: ResProject_variants.sh


## References
Plasmidsaurus
# References: 
[1] Verfyik, V., Karcagi, I., Tímár, E., et al. Exploring the fitness benefits of genome reduction in Escherichia coli by a selection-driven approach. Sci Rep 10:7345. Published 2020 Apr 30. doi:10.1038/s41598-020-64074-5. <br>
[2] Giovannoni, S., Cameron Thrash, J., Temperton, B. Implications of streamlining theory for microbial ecology. ISME J 8:1553–1565 (2014). doi:10.1038/ismej.2014.60. <br>
Fuchs, R.P., Fujii, S. Translesion DNA synthesis and mutagenesis in prokaryotes. Cold Spring Harb Perspect Biol 5:a012682 (2013). doi:10.1101/cshperspect.a012682. <br>
[3] Guynet, C., de la Cruz, F. Plasmid segregation without partition. Mobile Genet Elem 1:236–241 (2011). doi:10.4161/mge.1.3.18229. <br>
[4] Weigele, P., Raleigh, E.A. Biosynthesis and function of modified bases in bacteria and their viruses. Chem Rev 116:12655–12687 (2016). doi:10.1021/acs.chemrev.6b00114. <br>
[5] StbA: A key protein in the spread of antibiotic resistance genes. Accessed December 12, 2024.

