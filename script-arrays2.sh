#!/bin/bash
#SBATCH --job-name=testArray
#SBATCH  --nodes=1
#SBATCH  --ntasks-per-node=128
#SBATCH  --time=00:30:00
#SBATCH  -A standby 
#SBATCH --array=1-10
#SBATCH --output=array_%A_%a.out
#SBATCH --error=array_%A_%a.err

cwd=$PWD

echo "Current Working Directory: $cwd"

echo "My SLURM_ARRAY_TASK_ID: $SLURM_ARRAY_TASK_ID"
echo "---------------------------------------------------------"
echo "SLURM_JOB_ID: $SLURM_JOB_ID"
echo "SLURM_ARRAY_JOB_ID: $SLURM_ARRAY_JOB_ID"
echo "SLURM_ARRAY_TASK_ID: $SLURM_ARRAY_TASK_ID"
echo "SLURM_ARRAY_TASK_COUNT: $SLURM_ARRAY_TASK_COUNT"
echo "SLURM_ARRAY_TASK_MAX: $SLURM_ARRAY_TASK_MAX"
echo "SLURM_ARRAY_TASK_MIN: $SLURM_ARRAY_TASK_MIN"

echo "---------------------------------------------------------"
#create and print array with directory names
echo "List of Directories: "
array=(./dir_*)
for dir in "${array[@]}"; do echo "$dir"; done

echo "---------------------------------------------------------"
echo "I am going to directory: ${array[$SLURM_ARRAY_TASK_ID]}"

if [[ -d ${array[$SLURM_ARRAY_TASK_ID]} ]]; then
  cd  ${array[$SLURM_ARRAY_TASK_ID]}
else
  echo "error: could'nt find directory"
  exit 1
fi

#if [[ $? -ne 0 ]]; then
#  echo "error: could'nt change directory"
#  exit 1
#fi

echo "-----------starting job----------------------------------"

module load quantum-espresso/6.6

srun --mpi=pmi2 -n 128 pw.x < sio2.in > sio2.out

if [[ $? -ne 0 ]]; then
  echo "error in srun"
  exit 1
fi

cd $cwd

echo "-----------finished job----------------------------------"
