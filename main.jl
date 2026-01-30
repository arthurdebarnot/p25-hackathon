using GLMakie

include("structures.jl")
include("physique.jl")

fig = Figure() ; display(fig)

ax = Axis(fig[1, 1], aspect=DataAspect())

on(events(fig).tick) do tick
end