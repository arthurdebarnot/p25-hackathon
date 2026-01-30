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
    poly!(ax,Circle(Point2f(0, 0), 15f0),color = :blue)
    lines!(ax,Point2f[(0,15),(0,50)], color = :blue)
    display(fig)
    #arc!(ax,Point2f(0), 20, -π, π, color = :blue)
end