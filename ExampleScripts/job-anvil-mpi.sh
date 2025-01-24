#!/bin/bash                                                                                                                                                                                 
#SBATCH --job-name=P_2.075
#SBATCH  --nodes=1
#SBATCH  --ntasks-per-node=128
#SBATCH  --cpus-per-task=1
#SBATCH  --time=12:00:00
##SBATCH  --time=00:10:00
#SBATCH  -A XXX 
#SBATCH  -p shared

#module load intel/19.0.5.281
#module load intel-mkl/2019.5.281
#module load fftw/3.3.8
#module load impi/2019.5.281

module load quantum-espresso/6.7

#export executable=/home/XXX/softwares/qe-7.1/build/bin/pw.x
#export executabledos=/home/XXX/softwares/qe-7.1/build/bin/dos.x
#export executable=/home/XXX/softwares/QE-debug-version/qe-7.1/bin/pw.x

export executable=pw.x
export OMP_NUM_THREADS=1

srun -n 128 $executable < CsPbBr3.scf.in > CsPbBr3.scf.out
