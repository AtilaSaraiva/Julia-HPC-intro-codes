using Distributed

include("slurminit.jl")

# Parameters
const nVectors = 100
const jobID = parse(Int64, ARGS[1])
const JobQueue = [(:noise=>false,),
                  (:noise=>true, :noiseLevel=>1,),
                  (:noise=>true, :noiseLevel=>2,)]
# -


@everywhere begin
  using Pkg; Pkg.activate(@__DIR__)
  @assert Threads.nthreads() > 1
end

@everywhere begin
    using Base.Threads: @threads
    using ThreadPinning: distributed_pinthreads
end

@everywhere function computeSquares(x::Vector; noise::Bool=false, noiseLevel::Real)
    y = similar(x)
    if !noise
        @threads for i ∈ 1:length(x)
            y[i] = x[i]^2
        end
    else
        @threads for i ∈ 1:length(x)
            y[i] = x[i]^2 + noiseLevel
        end
    end

    return y
end

function main()
    # Pin threads to physical CPU cores to increase performance
    distributed_pinthreads(:cores)

    @show JobQueue[jobID]

    x = [ i .* rand(Float64,10000) for i ∈ 1:nVectors ]

    y = pmap(computeSquares, x)
    @time y = pmap(x_ -> computeSquares(x_, JobQueue[jobID]...), x)

    @show y[nVectors÷2] == x[nVectors÷2] .^ 2

    return nothing
end

main()

