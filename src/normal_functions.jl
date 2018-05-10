function normal_field(plane::Plane, c)
    plane.normal
end

function normal_field(cone::Cone, c)
    ## come back to this later
end

function normal_field(sphere::Sphere, c)
    sphere.normal_field(c)
end

function normal_field(cyl::InfCylinder, c)
    #sign(distance_field(cyl,c))* #should the definition of normal change?
    n = x->ForwardDiff.gradient(distance_field(cyl),x)
    # normalize(n(c))
end

function normal_field(construct::ConstructedSurface, c)
    construct.normal_field(c)
end
