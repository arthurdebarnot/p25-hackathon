using GLMakie

include("physique.jl")

poids(goo::Goo) = (0,-goo.masse*G) 

function force_rappel(goo1::Goo, goo2::Goo)
    """
    Crée une force de rappel appliquée au premier goo
    """
    (x1, y1) = goo1.position
    (x2, y2) = goo2.position
    f1 = -K.*(x1[] - x2[],y1[] - y2[]) #s'applique au goo1
    return f1
end

function resultante!(list_goos)
    res = (0,0)
    for goo in list_goos[]
        for i in goo.link
            res.+=force_rappel(goo, list_goos[][i])
        end
        res.+=poids(goo)
        goo.forces=res
    end
end

function norm(vecteur::typeof((u"cm",u"cm")))
    sqrt(vecteur[1]^2 + vecteur[2]^2)
end

function create_link(goo1::Goo, goo2::Goo)
    if norm(goo1.position.-goo2.position) ≤ 20u"cm"
        liens[goo1.id][goo2.id] = true
        liens[goo2.id][goo1.id] = true
    end
end

exist_link(goo1::Goo, goo2::Goo) = liens[goo1.id, goo2.id]

function newgoo!(goos,ngoo)
    push!(goos,ngoos)
    for (i,goo) in enumerate(goos)
        norm(goo.position,ngoo.position) < 0.2u"cm" && push!(goo.link, i) && push!(goos[][i].link,length(goos)+1) 
    end
end

function updatecin!(goos,δt)
    for goo in goos
        x=goo.position[][1]
        y=goo.position[][2]
        vx=goo.vitesse[][1]
        vy=goo.vitesse[][2]
        ax=goo.forces[][1] / goo.masse
        ay=goo.forces[][2] / goo.masse
        x = x + δt * vx + (1/2)*ax*δt^2
        y = y + δt * vy + (1/2)*ay*δt^2
        vx = vx + ax * δt
        vy = vy + ay * δt
        goo.position[][1]=x
        goo.position[][2]=y
        goo.vitesse[][1]=vx
        goo.vitesse[][2]=vy
    end
end