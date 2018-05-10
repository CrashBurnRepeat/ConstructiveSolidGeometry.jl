function distance_field(plane::Plane, c)
    d = -dot(plane.normal, plane.point)
    dist = dot(plane.normal, c) + d #needs to be "linearized"?
end

function distance_field(cone::Cone, c)
    p_minus_c = c - cone.tip
    dist =
        (p_minus_c⋅cone.axis)^2 -
        (p_minus_c\cdotp_minus_c) * (cos(cone.theta))^2 #update distance to be linear, not squared
end

function distance_field(sphere::Sphere, c)
    sphere.distance_field(c)
end

function distance_field(cyl::InfCylinder, c)
    tmp = cross((c-cyl.center), cyl.normal)
    dist = sqrt(tmp⋅tmp) - cyl.radius
end

function distance_field(construct::ConstructedSurface, c)
    construct.distance_field(c)
end
