using Pkg; Pkg.activate(@__DIR__)
using Base.Threads: @threads
using ThreadPinning: pinthreads

function computeSquares(x::Vector)
    y = similar(x)
    @threads for i ∈ 1:length(x)
        y[i] = x[i]^2
    end

    return y
end

function main()
    # Pin threads to physical CPU cores to increase performance
    pinthreads(:cores)

    x = 10 .* rand(Float64,1000000)

    y = computeSquares(x)
    @time y = computeSquares(x)

    @show y == x .^ 2

    return nothing
end

main()
