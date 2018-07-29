#Thanks to http://jamie-wong.com/2016/07/15/ray-marching-signed-distance-functions/

import Base: union, intersect, -

function union(x::T, y::S) where {T<:Surface, S<:Surface}
    x_dist_fun = (c)->distance_field(x,c)
    y_dist_fun = (c)->distance_field(y,c)
    dist_fun = (c)->min(x_dist_fun(c),y_dist_fun(c))
    norm_fun = (c)->
        if x_dist_fun == y_dist_fun
            x_norm_func = (x)->ForwardDiff.gradient(x_dist_fun,x)
            y_norm_func = (y)->ForwardDiff.gradient(y_dist_fun,y)
            if (x_norm_func(c)==y_norm_func(c)) #protects against self-union
                x_norm_func(c)
            else
                [NaN, NaN] #the proper gradient here is undefined
            end
        else
            ForwardDiff.gradient(dist_fun,c)
        end
    return ConstructedSurface(dist_fun)
end

function intersect(x::T, y::S) where {T<:Surface, S<:Surface}
    x_dist_fun = (c)->distance_field(x,c)
    y_dist_fun = (c)->distance_field(y,c)
    dist_fun = (c)->max(x_dist_fun(c),y_dist_fun(c))
    norm_fun = (c)->
    if x_dist_fun == y_dist_fun
        x_norm_func = (x)->ForwardDiff.gradient(x_dist_fun,x)
        y_norm_func = (y)->ForwardDiff.gradient(y_dist_fun,y)
        if (x_norm_func(c)==y_norm_func(c)) #protects against self-union
            x_norm_func(c)
        else
            [NaN, NaN] #the proper gradient here is undefined
        end
    else
        ForwardDiff.gradient(dist_fun,c)
    end
    return ConstructedSurface(dist_fun, norm_fun)
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
