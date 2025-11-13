# Daniel Allred - 10/28/2025 - Assignment_06

### Assignment Tasks
* Setup the directory
* Download raw ONT data
* Get Flye v2.9.6 (local build)
* Get Flye v2.9.6 (conda build)
* Decipher how to use Flye
* Run Flye 3 ways (conda, local, module) and write a script for each of these methods
* Compare teh results to the log files
* Build a pipeline.sh script
* Delete everything (except scripts) and start over
* Document everything in a README.md
* Push to github

### Documentation  

**Setting up the directory**  
#Start in the assignment_06 directory  
mkdir -p {assemblies/{assembly_conda,assembly_local,assembly_module},data,scripts}  
cd scripts  
touch 01_download_data.sh 02_flye_2.9.5_conda_install.sh 02_flye_2.9.5_manual_build.sh 03_run_flye_conda.sh 03_run_flye_local.sh 03_run_flye_module.sh  


**Download the raw ONT data**  
nano 01_download_data.sh  
#Run this script in the assignment_06 directory, it will download data into your ./data folder  


#!/bin/bash  
wget https://zenodo.org/records/15730819/files/SRR33939694.fastq.gz  
gunzip -c SRR33939694.fastq.gz > ./data/SRR33939694.fastq  
rm SRR33939694.fastq.gz  
#echo "Data downloaded at $(date)" >> README.md  


**Get Flye v2.9.6 (local build)**  
nano 02_flye_2.9.5_conda_install.sh  
#Run this script in the assignment_06 directory, it will create a local build of Flye and add it to your Path so it's callable  

#!/bin/bash
LOC=${HOME}/programs  
git clone https://github.com/fenderglass/Flye ${LOC}/Flye  
cd ${LOC}/Flye  
make  
echo "export PATH=\$PATH:${LOC}/Flye/bin" >> ~/.bashrc  


**Get Flye v2.9.6 (conda build)**  
nano 02_flye_2.9.5_conda_install.sh  
#Run this script in the assignment_06 directory, it will create a Conda environment named flye-env you can use, it will also export a yml file will relevant environment information

#!/bin/bash  
module load miniforge3  
source /sciclone/apps/miniforge3-24.9.2-0/etc/profile.d/conda.sh  
export CONDA_PKGS_DIRS=${HOME}/.conda/pkgs  
mamba create -y -n flye-env flye=2.9.6 -c bioconda  
#flye -v   gives version when I ran got 2.9.6-b1802  
conda activate flye-env  
conda env export --no-builds > fly-env.yml  
conda deactivate  

#export line is courtesy of ChatGPT, a mamba specific problem that this line fixes  


**Decipher how to use Flye**  

