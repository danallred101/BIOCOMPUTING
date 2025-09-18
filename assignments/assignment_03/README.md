# Daniel Allred - 9/17/2025 - Assignment_03

### Assignment Tasks
* Navigate and set up the assignment_03	directory
* Download a fasta sequence file
* Use Unix tools to explore the	file contents by answering a series of 10 questions


### Relevant Directory Structure (Unused directories omitted)
* BIOCOMPUTING
        * assignments
                * assignment_03
                        * README.md
                        * data
                                * GCF_000001735.4_TAIR10.1_genomic.fna


### Commands Used to Set up Directory
**Local:**  
bora *(alias comand to log onto the WM HPC)*


**HPC:**  
cd BIOCOMPUTING/assignments/  
mkdir assignment_0{3..8}  
cd assignment_03  
mkdir data  
touch README.md  
nano README.md *(Documented everything in README.md)*  
*(Opened new terminal, ran: bora, cd BIOCOMPUTING/assignments/assignment_03 - All future commands run in this>
cd data  
wget https://gzahn.github.io/data/GCF_000001735.4_TAIR10.1_genomic.fna.gz  
gunzip GCF_000001735.4_TAIR10.1_genomic.fna.gz  


### Commands for Questions 1-10
All commands are run in the directory ./BIOCOMPUTING/assignments/assignment_03/data

#### Question 1:
Command: grep -c ">" GCF_000001735.4_TAIR10.1_genomic.fna  
Reasoning: grep -c counts the number of a given input in a specified file, in fna files each sequence typically starts with a ">" so by counting the number of ">" we learn the number of sequences in the file.  
Output: 7  

#### Question 2:
Command: grep -v ">" GCF_000001735.4_TAIR10.1_genomic.fna | tr -d '\n' | wc -m  
Reasoning: The grep command gives all the sequence lines (without the headers), the tr command deletes all the newlines (which would be counted as characters, and wc counts all the characters.  
Output: 119668634  

#### Question 3:
Command:wc -l GCF_000001735.4_TAIR10.1_genomic.fna  
Reasoning: The wc command counts the number of lines in the file.  
Output: 14  

#### Question 4:
Command: grep ">" GCF_000001735.4_TAIR10.1_genomic.fna | grep -c "mitochondrion"  
Reasoning: The first grep command gets the header lines, the second grep command counts the number of times the word "mitochondrion" appears  
Output: 1

#### Question 5:
Command: grep ">" GCF_000001735.4_TAIR10.1_genomic.fna | grep -c "chromosome"  
Reasoning: Same as 4, just searching for a different keyword.  
Output: 5  

#### Question 6:
Command: wc -m <(grep -A1 "chromosome 1" GCF_000001735.4_TAIR10.1_genomic.fna | grep -v ">" | tr -d "\n") <(grep -A1 "chromosome 2" GCF_000001735.4_TAIR10.1_genomic.fna | grep -v ">" | tr -d "\n") <(<(grep -A1 "chromosome 3" GCF_000001735.4_TAIR10.1_genomic.fna | grep -v ">" | tr -d "\n")  
Reasoning: Definitely my most inelegant solution, essentially I'm creating a temporary file of the sequence for each given chromosome, then feeding all those files into wc -m which counts the number of bases in each. It's worth noting all of the outputs are one less than the answers given in the assignment. If I remove the tr -d "\n" command, I get the right numbers, but I think this might be an error in the answers, not on my end.  
Output:  
30427671 /dev/fd/63  
19698289 /dev/fd/62  
23459830 /dev/fd/61  
73585790 total  

#### Question 7:
Command: grep -A1 "chromosome 5" GCF_000001735.4_TAIR10.1_genomic.fna | grep -v ">" | tr -d "\n" | wc -m  
Reasoning: The first grep command grabs the header and seqeunce for chromsome 5, the second grep command removes the header, the tr command removes the new line, wc command counts the bumber of bases.  
Output: 26975502 *(As mentioned in Q6 this output is one less than the output given in assignemnt 3, if I remove the tr command it gives the right output, I think I've either done something weird with the tr command, or the answer in the assignment is off by 1)*  

#### Question 8:
Command: grep -v ">" GCF_000001735.4_TAIR10.1_genomic.fna | grep -c "AAAAAAAAAAAAAAAA"  
Reasoning: The first grep command removes headers, the second command counts the number of sequences contain the sequence of interest.  
Output: 1  

#### Question 9:
Command: grep ">" GCF_000001735.4_TAIR10.1_genomic.fna | sort | head -n 1  
Reasoning: The grep command selects for sequence headers, the sort command lists them alphabetically, the head command returns the first header in that alphabetical order.  
Output: >NC_000932.1 Arabidopsis thaliana chloroplast, complete genome  

#### Question 10:
Command: paste <(grep ">" GCF_000001735.4_TAIR10.1_genomic.fna) <(grep -v ">" GCF_000001735.4_TAIR10.1_genomic.fna) > tab_seperated.fasta  
Reasoning: paste will take the two input files and combine them by combining sequentially corresopnding lines from each file seperated by tabs. The two process subsittution commands <(grep ...) grab the headers and sequences respectively, allowing paste to combine them together into the new file "tab_seperated.fasta"   
Output: Too long to put here, but as expected. Can check file using command: cut -c 1-100 tab_seperated.fasta  


### Reflection:
When answering each question, I took a trial-and-error approach. I’d give it my best shot just from memory, then start to look through past lessons and run —help for different commands. If I was still stuck, I’d Google and ask ChatGPT to better explain how certain commands worked, or provide examples of how to use/execute a given command in a certain context. This was a pretty effective approach. For most of the questions I could get most of the way there on my own. I think the assignment was good practice in getting more familiar with a lot of the commands.
The process and command substitutions have been the most difficult individual tools to become comfortable with. During this problem set, I often didn’t remember or consider them as options to solve problems until I’d tried a fair few different ways. On the whole, it’s been frustrating trying to remember all the other commands available to me. I can logically think through what I want to do, but I can’t remember which commands do which things. Obviously, this is a problem that gets easier and easier with practice and familiarity, but it’s still a little frustrating.
These skills are essential in computational biology because of the scale of data sets. In a lot of data analysis (or at least a lot of the data analysis I’ve done), the data sets are at a small enough scale that you can manually go through and do/check things yourself; it’s troublesome, but doable. However, when you start working with really huge data sets (take any -omics data set), there is no practical way to approach or manipulate those data sets without coding. You have to be able to manipulate the data through commands on a computer, or you would never get anywhere. The more familiar you are with the available commands, the more effective you’ll be at conducting your data analysis.

