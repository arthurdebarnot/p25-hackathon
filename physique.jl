using GLMakie

include("physique.jl")

poids(goo::Goo) = (goo.position,[0,-goo.masse*G]) #(origine du vecteur, direction)

function rappel(goo1::Goo, goo2::Goo)
    if exist_link(goo1,goo2)
        (x1, y1) = goo1.position
        (x2, y2) = goo2.position
        f1 = (goo1.position, -K.*[x1 - x2,y1 - y2]) #(orgine du vecteur, direction)
        f2 = (goo2.position, -K.*[x2 - x1,y2 - y1])
        return f1, f2
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
    for (i,goo) in enumerate(goos)
        norm(goo.position,ngoo.position) < 0.2u"cm" && push!(goo.link, i) 
    end
end
