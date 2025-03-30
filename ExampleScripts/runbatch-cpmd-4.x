#!/bin/bash -l
#
#SBATCH --job-name=runbatch
#SBATCH --output=%x.o%j
#SBATCH --error=%x.e%j
#SBATCH --time=48:00:00
#SBATCH --nodes=4
#SBATCH --ntasks-per-node=16
#SBATCH --cpus-per-task=1
#SBATCH --partition=batch2



#
# Partitions:
##SBATCH --partition=batch
##SBATCH --partition=batch2
##SBATCH --partition=fatbatch
##
## --job-name=runbatch  : name of the run
## --time=48:00:00      : walltime for the run
## --nodes=2            : number of nodes
## --ntasks-per-node=16 : number of processes per node
##
## --dependency=afterok:<jobid>
#
# NOTE: The value of 'ntasks-per-node' depends on the chosen queue.
#       You have to use the correct number of cores per node,
#       otherwise your job will be rejected by the batch system.
#
#   --ntasks-per-node=12   : on regular node (--partition=batch)
#   --ntasks-per-node=16   : on regular node (--partition=batch2)
#   --ntasks-per-node=28   : on fatnode (--partition=fatbatch)
#
#-----------------------------------------------------------------------
  input="INP"
  output="OUT"
#
# set workdir: Only change if you know what you are doing
#
  workdir="."
#  workdir="/dev/shm/${SLURM_JOB_ID}"
#-----------------------------------------------------------------------
# nothing needs to be changed below this line
#-----------------------------------------------------------------------
  unset SLURM_EXPORT_ENV
#
  cd ${SLURM_SUBMIT_DIR}
#
# set path for pseudopotential library and CPMD executable
#
  export CPMD="/bin/cpmd.x"
  export PAR_RUN="mpirun"
  export PP_LIBRARY_PATH="/pot.cpmd"
#
#  export TASKS_MPI=16
#  export ppn=${SLURM_NTASKS_PER_NODE}
#  if [ ${ppn} -eq 16 ]; then
#    export OMP_NUM_THREADS=8
#  elif [ ${ppn} -eq 28 ]; then
#    export OMP_NUM_THREADS=14
#  else
#    export OMP_NUM_THREADS=6
#  fi
#  export OMP_PLACES=CORES
#  export OMP_PROC_BIND=close,close
#  export OMP_WAIT_POLICY='ACTIVE'
#
# load modules
#
  module purge
  module load openmpi/intel/3.1.3-2019.1.144
#
  ulimit -H unlimited
  ulimit -S unlimited
  ulimit -l unlimited
  ulimit -l
#
# copy to local workdir:
#
  if [ ${workdir} != "." ]; then
    mkdir -p ${workdir}
    cp -a * ${workdir}
    cd ${workdir}
  fi
#
# set automatic run stop 600s before end of walltime limit:
#
  SLEEPTIME=$(grep time $0 | head -1 | sed 's/.*time=//g'| \
              awk -F: '{print -600+3600*$1+$2*60+$3}')
  echo "auto stop in ${SLEEPTIME} seconds"
  (sleep ${SLEEPTIME} ; touch ${workdir}/EXIT ; echo -n "touched EXIT at "; date) &
#
  echo -n "Starting run at: "
  date

#  export MFLAG="--map-by slot:PE=${OMP_NUM_THREADS} --report-bindings --bind-to core"

  ${PAR_RUN} ${CPMD} ${input} ${PP_LIBRARY_PATH} > ${output}

  echo -n "Stopping run at: "
  date
#
# move results and tidy up:
#
  echo
  if [ ${workdir} != "." ]; then
    cp -a * ${SLURM_SUBMIT_DIR}
    cd ${SLURM_SUBMIT_DIR}
    rm -rf ${workdir}
  fi
#
