#!/bin/bash

#download the gammeoproteobacteria reference lineage
#wget -P /data/homezvol2/krraygoz/myrepos/ee282/code/scripts/mb_downloads/ https://busco-data.ezlab.org/v5/data/lineages/gammaproteobacteria_odb10.2024-01-08.tar.gz

#Extract the tar.gz into a directory called gammaproteobacteria
#tar -xvzf /data/homezvol2/krraygoz/myrepos/ee282/code/scripts/mb_downloads/gammaproteobacteria_odb10.2024-01-08.tar.gz -C /data/homezvol2/krraygoz/myrepos/ee282/code/scripts/mb_downloads/

#Run compleasm
#compleasm run -a IJONaive_assembled.fasta -o ~/myrepos/ee282/output/compleasm -t 16 -l gammaproteobacteria 2> compleasmIJO_error.log


#This worked^ it returned the following:
#S:1.37%, 5
#D:93.44%, 342
#F:0.27%, 1
#I:0.00%, 0
#M:4.92%, 18
#N:366
## Download lineage: 5.27(s)
## Run miniprot: 59.86(s)
## Analyze miniprot: 34.34(s)
## Total runtime: 99.48(s)

#Try on Enterobacterales

#download the enterobacterales reference lineage
#wget -P /data/homezvol2/krraygoz/myrepos/ee282/code/scripts/mb_downloads/ https://busco-data.ezlab.org/v5/data/lineages/enterobacterales_odb10.2024-01-08.tar.gz

#Extract the tar.gz into a directory called enterbacterales
#tar -xvzf /data/homezvol2/krraygoz/myrepos/ee282/code/scripts/mb_downloads/enterobacterales_odb10.2024-01-08.tar.gz -C /data/homezvol2/krraygoz/myrepos/ee282/code/scripts/mb_downloads/

#Run compleasm
#compleasm run -a IJONaive_assembled.fasta -o ~/myrepos/ee282/output/compleasm -t 16 -l enterobacterales 2> compleasmIJO_error.log
compleasm run -a IJOLarge_assembled.fasta -o ~/myrepos/ee282/output/compleasm/Large -t 16 -l enterobacterales 2> compleasmIJO_error.log
compleasm run -a IJOSmall_assembled.fasta -o ~/myrepos/ee282/output/compleasm/Small -t 16 -l enterobacterales 2> compleasmIJO_error.log
