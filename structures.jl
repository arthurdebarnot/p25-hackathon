using Unitful
using GLMakie

const G = Unitful.gn/20
const K = 100u"J/m^2"
liens = Dict{Goo, Array{Bool}}

mutable struct Goo
    masse::typeof(u"kg")
    rayon::typeof(u"cm")
    position::typeof((Observable(0.0u"m"),Observable(0.0u"m"))
    id::UInt8 # numérote les goos
end

abstract type Forme end

struct Rectangle <: Forme
    longueur::typeof(u"m")
    largeur::typeof(u"m")
    position::typeof((u"m",u"m"))
end