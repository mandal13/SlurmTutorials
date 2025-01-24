#!/bin/bash
#SBATCH --job-name=mmba
#SBATCH  --nodes=1
#SBATCH  --ntasks-per-node=128
#SBATCH  --time=24:00:00
#SBATCH  -A highmem 


module load quantum-espresso/7.1


set -x

#cp pb-mmba.ph.out pb-mmba.ph.out-old

cp pb-mmba.ph.out old/pb-mmba.ph.out-1

#srun --mpi=pmi2 -n 128 pw.x < pb-mmba.scf.in > pb-mmba.scf.out
srun --mpi=pmi2 -n 128 ph.x < pb-mmba.ph.in > pb-mmba.ph.out

#srun --mpi=pmi2 -n 128 dynmat.x < pb-mmba.dynmat.in > pb-mmba.dynmat.out


#srun --mpi=pmi2 -n 128 q2r.x < pb-mmba.q2r.in > pb-mmba.q2r.out
#srun --mpi=pmi2 -n 128 matdyn.x < pb-mmba.matdyn.in > pb-mmba.matdyn.out
#srun --mpi=pmi2 -n 128 matdyn.x < pb-mmba.matdyn.dos.in > pb-mmba.matdyn.dos.out
