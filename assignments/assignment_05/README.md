# Daniel Allred - 10/1/2025 - Assignment_05

### Assignment Tasks
* Setup the directory
* Write a script to download and prep fastq data
* Install and explore the fastp tool
* Write a script to run fastp
* Write pipeline.sh script
* Verify pipeline.sh script works well
* Document!

### Documentation

**Setting up the basic directory**  
*#naviagte to bora log in, move to the ~/BIOCOMPUTING/assignments/assigment_05 directory  *  
mkdir -p ./data/{raw,trimmed} ./scripts ./log  
touch README.md pipeline.sh  
cd scripts/  
touch 01_download_data.sh 02_run_fastp.sh  
*#add scripts to path and ensure they're executable (either run this code in terminal or close and re-open so bash runs it for you)*  
cd  
nano .bashrc  
export PATH=$PATH:/sciclone/home/drallred/BIOCOMPUTING/assignments/assignment_05/scripts  
export PATH=$PATH:/sciclone/home/drallred/BIOCOMPUTING/assignments/assignment_05  
chmod 755 pipeline.sh  
chmod 755 ./scripts/*.sh  

**Writing 01_download_data.sh**  
*#navigate into the 01_download_data.sh file (probably: nano ./scripts/01_download_data.sh)*  
#!/bin/bash  
wget https://gzahn.github.io/data/fastq_examples.tar  
tar -xvf fastq_examples.tar -C ./data/raw  #-C lets me specify end file locations  
rm fastq_examples.tar  


**Installing the fastp tool**  
*#Navigate to the programs directory*  
wget http://opengene.org/fastp/fastp  
chmod a+x ./fastp  
*#Downloaded on Release v1.0.1*  
*#Already have the programs directory added to my path, and scince I put fastp directly into programs, I don't need to update the path (at some point I'll probably do a big reorganization with multiple directories for specfici program types, but for now it's all togehter, yay)*  


**Writing 02_run_fastp.sh**  
*#navigate into the 02_run_fastp.sh file (probably: nano ./scripts/02_run_fastp.sh)*  
#!/bin/bash

#Defining in and out file names
FWD_IN=${1}  
REV_IN=${FWD_IN/_R1_/_R2_}  
FWD_OUT=${FWD_IN/.fastq.gz/.trimmed.fastq.gz}  
REV_OUT=${REV_IN/.fastq.gz/.trimmed.fastq.gz}  
HTML_OUT=${FWD_OUT/_R1_/_out_} #getting specific file name for the HTML report  
HTML_OUT=${HTML_OUT##*/} #getting rid of the directory path which would mess up the ouput  
HTML_OUT=${HTML_OUT/.trimmed.fastq.gz/.html} #labeling it as a .html file  
#Running through fastp, with various parameters, most are failry self-explanatory  
fastp --in1 $FWD_IN --in2 $REV_IN --out1 ${FWD_OUT/raw/trimmed} --out2 ${REV_OUT/raw/trimmed} --json /dev/null \  
 --html  ./log/$HTML_OUT --trim_front1 8 --trim_front2 8 --trim_tail1 20 \  
 --trim_tail2 20 --n_base_limit 0 --length_required 100 --average_qual 20  


**Writing pipeline.sh**  
*#navigate into the pipeline.sh file (probably: nano .pipeline.sh)*  
#!/bin/bash
set -euo pipefail #ensuring that if something goes wrong during execution it will stop running  
01_download_data.sh  
for i in ./data/raw/*_R1_*; do 02_run_fastp.sh ${i}; done #Making sure to limit to only R1 files because the 02 script will only work with those, and it snags all the R2s  


### Reflection

Overall this assignment went quite smoothly. I think the biggest challenges came in writing the 02_run_fastp.sh script. I'm still getting comfortable with using and defining variables, especially as you throw parameter expansion into the mix. The hints in the assignment helped a lot. The singl biggest trip up for me was the parameter expansion swapping raw for trimmed in the output file directories. It took me a little while to figure out that the directory path was getting passed all the way there and needed to be swapped so the outputs would go to trimmed. Other than that the rest went pretty smooth. The for loop was way easier to write than I was expecting, just had to make sure I was only looping through R1 files since the 02 script grabs R1 and R2 files. I don't hink I learned anything new specifically (besides of course fastp) but I'm just getting more and more comfortable with this type of programming which is super cool.  
I think we split it up into two scripts for two reasons really. First is that the two different scripts do two different things, so from an organizational point of view it's nice to have them seperate. It would be really annoying if you just had one huge script that did a ton of stuff, that would be hard somewhat unapproachable to others. This blends in nicely to the second reason for splitting, which is you can call them seperatley later. By making two seperate scripts you can then make one overall pipeline that calls them as needed, this makes the initial programming more organzied (and easier in my mind) and will make it much more approachable to anyone trying to understand what your code is doing.  


