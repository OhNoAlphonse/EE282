# Analysis Proposal for EE282 Final Project

Author Kayla Raygoza

## Introduciton

Phage therapy, a promising alternative to traditional antibiotics, has the potential to combat antibiotic-resistant bacterial infections. However, the emergence of phage-resistant bacterial strains poses a significant challenge to its efficacy. By understanding the genetic basis of phage resistance, we can develop strategies to improve the effectiveness of phage therapy. This project aims to identify specific genetic alterations in phage-resistant bacterial strains that contribute to their increased resistance. If we can prevent bacteria from acquiring specific mutations through engineering or applying other selective pressures, we would improve phage efficacy. Alternatively, we could encourage phage evolution or create genetically engineered phages that are unaffected by the mutations that bacteria gather.

## Main
The main focus of this project is to identify genetic mutations that confer phage resistance in a variety of bacterial strains. To do so, we will compare the genomes of an unevolved, ancestral Eschericia coli (E. coli) strain “IJO” to two mutants that have evolved resistance to a phage through repeated exposure. In our lab, we have created two resistant E. coli; one that forms small colonies (IJO_SmaRes) and one that forms larger colonies (IJO_LarRes). 

Starting with the ancestral genome, I will download the raw fasta files from Seqcoast and will use FastQC to assess the quality of the raw reads. Then, I will assemble the genome with unicycler and annotate with RAST. Once this has been completed for the ancestral genome, I will repeat for the two mutants. Once they are ready, I will use progressive mauve for the genomic comparison. Comparative genomics will enable us to analyze these changes across different isolates, mapping the mutations and identifying recurring resistance mechanisms across bacterial strains. Additionally, variant calling, using iVAR, will allow me to detect specific mutations by comparing the genomes of resistant bacterial mutants with their ancestral strains, highlighting genetic changes that may contribute to survival under phage pressure. Together, these methods will provide valuable insights into the genetic pathways bacteria use to evade phage attack.

To effectively communicate findings, I will generate comparative genomic maps with Circos that align ancestral and resistant genomes to pinpoint mutations associated with phage resistance. I also plan to create variant distribution plots with ggplot2 to show the locations and types of mutations across different E. coli mutants. These visuals will help illustrate patterns of resistance mutations across strains, making complex genomic data accessible to both technical and non-technical audiences and highlighting any parallel adaptation patterns or unique resistance mechanisms in different species.

##Conclusion

The feasibility of this approach is strongly supported by my existing access to sequenced genomes for both ancestral and mutant data. I am confident that this approach will work for E. coli as it has in the past for Enterncoccous faecium (Wandro et al. 2019) . I am familiar with assembling phage genomes through the BV BRC and through a website called Phagenomics.com. The project’s incremental nature also allows me to incorporate new resistant mutants as they are generated in the lab, which provides a unique opportunity to track resistance evolution in near-real time and to apply findings to subsequent analyses as they become available.By leveraging comparative genomics and mutation mapping, I hope to identify critical genetic changes that enable bacterial survival against phage infection. These insights will directly inform potential strategies for enhancing phage therapies. With access to sequenced genomes, a structured pipeline, and ongoing support from my lab, this project is both feasible and impactful.


