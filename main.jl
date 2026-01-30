using GLMakie

include("structures.jl")
include("physique.jl")
include("decor.jl")

fig = Figure() ; display(fig)

ax = Axis(fig[1, 1], aspect=DataAspect())

list_goos = Observable([])

goo = Goo(400u"g", 1u"cm", (0u"m", 0u"m"), (0u"m/s", 0u"m/s"), (0u"N", 0u"N"), Int[])

newgoo!(list_goos, goo)

# dessine_moi_une_plateforme!(ax)

on(events(fig).tick) do tick
    resultante!(list_goos)
    updatecin!(list_goos, tick.delta_time)
    dessine_moi_les_goos!(ax, list_goos[])
    yield()
    notify(list_goos)
end