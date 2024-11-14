#!/bin/bash

# download
wget https://ftp.flybase.net/releases/FB2022_05/dmel_r6.48/gtf/dmel-all-r6.48.gtf.gz

#check
md5sum /data/homezvol2/krraygoz/myrepos/ee282/dmel-all-r6.48.gtf.gz

# Count features by type using bioawk
echo "Counting features by type:"
bioawk -c gff '{print $3}' "$GTF_FILE" | sort | uniq -c | sort -nr

# Count genes per chromosome arm
echo "Counting genes per chromosome arm:"
bioawk -c gff '$3 == "gene" {print $1}' "$GTF_FILE" | \
  sed -E 's/([XY12L|R]{1}[0-9])/\1/' | sort | uniq -c

