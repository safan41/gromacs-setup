#!/usr/bin/bash
cd ~
apt update
sudo apt install libopenmpi-dev
bash <(curl -sSL conda.sh)
eval "$($HOME/miniconda3/bin/conda shell.bash hook)"
conda init
source ~/.bashrc

if [[ $(conda --version) = conda* ]]; then
    mkdir biobb
    cd biobb
    curl -o environment.yml https://raw.githubusercontent.com/safan41/gromacs-setup/refs/heads/main/environment.yml
    
    conda env create -f environment.yml
    
    if [[ $? = 1 ]]; then 
        echo 'ERROR: CONDA ENVIRONMENT FAILED (Install failed somewhere)'
    fi

    echo "alias jlab=\"jupyter lab --NotebookApp.token='' --NotebookApp.password=''\"" >> ~/.bashrc
    
    source ~/.bashrc

    mkdir -p ~/.jupyter/lab/user-settings/@jupyterlab/extensionmanager-extension
    
    message_content="$(cat <<-EOF
{
    // Extension Manager
    // @jupyterlab/extensionmanager-extension:plugin
    // Extension manager settings.
    // *********************************************

    // Disclaimed Status
    // Whether the user agrees the access to external web services and understands extensions may introduce security risks or contain malicious code that runs on his machine.
    "disclaimed": true
}
EOF
)"
    echo "$message_content" > ~/.jupyter/lab/user-settings/@jupyterlab/extensionmanager-extension/plugin.jupyterlab-settings 
    
    echo "SCRIPT COMPLETE! Activate environment with 'conda activate biobb_env' and run JupyterLab with 'jlab' to continue" 
else
    echo 'ERROR: NO CONDA VERSION FOUND (Are you connected to the internet?)'
fi
