#!/bin/bash
set -ueo pipefail

# set project directory where files are found
# this is mine, but you will have to change it to the correct location for your project
MAIN_DIR="/sciclone/home/drallred/BIOCOMPUTING/lessons/lesson_05"

# go to that location
cd $MAIN_DIR

#for-loop
for i in ./data/*_R1_*.fastq
do
FWD=${i}
REV=${FWD/_R1_/_R2_}
OUT=${FWD%%_*}_chopped.fastq
N=200


${MAIN_DIR}/scripts/interleave_chop.sh $FWD $REV $OUT $N
done
