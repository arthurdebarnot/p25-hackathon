using Unitful
using GLMakie

const G = Unitful.gn/20
const K = 100u"J/m^2"
liens = Dict{Goo, Array{Bool}}

mutable struct Goo
    masse::typeof(u"kg")
    rayon::typeof(u"cm")
    position::typeof(Observable((0.0u"m",0.0u"m")))
    id::UInt8 # numérote les goos
    vitesse::typeof(Observable((0.0u"m/s",0.0u"m/s")))
    forces::typeof(Observable((0.0u"N", 0.0u"N")))
end

abstract type Forme end

""" On considère qu'une plateforme / rectangle est repérée par son coin en bas à gauche
"""
struct Rectangle <: Forme
    longueur::typeof(u"m")
    largeur::typeof(u"m")
    position::typeof((u"m",u"m"))
end