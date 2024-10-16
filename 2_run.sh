#!/usr/bin/env bash

#SBATCH --account=account-token
#SBATCH --mem-per-cpu=4000M              # Memory per cpu
#SBATCH --ntasks=1                       # Number of tasks
#SBATCH --cpus-per-task=8                       # Number of tasks
#SBATCH --time=00:15:00                  # Time limit for the job (necessary)
#SBATCH --mail-type=ALL
#SBATCH --mail-user=email@token # Your email address to be notified when the job starts and ends

export JULIA_NUM_THREADS=$SLURM_CPUS_PER_TASK
julia 2_threaded.jl
