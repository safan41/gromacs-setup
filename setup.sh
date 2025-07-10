#!/usr/bin/bash
cd ~
bash <(curl -sSL conda.sh)
eval "$($HOME/miniconda3/bin/conda shell.bash hook)"
conda init
source ~/.bashrc
version= conda --version

if $version == conda*; then
    mkdir biobb && cd biobb
    curl -sS https://raw.githubusercontent.com/safan41/gromacs-setup/refs/heads/main/environment.yml
    conda env create -f environment.yml
    echo "alias jlab=jupyter lab --NotebookApp.token='' --NotebookApp.password=''" > ~/.bashrc
    echo "SCRIPT COMPLETE! Activate environment with 'conda activate biobb_env' and run JupyterLab with 'jlab' to continue" 
else
    echo 'ERROR: NO CONDA VERSION FOUND (Are you connected to the internet?)'
fi
