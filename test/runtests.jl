using Test, Colors, ColorSchemes, ColorTypes, FixedPointNumbers

monalisa = ColorScheme([
    RGB(0.05482025926320272, 0.016508952654741622, 0.019315160361063788),
    RGB(0.07508160782698388, 0.034110215845969745, 0.039708343938094984),
    RGB(0.10884977211887092, 0.033667530751245296, 0.026120424375656533),
    RGB(0.10025110094110237, 0.05342427394738222, 0.04975936729231899),
    RGB(0.11004568002009293, 0.06764950003139521, 0.07202128202310687),
    RGB(0.1520114897984492, 0.06721701384356317, 0.04758612657624729),
    RGB(0.16121466572057147, 0.10737190368841328, 0.07491505937992286),
    RGB(0.2272468746270438, 0.09450818887496519, 0.053122482545649836),
    RGB(0.24275776450376843, 0.14465569383748178, 0.09254885719488251),
    RGB(0.19832488479851235, 0.16827798680930195, 0.08146721610879516),
    RGB(0.29030547394827216, 0.1566704731433784, 0.06955958896758961),
    RGB(0.3486958875330028, 0.14413808439049522, 0.06517845643634491),
    RGB(0.2631529920611145, 0.22896210929698424, 0.1119250237167965),
    RGB(0.35775151767110114, 0.23955578484799914, 0.08566681526152695),
    RGB(0.42895506355552904, 0.19814294026377038, 0.07315576139822164),
    RGB(0.3359280058835734, 0.30177882691623686, 0.14764230985832),
    RGB(0.5168174153887967, 0.2588008525490645, 0.07751817567374263),
    RGB(0.44056726473192726, 0.3387984774995975, 0.10490250831857457),
    RGB(0.4048595970607235, 0.40823989479512734, 0.2096109034699151),
    RGB(0.619694338941659, 0.33787470822764315, 0.0871136546089913),
    RGB(0.5108290351302369, 0.41506713362977327, 0.13590312315603137),
    RGB(0.5272516131642648, 0.4706039514608196, 0.21392546020040532),
    RGB(0.5942622209175139, 0.47822315473126586, 0.14678522310513448),
    RGB(0.735266714513005, 0.4318652289706696, 0.1049661472744881),
    RGB(0.6201870982552801, 0.5227924127640037, 0.2167074150596878),
    RGB(0.6929049533440698, 0.5663098519207086, 0.18551505068207655),
    RGB(0.6814114992549445, 0.5814898147520997, 0.27039081549715527),
    RGB(0.8500397772474145, 0.5401215248181611, 0.1362117676724628),
    RGB(0.7575520588269891, 0.6334254649343621, 0.25145144950124687),
    RGB(0.8164723313500291, 0.6970150665478066, 0.32242062463720045),
    RGB(0.9330273170314637, 0.6651641943114455, 0.19865164906805746),
    RGB(0.9724409077178674, 0.7907008712807734, 0.2851364857083522)],
    "testing",
    "colors from Leonardo da Vinci's Mona Lisa")

@testset "basic tests" begin
    @test length(monalisa) == 32
    @test length(monalisa.colors) == 32
    # test that sampling schemes yield different values
    @inferred get(monalisa, 0.0)
    @test get(monalisa, 0.0) != get(monalisa, 0.5)
    @test monalisa[end] ≈ monalisa[1.0]
    
    # indexing tests
    #=
    @test monalisa[begin] == first(monalisa) 
    TODO uncomment this test once ColorSchemes drops support for Julia versions <= 1.3.
    Use of "begin" in arrays is only supported in later versions of Julia, and throws 
    ERROR: LoadError: syntax: unexpected "]" (revealed through CI testing) in Julia 1.3.
    =#
    @test monalisa[1] == first(monalisa)
    @test monalisa[end] == last(monalisa)
end

# getinverse() tests are now in ColorSchemes

@testset "conversion tests" begin
    # convert an Array{T,2} to an RGB image
    tmp = @inferred get(monalisa, rand(10, 10))
    @test typeof(tmp) == Array{ColorTypes.RGB{Float64}, 2}

    # test conversion with default clamp
    x = [0.0 1.0 ; -1.0 2.0]
    y = @inferred get(monalisa, x)
    @test y[1,1] ≈ y[2,1]
    @test y[1,2] ≈ y[2,2]

    # test conversion with symbol clamp
    y2 = @inferred get(monalisa, x, :clamp)

    @test y2[1] ≈ y[1]
    @test y2[2] ≈ y[2]
    @test y2[end] ≈ y[end]

    # test conversion with symbol extrema
    y2 = @inferred get(monalisa, x, :extrema)
    @test y2[2,1] ≈ y[1, 1]   # Minimum now becomes one edge of ColorScheme
    @test y2[2,2] ≈ y[1, 2]   # Maximum now becomes other edge of ColorScheme
    @test y2[1,1] !== y2[2, 1] # Inbetween values or now different

    # test conversion with manually supplied range
    y3 = @inferred get(monalisa, x, (-1.0, 2.0))
    @test y3[1] ≈ y2[1]
    @test y3[2] ≈ y2[2]
    @test y3[end] ≈ y2[end]

    # test empty range (#43)
    y4 = @inferred get(monalisa, 0.4, (0.0, 0.0))
    @test 0.3 < y4.r < 0.4
    @test 0.2 < y4.g < 0.25
    @test 0.1 < y4.b < 0.15

    # test gray value (#23)
    c = @inferred get(monalisa, Gray(N0f16(1.0)))
    @test typeof(c) == RGB{Float64}
    @test c.r > 0.95
    @test c.g > 0.75
    @test c.b < 0.3
    c = @inferred get(monalisa, Gray24(N0f16(1.0)))
    @test typeof(c) == RGB{Float64}
    @test c.r > 0.95
    # Booleans
    @inferred get(monalisa, false)

    @test get(monalisa, 0.0) ≈  get(monalisa, false)
    @test get(monalisa, 1.0) ≈ get(monalisa, true)
end

@testset "misc tests" begin
    # test with steplen (#17)
    r  = range(0, stop=5, length=10)
    y  = @inferred get(monalisa, r)
    y2 = @inferred get(monalisa, collect(r))

    @test isapprox(y[1], y2[1]) # fixes #61

    # test for specific value
    val = 0.2
    y   = @inferred get(monalisa, [val])
    y2  = @inferred get(monalisa, val)
    @test isapprox(y[1], y2)

    col = @inferred get(reverse(monalisa), 0.0)
    @test col.r > 0.9
    @test col.g > 0.7
    @test col.b > 0.2

    # test iteration of a colorscheme
    counter = 1
    for (n, i) in enumerate(monalisa)
        @test counter == n
        counter += 1
    end
    @test counter == 33

    # test findcolorschemes()
    @test length(findcolorscheme("rainbow")) > 0

    # test resample
    csa = resample(ColorSchemes.turbo, 20)
    @test length(csa) == 20

    csa = resample(ColorSchemes.turbo, 20, (α) -> 0.5)
    @test csa[1].alpha == 0.5
end

# these won't error but they don't yet work correctly either
# until `get()` can handle nono-normalized color values
@testset "tests with 255-based scheme" begin
    monalisa1 = deepcopy(monalisa)
    # set all colors to 255
    for c in eachindex(monalisa1.colors)
        monalisa1.colors[c] = RGB(monalisa1.colors[c].r * 255, monalisa1.colors[c].g * 255, monalisa1.colors[c].b * 255)
    end
    @test length(monalisa1) ≈ 32
    @test length(monalisa1.colors) ≈ 32

    @test 12 < monalisa1[1].r < 14
    @test 3  < monalisa1[1].g < 5
    @test 3  < monalisa1[1].b < 6

    # test that sampling schemes yield different values
    @inferred get(monalisa1, 0.0)
    @test get(monalisa1, 0.0) != get(monalisa1, 0.5)
    @test monalisa1[end] ≈ monalisa1[1.0]
    tmp = @inferred get(monalisa1, rand(10, 10))
    @test typeof(tmp) == Array{ColorTypes.RGB{Float64}, 2}

    # test conversion with default clamp
    x = [0.0 1.0 ; -1.0 2.0]
    y = @inferred get(monalisa1, x)
    @test y[1,1] ≈ y[2,1]
    @test y[1,2] ≈ y[2,2]

    # test conversion with symbol clamp
    y2 = @inferred get(monalisa1, x, :clamp)

    @test isapprox(y2[1], y[1])
    @test isapprox(y2[2], y[2])
    @test isapprox(y2[end], y[end])

    # test conversion with symbol centered
    y2 = @inferred get(monalisa1, x, :centered)
    @test y2[2,2] ≈ y[1, 2]   # Maximum now becomes one edge of ColorScheme
    @test y2[1,1] ≈ get(monalisa1, 0.5) # Zero value is centered
    @test y2[1,2] ≈ get(monalisa1, 0.75)
    @test y2[2,1] ≈ get(monalisa1, 0.25)

    # test conversion with symbol extrema
    y2 = @inferred get(monalisa1, x, :extrema)
    @test y2[2,1] ≈ y[1, 1]   # Minimum now becomes one edge of ColorScheme
    @test y2[2,2] ≈ y[1, 2]   # Maximum now becomes other edge of ColorScheme
    @test y2[1,1] !== y2[2, 1] # Inbetween values now different

    # test conversion with manually supplied range
    y3 = @inferred get(monalisa1, x, (-1.0, 2.0))
    @test isapprox(y3[1], y2[1])
    @test isapprox(y3[2], y2[2])
    @test isapprox(y3[end], y2[end])

    # test error on unknown rangescale
    @test_throws ArgumentError get(monalisa1, x, :foo)

    # tests concatenation
    l1 = length(monalisa)
    l2 = length(monalisa * monalisa)
    @test l2 == 2l1
end
