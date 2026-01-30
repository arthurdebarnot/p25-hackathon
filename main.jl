using GLMakie
using Unitful

include("structures.jl")
include("physique.jl")
include("decor.jl")

fig = Figure() ; display(fig)

ax = Axis(fig[1, 1], aspect=DataAspect())

list_goos = Goo[]

goo = Goo(400.0u"g", 1.0u"cm", (0.0u"m", 0.0u"m"), (0.0u"m/s", 0.0u"m/s"), (0.0u"N", 0.0u"N"), Int[], Int[])

push!(list_goos[], goo)

# dessine_moi_une_plateforme!(ax)

dessine_moi_les_goos!(ax, list_goos)

on(events(fig).tick) do tick
    resultante!(list_goos)
    updatecin!(list_goos, tick.delta_time*u"s")
    yield()
    notify(list_goos)
end

# Ajouter un goo après un clic
pos = Observable((0.0,0.0))

scene = Scene(camera = campixel!)
scatter!(scene, points, color = :gray)

on(events(scene).mousebutton) do event
    if event.button == Mouse.left && event.action == Mouse.press
        mp = events(scene).mouseposition[]
        pos[]= mp
        notify(pos)
    end
end

ngoo = newgoo(pos[])
addgoo!(list_goos,ngoo,plats=nothing)

scene