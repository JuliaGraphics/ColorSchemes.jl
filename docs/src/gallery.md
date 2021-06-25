```@meta
DocTestSetup = quote
    using Luxor, Colors, ColorSchemes
end
```

```@setup drawgallery

# use a `drawschemes(cschemes)`` function to insert drawings of schemes
# use SVG for Documenter.jl >= 0.27

using Luxor, Colors, ColorSchemes

function draw_a_scheme(pos,cscheme, swatchwidth, swatchheight, counter)
    cols = colorschemes[cscheme].colors
    setline(0.25)
    @layer begin
        translate(pos)

        # text
        fontsize(5)
        fontface("JuliaMono-Regular")
        sethue("white")
        setline(0.1)

        # first position, scheme name
        text(string(cscheme), Point(0, swatchheight/2 + (isodd(counter) ? -5 : 0)), halign=:center)

        # # second position, boxes of colors
        @layer begin
            ncols = length(cols)
            sectorangle = 2π/ncols
            for (n, θ) in enumerate(range(0, 2π, step=sectorangle))
                sethue(cols[mod1(n, end)])
                sector(O, 10, max(swatchwidth, swatchheight)/3, 3π/2 + θ, 3π/2 + θ + sectorangle, :fill)
            end
        end
    end
end

function drawgallery(category;
        filetype=:svg)
    schemes = filter(s -> occursin(category, colorschemes[s].category), collect(keys(colorschemes)))
    # is vector of symbol
    l = length(schemes)
    swatchsize = 80
    ncols = 10
    nrows = 1 + round(l ÷ ncols, RoundUp)
    d = Drawing(800, 50 + (swatchsize * nrows), filetype)
    origin()
    background("grey15")
    sethue("white")
    fontsize(20)
    fontface("JuliaMono-Bold")
    text("Category: " * category, boxtopleft(BoundingBox() + (10, 25)), halign=:left)
    tiles = Partition(800, swatchsize * nrows, swatchsize, swatchsize)
    for (pos, n) in tiles
        draw_a_scheme(pos, schemes[n], tiles.tilewidth, tiles.tileheight, n)
        if n >= l
            break
        end
    end
    finish()
    return d
end

```

# Gallery

These diagrams show the colorschemes in compact form, so you can quickly find one.
See [Pre-defined schemes](@ref) for more details, bigger swatchs, and references.

```@example drawgallery
drawgallery("cmocean") # hide
```

```@example drawgallery
drawgallery("matplotlib")  # hide
```

```@example drawgallery
drawgallery("gnuplot") # hide
```

```@example drawgallery
drawgallery("scientific") # hide
```

```@example drawgallery
drawgallery("colorbrewer") # hide
```

```@example drawgallery
drawgallery("gnuplot") # hide
```

```@example drawgallery
drawgallery("colorcet") # hide
```

```@example drawgallery
drawgallery("seaborn") # hide
```

```@example drawgallery
drawgallery("tableau") # hide
```

```@example drawgallery
drawgallery("cvd") # hide
```

```@example drawgallery
drawgallery("flags") # hide
```

```@example drawgallery
drawgallery("general") # hide
```
