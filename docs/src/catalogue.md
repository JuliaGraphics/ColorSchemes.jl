```@setup catalog
# this code will display all the schemes in a category, as an SVG
# use in this docs/src/catalogue.md file as
#  ```@example catalog
#     using Luxor, ColorSchemes # hide
#     ColorSchemeCategory("cmocean") # hide
#  ```
# which displays the "cmocean" category

using Luxor, ColorSchemes

struct ColorSchemeGroup
    name::String
end

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

function generate_schemes_matching_notes_string(str)
    iobuffer = IOBuffer()

    write(iobuffer, """
    <div class="category">
      """)

    schemes = filter(s -> occursin(str, colorschemes[s].notes), collect(keys(colorschemes)))
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

function Base.show(io::IO, m::MIME"text/html", group::ColorSchemeGroup)
     print(io, generate_schemes_matching_notes_string(group.name))
end
```

# Catalogue of ColorSchemes

At the REPL you can search for colorschemes by name:

```julia
findcolorscheme("julia")
```

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

Colorschemes designed with color-vision deficient users in mind, by authors such as Paul Tol, Masataka Okabe, Kei Ito, and Martin Krzywinski. This list also includes schemes with "cvd" in the Notes field.

```@example catalog
using Luxor, ColorSchemes # hide
ColorSchemeCategory("cvd") # hide
ColorSchemeGroup("cvd") # hide
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

## ✦ Pacific North West

The colors of Washington State and the Pacific Northwest of the USA. See [Jake Lawlor's github
repository](https://github.com/jakelawlor/PNWColors).

```@example catalog
using Luxor, ColorSchemes # hide
ColorSchemeCategory("PNW Pacific North West") # hide
```

## ✦ Wes Anderson

Palettes derived from the films of Wes Anderson. See [Karthik's github
repository](https://github.com/karthik/wesanderson).

```@example catalog
using Luxor, ColorSchemes # hide
ColorSchemeCategory("Wes Anderson") # hide
```

## ✦ general and miscellaneous

```@example catalog
using Luxor, ColorSchemes # hide
ColorSchemeCategory("general") # hide
```

```@example catalog
using Luxor, ColorSchemes # hide
ColorSchemeCategory("nord") # hide
```

```@example catalog
using Luxor, ColorSchemes # hide
ColorSchemeCategory("kindlmann") # hide
```

## ✦ Julia logo colorschemes

```@example catalog
using Luxor, ColorSchemes # hide
ColorSchemeCategory("julia") # hide
```
