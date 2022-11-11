#!/usr/bin/env bash

# Exit script on error
set -e 

# Set environment variables
CONDA_INSTALL_LOCATION="$(pwd)/conda"
LOGS_LOCATION="$(pwd)/logs"


### Miniconda Setup ###

# Install Miniconda
if [ ! -d "${CONDA_INSTALL_LOCATION}" ]; then
  mkdir -p "${CONDA_INSTALL_LOCATION}"
  pushd "${CONDA_INSTALL_LOCATION}" || exit
  wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
  bash Miniconda3-latest-Linux-x86_64.sh -b -f -p "${CONDA_INSTALL_LOCATION}"
else
  pushd "${CONDA_INSTALL_LOCATION}" || exit
fi

# Set up Miniconda to work with the shell
source "${CONDA_INSTALL_LOCATION}/etc/profile.d/conda.sh"

# Update Miniconda
conda upgrade -y conda

# Exit conda directory
popd || exit
echo ""

echo "[INFO] To use the installed version of Miniconda in other shells, run the following command:"
echo "$ source ${CONDA_INSTALL_LOCATION}/etc/profile.d/conda.sh"


### End Tasks Section ###
echo ""

echo "### Done! ###"
