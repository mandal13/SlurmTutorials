## Slurm Commands

## 1.  sinfo
Dispaly compute partition and node information

    sinfo --help
  
    sinfo

    sinfo --partition gilbreth-debug

    sinfo -lNp gilbreth-debug

    sinfo --states=idle

## 2. sbatch
Submit a job for remote execution

    sbatch script.sh


### Examples

- **[script-1.sh](script-1.sh):** Template with generally used options

## 3. srun
Launch parallel tasks (job steps) for MPI jobs

    srun --mpi=pmi2 -n 128 pw.x < CsPbBr3.scf.in > CsPbBr3.scf.out
    
## 4. salloc
Allocate resources for interactive jobs

    salloc -A debug -N1 -n1 -t 01:00:00

## 5. squeue
Display status of job steps

    squeue -u username
    squeue -u username --start
    squeue -A <account>
    alias mysq="squeue -u $USER"
    alias mysq-watch="watch -n 10 squeue -u $USER"

## 6. sprio
Job priorities based on `fairshare algorithm` and job age

Display job priority information

    sprio -j jobid
    sprio -j jobid -n

## 7. scancel
Cancel pending or running jobs

    scancel jobid
    scancel -u username
    squeue -u $USER | awk '{print $1}' | tail -n+2 | xargs scancel
    squeue -u $USER | grep ^197 | awk '{print $1}' | xargs -n 1 scancel

## 8. sstat
Display status information for running jobs

    sstat -j jobid
    sstat -j jobid --format=JobId,MaxRSS,AveCPUFreq,MaxDiskRead,MaxDiskWrite

## 9. sacct
Display status information for past jobs

    sacct -j jobid
    sacct --format=JobId,MaxRSS,AveCPUFreq,MaxDiskRead,MaxDiskWrite,State
    sacct --brief
    
### Exit codes

  Exit status: 0-255
  
  0 ---> sucess, completed
  
  nonzero ---> failure
  
  Codes 1 - 127 indicates error in job
  
  codes 129 - 255 indicate jobs terminated by Unix signals
  
  `man signal`

## 10. seff
Display job efficiency info for past jobs (CPU and Memory use)

    seff jobid


## 11. scontrol
Display or modify Slurm configuration and state

    scontrol show partition <partition>
    scontrol show node <nodeid>
    scontrol show job <jobid>
    scontrol hold <jobid>
    scontrol release <jobid>


