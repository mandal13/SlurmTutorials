#!/bin/bash


# Function to display usage information
get_usage() {
    echo "Usage: $0 JOB_ID"
    echo "Options:"
    echo "  -h, --help       Display this help message"
    echo ""
}

if [[ $# == 0 ]]; then
   echo "Error: No arguments provided."
   get_usage
   exit 1
fi

# Main script
if [[ "$1" == "-h" || "$1" == "--help" ]]; then
    get_usage
    exit 0
fi

#set -x
# Check if SLURM_JOB_ID environment variable is set
SLURM_JOB_ID=$1
if [ -z "$SLURM_JOB_ID" ]; then
  echo "Error: SLURM_JOB_ID is empty." >&2
  exit 1
fi

scontrol show job "$SLURM_JOB_ID" > /dev/null 2>&1

if [[ $? == 0 ]] ;then
  # Get the working directory of the running SLURM job
  WORKING_DIR=$(scontrol show job "$SLURM_JOB_ID" | grep "WorkDir=" | cut -d= -f2)

  echo
  echo "Working directory of SLURM job $SLURM_JOB_ID: $WORKING_DIR"
  echo
else
  echo
  echo "Invalid SLURM ID: $SLURM_JOB_ID"
  echo
fi

