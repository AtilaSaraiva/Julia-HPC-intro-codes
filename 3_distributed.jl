using Distributed

include("slurminit.jl")

# Parameters
const nVectors = 100
# -

# Activating environment on all nodes
@everywhere begin
  using Pkg; Pkg.activate(@__DIR__)
  @assert Threads.nthreads() > 1
end

# Importing functions on all nodes
@everywhere begin
    using Base.Threads: @threads
    using ThreadPinning: distributed_pinthreads
end

# Defining function on all nodes
@everywhere function computeSquares(x::Vector)
    y = similar(x)
    @threads for i ∈ 1:length(x)
        y[i] = x[i]^2
    end

    return y
end

function main()
    # Pin threads to physical CPU cores to increase performance
    distributed_pinthreads(:cores)

    # Declaring a vector with nVectors inside
    x = [ i .* rand(Float64,10000) for i ∈ 1:nVectors ]

    # pmap distributes the application of function over the elements of x
    y = pmap(computeSquares, x)
    @time y = pmap(computeSquares, x)

    # Checking the result makes sense
    @show y[nVectors÷2] == x[nVectors÷2] .^ 2

    return nothing
end

main()
