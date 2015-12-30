#!/usr/bin/env julia

using ColorSchemes, Colors
using Base.Test

# write your own tests here

# create a colorscheme from image file
hokusai_test = extract(Pkg.dir("ColorSchemes", "test", "hokusai.jpg"))

@test length(hokusai_test) == 10
@test typeof(hokusai_test) == Array{ColorTypes.RGB{Float64},1}

# extract colors and weights from image file
c, w =  extract_weighted_colors(Pkg.dir("ColorSchemes", "test", "hokusai.jpg"), 10, 10, 0.01; shrink = 4)

@test length(c) == 10
@test length(w) == 10

# load scheme from ./data
hok = loadcolorscheme("hokusai")

@test length(hok) == 32
@test typeof(hokusai_test) == Array{ColorTypes.RGB{Float64},1}

# test that schemes yield different values
@test colorscheme(hokusai_test, 0.0) != colorscheme(hokusai_test, 0.5)

# create weighted palette; there is some unpredictability here...
csw = colorscheme_weighted(c, w, 37)
@test 36 <= length(csw) <= 38

# default is 50
csw = colorscheme_weighted(c, w)
@test length(csw) == 50

cd("/tmp")
savecolorscheme(csw, "test_hokusai.txt", "this is a test")
csw1 = loadcolorscheme("test_hokusai")
@test typeof(csw1) == Array{ColorTypes.RGB{Float64},1}

println("tests finished")
