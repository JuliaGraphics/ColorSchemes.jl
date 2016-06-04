## ColorSchemes

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

You can use the excellent [Colors.jl](https://github.com/JuliaGraphics/Colors.jl) package for working with colors, and for producing palettes that provide colors carefully chosen for readability and communication.

Sometimes, however, you might want a _colorscheme_ — a set of 'interesting' colors that complement each other visually — rather than a color palette. This package provides a simple approach to working with colorschemes.

### Usage <a id="Usage"></a>

To add this package (to Julia 0.4+):

    Pkg.add("ColorSchemes")

It requires Images.jl, Colors.jl, Clustering.jl, and FileIO.jl.

To use the basic functions in the package:

    using ColorSchemes

Load a built-in color scheme:

    leonardo = loadcolorscheme("leonardo")

Extracting colorschemes from images requires image importing and exporting abilities. These are platform-specific. On Linux/UNIX, ImageMagick can be used for importing and exporting images.

### Related packages

You might also like these packages for working with color palettes:

- [ColorBrewer.jl](https://github.com/timothyrenner/ColorBrewer.jl)

- [NoveltyColors.jl](https://github.com/randyzwitch/NoveltyColors.jl)

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

You can load a predefined scheme (from text files in the `ColorSchemes/data` directory) using:

    leonardo = loadcolorscheme("leonardo")

<img src="doc/leo-colorscheme.png" width=600>

— the `.txt` suffix can be omitted. They're stored in files as rows of red, green, and blue values:

    # colorscheme leonardo
    # created 2015-12-29T19:53:22
    0.05482025926320272	0.016508952654741622	0.019315160361063788
    0.07508160782698388	0.034110215845969745	0.039708343938094984
    ...
    0.735266714513005	0.4318652289706696	0.1049661472744881
    0.6201870982552801	0.5227924127640037	0.2167074150596878
    0.6929049533440698	0.5663098519207086	0.18551505068207655
    0.6814114992549445	0.5814898147520997	0.27039081549715527
    0.8500397772474145	0.5401215248181611	0.1362117676724628
    0.7575520588269891	0.6334254649343621	0.25145144950124687
    0.8164723313500291	0.6970150665478066	0.32242062463720045
    0.9330273170314637	0.6651641943114455	0.19865164906805746
    0.9724409077178674	0.7907008712807734	0.2851364857083522

You can reference a single value of a scheme once it's loaded:

    leonardo[3]

    -> RGB{Float64}(0.10884977211887092,0.033667530751245296,0.026120424375656533)

Or you can 'sample' the scheme at any point between 0 and 1:

    colorscheme(leonardo, 0.5)

    -> RGB{Float64}(0.42637271063618504,0.28028983973265065,0.11258024276603132)

You can create a new color scheme by sampling an image. For example, here's an image of a famous painting:

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

The `ColorSchemes/data` directory contains a number of predefined colorschemes. In the following illustration, first is shown the contents of a colorscheme, followed by a continuous blend obtained using `colorscheme()` with values ranging from 0 to 1 (stepping through the range `0:0.001:1`):

<img src="doc/colorschemes.png" width=800>

Here's an <a href="doc/colorschemes.svg"> SVG</a> of them.

You can list the names of colorschemes in the `ColorSchemes/data` directory with `list()`, and look for matches with `filter()`.

    filter(x-> contains(x, "temp"), list())

    2-element Array{AbstractString,1}:
    "lighttemperaturemap"
    "temperaturemap"    

## Colorschemes, blends/gradients <a id="Colorschemes, blends/gradients"></a>

As well as accessing colors by indexing (eg `leonardo[2]` or `leonardo[2:20]`), a colorscheme can simulate a continuous range of colors by handling any number between 0 and 1 and interpolating between the provided color definitions. So:

    colorscheme(leonardo, 0.5)

returns

    RGB{Float64}(0.42637271063618504,0.28028983973265065,0.11258024276603132)

The colors in the predefined colorschemes are sorted by LUV luminance, so this makes a kind of sense.

## Sorting color schemes <a id="Sorting color schemes"></a>

To sort a colorscheme:

    sortcolorscheme(cscheme)

or

    sortcolorscheme(leonardo, rev=true)

The default is to sort colors by their LUV luminance value, but you could try specifying the `:u` or `:v` LUV fields instead (sorting colors is another problem domain not really addressed in this package...):

    sortcolorscheme(colorscheme, :u)

## Making colorscheme files <a id="Making colorscheme files"></a>

You can make a colorscheme file from a colorscheme like this:

    savecolorscheme(leonardo, "/tmp/leonardo_scheme.txt", "comment: from the Mona Lisa")

which saves the color values in a text file with the provided name. The file contains one or more lines of three Float64 numbers between 0 and 1, for Red, Green, and Blue. A comment line can be added.

## Weighted colorschemes <a id="Weighted colorschemes"></a>

Sometimes an image is dominated by some colors with others occurring less frequently. For example, there may be much more brown than yellow in a particular image. You can extract both a set of colors and a set of numerical values or weights that indicate the proportions of colors in the image.

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

Compare the weighted and unweighted versions:

<img src="doc/hok-scheme-unweighted.png" width=600>

<img src="doc/hok-scheme-weighted.png" width=600>

## Plotting <a id="Plotting"></a>

#### Plots <a id="Plots.jl"></a>

Tom Breloff's amazing superplotting package, [Plots.jl](https://github.com/tbreloff/Plots.jl) can use colorschemes.

With the `contour()` function:

    leonardo = loadcolorscheme("leonardo")

    x = 1:0.3:20
    y = x
    f(x,y) = begin
          sin(x) + cos(y)
      end
    contour(x, y, f, fill=true, c=leonardo)

<img src="doc/plots-contour-1.png" width=600>

With other plots, use the `palette` keyword:

    canaletto = loadcolorscheme("canaletto")

    plot(Plots.fakedata(100, 20), w=4,
    background_color=canaletto[1],
    palette=canaletto)

<img src="doc/plots-background.png" width=600>

#### Gadfly <a id="Gadfly"></a>

Here's how you can use colorschemes in Gadfly:

<img src="doc/hokusai-weights-1.png" width=600>

#### Winston <a id="Winston"></a>

If you prefer Winston.jl for plotting, you can use colorschemes with `imagesc`:

<img src="doc/winston.png" width=600>

Sometimes you'll want a smoother gradient with more colors. You can use `colorscheme(scheme, n)` to generate a more detailed array of colors, varying `n` from 0 to 1 by 0.001:

<img src="doc/winston-1.png" width=600>

(Unfortunately, when doing array comprehensions in Julia currently, the type information can be lost, hence the addition of `Array{ColorTypes.RGB}()` around the comprehension.)

#### PyPlot <a id="PyPlot"></a>

The colorschemes can be used with the `cmap` keyword in PyPlot:

<img src="doc/pyplot.png" width=600>

## Images <a id="Images"></a>

Here's how you can use colorschemes when creating images with Images.jl. The code creates a Julia set and uses a colorscheme extracted from Vermeer's painting "Girl with a Pearl Earring" (loaded using `loadcolorscheme("vermeer")`). (For no good reason.)

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
        vermeer_pearl = loadcolorscheme("vermeer")
        imOutput = Images.colorim(array)
        maxiterations = 200
        for col = linspace(xmin, xmax, size)
            for row = linspace(ymin, ymax, size)
                pixelcolor = julia(complex(row, col), c, maxiterations) /256
                xpos = convert(Int, round(remap(col, xmin, xmax, 1, size)))
                ypos = convert(Int, round(remap(row, ymin, ymax, 1, size)))
                imOutput.data[xpos, ypos, :] = [
                  (colorscheme(vermeer_pearl,pixelcolor).r),
                  (colorscheme(vermeer_pearl,pixelcolor).g),
                  (colorscheme(vermeer_pearl,pixelcolor).b)]
            end
        end
        FileIO.save(filename, imOutput)
    end

    draw(-0.4 + 0.6im, 1200)

### Saving colorschemes as images ###

Sometimes you want to save a colorscheme, which are usually just a pixel thick, as an image. You can do this with `colorscheme_to_image()`. The second argument is the number of repetitions of each color in the row, the third is the number of rows. The function returns an image which you can save using FileIO's `save()`:

    (using FileIO, ColorSchemes, Images, Colors)

    vermeer_pearl = loadcolorscheme("vermeer")
    img = colorscheme_to_image(vermeer_pearl, 30, 400)
    save("/tmp/cs_vermeer-30-300.png", img)

<img src="doc/cs_vermeer-30-300.png" width=400>
