struct ConvexHull
    polytope
    vertices
end

function ConvexHull(x::Matrix{Float64})::ConvexHull
    p = polyhedron(vrep(x))
    v = vrep(p).V
    ConvexHull(p, [v[i, :] for i in axes(v, 1)])
end

ConvexHull(x::DataFrame)::ConvexHull = ConvexHull(Matrix(x))