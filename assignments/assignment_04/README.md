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
*navigate the given options, web login was funky so I just used a personal access token that will expire after the semester ends*
*did my first git push, realised stuff wasn't in line, did git pull, relised I had divergent branches, yippeee*





