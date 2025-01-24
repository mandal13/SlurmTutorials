# configuration   

module load slurm_setup
module list

export CPMD=/bin/cpmd.x
export PP_LIBRARY_PATH=/PP

output=out
input=1y54_tyr150_qmmm_0.inp


number_of_jobs=17

if [[  $((SLURM_NNODES % number_of_jobs)) == 0   ]]
then

        node_per_job=$((SLURM_NNODES/number_of_jobs))
        cores_per_job=$((node_per_job*48))

        ARRAY=(0.10 0.15 0.20 0.25 0.30 0.35 0.40 0.45 0.50 0.55 0.60 0.65 0.70 0.75 0.80 0.85 0.90)


        for i in `seq 1 ${number_of_jobs}`;
        do
         echo $i
        ##################################
         mkdir -p ${SLURM_SUBMIT_DIR}/UMB_${ARRAY[$i-1]}/PBE/run_2/
         cd ${SLURM_SUBMIT_DIR}/UMB_${ARRAY[$i-1]}/PBE/run_2/
         cp ../run_1/LATEST .
         cp ../run_1/RESTART* .
         cp ../run_1/1* .
         srun -N ${node_per_job} -n ${cores_per_job} -J subjob.$i $CPMD ${input} $PP_LIBRARY_PATH > $output &
        ##################################
        done

        wait

fi






#!/bin/bash -l
#SBATCH --job-name=cpmd-pbe0_9
#SBATCH --output=log.o%j
#SBATCH --partition=general
#SBATCH --account=XXX
#SBATCH --nodes=68
#SBATCH --tasks-per-node=48
#SBATCH --time=48:00:00
#SBATCH --export=NONE
#SBATCH --mail-type=NONE
#SBATCH --no-requeue
##SBATCH --mail-user=XXX@mail.com

#set verbose output
set -vx

#source ./run_cpmd-pbe0-1.sh
# configuration   

module load slurm_setup
module list

export CPMD=/bin/cpmd.x
export PP_LIBRARY_PATH=/PP

output=out
input=1y54_tyr150_qmmm_0.inp


number_of_jobs=17


if [[  $((SLURM_NNODES % number_of_jobs)) == 0   ]]
then

        node_per_job=$((SLURM_NNODES/number_of_jobs))
        cores_per_job=$((node_per_job*48))

        ARRAY=(0.10 0.15 0.20 0.25 0.30 0.35 0.40 0.45 0.50 0.55 0.60 0.65 0.70 0.75 0.80 0.85 0.90)


        for i in `seq 1 ${number_of_jobs}`;
        do
         echo $i
        ##################################
         mkdir -p ${SLURM_SUBMIT_DIR}/UMB_${ARRAY[$i-1]}/PBE0/run_9/
         cd ${SLURM_SUBMIT_DIR}/UMB_${ARRAY[$i-1]}/PBE0/run_9/
         cp ../run_8/LATEST .
         cp ../run_8/RESTART* .
         cp ../run_8/1* .
         srun -N ${node_per_job} -n ${cores_per_job} -J subjob.$i $CPMD ${input} $PP_LIBRARY_PATH > $output &
        ##################################
        done

        wait

fi






