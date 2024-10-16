if "SLURM_JOB_ID" ∈ keys(ENV)
    println("Inside a SLURM job, adding processes")
    @eval using Pkg; Pkg.activate(@__DIR__)
    @eval using ClusterManagers

    addprocs_slurm(parse(Int64, ENV["SLURM_NTASKS"]))
    const slurm = true
else
    addprocs(2)
    const slurm = false
end
