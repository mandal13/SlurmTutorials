# Jobs which are part of a job array will have the environment variable `SLURM_ARRAY_TASK_ID` set to its array index value

---
https://slurm.schedmd.com/job_array.html

## Submit a job array with index values between 0 and 31
    $ sbatch --array=0-31    -N1 tmp

## Submit a job array with index values of 1, 3, 5 and 7

    $ sbatch --array=1,3,5,7 -N1 tmp

## Submit a job array with index values between 1 and 7 with a step size of 2 (i.e. 1, 3, 5 and 7)

      $ sbatch --array=1-7:2   -N1 tmp

# Job ID and Environment Variables 
Job arrays will have additional environment variables set.

`SLURM_ARRAY_JOB_ID` will be set to the first job ID of the array.

`SLURM_ARRAY_TASK_ID` will be set to the job array index value.

`SLURM_ARRAY_TASK_COUNT` will be set to the number of tasks in the job array.

`SLURM_ARRAY_TASK_MAX` will be set to the highest job array index value.

`SLURM_ARRAY_TASK_MIN` will be set to the lowest job array index value.

        $ sbatch --array=1-3 -N1 tmp
        Submitted batch job 36

```bash
SLURM_JOB_ID=36
SLURM_ARRAY_JOB_ID=36
SLURM_ARRAY_TASK_ID=3
SLURM_ARRAY_TASK_COUNT=3
SLURM_ARRAY_TASK_MAX=3
SLURM_ARRAY_TASK_MIN=1

SLURM_JOB_ID=37
SLURM_ARRAY_JOB_ID=36
SLURM_ARRAY_TASK_ID=1
SLURM_ARRAY_TASK_COUNT=3
SLURM_ARRAY_TASK_MAX=3
SLURM_ARRAY_TASK_MIN=1

SLURM_JOB_ID=38
SLURM_ARRAY_JOB_ID=36
SLURM_ARRAY_TASK_ID=2
SLURM_ARRAY_TASK_COUNT=3
SLURM_ARRAY_TASK_MAX=3
SLURM_ARRAY_TASK_MIN=1
```

Under normal circumstances, array jobs will have the first task of the array be a place holder
for the rest of the array, causing it to be the last to run.
As a result, the task with the lowest `SLURM_JOB_ID` will have the highest `SLURM_ARRAY_TASK_ID`.

All Slurm commands and APIs recognize the `SLURM_JOB_ID` value. Most commands also recognize the `SLURM_ARRAY_JOB_ID` plus `SLURM_ARRAY_TASK_ID` values separated by an underscore as identifying an element of a job array. Using the example above, `"37"` or `"36_1"` would be equivalent ways to identify the second array element of job `36`.

# File Names

Two additional options are available to specify a job's 
`stdin, stdout, and stderr file names: %A` will be replaced by
the value of `SLURM_ARRAY_JOB_ID` (as defined above) and `%a` will be 
replaced by the value of `SLURM_ARRAY_TASK_ID` (as defined above). 
The default output file format for a job array is `"slurm-%A_%a.out"`.
An example of explicit use of the formatting is:
`sbatch -o slurm-%A_%a.out --array=1-3 -N1 tmp`
which would generate output files names of 
this sort `"slurm-36_1.out"`, `"slurm-36_2.out"` and `"slurm-36_3.out"`.


# Scancel Command Use
If the job ID of a job array is specified as input to the scancel command then all elements of that job array will be cancelled. Alternately an array ID, optionally using regular expressions, may be specified for job cancellation.

## Cancel array ID 1 to 3 from job array 20

    $ scancel 20_[1-3]

## Cancel array ID 4 and 5 from job array 20

    $ scancel 20_4 20_5

## Cancel all elements from job array 20

    $ scancel 20

## Cancel the current job or job array element (if job array)

```bash
if [[-z $SLURM_ARRAY_JOB_ID]]; then
  scancel $SLURM_JOB_ID
else
  scancel ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID}
fi
```

# Squeue Command Use
When a job array is submitted to Slurm, only one job record is created. Additional job records will only be created when the state of a task in the job array changes, typically when a task is allocated resources or its state is modified using the scontrol command. By default, the squeue command will report all of the tasks associated with a single job record on one line and use a regular expression to indicate the "array_task_id" values. 

An option of `"--array"` or `"-r"` has also been added to the squeue command to print one job array element per line

    squeue --array
    squeue -r -u $USER
