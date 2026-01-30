using GLMakie
using Unitful

fig = Figure() ; display(fig)

ax = Axis(fig[1, 1])

x_coords = Observable(Float64[])

scatter!(ax, x_coords, x_coords)

on(events(fig).tick) do tick
    push!(x_coords[], tick.time)
    notify(x_coords)
end
