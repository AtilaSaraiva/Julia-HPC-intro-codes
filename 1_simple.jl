function computeSquares(x::Vector)
    y = similar(x)
    for i ∈ 1:length(x)
        y[i] = x[i]^2
    end

    return y
end

function main()
    x = 10 .* rand(Float64,1000000)

    y = computeSquares(x)
    @time y = computeSquares(x)

    @show y == x .^ 2

    return nothing
end

main()
