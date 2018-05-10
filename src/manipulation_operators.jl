function rotate(c, θ, center=SVector(0,0)) # for now, 2D rotations, needs generalization
    # Coord(
    #     (c.x - center.x)*cos(θ) + (c.y - center.y)*sin(θ) + center.x,
    #     -(c.x - center.x)*sin(θ) + (c.y - center.y)*cos(θ) + center.y,
    #     c.z
    # )
    [cos(θ) sin(θ); -sin(θ) cos(θ)]*(c-center)
end

#test with off-origin rotations
function rotate(csg::Surface, θ, center=SVector(0,0)) # for now, 2D rotations, needs generalization
    ConstructedSurface((c)->distance_field(csg,rotate(c,θ,center)))
end

function rotate!(csg::Surface, θ, center=SVector(0,0))
    csg = rotate(csg, θ, center)
    nothing
end

function translate(csg::Surface, delta) #for now, 2D translations
    ConstructedSurface((c)->distance_field(csg,c-delta))
end

function warp(csg, warp_fun)
    ConstructedSurface(c->distance_field(csg,warp_fun(c)))
end

function scale(csg, sfact)
    ConstructedSurface(c->distance_field(csg,c/sfact))
end
