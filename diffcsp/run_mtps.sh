#!/bin/bash

#SBATCH --job-name=DiffCSP        # Job name
#SBATCH --output=diffcsp_mpts.out
#SBATCH --error=diffcsp_mpts.err
#SBATCH --time=12:00:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
#SBATCH --mem=64G
#SBATCH --partition=gpu_h100
#SBATCH --gpus=1

#export CUDA_VISIBLE_DEVICES='0'
#export PYTORCH_CUDA_ALLOC_CONF='expandable_segments:True'
#export NUMEXPR_MAX_THREADS=64

source /home/rs1/21CS92R01/anaconda3/bin/activate CrysLDM


python3 -W ignore run.py data=mpts_52 model=diffusion_w_type expname=mpts_52

python3 -W ignore generation.py --model_path /home/rs1/21CS92R01/workplace/DiffCSP_forked/singlerun/2025-05-04/mpts_52 --dataset mpts_52

python3 -W ignore compute_metrics.py --root_path /home/rs1/21CS92R01/workplace/DiffCSP_forked/singlerun/2025-05-04/mpts_52/ --tasks gen --gt_file data/mpts_52/test.csv