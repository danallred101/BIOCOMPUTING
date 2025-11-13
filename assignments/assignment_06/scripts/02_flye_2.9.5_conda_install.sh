#!/bin/bash

module load miniforge3
source /sciclone/apps/miniforge3-24.9.2-0/etc/profile.d/conda.sh
export CONDA_PKGS_DIRS=${HOME}/.conda/pkgs #mamba doesn't know to store pacakges and environments in my home directory and tries to do it on the global HPC one, which I dont have access to, this export line tells mamba to use my personal directory, thank you ChatGPT for the explanation
mamba create -y -n flye-env flye=2.9.6 -c bioconda
#flye -v   gives version wehn I ran got 2.9.6-b1802
conda activate flye-env
conda env export --no-builds > fly-env.yml
conda deactivate
