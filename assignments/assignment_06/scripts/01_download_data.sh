#!/bin/bash

wget https://zenodo.org/records/15730819/files/SRR33939694.fastq.gz
gunzip -c SRR33939694.fastq.gz > ./data/SRR33939694.fastq
rm SRR33939694.fastq.gz
#echo "Data downloaded at $(date)" >> README.md

