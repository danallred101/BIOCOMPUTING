# Daniel Allred - 9/24/2025 - Assignment_04

### Assignment Tasks
* Download and unpack the gh "tarball" file
* Build a bash script from task 2
* Run your install_gh.sh script
* Add the location of the gh binary to your $PATH
* Run gh auth login to setup your GitHub username and password
* Create another installation script (for seqtk)
* Figure out seqkt
* Write a `summarize_fasta.sh` script
* Run `summarize_fasta.sh` in a loop on multiple files.
* Document Everything in README.md
* Push to GitHub

### Documentation  

**Downloading and installing gh**  
Log into bora  
cd ~/programs  
wget https://github.com/cli/cli/releases/download/v2.74.2/gh_2.74.2_linux_amd64.tar.gz  
tar -xzvf https://github.com/cli/cli/releases/download/v2.74.2/gh_2.74.2_linux_amd64.tar.gz  
rm gh_2.74.2_linux_amd64.tar.gz  

**Turn into bash script**  
nano install_gh.sh  
type: #!/bin/bash  
copy in all the previous commands  

**Add the location of gh binary to $PATH**  
cd ~  
nano .bashrc  
Add this line of code:  
export PATH=$PATH:/sciclone/home/drallred/programs/gh_2.74.2_linux_amd64/bin  
*remember to exit and reenter terminal so bashrc has run this code, or just run it yourself in terminal*  

**Log in to github**  
gh auth login  
*navigate the given options, web login wasn't working well so I just used a personal access token that will expire after the semester ends*  
*did my first git push, realised stuff wasn't in line, did git pull, relised I had divergent branches, yippeee, merged some braches and everything worked out*  


**Create installation script for seqtk**  
cd ~/programs  
nano install_seqtk.sh  
*(in nano screen)*  
#!/bin/bash  
git clone https://github.com/lh3/seqtk.git;
cd seqtk; make *(recommended installation command from seqtk's readme)*  
echo "export PATH=\$PATH:$(pwd)" >> ~/.bashrc *(\ in front of $PATH variable, maintains it as a variable when it's sent to .bashrc instead of expanding out into the actual value, which is a lot cleaner)*  
*save the file and exit nano*  
chmod 755 install_seqtk.sh  


**messed around with seqtk for a bit**  


**Write a 'summarize_fasta.sh' script**  
cd ~/programs  
nano summarize_fasta.sh  
*(in nano screen)*  
#!/bin/bash  

file=${1}  

#getting important info
sequences_number=$(cut -f1 <(seqtk size $file))  
nucleotides_number=$(cut -f2 <(seqtk size $file))  
table_names_lengths=$(cut -f1,2 <(seqtk comp $file))  

#sending to screen  
echo "The total number of sequences is: $sequences_number"  
echo "The total number of nucleotides is: $nucleotides_number"  
echo "Table of sequence names and nucleotide numbers:"   
echo "$table_names_lengths"  

*save the file and exit nano*  
chmod 755 install_seqtk.sh  

**Run 'summarize_fasta.sh' in a loop on multiple files**  
*(needed to get 3 fasta files)*  
cd ~/BIOCOMPUTING/assignments/assignment_04/  
mkdir data  
cd data/  
cp ~/BIOCOMPUTING/assignments/assignment_03/data/GCF_000001735.4_TAIR10.1_genomic.fna ~/BIOCOMPUTING/assignments/assignment_04/data/  
cp GCF_000001735.4_TAIR10.1_genomic.fna GCF_000001735.4_TAIR10.1_genomic_v2.fna  
cp GCF_000001735.4_TAIR10.1_genomic.fna GCF_000001735.4_TAIR10.1_genomic_v3.fna  

for file in *.fna; do summarize_fasta.sh $file; done  

### Reflection
Overall, the assignment went smoothly. When I have access to Google and ChatGPT, I can quickly resolve my problems and breeze through them. I did have issues with the initial github login. The browser option for logging in brought up a strange screen on the HPC terminal, and I couldn’t get it to work. Instead, I chose the passkey option. I learned what passkeys are and how to generate them. I set up a passkey with all options enabled, which expires in 90 days (after this semester ends), so hopefully that doesn’t cause any issues. I also got tripped up for a second on adding the gh binary location to my path. I didn’t realise that the gh_2.74.2_linux_amd64 thing was actually a directory, but that was quickly fixed once I went into the files. Once I had installed gh, I tried to push my changes, but then I got a message that I had a divergent branch, which was not a great moment. I went through all my things and figured out what was divergent and merged the two branches. Hopefully, I won’t make that mistake again. The rest of the assignment went relatively smoothly, still getting used to variables and for loops, but definitely getting more comfortable with it.  

$PATH gives you the value of your PATH variable. This is where your computer will look for any commands/scripts/programs you try to call. That’s why you have to update your path variable with the directories of any new programs or scripts you create; otherwise, when you try to call that new script, your computer won’t know where to get the script from.

