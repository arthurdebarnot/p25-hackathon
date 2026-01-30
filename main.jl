using GLMakie
using Unitful

include("structures.jl")
include("physique.jl")
include("decor.jl")

fig = Figure() ; display(fig)

ax = Axis(fig[1, 1], aspect=DataAspect())

list_goos = Goo[]

goo = Goo(400.0u"g", 1.0u"cm", (0.0u"m", 0.0u"m"), (0.0u"m/s", 0.0u"m/s"), (0.0u"N", 0.0u"N"), Int[], Int[])

push!(list_goos, goo)

# dessine_moi_une_plateforme!(ax)

# dessine_moi_les_goos!(ax, list_goos)

list_pos_goos_x = Observable(typeof(0.0u"m")[])
list_pos_goos_y = Observable(typeof(0.0u"m")[])

function resize!(list_pos_goos, list_goos)
    for i in 1:(length(list_goos) - length(list_pos_goos[]))
        push!(list_pos_goos[], 0.0u"m")
    end
end

function updatepos!(list_pos_goos_x, list_pos_goos_y, list_goos)
    for i in 1:length(list_pos_goos_x[])
        list_pos_goos_x[][i] = list_goos[i].position[1]
        list_pos_goos_y[][i] = list_goos[i].position[2]
    end
end

resize!(list_pos_goos_x, list_goos)
resize!(list_pos_goos_y, list_goos)
updatepos!(list_pos_goos_x, list_pos_goos_y, list_goos)

scatter!(ax, list_pos_goos_x, list_pos_goos_y)

on(events(fig).tick) do tick
    resultante!(list_goos)
    updatecin!(list_goos, tick.delta_time*u"s")
    resize!(list_pos_goos_x, list_goos)
    resize!(list_pos_goos_y, list_goos)
    updatepos!(list_pos_goos_x, list_pos_goos_y, list_goos)
    yield()
    notify(list_pos_goos_x)
    notify(list_pos_goos_y)
end
plat=[Rectangle(1.0u"m",1.0u"m",(-0.5u"m",0.0u"m"),Int[])]
# Ajouter un goo après un clic
pos = Observable((0.0,0.0))

scene1 = Scene(camera = campixel!)
scatter!(scene1, points, color = :gray)

on(events(scene1).mousebutton) do event
    if event.button == Mouse.left && event.action == Mouse.press
        mp = events(scene1).mouseposition[]
        pos[]= mp
        notify(pos)
    end
end
scene1
ngoo = newgoo(pos[])
addgoo!(list_goos,ngoo, plat)