#!/bin/bash
#SBATCH --job-name=Quiz_7
#SBATCH --nodes=1 # how many physical machines in the cluster
#SBATCH --ntasks=1 # how many separate 'tasks' (stick to 1)
#SBATCH --cpus-per-task=1 # how many cores (bora max is 20)
#SBATCH --time=00:01:00 # d-hh:mm:ss or just No. of minutes
#SBATCH --mem=1G # how much physical memory (all by default)
#SBATCH --mail-type=FAIL,BEGIN,END # when to email you
#SBATCH --mail-user=drallred@wm.edu # who to email
#SBATCH -o /sciclone/home/drallred/logs/quiz7_%j.out # change this!
#SBATCH -e /sciclone/home/drallred/logs/quiz7_%j.err # change this!
#module load whatever_modules_you_need #set up environment
echo "Hello world!"
