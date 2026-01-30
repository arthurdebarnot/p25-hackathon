using GLMakie
GLMakie.activate!() # hide

points = Observable(Point2f[])

scene = Scene(camera = campixel!)
linesegments!(scene, points, color = :black)
scatter!(scene, points, color = :gray)

on(events(scene).mousebutton) do event
    if event.button == Mouse.left && event.action == Mouse.press
        mp = events(scene).mouseposition[]
        push!(points[], mp, mp)
        notify(points)
    end
end

on(events(scene).mouseposition) do mp
    mb = events(scene).mousebutton[]
    if mb.button == Mouse.left && (mb.action == Mouse.press || mb.action == Mouse.repeat)
        points[][end] = mp
        notify(points)
    end
end

scene