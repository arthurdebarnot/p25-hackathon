include("structures.jl")

# Création des plateformes
function dessine_moi_une_plateforme(ax,plateforme :: Rectangle)
    poly!(ax, Point2f[position,(position[1], position[2] + longueur),(position[1] + largeur, position[2]+longueur),(position[1]+largeur,position[2])])
end
