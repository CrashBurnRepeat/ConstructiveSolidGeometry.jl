#Thanks to http://jamie-wong.com/2016/07/15/ray-marching-signed-distance-functions/

import Base: union, intersect, -

function union(x::T, y::S) where {T<:Surface, S<:Surface}
    x_dist_fun = (c)->distance_field(x,c)
    y_dist_fun = (c)->distance_field(y,c)
    dist_fun = (c)->
        if x_dist_fun(c)==y_dist_fun(c)
            (x_dist_fun(c)+y_dist_fun(c))/2.0 #properly defines the normal for ForwardDiff
        else
            min(x_dist_fun(c),y_dist_fun(c))
        end
    return ConstructedSurface(dist_fun)
end

function intersect(x::T, y::S) where {T<:Surface, S<:Surface}
    x_dist_fun = (c)->distance_field(x,c)
    y_dist_fun = (c)->distance_field(y,c)
    dist_fun = (c)->
        if x_dist_fun(c)==y_dist_fun(c)
            (x_dist_fun(c)+y_dist_fun(c))/2.0 #properly defines the normal for ForwardDiff
        else
            max(x_dist_fun(c),y_dist_fun(c))
        end
    return ConstructedSurface(dist_fun)
end

function -(x::T, y::S) where {T<:Surface, S<:Surface}
    intersect(x,complement(y))
end

function complement(x::T) where {T<:Surface}
    return ConstructedSurface((c)->-distance_field(x,c), (c)->-normal_field(x,c))
end

function is_in_surface(x::T, c) where {T<:Surface}
    distance_field(x,c)<=0 #different equality for different boundaries?
end
