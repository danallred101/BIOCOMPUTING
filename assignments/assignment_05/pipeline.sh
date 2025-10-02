#!/bin/bash
set -euo pipefail
01_download_data.sh
for i in ./data/raw/*_R1_*; do 02_run_fastp.sh ${i}; done


