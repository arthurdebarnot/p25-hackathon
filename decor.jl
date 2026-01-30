include("structures.jl")

# Création des plateformes
function dessine_moi_une_plateforme(ax,plateforme :: Rectangle)
    poly!(ax, Point2f[plateforme.position,(plateforme.position[1], plateforme.position[2] + plateforme.longueur),(plateforme.position[1] + plateforme.largeur, plateforme.position[2]+plateforme.longueur),(plateforme.position[1]+plateforme.largeur,plateforme.position[2])])
end

function dessine_moi_un_goo(ax,goo::Goo)
    poly!(ax,Circle(Point2f(goo.position[1], goo.position[2]), goo.rayon),color = :blue)
end

function dessine_moi_les_goos(list_goo)
    dessine_moi_un_goo.(list_goo)
end

function dessine_moi_les_liens(ax,goo ::Goo)
    for voisin in goo.link
        lines!(ax,Point2f[goo.position,voisin.position],color = :blue)
    end
end

function dessine_moi_tous_les_liens(ax, list_goo)
    dessine_moi_les_liens.(list_goo)
end