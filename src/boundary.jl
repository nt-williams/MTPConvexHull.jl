function boundary(h::ConvexHull, p::Array{Float64})
    # Just return the point if it's in the convex hull
    (p ∈ h.polytope) && return p

    # Number of vertices
    n = length(h.vertices)

    λ = Variable(n)                               # Coefficients for convex combination
    x = sum([λ[i] * h.vertices[i] for i in 1:n])  # Point on the convex hull
    
    # Define the optimization problem
    problem = minimize(sumsquares(x - p))               # Minimize squared distance
    append!(problem.constraints, [λ >= 0, sum(λ) == 1]) # Constraints for convex hull

    # Solve the problem
    solve!(problem, SCS.Optimizer)

    # Extract the closest point on the convex hull
    evaluate(x)
end

function boundary(h::ConvexHull, p::Vector{Int})
    boundary(h, Array{Float64}(p))
end