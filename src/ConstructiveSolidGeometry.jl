module ConstructiveSolidGeometry

include("types.jl")
include("util.jl")
include("ray_trace.jl")
include("region_operators.jl")
include("cell_utils.jl")
include("distance_functions.jl")
include("normal_functions.jl")
include("logical_operators.jl")
include("manipulation_operators.jl")
include("plotting.jl")

export Coord
export Ray
export Surface
export Plane
export Cone
export Sphere
export InfCylinder
export Box
export Region
export Cell
export Geometry
export ConstructedSurface
export +,-,*,^,|,~,==,zero
export reflect
export generate_random_ray
export raytrace
export find_intersection
export halfspace
export is_in_cell
export find_cell_id
export plot_geometry_2D
export plot_cell_2D
export dot
export magnitude
export unitize
export cross
export union, intersect, complement #should complement be a different symbol?
export distance_field
export normal_field
export rotate, rotate!, translate
export x̂, ŷ, ẑ

using Plots: heatmap, ColorGradient, RGBA
using StaticArrays: SVector, SArray
using ForwardDiff
using LinearAlgebra

end # module
