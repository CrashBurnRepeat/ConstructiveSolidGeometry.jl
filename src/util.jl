import Base: +, -, *, ^, |, ~, ==, zero
import LinearAlgebra: dot, cross
+(a::Coord, b::Coord)     = Coord(a.x+b.x, a.y+b.y, a.z+b.z)
-(a::Coord, b::Coord)     = Coord(a.x-b.x, a.y-b.y, a.z-b.z)
-(a::Coord)               = Coord(-a.x, -a.y, -a.z)
*(a::Float64, b::Coord)   = Coord(a*b.x, a*b.y, a*b.z)
*(b::Coord, a::Float64,)  = Coord(a*b.x, a*b.y, a*b.z)
*(a::Int, b::Coord)       = Coord(a*b.x, a*b.y, a*b.z)
*(b::Coord, a::Int)       = Coord(a*b.x, a*b.y, a*b.z)
dot(a::Coord, b::Coord)   = (a.x*b.x + a.y*b.y + a.z*b.z)
==(a::Coord, b::Coord)    = (a.x==b.x && a.y==b.y && a.z==b.z)
"""
    magnitude(a::Coord)

A utility function to determine the magnitude of a `Coord` object. Typical use case is to subtract two Coord objects and check the resulting Coord object's magnitude to determine the distance between the two Coords.
"""
magnitude(a::Coord)       = sqrt(dot(a,a))
"""
    unitize(a::Coord)

A utility function to unitize a `Coord`
"""
unitize(a::Coord)         = (1. / magnitude(a) * a)
cross(a::Coord, b::Coord) = Coord(a.y*b.z - a.z*b.y, a.z*b.x - a.x*b.z, a.x*b.y - a.y*b.x)

"""
    zero(a::Coord)
    zero(::Coord)

Returns the origin coordinate
"""
zero(::Type{Coord})=Coord(0,0,0)
zero(a::Coord) = zero(typeof(a))

#i,j,k or x,y,z notation? I think x,y,z would be more widely understood
const x̂ = Coord(1,0,0); #typed x\hat [tab]
const ŷ = Coord(0,1,0); #typed y\hat [tab]
const ẑ = Coord(0,0,1); #typed z\hat [tab]
