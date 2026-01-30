using Unitful

const G = Unitful.gn/20
const K = 100u"J/m^2"
liens = Dict{Goo, Array{Bool}}

mutable struct Goo
    masse::typeof(u"kg")
    rayon::typeof(u"cm")
    position::typeof((Observable(0.0)u"m",u"m"))
    id::UInt8 # numérote les goos


end

abstract type Forme end

""" On considère qu'une plateforme / rectangle est repérée par son coin en bas à gauche
"""
struct Rectangle <: Forme
    longueur::typeof(u"m")
    largeur::typeof(u"m")
    position::typeof((u"m",u"m"))
end