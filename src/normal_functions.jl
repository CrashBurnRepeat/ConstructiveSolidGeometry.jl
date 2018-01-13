function normal_field(plane::Plane, c::Coord)
    plane.normal
end

function normal_field(cone::Cone, c::Coord)
    ## come back to this later
end

function normal_field(sphere::Sphere, c::Coord)
    unitize(c-sphere.center)
end

function normal_field(cyl::InfCylinder, c::Coord)
    #sign(distance_field(cyl,c))* #should the definition of normal change?
    unitize(
        c - cyl.center - cyl.normal*dot(c-cyl.center, cyl.normal)
    )
end

function normal_field(construct::ConstructedSurface, c::Coord)
    construct.normal_field(c)
end
