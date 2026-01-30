using GLMakie

poids(goo::Goo) = (0,-goo.masse*G) 

function force_rappel(goo1::Goo, goo2::Goo)
    """
    Crée une force de rappel appliquée au premier goo
    """
    (x1, y1) = goo1.position
    (x2, y2) = goo2.position
    f1 = -K.*(x1 - x2, y1 - y2) #s'applique au goo1
    return f1
end

function resultante!(list_goos)
    for goo in list_goos[]
        res = (0,0)
        for i in goo.links
            res.+=force_rappel(goo, list_goos[][i])
        end
        res.+=poids(goo)
        goo.forces=res
    end
end

function norm(vecteur::typeof((0.0u"m", 0.0u"m")))
    sqrt(vecteur[1]^2 + vecteur[2]^2)
end

function distance(goo1, goo2)
    norm(goo1.position .- goo2.position)
end

function newgoo!(goos,ngoo)
    push!(goos[],ngoo)
    for (i, goo) in enumerate(goos[])
        distance(goo, ngoo) <= 20u"cm" && (push!(goo.links, i) ; push!(goos[][i].links,length(goos[])+1))
    end
end

function updatecin!(goos,δt)
    for goo in goos[]
        x=goo.position[1]
        y=goo.position[2]
        vx=goo.vitesse[1]
        vy=goo.vitesse[2]
        ax=goo.forces[1] / goo.masse
        ay=goo.forces[2] / goo.masse
        x = x + δt * vx + (1/2)*ax*δt^2
        y = y + δt * vy + (1/2)*ay*δt^2
        vx = vx + ax * δt
        vy = vy + ay * δt
        goo.position[1]=x
        goo.position[2]=y
        goo.vitesse[1]=vx
        goo.vitesse[2]=vy
    end
end