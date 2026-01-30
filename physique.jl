poids(goo::Goo) = (0.0u"N",-goo.masse*G) 

function force_rappel(goo1::Goo, goo2::Goo)
    """
    Crée une force de rappel appliquée au premier goo
    """
    (x1, y1) = goo1.position
    (x2, y2) = goo2.position
    r,θ = coordonnées_cartésien_to_polar(x1-x2,y1-y2)
	Fx = -k*(r-lgoo)*cos(θ)
	Fy = -k*(r-lgoo)*sin(θ)
    return (Fx,Fy)
end
function force_rappel(goo1::Goo, plat::Rectangle)
    """
    Crée une force de rappel appliquée au premier goo
    """
    (x1, y1) = goo1.position
    (x2, y2) = plat.li
    r,θ = coordonnées_cartésien_to_polar(x1-x2,y1-y2)
	Fx = -k*(r-lplat)*cos(θ)
	Fy = -k*(r-lplat)*sin(θ) 
    return (Fx,Fy)
end

function coordonnées_cartésien_to_polar(x,z)
	if x == 0
		return (sqrt(x*x + z*z),pi/2)
	elseif ustrip(x)>0
		return (sqrt(x*x + z*z), atan(z/x))
	else
		return (sqrt(x*x + z*z), atan(z/x) + pi)
	end
end

function resultante!(list_goos)
    for goo in list_goos
        res = (0.0u"N",0.0u"N")
        for i in goo.links_g
            res = res .+ force_rappel(goo, list_goos[][i])
        end
        res = res .+ poids(goo)
        for plat in goo.links_p
            res = res .+force_rappel(goo,plat)
        end
        goo.forces=res
    end
end

function norm(vecteur::typeof((0.0u"m", 0.0u"m")))
    sqrt(vecteur[1]^2 + vecteur[2]^2)
end

function distance(goo1::Goo, goo2::Goo)
    norm(goo1.position .- goo2.position)
end

function newgoo(pos,masse=400.0u"g",rayon=10.0u"cm")
    return Goo(masse,rayon,(pos[1]u"m",pos[2]u"m"),(0.0u"m/s", 0.0u"m/s"),(0.0u"N",0.0u"N"),[])
end

function addgoo!(goos,ngoo,plats)
    for (i,goo) in enumerate(goos[])
        distance(goo,ngoo) < 20u"cm" && (push!(ngoo.links_g, i) ; push!(goo.links_g,length(goos)+1))
    end
    for plat in plats
        dist=distance(ngoo,plat)[1]
        (x,y)=distance(ngoo,plat)[2]
        dist < 10u"cm" && (push!(plat.links_g,length(goos)+1) ;push!(ngoo.links_p,(x,y)) )
    end
    push!(goos,ngoos)
end

function updatecin!(goos,δt)
    for goo in goos
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
        goo.position = (x, y)
        goo.vitesse = (vx, vy)
    end
end

function phyplat(plats,goos)
    eps=10^(-5)u"m"
    for plat in plats
        for goo in goos
            dist = distance(goo, plat)[1]
            (x,y)=distance(goo, plat)[2]
            if dist < eps + goo.rayon && x > plat.position[1] && x< plat.position[1] + plat.largueur
                goo.forces[2] = 0.0u"N"
            end
        end
    end
end

function distance(goo::Goo, plateforme::Rectangle)
    X = linspace(plateforme.position[1], plateforme.position[1]+ plateforme.largeur,1000)
    Y = linspace(plateforme.position[2], plateforme.position[2]+ plateforme.longueur,1000)
    distance = distance((X[1],Y[1]),goo)
    coordonnées = (0u"m",0u"m")
    for x in X
        for y in Y
            if norme((x,y),goo) < distance
                distance = norme((x,y),goo)
                coordonnées = (x,y)
            end
        end
    end
    (distance,coordonnées)
end

function distance(position, goo::Goo)
    return sqrt((position[1]-goo.position[1])^2 + (position[2]-goo.position[2])^2)
end


