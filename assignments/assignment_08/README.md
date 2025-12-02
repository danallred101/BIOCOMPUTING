# Daniel Allred - 12/2/2025 - Assignment_08 (Group Project)

### Overview
The goal of this project was twofold. First, to compare the impact that changing various flags at different points in the pipeline would have on the final outcome. Second, to ask an interesting question about some biological process. 

For this project, we selected a study that looked at the gut microbiome in three age groups: the Young-Old group (YO, ages 60-74), the Middle-Old group (MO, ages 75-89), and the Long-Lived Old group (LO, ages 90-99). This study can be found here: https://www.ncbi.nlm.nih.gov/bioproject/PRJNA1195999. 

We chose ten samples in total, 3 YO, 4 MO, and 3 LO. We selected for this spread across samples and by byte size (taking the files with the largest byte size within each category). The accession numbers and the age group they correspond to are outlined in Accessions_summary.tsv file in the outputs folder.

Each group member was tasked with changing at least one, or possibly more, relevant flags in the bioinformatics pipeline. The changes made by each group member are outlined in the GroupProject_Summary.tsv file.

## Scripts and pipeline format:

### **00 — Setup**
Builds out basic file structure.

<details>
<summary><strong>00_setup.sh</strong></summary>

#!/bin/bash

'set -ueo pipefail

'# build out data and output structure in scratch directory

## set scratch space for data IO
SCR_DIR="${HOME}/scr10" # change to main writeable scratch space if not on W&M HPC

## set project directory in scratch space
PROJECT_DIR="${SCR_DIR}/group_project"

## set database directory
DB_DIR="${SCR_DIR}/db"

## make directories for this project
mkdir -p "${PROJECT_DIR}/data/raw"
mkdir -p "${PROJECT_DIR}/data/clean"
mkdir -p "${PROJECT_DIR}/output"
mkdir -p "${DB_DIR}/metaphlan"
mkdir -p "${DB_DIR}/prokka"
</details>


### **01 — Download**
Downloads all files given accession numbers in the accessions.txt file and compressess files into .gz format.
<details>
<summary><strong>01_download.sh</strong></summary>

</details>

### **02 — QC**
Performs quality control using fastp.
<details>
<summary><strong>02_qc.sh</strong></summary>
#!/bin/bash
#SBATCH --job-name=qc
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=20
#SBATCH --time=1200
#SBATCH --mail-type=FAIL,BEGIN,END
#SBATCH --mail-user=drallred@wm.edu               # change this!
#SBATCH -o /sciclone/home/drallred/logs/qc_%j.out # change this!
#SBATCH -e /sciclone/home/drallred/logs/qc_%j.err # change this!
#!/bin/bash
SCR_DIR="${HOME}/scr10" # change to main writeable scratch space if not on W&M HPC
PROJECT_DIR="${SCR_DIR}/group_project"
DB_DIR="${SCR_DIR}/db"
DL_DIR="${PROJECT_DIR}/data/raw"
SRA_DIR="${SCR_DIR}/SRA"
for fwd in ${DL_DIR}/*_1.fastq.gz;do rev=${fwd/_1.fastq.gz/_2.fastq.gz};outfwd=${fwd/.fastq.gz/_qc.fastq.gz};outrev=${rev/.fastq.gz/_qc.fastq.gz};fastp -i $fwd -o $outfwd -I $rev -O $outrev -j /dev/null -h /dev/null -n 3 -l 100 -e 10;done
# all QC files will be in $DL_DIR and have *_qc.fastq.gz naming pattern
</details>

### **03 — Assemble**
Performs assemblies on all reads simultaneously.

To generate individual slurm scripts run:
* for i in $(cat ./data/accessions.txt); do cat ./scripts/03_assemble_template.sh | sed "s/REPLACEME/${i}/g" >> ./scripts/${i}_assemble.slurm;done

To submit thos individual slurm scripts run:
* for i in ./scripts/SRR*.slurm; do sbatch ${i}; done

<details>
<summary><strong>03_assemble_template.sh</strong></summary>
#!/bin/bash
#SBATCH --job-name=REPLACEME_assembly
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=20
#SBATCH --time=1-10:00:00
#SBATCH --mail-type=FAIL,BEGIN,END
#SBATCH --mail-user=drallred@wm.edu               # change this!
#SBATCH -o /sciclone/home/drallred/logs/REPLACEME_assembly_%j.out # change this!
#SBATCH -e /sciclone/home/drallred/logs/REPLACEME_assembly_%j.err # change this!



SCR_DIR="${HOME}/scr10" # change to main writeable scratch space if not on W&M HPC
PROJECT_DIR="${SCR_DIR}/group_project"
DB_DIR="${SCR_DIR}/db"
QC_DIR="${PROJECT_DIR}/data/clean"
SRA_DIR="${SCR_DIR}/SRA"
CONTIG_DIR="${PROJECT_DIR}/contigs"

mkdir -p $CONTIG_DIR

for fwd in ${QC_DIR}/*REPLACEME*1_qc.fastq.gz
do

# derive input and output variables 
rev=${fwd/_1_qc.fastq.gz/_2_qc.fastq.gz}
filename=$(basename $fwd)
samplename=$(echo ${filename%%_*})
outdir=$(echo ${CONTIG_DIR}/${samplename})

#run spades with mostly default options
spades.py -1 $fwd -2 $rev -o $outdir -t 20 --meta # --metaviral rplace prokka with pharokka
done

</details>

### **04 — Annotate**
Performs annotations on all reads simultaneously.

To generate individual slurm scripts run:
* for i in $(cat ./data/accessions.txt); do cat ./scripts/04_annotate_template.sh | sed "s/REPLACEME/${i}/g" >> ./scripts/${i}_annotate.slurm;done

To submit thos individual slurm scripts run:
* for i in ./scripts/*_annotate.slurm; do sbatch ${i}; done
<details>
<summary><strong>04_annotate_template.sh</strong></summary>
#!/bin/bash
#SBATCH --job-name=GP_Annotate
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=20
#SBATCH --time=2-00:00:00 # asking for ten hours since each should only take ~30-60 minutes
#SBATCH --mail-type=FAIL,BEGIN,END
#SBATCH --mail-user=drallred@wm.edu               # change this!
#SBATCH -o /sciclone/home/drallred/logs/annotate_group_project_%j.out # change this!
#SBATCH -e /sciclone/home/drallred/logs/annotate_group_project_%j.err # change this!


# set filepath vars
SCR_DIR="${HOME}/scr10" # change to main writeable scratch space if not on W&M HPC
PROJECT_DIR="${SCR_DIR}/group_project"
DB_DIR="${SCR_DIR}/db_group_project"
DL_DIR="${PROJECT_DIR}/data/clean"
SRA_DIR="${SCR_DIR}/SRA"
CONTIG_DIR="${PROJECT_DIR}/contigs"
ANNOT_DIR="${PROJECT_DIR}/annotations"

# load prokka
module load miniforge3
eval "$(conda shell.bash hook)"
conda activate prokka-env


for fwd in ${DL_DIR}/REPLACEME_1_qc.fastq.gz
do

# derive input and output variables
rev=${fwd/_1_qc.fastq.gz/_2_qc.fastq.gz}
filename=$(basename $fwd)
samplename=$(echo ${filename%%_*})
contigs=$(echo ${CONTIG_DIR}/${samplename}/contigs.fasta)
outdir=$(echo ${ANNOT_DIR}/${samplename})
contigs_safe=${contigs/.fasta/.safe.fasta}

# rename fasta headers to account for potentially too-long names (or spaces)
seqtk rename <(cat $contigs | sed 's/ //g') contig_ > $contigs_safe

# run prokka to predict and annotate genes
prokka $contigs_safe --outdir $outdir --prefix $samplename --cpus 20 --kingdom Bacteria --metagenome --locustag $samplename --force

done

conda deactivate && conda deactivate
</details>

### **05 — Coverage**
This script creates the final summary files that will be used for analysis in the projcet. 
<details>
<summary><strong>05_coverage.sh</strong></summary>
#!/bin/bash
#SBATCH --job-name=coverage
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=20
#SBATCH --time=1-00:00:00
#SBATCH --mail-type=FAIL,BEGIN,END
#SBATCH --mail-user=drallred@wm.edu               # change this!
#SBATCH -o /sciclone/home/drallred/logs/coverage_%j.out # change this!
#SBATCH -e /sciclone/home/drallred/logs/coverage_%j.err # change this!

set -ueo pipefail

# filepath vars
SCR_DIR="${HOME}/scr10"
PROJECT_DIR="${SCR_DIR}/group_project"
QC_DIR="${PROJECT_DIR}/data/clean"
CONTIG_DIR="${PROJECT_DIR}/contigs"
ANNOT_DIR="${PROJECT_DIR}/annotations"
MAP_DIR="${PROJECT_DIR}/mappings"
COV_DIR="${PROJECT_DIR}/coverm"

mkdir -p "${MAP_DIR}" "${COV_DIR}"

# load conda
module load miniforge3
eval "$(conda shell.bash hook)"

# check if coverm-env exists, if not, create it
if ! conda env list | awk '{print $1}' | grep -qx "subread-env"; then     echo "[setup] creating subread-env with mamba";     mamba create -y -n subread-env -c bioconda -c conda-forge subread bowtie2 samtools; fi

# activate env
conda activate subread-env

# main loop
for fwd in ${QC_DIR}/*1_qc.fastq.gz
do
    rev=${fwd/_1_qc.fastq.gz/_2_qc.fastq.gz}
    filename=$(basename "$fwd")
    samplename=$(echo "${filename%%_*}")
    contigs="${CONTIG_DIR}/${samplename}/contigs.fasta"
    contigs_safe=${contigs/.fasta/.safe.fasta}
    gff="${ANNOT_DIR}/${samplename}/${samplename}.gff"
    bam="${MAP_DIR}/${samplename}.bam"
    cov_out="${COV_DIR}/${samplename}_gene_tpm.tsv"

    echo "[sample] ${samplename}"

    # index contigs if needed
        echo "  [index] bowtie2-build ${contigs_safe}"
        bowtie2-build "${contigs_safe}" "${contigs_safe}"

    # map reads to contigs
        echo "  [map] mapping reads"
        bowtie2 -x "${contigs_safe}" -1 "$fwd" -2 "$rev" -p 8 \
          2> "${MAP_DIR}/${samplename}.bowtie2.log" \
        | samtools view -b - \
        | samtools sort -@ 8 -o "${bam}"
        samtools index "${bam}"

 # run featureCounts per gene (CDS), then compute TPM
    counts="${COV_DIR}/${samplename}_gene_counts.txt"
    tpm_out="${COV_DIR}/${samplename}_gene_tpm.tsv"

    echo "  [featureCounts] counting reads per CDS (locus_tag)"
    featureCounts \
      -a "${gff}" \
      -t CDS \
      -g locus_tag \
      -p -B -C \
      -T 20 \
      -o "${counts}" \
      "${bam}"

    echo "  [TPM] calculating TPM"
    awk 'BEGIN{OFS="\t"}
         NR<=2 {next}                           # skip header lines
         {
           id=$1; len=$6; cnt=$(NF);           # Geneid, Length, sample count is last column
           if (len>0) {
             rpk = cnt/(len/1000);
             RPK[id]=rpk; LEN[id]=len; CNT[id]=cnt; ORDER[++n]=id; SUM+=rpk;
           }
         }
         END{
           print "gene_id","length","counts","TPM";
           for (i=1;i<=n;i++){
             id=ORDER[i];
             tpm = (SUM>0 ? (RPK[id]/SUM)*1e6 : 0);
             printf "%s\t%d\t%d\t%.6f\n", id, LEN[id], CNT[id], tpm;
           }
         }' "${counts}" > "${tpm_out}"

    echo "  [done] ${tpm_out}"

    echo "  [done] ${cov_out}"

# join the coverage estimation info back to the annotation file

ann="${ANNOT_DIR}/${samplename}/${samplename}.tsv"
joined="${ANNOT_DIR}/${samplename}/${samplename}_DRA.with_cov.tsv" #CHANGE IN TO YOUR INITIAL

echo "  [join] adding coverage columns to annotation TSV"
awk -v FS='\t' -v OFS='\t' -v keycol='locus_tag' '
  # Read TPM table: gene_id  length  counts  TPM
  NR==FNR {
    if (FNR==1) next
    id=$1; LEN[id]=$2; CNT[id]=$3; TPM[id]=$4
    next
  }
  # On the annotation header, find which column is locus_tag
  FNR==1 {
    for (i=1;i<=NF;i++) if ($i==keycol) K=i
    if (!K) { print "ERROR: no \"" keycol "\" column in annotation header" > "/dev/stderr"; exit 1 }
    print $0, "cov_length_bp", "cov_counts", "cov_TPM"
    next
  }
  # Append coverage fields if we have them
  {
    id=$K
    print $0, (id in LEN? LEN[id]:"NA"), (id in CNT? CNT[id]:"0"), (id in TPM? TPM[id]:"0")
  }
' "${tpm_out}" "${ann}" > "${joined}"

echo "  [done] ${joined}"

done
</details>

