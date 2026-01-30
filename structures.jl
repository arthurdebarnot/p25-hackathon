const G = Unitful.gn/20
const K = 100u"J/m^2"

mutable struct Goo
    masse::typeof(0.0u"kg")
    rayon::typeof(0.0u"m")
    position::typeof((0.0u"m",0.0u"m"))
    vitesse::typeof((0.0u"m/s",0.0u"m/s"))
    forces::typeof((0.0u"N", 0.0u"N"))
    links_g::Vector{Int}
    links_p::Vector{Int}
end

abstract type Forme end

""" On considère qu'une plateforme / rectangle est repérée par son coin en bas à gauche
"""
struct Rectangle <: Forme
    longueur::typeof(u"m")
    largeur::typeof(u"m")
    position::typeof((u"m",u"m"))
    links_g:: Vector{Int}
end