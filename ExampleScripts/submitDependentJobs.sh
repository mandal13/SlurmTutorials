#!/bin/bash

# Function to prompt user for job submission details
prompt_for_job_details() {
    read -rp "Enter jobscript name: " job_script_name
    read -rp "Enter dependency (optional, enter 'none' for no dependency): " dependency


    if [ "$dependency" != "none" ]; then
    select dType in afterany afternotok afterok
    do
       case $dType in
       afterany)
         echo "You selected: $dType"
         break
       ;;
       afternotok)
         echo "You selected: $dType"
         break
       ;;
       afterok)
         echo "You selected: $dType"
         break
       ;;
       *)
         echo "Error: please select from the options!!"
         exit
       ;;
       esac
    done
    fi

}

# Function to submit the job to SLURM
submit_job() {
    local job_script_name=$1
    local dependency=$2
    local dType=$3

    # Construct sbatch command
    sbatch_args=" "

    # If dependency is provided, add it to the sbatch command
    if [ "$dependency" != "none" ]; then
        sbatch_args+=" --dependency=$dType:$dependency"
    fi

    #set -x
    # Submit the job
    sbatch $sbatch_args $job_script_name
}

# Main script
echo "Welcome to the SLURM job submission script"
prompt_for_job_details

# Submit the job
submit_job "$job_script_name"  "$dependency" "$dType"

echo "Job submitted successfully."

