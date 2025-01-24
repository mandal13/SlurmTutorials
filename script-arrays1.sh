#!/bin/bash

#SBATCH --job-name=testArray
#SBATCH --array=1-5
#SBATCH --output=array_%A_%a.out
#SBATCH --error=array_%A_%a.err
#SBATCH --gres=gpu:1
#SBATCH --time=00:10:00
#SBATCH --mem=400

# Print the task id.
echo "My SLURM_ARRAY_TASK_ID:" $SLURM_ARRAY_TASK_ID

# Add lines here to run your computations.
