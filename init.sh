#!/bin/bash

# ______ Make conda envs and jupyter kernel persistent ______
# only /home is persistent, so we need to store envs and kernels here
# create jupyter config file so that kernels will stored in /home
echo -e "{\n  \"CondaKernelSpecManager\": {\n    \"kernelspec_path\": \"--user\"\n  }\n}" >> /home/jovyan/.jupyter/jupyter_config.json
# define a path in /home for conda envs as well
conda config --add envs_dirs /home/jovyan/.conda_envs 

# ______ Create conda env with respective dependencies ______
# create conda env. Here w python 3.9 
conda create -n py39 python=3.9 -y 
# configure conda for bash (needed for activation)
conda init bash
# restart terminal (needed for activation)
source ~/.bashrc
# activate new env (with full path at the first time)
conda activate /home/jovyan/.conda_envs/py39
#install dependencies
conda install -y cudatoolkit-dev=11.3.1 -c conda-forge
conda install -y -c anaconda cudnn
pip install --upgrade "jax[cuda11_pip]" -f https://storage.googleapis.com/jax-releases/jax_cuda_releases.html
pip install git+https://github.com/jakobkilian/whisper-jax.git
# install IPython kernel (inside of new env!) to make it visible
conda install ipykernel -y

# ______ Bugfix: update jupyter to prevent kernels not loading correctly ______
# update jupyter - otherwise kernel is not recognized (bugfix)
pip install --upgrade jupyter_client
pip install --upgrade jupyter_server

# ______ Check if Jupyter can see the newly created env and kernel ______
# leave conda env
conda deactivate
# check if the kernel appears in both:
python -m nb_conda_kernels list
jupyter kernelspec list

#THE END
