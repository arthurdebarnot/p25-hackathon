using GLMakie
using Unitful

include("structures.jl")
include("physique.jl")
const g = Unitful.gn / 20

using GLMakie.Colors
let fig = Figure()
    ax = Axis(fig[1,1],aspect =DataAspect())
    xs = LinRange(0, 10, 100)
    ys = LinRange(0, 15, 100)
    poly!(ax,Circle(Point2f(0, 0), 15f0),color = :blue)
    lines!(ax,Point2f[(0,15),(0,50)], color = :blue)
    display(fig)
    #arc!(ax,Point2f(0), 20, -π, π, color = :blue)
end

function dessine_moi_un_goo(ax,goo::Goo)
    poly!(ax,Circle(Point2f(goo.position[1], goo.position[2]), goo.rayon),color = :blue)
end

function dessine_moi_les_goos(list_goo)
    dessine_moi_un_goo.(list_goo)
end


function dessine_moi_une_plateforme(ax,plateforme :: Rectangle)
    poly!(ax, Point2f[position,(position[1], position[2] + longueur),(position[1] + largeur, position[2]+longueur),(position[1]+largeur,position[2])])
end

function dessine_moi_les_liens(ax,goo ::Goo)
    for voisin in goo.link
        lines!(ax,Point2f[goo.position,voisin.position],color = :blue)
    end
end


# bla bla bla
function piche()

    println("piche")
end

function distance(goo :: Goo, plateforme :: Rectangle)
    X = linspace(plateforme.position[1], plateforme.position[1]+ plateforme.largeur,1000)
    Y = linspace(plateforme.position[2], plateforme.position[2]+ plateforme.longueur,1000)
    distance = norme((X[1],Y[1]),goo)
    for x in X
        for y in Y
            if norme((x,y),goo)> distance
                distance = norme((x,y),goo)
            end
        end
    end
    distance
end

function norme(position, goo)
    return sqrt((position[1]-goo.position[1])^2 + (position[2]-goo.position[2])^2)
end

goo = Goo(400.0u"g", 1.0u"cm", (0.0u"m", 0.0u"m"), (0.0u"m/s", 0.0u"m/s"), (0.0u"N", 0.0u"N"), Int[],[])
plat=[Rectangle()]