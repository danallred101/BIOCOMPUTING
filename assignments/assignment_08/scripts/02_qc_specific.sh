#!/bin/bash
#SBATCH --job-name=qc_specific
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=20
#SBATCH --time=1200
#SBATCH --mail-type=FAIL,BEGIN,END
#SBATCH --mail-user=drallred@wm.edu               # change this!
#SBATCH -o /sciclone/home/drallred/logs/qc_s%j.out # change this!
#SBATCH -e /sciclone/home/drallred/logs/qc_s%j.err # change this!

SCR_DIR="${HOME}/scr10" # change to main writeable scratch space if not on W&M HPC
PROJECT_DIR="${SCR_DIR}/group_project"
DB_DIR="${SCR_DIR}/db"
DL_DIR="${PROJECT_DIR}/data/raw"
SRA_DIR="${SCR_DIR}/SRA"
for fwd in ${DL_DIR}/SRR31654355_1.fastq.gz;do rev=${fwd/_1.fastq.gz/_2.fastq.gz};outfwd=${fwd/.fastq.gz/_qc.fastq.gz};outrev=${rev/.fastq.gz/_qc.fastq.gz};fastp -i $fwd -o $outfwd -I $rev -O $outrev -j /dev/null -h /dev/null -n 3 -l 100 -e 10;done
# all QC files will be in $DL_DIR and have *_qc.fastq.gz naming pattern

