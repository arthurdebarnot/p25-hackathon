using Unitful
using GLMakie

const G = Unitful.gn/20

struct Goo
    masse::typeof(u"kg")
    rayon::typeof(u"cm")
end

struct Plateforme
    longueur::typeof(u"m")
    couleur::typeof(UInt16) #couleur html
end


fig = Figure() display(fig)