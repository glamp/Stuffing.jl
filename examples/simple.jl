using Stuffing
using Random
using DelimitedFiles
using Images
using Colors

# prepare some pseudo images 
mask = fill("bb", 10, 10) # can be any AbstractMatrix
m, n = size(mask)
# # make an L
# mask[:,4] .= "bb"
# mask[8,:] .= "bb"


# I = fill(false, S, S)
# I[:,2] .= true

L = fill(false, 3, 3)
L[:,3] .= true
L[3,:] .= true
# L[1,:] .= true
objs = []
for i in 1:10
    push!(objs, L)
end

# for i in 1:5
#     push!(objs, I)
# end
# push!(objs, transpose(L))

sort!(objs, by=prod ∘ size, rev=true) # better in descending order of size

# packing
qts = qtrees(objs, mask=mask, maskbackground="aa")
place!(qts)
fit!(qts, patient=100)

# draw
println("visualization:")
oqt = overlap(qts)
println(repr("text/plain", oqt))
# or
println(QTree.charimage(oqt, maxlen=97))
# or
imageof(qt) = Gray.(QTree.decode.(qt[1]))
save("arrangement.png", colorview(Gray, imageof(oqt)))

# get layout
println("layout:")
positions = getpositions(qts)
println(positions)

println("or get layout directly")
packing(mask, objs, maskbackground="aa")
# or
qts = qtrees(objs, mask=mask, maskbackground="aa");
packing!(qts)
getpositions(qts)