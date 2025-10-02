#!/bin/bash
wget https://gzahn.github.io/data/fastq_examples.tar
tar -xvf fastq_examples.tar -C ./data/raw  #-C lets me specify end file	locations
rm fastq_examples.tar
