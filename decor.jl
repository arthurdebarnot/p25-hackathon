# Création des plateformes
function dessine_moi_une_plateforme!(ax,plateforme :: Rectangle)
    poly!(ax, Point2f[(ustrip(u"m",plateforme.position[]),ustrip(u"m",plateforme.position[2])),(plateforme.position[1], plateforme.position[2] + plateforme.longueur),(plateforme.position[1] + plateforme.largeur, plateforme.position[2]+plateforme.longueur),(plateforme.position[1]+plateforme.largeur,plateforme.position[2])])
end

function dessine_moi_un_goo!(ax,goo::Goo)
    poly!(ax,Circle(Point2f(ustrip(u"m",goo.position[1]), ustrip(u"m",goo.position[2])), ustrip(u"m",goo.rayon),color = :blue)
end

function dessine_moi_les_goos!(ax, list_goo::Vector{Goo})
    dessine_moi_un_goo!.(ax, list_goo)
end

function dessine_moi_les_liens!(ax,goo ::Goo)
    for voisin in goo.link
        lines!(ax,Point2f[goo.position,voisin.position],color = :blue)
    end
end

function dessine_moi_tous_les_liens(ax, list_goo)
    dessine_moi_les_liens!.(ax, list_goo)
end