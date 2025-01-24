# **Slurm Tutorial: Efficient Job Management for HPC**

## **Overview**
This repository provides a comprehensive guide to using the **Slurm Workload Manager** for running and managing jobs on High-Performance Computing (HPC) platforms. It covers essential Slurm commands, advanced features, and includes example scripts tailored to various use cases.

---

## **Contents**
1. **Basic Slurm Commands**: Learn the foundational commands to submit, monitor, and manage jobs.  
2. **Job Dependencies**: Understand how to define dependencies between jobs for complex workflows.  
3. **Job Arrays**: Simplify large-scale, repetitive tasks with job arrays.  
4. **Advanced Topics**: Explore additional techniques to enhance job management efficiency.  

### **Example Scripts**
The repository includes ready-to-use Slurm job scripts for different scenarios, such as:  
- Simple batch job submission  
- Running parallel jobs  
- Submitting job arrays
- Submitting jobs with dependencies  

---


## Slurm Documentation

https://slurm.schedmd.com/

---

## [Slurm Commands](Slurm-commands.md)

[sinfo](Slurm-commands.md#sinfo): Display compute partition and node information

[sbatch](Slurm-commands.md#sbatch): Sumbit a job script for remote execution

[srun](Slurm-commands.md#srun): Launch parallel tasks (job steps) for MPI jobs

[salloc](Slurm-commands.md#salloc): Allocate resources for an interactive job

[squeue](Slurm-commands.md#squeue): Display status of jobs and job steps

[sprio](Slurm-commands.md#sprio): Display job priority information

[scancel](Slurm-commands.md#scancel): Cancel pending or running jobs

[sstat](Slurm-commands.md#sstat): Display status information for running jobs

[sacct](Slurm-commands.md#sacct): Dispaly accounting information for past jobs

[seff](Slurm-commands.md#seff): Display job efficiency information for past jobs

[scontrol](Slurm-commands.md#scontrol): Display or modify Slurm configuration and state

---

## Job Dependencies
Add `#SBATCH --dependency=<type>` to job script Or use

    sbatch --dependency=<type> script.sh
    sbatch --dependency=afterok:job_id script.sh
    sbatch --dependency=afternotok:job_id script.sh
    sbatch --dependency=afterany:job_id script.sh

---

## Job Array
Job arrays offer a mechanism for submitting and managing collections of similar jobs quickly and easily

- **[Slurm Job Arrays](script-arrays.md)**
- 
  # Examples
  
- **[script-arrays1.sh](script-arrays1.sh)**
- **[script-arrays2.sh](script-arrays2.sh)**

---

## **Acknowledgment**
This tutorial was heavily inspired by the YouTube lecture:  
**[Slurm Job Management](https://www.youtube.com/watch?v=GD5Ov75lQoM&t=3598s)**  
by the **University of Southern California**.

---

