using GLMakie
using Unitful


const g = Unitful.gn / 20

struct Goo
    m :: typeof(u"kg")
    r :: typeof(u"m")
    x :: typeof(u"m")
    y :: typeof(u"m")
end

using Makie.Colors
let fig = Figure()
    ax = Axis(fig[1,1],aspect =DataAspect())
    xs = LinRange(0, 10, 100)
    ys = LinRange(0, 15, 100)
    poly!(ax, Point2f[(0,0),(0,10),(20,10),(20,0)], color = :skyblue)
    poly!(ax,Circle(Point2f(0, 0), 15f0))
    lines!(ax,)
    display(fig)
    #arc!(ax,Point2f(0), 20, -π, π, color = :blue)
end