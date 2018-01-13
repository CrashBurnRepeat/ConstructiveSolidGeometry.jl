#Thanks to http://jamie-wong.com/2016/07/15/ray-marching-signed-distance-functions/

import Base: union, intersect, -

function union(x::T, y::S) where {T<:Surface, S<:Surface}
    x_dist_fun = (c)->distance_field(x,c)
    y_dist_fun = (c)->distance_field(y,c)
    dist_fun = (c)->min(x_dist_fun(c),y_dist_fun(c))

    x_norm_fun = (c)->normal_field(x,c)
    y_norm_fun = (c)->normal_field(y,c)
    norm_fun = (c)->
        if x_dist_fun(c)<y_dist_fun(c)
            return x_norm_fun(c)
        elseif x_dist_fun(c)==y_dist_fun(c)
            return unitize(x_norm_fun(c)+y_norm_fun(c))
        else
            return y_norm_fun(c)
        end
    return ConstructedSurface(dist_fun, norm_fun)
end

function intersect(x::T, y::S) where {T<:Surface, S<:Surface}
    x_dist_fun = (c)->distance_field(x,c)
    y_dist_fun = (c)->distance_field(y,c)
    dist_fun = (c)->max(x_dist_fun(c),y_dist_fun(c))

    x_norm_fun = (c)->normal_field(x,c)
    y_norm_fun = (c)->normal_field(y,c)
    norm_fun = (c)->
        if x_dist_fun(c)>y_dist_fun(c)
            return x_norm_fun(c)
        elseif x_dist_fun(c)==y_dist_fun(c)
            return unitize(x_norm_fun(c)+y_norm_fun(c))
        else
            return y_norm_fun(c)
        end
    return ConstructedSurface(dist_fun, norm_fun)
end

function -(x::T, y::S) where {T<:Surface, S<:Surface}
    x_dist_fun = (c)->distance_field(x,c)
    y_dist_fun = (c)->distance_field(y,c)
    dist_fun = (c)->max(x_dist_fun(c),-y_dist_fun(c))

    x_norm_fun = (c)->normal_field(x,c)
    y_norm_fun = (c)->normal_field(y,c)
    norm_fun = (c)->
        if x_dist_fun(c)>-y_dist_fun(c)
            return x_norm_fun(c)
        elseif x_dist_fun(c)==-y_dist_fun(c)
            return unitize(x_norm_fun(c)-y_norm_fun(c))
        else
            return -y_norm_fun(c)
        end
    return ConstructedSurface(dist_fun, norm_fun)
end

function complement(x::T) where {T<:Surface}
    return ConstructedSurface((c)->-distance_field(x,c), (c)->-normal_field(x,c))
end

function is_in_surface(x::T, c::Coord) where {T<:Surface}
    distance_field(x,c)<=0 #different equality for different boundaries?
end
