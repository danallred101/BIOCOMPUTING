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
*Biocomputing folder was already transfered to HPC during class, so mkdir comma>
cd BIOCOMPUTING/assignments/
mkdir -p assignment_02/data
cd assignment_02
touch README.md
nano README.md *opened new terminal to continue work in HPC, while documenting >

**Local:**
brew install lftp *(MacOS doesn't have the ftp command, after searching decided using the homebrew lftp command was best workaround)*

