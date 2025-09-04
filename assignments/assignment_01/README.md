List of Commands:

#The assignments directory was already made (if it hadn't been made would've used: mkdir -p ./assignments/assignment_1)

#In ./assignments

#Making all the basic directories and two markdown files
mkdir assignment_1
cd assignment_1
mkdir data scripts results docs config logs
mkdir data/{raw,clean}
touch assignment_1_essay.md README.md

#Adding all the placeholder files (this lets us push to github and have the directories appear)
touch ./data/raw/bases.fasta
touch ./data/clean/cleanbases.fasta
touch ./scripts/script.sh
touch ./results/goodstuff.txt
touch ./docs/info.txt
touch ./config/configurations.txt
touch ./logs/logfile.log


