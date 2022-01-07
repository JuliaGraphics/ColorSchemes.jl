```@setup catalog
using Luxor, ColorSchemes

function generate_scheme_svg(schemename;
        swatchwidth = 800,
        swatchheight = 20)

    # create swatch
    cols = colorschemes[schemename].colors
    l = length(cols)
    Drawing(swatchwidth, swatchheight, :svg)
    setline(0.5)
    origin()
    t = Tiler(swatchwidth, swatchheight, 1, l, margin=0)
    for (i, c) in enumerate(cols)
        sethue(c)
        box(t, i, :fillstroke)
    end
    finish()

    swatch = svgstring()

    # fill the template
    schemetemplate = """
    <div class="schemename">:$(schemename)</div>
    <div class="swatch">$(swatch)</div>
    """
    return schemetemplate
end

function generate_schemes_in_category(category)
    iobuffer = IOBuffer()

    write(iobuffer, """
    <div class="category">
      """)

    schemes = filter(s -> occursin(category, colorschemes[s].category), collect(keys(colorschemes)))
    for s in sort(schemes)
        write(iobuffer, generate_scheme_svg(s))
    end
    write(iobuffer, """
    </div>
    """)

    return String(take!(iobuffer))
end

function Base.show(io::IO, m::MIME"text/html", category::ColorSchemeCategory)
     print(io, generate_schemes_in_category(category.name))
end
```

# Catalogue of ColorSchemes

## ✦ cmocean

From "Beautiful colormaps for oceanography": [cmocean](https://matplotlib.org/cmocean/)

```@example catalog
using Luxor, ColorSchemes # hide
ColorSchemeCategory("cmocean") # hide
```

## ✦ scientific

From [Scientific colormaps](http://www.fabiocrameri.ch/colourmaps.php)

```@example catalog
using Luxor, ColorSchemes # hide
ColorSchemeCategory("scientific") # hide
```

## ✦ matplotlib

From [matplot](https://matplotlib.org)

```@example catalog
using Luxor, ColorSchemes # hide
ColorSchemeCategory("matplotlib") # hide
```

## ✦ colorbrewer

From [ColorBrewer](http://colorbrewer2.org/)

```@example catalog
using Luxor, ColorSchemes # hide
ColorSchemeCategory("colorbrewer") # hide
```

## ✦ gnuplot

From [GNUPlot](http://www.gnuplot.info)

```@example catalog
using Luxor, ColorSchemes # hide
ColorSchemeCategory("gnuplot") # hide
```

## ✦ colorcet

From ["collection of perceptually accurate colormaps"](https://colorcet.holoviz.org)

```@example catalog
using Luxor, ColorSchemes # hide
ColorSchemeCategory("colorcet") # hide
```

## ✦ Seaborn

From ["colorschemes used by Seaborn, a Python data visualization library based on matplotlib."](http://seaborn.pydata.org/tutorial/color_palettes.html)

```@example catalog
using Luxor, ColorSchemes # hide
ColorSchemeCategory("seaborn") # hide
```

## ✦ ggthemes/tableau

From ["ggthemes tableau palettes"](https://github.com/jrnold/ggthemes)

```@example catalog
using Luxor, ColorSchemes # hide
ColorSchemeCategory("tableau") # hide
```

## ✦ Color-Vision Deficient-friendly schemes

Colorschemes designed with color-vision deficient users in mind, by authors such as Paul Tol, Masataka Okabe, Kei Ito, and Martin Krzywinski.

```@example catalog
using Luxor, ColorSchemes # hide
ColorSchemeCategory("cvd") # hide
```

## ✦ Flags

Colors extracted from flags of different countries and regions, downloaded from
[Flagpedia](https://flagpedia.net). Intended to represent these regions in
visualizations, but not necessarily effective. Many flags have similar
colorschemes. The flags are named according to the region's ISO3166 two-letter
abbreviation (often the same as top-level WWW domain), with any hyphens removed.

```@example catalog
using Luxor, ColorSchemes # hide
ColorSchemeCategory("flags") # hide
```

## ✦ MetBrewer

Palettes inspired by works at the Metropolitan Museum of Art
in New York. See [Blake Mills' github
repository](https://github.com/BlakeRMills/MetBrewer).

```@example catalog
using Luxor, ColorSchemes # hide
ColorSchemeCategory("MetBrewer") # hide
```

## ✦ general and miscellaneous

```@example catalog
using Luxor, ColorSchemes # hide
ColorSchemeCategory("general") # hide
```
