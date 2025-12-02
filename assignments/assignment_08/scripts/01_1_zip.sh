#!/bin/bash
#SBATCH --job-name=Dan_Gzip
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=20
#SBATCH --time=500
#SBATCH --mail-type=FAIL,BEGIN,END
#SBATCH --mail-user=drallred@wm.edu               # change this!
#SBATCH -o /sciclone/home/drallred/logs/zip_%j.out # change this!
#SBATCH -e /sciclone/home/drallred/logs/zip_%j.err # change this!

DL_DIR="${HOME}/scr10/group_project/data/raw"


gzip ${DL_DIR}/*.fastq
