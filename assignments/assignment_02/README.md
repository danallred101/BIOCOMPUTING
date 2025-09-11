# Daniel Allred - 9/10/2025 - Assignment_02

### Assignment Tasks
* Set up workspace on HPC by building BIOCOMPUTING directories and more
* Download two files from NCBI on local machine
* Transfer both files from local to HPC using FileZilla
* Verify file integrity usig md5sum
* Create useful bash aliases
* Document the whole thing

### Directory Structure
BIOCOMPUTING (main parent directory)
* notes
* practice
* projects
* README.md
* test
* assignments
	* assignment_01
	* assignment_02
		* README.md
		* data
			* 'GCF_000005845.2_ASM584v2_genomic.fna.gz'
			* 'GCF_000005845.2_ASM584v2_genomic.gff.gz'


### All Commands Used (and file transfer workflow):
**Local:**  
bora  *(alias command to log onto the WM HPC)*

**HPC:**  
*Biocomputing folder was already transfered to HPC during class, so mkdir commands are different than those listed in assignment*    
cd BIOCOMPUTING/assignments/  
mkdir -p assignment_02/data  
cd assignment_02  
touch README.md  
nano README.md *opened new terminal to continue work in HPC, while documenting >  

**Local:**  
brew install lftp *(MacOS doesn't have the ftp command, after searching decided using the homebrew lftp command was best workaround)*  
lftp ftp.ncbi.nlm.nih.gov  
'cd genomes/all/GCF/000/005/845/GCF_000005845.2_ASM584v2/'  
ls  
lcd BIOCOMPUTING/ *(changed the lcd so the get command would place files there)*  
get 'GCF_000005845.2_ASM584v2_genomic.fna.gz'  
get 'GCF_000005845.2_ASM584v2_genomic.gff.gz'  
bye  

**File transfer using FileZilla:**  
Open FileZilla  
Connect to Bora using SFTP  
Upload both .gz files obtained with get command to /BIOCOMPUTING/assignments/assignment_02/data/  
Checked files permissions on FileZilla - double click on file, select "File Permissions" - only owner had Read and Write permissions  

**HPC:**  
cd data  
chmod 744 GCF_000005845.2_ASM584v2_genomic.fna.gz *(sets users permissions to rwx, group permissions to r, and global permissions to r)*  
chmod 744 GCF_000005845.2_ASM584v2_genomic.gff.gz  

**Local:**  
md5sum GCF_000005845.2_ASM584v2_genomic.fna.gz GCF_000005845.2_ASM584v2_genomic.gff.gz  

**HPC:**  
md5sum GCF_000005845.2_ASM584v2_genomic.fna.gz GCF_000005845.2_ASM584v2_genomic.gff.gz  
nano .bashrc *(checking for aliases)*  


### MD5 Hashes  
**Listed Local/HPC:**  
.fna.gz:   
c13d459b5caa702ff7e1f26fe44b8ad7  
c13d459b5caa702ff7e1f26fe44b8ad7  
*MATCH*  

.gff.gz:  
2238238dd39e11329547d26ab138be41  
2238238dd39e11329547d26ab138be41  
*MATCH*  

### Alias Descriptions:  
u='cd ..;clear;pwd;ls -alFh --group-directories-first' - tells the current directory to up to the parent directory, clear the terminal, print the working directory, and runs the list command showing all files, long format, in human readable sizes, with a symbol at the end to indicate entry type, it also list all directories first  
d='cd -;clear;pwd;ls -alFh --group-directories-first' - tells the current directory to go to the previous used directory, clear the terminal, print the working directory, and runs the list command showing all files, long format, in human readable sizes, with a symbol at the end to indicate entry type, it also list all directories first  
ll='ls -alFh --group-directories-first' - runs the list command showing all files, long format, in human readable sizes, with a symbol at the end to indicate entry type, it also list all directories first  

## Reflection:  
The initial setup of the directories in the HPC was easy and nice practice. The first difficult part was downloading the files from NCBI. Since MacOS doesn't have the FTP command pre-installed I had to do some google and ChatGPT searches to figure out that homebrew has an lftp command which functions very similarly, once I'd figured that out it was quite easy. All the rest was fairly simple, I actually just learned about the MD5 hashes this weekend because I needed to download some data for an RNA-seq experiment. Still getting used to documeing in markdown, but I wouldn't change anything, this felt like a useful assignment.  
P.S. I ended up having a really difficult time doing a git push, kept getting error messages about the connection dropping, ended up making an SSH key which fixed the problem.


