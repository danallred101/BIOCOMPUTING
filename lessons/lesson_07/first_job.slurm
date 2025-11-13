#!/bin/bash
#SBATCH --job-name=myfirstjob
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=1
#SBATCH --mem=1G
#SBATCH --mail-type=FAIL,BEGIN,END
#SBATCH --mail-user=drallred@wm.edu               # change this!
#SBATCH -o /sciclone/home/drallred/logs/firstjob_%j.out # change this!
#SBATCH -e /sciclone/home/drallred/logs/firstjob_%j.err # change this!
sleep 30 && echo "Hello world!"
