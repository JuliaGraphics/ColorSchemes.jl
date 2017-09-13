#!/usr/bin/env julia

using Base.Test

using ColorSchemes, Colors

function run_all_tests()
    # create a colorscheme from image file

    hokusai_test = extract(dirname(@__FILE__) * "/hokusai.jpg")

    @test length(hokusai_test) == 10

    # extract colors and weights from image file located here in the test directory
    c, w =  extract_weighted_colors(dirname(@__FILE__) * "/hokusai.jpg", 10, 10, 0.01; shrink = 4)

    @test length(c) == 10
    @test length(w) == 10

    # load scheme
    hok = ColorSchemes.hokusai

    @test length(hok) == 32

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

    # save as text
    colorscheme_to_text(ColorSchemes.hokusai, "hokusai_test_version", "hokusai_as_text.jl", comment="a test")

    @test filesize("hokusai_as_text.jl") > 2000 # TODO read it back in, for goodness sake...! :)

    open("hokusai_as_text.jl") do f
        lines = readlines(f)
        @test startswith(lines[4], "RGB{Float64}(0.085")
    end

end

function run_minimum_tests()

    # load scheme
    hok = ColorSchemes.hokusai

    @test length(hok) == 32

    # test sort
    @test sortcolorscheme(hok, rev=true) != sortcolorscheme(hok)

    # save as text
    colorscheme_to_text(hok, "hokusai_test_version", "hokusai_as_text.jl", comment="a test")

    @test filesize("hokusai_as_text.jl") > 2000 

    open("hokusai_as_text.jl") do f
        lines = readlines(f)
        @test startswith(lines[4], "RGB{Float64}(0.085")
    end

    # convert an Array{T,2} to an RGB image
    tmp = get(ColorSchemes.leonardo, rand(10, 10))
    @test typeof(tmp) == Array{ColorTypes.RGB{Float64}, 2}

    # test conversion with default clamp
    x = [0.0 1.0 ; -1.0 2.0]
    y=get(ColorSchemes.leonardo, x)
    @test y[1,1] == y[2,1]
    @test y[1,2] == y[2,2]

    # test conversion with symbol clamp
    y2=get(ColorSchemes.leonardo, x, :clamp)
    @test y2 == y

    # test conversion with symbol extrema
    y2=get(ColorSchemes.leonardo, x, :extrema)
    @test y2[2,1] == y[1,1]   # Minimum now becomes one edge of ColorScheme
    @test y2[2,2] == y[1,2]   # Maximum now becomes other edge of ColorScheme
    @test y2[1,1] !== y2[2,1] # Inbetween values or now different

    # test conversion with manually supplied range
    y3=get(ColorSchemes.leonardo, x, (-1.0, 2.0))
    @test y3 == y2


end

if get(ENV, "COLORSCHEMES_KEEP_TEST_RESULTS", false) == "true"
        cd(mktempdir())
        info("running tests in: $(pwd())")
        info("...Keeping the results")
        run_minimum_tests()
        info("Test images saved in: $(pwd())")
else
    mktempdir() do tmpdir
        cd(tmpdir) do
            info("running tests in: $(pwd())")
            info("but not keeping the results")
            info("because you didn't do: ENV[\"COLORSCHEMES_KEEP_TEST_RESULTS\"] = \"true\"")
            run_minimum_tests()
            info("Test images weren't saved. To see the test images, next time do this before running:")
            info(" ENV[\"COLORSCHEMES_KEEP_TEST_RESULTS\"] = \"true\"")
        end
    end
end
