function distance_field(plane::Plane, c::Coord)
    d::Float64 = -dot(plane.normal, plane.point)
    dist::Float64 = dot(plane.normal, c) + d
end

function distance_field(cone::Cone, c::Coord)
    p_minus_c::Coord = c - cone.tip
    dist::Float64 =
        dot(p_minus_c,cone.axis)^2 -
        dot(p_minus_c,p_minus_c) * (cos(cone.theta))^2
end

function distance_field(sphere::Sphere, c::Coord)
    dist::Float64 =
        (c.x - sphere.center.x)^2 +
        (c.y - sphere.center.y)^2 +
        (c.z - sphere.center.z)^2 -
        sphere.radius^2
end

function distance_field(cyl::InfCylinder, c::Coord)
    tmp::Coord = cross((c-cyl.center), cyl.normal)
    dist::Float64 = dot(tmp, tmp) - cyl.radius^2
end

function distance_field(construct::ConstructedSurface, c::Coord)
    construct.distance_field(c)
end
