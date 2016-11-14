## ColorSchemes

This package provides some tools for working with colorschemes and colormaps. As well as providing many pre-made colormaps and schemes, this package allows you to extract colorschemes from images and use them in plots or other graphics programs.

This package relies on the [Colors.jl](https://github.com/JuliaGraphics/Colors.jl) package for working with colors.

### Contents

+ [Usage](#Usage)
+ [Basics](#Basics)
+ [ Colorschemes, blends/gradients](#Colorschemes, blends/gradients)
+ [ Sorting color schemes](#Sorting color schemes)
+ [ Making colorscheme files](#Making colorscheme files)
+ [ Weighted colorschemes](#Weighted colorschemes)
+ [Plotting](#Plotting)
+ [ Plots](#Plots.jl)
+ [ Gadfly](#Gadfly)
+ [ Winston](#Winston)
+ [ PyPlot](#PyPlot)
+ [Images](#Images)

### Usage <a id="Usage"></a>

To add this package:

    Pkg.add("ColorSchemes")

To use the basic functions in the package:

    using ColorSchemes

### Basics <a id="Basics"></a>

A colorscheme is an array of colors:

    32-element Array{ColorTypes.RGB{Float64},1}:
        RGB{Float64}(0.0548203,0.016509,0.0193152)
        RGB{Float64}(0.0750816,0.0341102,0.0397083)
        RGB{Float64}(0.10885,0.0336675,0.0261204)
        RGB{Float64}(0.100251,0.0534243,0.0497594)
        ...
        RGB{Float64}(0.85004,0.540122,0.136212)
        RGB{Float64}(0.757552,0.633425,0.251451)
        RGB{Float64}(0.816472,0.697015,0.322421)
        RGB{Float64}(0.933027,0.665164,0.198652)
        RGB{Float64}(0.972441,0.790701,0.285136)

The names of the built-in colorschemes are stored in the `schemes` array:

    julia> schemes
    330-element Array{Symbol,1}:
     :alpine
     :aquamarine
     :army
     :atlantic
     :aurora
     ⋮
     :PiYG_5
     :PiYG_6
     :PiYG_7
     :PiYG_8
     :PiYG_9
     :PiYG_10
     :PiYG_11

To use one of the built-in colorschemes, use its symbol:

    julia> ColorSchemes.leonardo

    32-element Array{ColorTypes.RGB{Float64},1}:
     RGB{Float64}(0.0548203,0.016509,0.0193152)
     RGB{Float64}(0.0750816,0.0341102,0.0397083)
     RGB{Float64}(0.10885,0.0336675,0.0261204)
     RGB{Float64}(0.100251,0.0534243,0.0497594)
     ...
     RGB{Float64}(0.620187,0.522792,0.216707)
     RGB{Float64}(0.692905,0.56631,0.185515)
     RGB{Float64}(0.681411,0.58149,0.270391)
     RGB{Float64}(0.85004,0.540122,0.136212)
     RGB{Float64}(0.757552,0.633425,0.251451)
     RGB{Float64}(0.816472,0.697015,0.322421)
     RGB{Float64}(0.933027,0.665164,0.198652)
     RGB{Float64}(0.972441,0.790701,0.285136)

<img src="doc/leo-colorscheme.png" width=600>

By default, the names of the colorschemes aren't imported (there _are_ rather a lot of them). But to avoid using the prefixes, you can import any that you want:

    julia> import ColorSchemes.leonardo
    julia> leonardo
    32-element Array{ColorTypes.RGB{Float64},1}:
     RGB{Float64}(0.0548203,0.016509,0.0193152)
     RGB{Float64}(0.0750816,0.0341102,0.0397083)
     RGB{Float64}(0.10885,0.0336675,0.0261204)
     RGB{Float64}(0.100251,0.0534243,0.0497594)
     ...
     RGB{Float64}(0.757552,0.633425,0.251451)
     RGB{Float64}(0.816472,0.697015,0.322421)
     RGB{Float64}(0.933027,0.665164,0.198652)
     RGB{Float64}(0.972441,0.790701,0.285136)

You can reference a single value of a scheme once it's loaded:

    leonardo[3]

    -> RGB{Float64}(0.10884977211887092,0.033667530751245296,0.026120424375656533)

Or you can 'sample' the scheme at any point between 0 and 1 using `get`:

    get(leonardo, 0.5)

    -> RGB{Float64}(0.42637271063618504,0.28028983973265065,0.11258024276603132)

You can extract a colorscheme from an image. For example, here's an image of a famous painting:

<img src="doc/monalisa.jpg" width=400>

Use `extract()` to create a colorscheme from the original image:

    monalisa = extract("monalisa.jpg", 10, 15, 0.01; shrink=2)

which creates a 10-color scheme (using 15 iterations and with a tolerance of 0.01; the image can be reduced in size, here by 2, before processing, to save time).

    10-element Array{ColorTypes.RGB{Float64},1}:
     RGB{Float64}(0.0465302,0.0466217,0.0477755)
     RGB{Float64}(0.695769,0.502293,0.165606)
     RGB{Float64}(0.890576,0.833807,0.492074)
     RGB{Float64}(0.481471,0.355741,0.108024)
     RGB{Float64}(0.445139,0.450331,0.24395)
     RGB{Float64}(0.889475,0.688348,0.29377)
     RGB{Float64}(0.161839,0.144967,0.0806486)
     RGB{Float64}(0.736354,0.706571,0.441564)
     RGB{Float64}(0.292996,0.2819,0.137832)
     RGB{Float64}(0.612204,0.586307,0.332992)

(Extracting colorschemes from images requires image importing and exporting abilities. These are platform-specific. On Linux/UNIX, ImageMagick can be used for importing and exporting images.)

The ColorSchemes automatically loads a number of predefined colorschemes. In the following illustration, the contents of a colorscheme is drawn first, followed by a continuous blend obtained using `get()` with values ranging from 0 to 1 (stepping through the range `0:0.001:1`). Below that, a luminance graph shows how the luminance of the scheme varies as the colors change.

It's generally agreed that you should choose for your graphs a colormap with a smooth linear gradient: abrupt changes in luminance, caused by, say, suddenly brighter colors, will cause the viewer of a graph to misinterpret the information.

<img src="doc/colorschemes.png" width=800>

(You can generate this file using `ColorSchemes/data/draw-swatches.jl`.)

You can list the names of built-in colorschemes in the `ColorSchemes/data` directory by looking in the `schemes` symbol. Look for matches with `filter()`.

    julia> filter(x-> contains(string(x), "temp"), schemes)
    2-element Array{Symbol,1}:
     :lighttemperaturemap
     :temperaturemap

Of course you can easily make your own colorscheme by building an array:

    grays = [RGB{Float64}(i, i, i) for i in 0:0.1:1.0]

or, slightly longer:

    reds = RGB{Float64}[]

    for i in 0:0.05:1
      push!(reds, RGB{Float64}(1, 1-i, 1-i))
    end

## Colorschemes, blends/gradients <a id="Colorschemes, blends/gradients"></a>

You can access the specific colors of a colorscheme by indexing (eg `leonardo[2]` or `leonardo[2:20]`). Or you can sample a colorscheme at a point between 0.0 and 1.0 as if it was a continuous range of colors:

    get(leonardo, 0.5)

returns

    RGB{Float64}(0.42637271063618504,0.28028983973265065,0.11258024276603132)

The colors in the predefined colorschemes are usually sorted by LUV luminance, so this often makes sense.

## Sorting color schemes <a id="Sorting color schemes"></a>

To sort a colorscheme:

    sortcolorscheme(cscheme)

or

    sortcolorscheme(leonardo, rev=true)

The default is to sort colors by their LUV luminance value, but you could try specifying the `:u` or `:v` LUV fields instead (sorting colors is another problem domain not really addressed in this package...):

    sortcolorscheme(colorscheme, :u)

## Weighted colorschemes <a id="Weighted colorschemes"></a>

Sometimes an image is dominated by some colors with others occurring less frequently. For example, there may be much more brown than yellow in a particular image. A colorscheme derived from this image can reflect this. You can extract both a set of colors and a set of numerical values or weights that indicate the proportions of colors in the image.

    cs, wts = extract_weighted_colors("monalisa.jpg", 10, 15, 0.01; shrink=2)

The colorscheme is now in `cs`, and `wts` holds the various weights of each color:

    wts
    -> 10-element Array{Float64,1}:
     0.294055
     0.0899108
     0.0808455
     0.0555576
     0.142818
     0.0356599
     0.0391717
     0.112667
     0.0596559
     0.0896584

With the colorscheme and the weights, you can make a colorscheme in which the more common colors take up more space in the scheme:

    colorscheme_weighted(cs, wts, len)

Or in one go:

    colorscheme_weighted(extract_weighted_colors("monalisa.jpg")...)

Compare the weighted and unweighted versions of schemes extracted from the Hokusai image "The Great Wave":

<img src="doc/hok-scheme-unweighted.png" width=600>

<img src="doc/hok-scheme-weighted.png" width=600>

## Plotting <a id="Plotting"></a>

#### Plots <a id="Plots.jl"></a>

Tom Breloff's amazing superplotting package, [Plots.jl](https://github.com/tbreloff/Plots.jl) can use colorschemes.

With the `contour()` function, use `cgrad()` to read the colorscheme as a gradient:

    using Plots, Colorschemes

    x = 1:0.3:20
    y = x
    f(x,y) = begin
          sin(x) + cos(y)
      end
    contour(x, y, f, fill=true, seriescolor=cgrad(ColorSchemes.leonardo))

<img src="doc/plots-contour-1.png" width=600>

(You can use `c` as a short cut for `seriescolor`.)

With other plots, use the `palette` keyword:

    plot(Plots.fakedata(100, 20),
        w=4,
        background_color=ColorSchemes.vermeer[1],
        palette=ColorSchemes.vermeer)

<img src="doc/plots-background.png" width=600>

#### Gadfly <a id="Gadfly"></a>

Here's how you can use ColorSchemes in Gadfly:

    x = repeat(collect(1:20), inner=[20])
    y = repeat(collect(1:20), outer=[20])
    plot(x=x, y=y,
        color=x+y,
        Geom.rectbin,
        Scale.ContinuousColorScale(p -> get(ColorSchemes.sunset, p)))

<img src="doc/gadfly-sunset.png" width=600>

#### Winston <a id="Winston"></a>

If you prefer Winston.jl for plotting, you can use colorschemes with `imagesc`:

    using Winston
    klimt = ColorSchemes.klimt
    Winston.colormap(klimt)
    Winston.imagesc(reshape(1:10000,100,100))

<img src="doc/winston.png" width=600>

Sometimes you'll want a smoother gradient with more colors. You can use `get(scheme, n)` to generate a more detailed array of colors, varying `n` from 0 to 1 by 0.001:

    brasstones = ColorSchemes.brass
    brasstonesmooth = [get(brasstones, i) for i in 0:0.001:1]
    Winston.colormap(brasstonesmooth)
    Winston.imagesc(reshape(1:10000,100,100))

<img src="doc/winston1.png" width=600>

#### PyPlot <a id="PyPlot"></a>

The colorschemes can be used with the `cmap` keyword in PyPlot:

    using PyPlot, Distributions

    solar = ColorSchemes.solar

    n = 100
    x = linspace(-3, 3, n)
    y = linspace(-3,3,n)

    xgrid = repmat(x',n,1)
    ygrid = repmat(y,1,n)
    z = zeros(n,n)

    for i in 1:n
        for j in 1:n
            z[i:i,j:j] = pdf(MvNormal(eye(2)),[x[i];y[j]])
        end
    end

    fig = PyPlot.figure("pyplot_surfaceplot",figsize=(10,10))
    ax = fig[:add_subplot](2,1,1, projection = "3d")
    ax[:plot_surface](xgrid, ygrid, z, rstride=2,edgecolors="k",
        cstride=2,
        cmap=ColorMap(solar),
        alpha=0.8,
        linewidth=0.25)

<img src="doc/pyplot.png" width=600>

## Images <a id="Images"></a>

Here's how you can use colorschemes when creating images with Images.jl. The code creates a Julia set and uses a colorscheme extracted from Vermeer's painting "Girl with a Pearl Earring".

<img src="doc/julia-set-with-girl-pearl-vermeer.jpg" width=900>

    using ColorSchemes

    function julia(z, c, maxiter::Int64)
        for n = 1:maxiter
            if abs(z) > 2
                return n
            end
            z = z^2 + c
        end
        return maxiter
    end

    # convert a value between oldmin/oldmax to equivalent value between newmin/newmax
    remap(value, oldmin, oldmax, newmin, newmax) = ((value - oldmin) / (oldmax - oldmin)) * (newmax - newmin) + newmin

    function draw(c, size;
          xmin = -2, ymin = -2, xmax  =  2, ymax = 2,
          filename = "/tmp/julia-set.png")
        array = Array{UInt8}(size, size, 3)
        imOutput = Images.colorim(array)
        maxiterations = 200
        for col = linspace(xmin, xmax, size)
            for row = linspace(ymin, ymax, size)
                pixelcolor = julia(complex(row, col), c, maxiterations) /256
                xpos = convert(Int, round(remap(col, xmin, xmax, 1, size)))
                ypos = convert(Int, round(remap(row, ymin, ymax, 1, size)))
                imOutput.data[xpos, ypos, :] = [
                  (get(ColorSchemes.vermeer,pixelcolor).r),
                  (get(ColorSchemes.vermeer,pixelcolor).g),
                  (get(ColorSchemes.vermeer,pixelcolor).b)]
            end
        end
        FileIO.save(filename, imOutput)
    end

    draw(-0.4 + 0.6im, 1200)

### Saving colorschemes as images ###

Sometimes you want to save a colorscheme, which is usually just a pixel thick, as an image. You can do this with `colorscheme_to_image()`. The second argument is the number of repetitions of each color in the row, the third is the total number of rows. The function returns an image which you can save using FileIO's `save()`:

    (using FileIO, ColorSchemes, Images, Colors)

    img = colorscheme_to_image(ColorSchemes.vermeer, 30, 400)
    save("/tmp/cs_vermeer-30-300.png", img)

<img src="doc/cs_vermeer-30-300.png" width=400>
