#!/bin/bash

## Resource Request

#SBATCH --job-name = myJobName          # Specifies a name for the job allocation
#SBATCH --output = myJobName.o%j        # Instructs Slurm to connect the batch script’s standard output directly to the filename.
#SBATCH --error = myJobName.e%j         # file for standard erro
#SBATCH --partition = normal            # Requests a specific partition for the resource allocation

#SBATCH --ntasks = 3                    # This option advises the Slurm controller that job steps run within the allocation will launch
                                        # a maximum of number tasks and offer enough resources
                                        
#SBATCH --cpus-per-task = 16            # Advises the Slurm controller that ensuing job steps will require ncpus number of processors per task.
                                        # Without this option, the controller will just try to assign one processor per task

#SBATCH --ntasks-per-node = 28
#SBATCH --nodes = 2
                                        
#SBATCH --mem-per-cpu = 700M            # This is the minimum memory required per allocated CPU
#SBATCH --time = 0-00:10:00             # time format is days-hours:minutes:seconds

#SBATCH --mail-user = yourlD@nmsu.edu   # Defines user who will receive email notification
#SBATCH --mail-type = BEGIN             # Notifies user by email when certain event types occur. Valid type values are BEGIN, END, FAIL
#SBATCH --mail-type = END               # --mail-type BEGIN, END, FAIL
#SBATCH --mail-type = FAIL
#SBATCH --account = <account_id>

#SBATCH --get-user-env                  # Tells sbatch to retrieve the login environment variables.
                                        # Be aware that any environment variables already set in sbatch environment 
                                        # will take precedence over any environment variables in the user’s login environment.
                                        # Clear any environment variables before calling sbatch 
                                        # that you don’t want to be propagated to the spawned program.

# shell environment is transferred to job when submitted
# use module purge to clear modules


#------------------------------------------# 
#      Slurm Environment Variables         #
#------------------------------------------#
# SLURM_CPUS_PER_TASK : Number of CPUs requested per task.
# SLURM_JOB_ID : ID of the job allocation.
# SLURM_JOB_NAME : Name of the job.
# SLURM_JOB_NODELIST : List of nodes allocated to the job.
# SLURM_JOB_NUM_NODES : Total number of nodes in the job’s resource allocation.
# SLURM_NPROCS : Total number of CPUs allocated
# SLURM_NTASKS : Maximum number of MPI tasks (that’s processes).
# SLURM_NTASKS_PER_CORE : Number of tasks requested per core.
# SLURM_SUBMIT_DIR : The directory from which SBATCH was invoked.

echo "Job ID: $SLURM_JOB_ID"
echo "Nodelist: $SLURM_JOB_NODELIST"

cd $SLURM_SUBMIT_DIR/test


## Job Steps
srun echo "`Start process`"
srun hostname
srun sleep 30
srun echo "`End process`"

module purge
module load quantum-espresso/6.6

srun --mpi=pmi2 -n 128 pw.x < CsPbBr3.scf.in > CsPbBr3.scf.out
