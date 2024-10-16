#!/usr/bin/env bash

#SBATCH --array=1-3
#SBATCH --account=account-token
#SBATCH --mem-per-cpu=4000M              # Memory per cpu
#SBATCH --ntasks=10                      # Number of tasks
#SBATCH --cpus-per-task=4                # Number of tasks
#SBATCH --time=00:15:00                  # Time limit for the job (necessary)
#SBATCH --mail-type=ALL
#SBATCH --mail-user=email@token # Your email address to be notified when the job starts and ends

export JULIA_NUM_THREADS=$SLURM_CPUS_PER_TASK
julia 3_distributed.jl $SLURM_ARRAY_TASK_ID
