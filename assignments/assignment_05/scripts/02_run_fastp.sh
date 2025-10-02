#!/bin/bash

#Run this command from the assignment_05 directory, and specify where data is coming from
#Defining in and out file names
FWD_IN=${1}
REV_IN=${FWD_IN/_R1_/_R2_}
FWD_OUT=${FWD_IN/.fastq.gz/.trimmed.fastq.gz}
REV_OUT=${REV_IN/.fastq.gz/.trimmed.fastq.gz}
HTML_OUT=${FWD_OUT/_R1_/_out_}
HTML_OUT=${HTML_OUT##*/}
HTML_OUT=${HTML_OUT/.trimmed.fastq.gz/.html}
#Running through fastp, out files are swapping raw for trimmed in output directory path, ensure you have those exact directory names
fastp --in1 $FWD_IN --in2 $REV_IN --out1 ${FWD_OUT/raw/trimmed} --out2 ${REV_OUT/raw/trimmed} --json /dev/null \
 --html  ./log/$HTML_OUT --trim_front1 8 --trim_front2 8 --trim_tail1 20 \
 --trim_tail2 20 --n_base_limit 0 --length_required 100 --average_qual 20
