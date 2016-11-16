#!/usr/bin/env julia

using ColorSchemes, Colors
using Base.Test

mktempdir() do tmpdir
     cd(tmpdir)
     info("running tests in: $(pwd())")

     # create a colorscheme from image file

     hokusai_test = extract(dirname(@__FILE__) * "/hokusai.jpg")

     @test length(hokusai_test) == 10
     @test typeof(hokusai_test) == Array{ColorTypes.RGB{Float64},1}

     # extract colors and weights from image file located here in the test directory
     c, w =  extract_weighted_colors(dirname(@__FILE__) * "/hokusai.jpg", 10, 10, 0.01; shrink = 4)

     @test length(c) == 10
     @test length(w) == 10

     # load scheme
     hok = ColorSchemes.hokusai

     @test length(hok) == 32
     @test typeof(hokusai_test) == Array{ColorTypes.RGB{Float64},1}

     # test that sampling schemes yield different values
     @test get(hokusai_test, 0.0) != get(hokusai_test, 0.5)

     # test sort
     @test sortcolorscheme(hokusai_test, rev=true) != sortcolorscheme(hokusai_test)

     # create weighted palette; there is some unpredictability here...
     csw = colorscheme_weighted(c, w, 37)
     @test 36 <= length(csw) <= 38

     # default is 50
     csw = colorscheme_weighted(c, w)
     @test length(csw) == 50

 end
 
