```@meta
DocTestSetup = quote
    using ColorSchemes, Colors
end
```

# Introduction to ColorSchemes
This package provides a collection of colorschemes:

- scientifically devised colorschemes from ColorBrewer, CMOcean, ScientificColorMaps, ColorCet, and Seaborn
- popular favourites such as _viridis_, _inferno_, and _magma_ from MATPlotLib
- variously themed colorschemes such as _sunset_, _coffee_, _neon_, and _pearl_
- artistic colorschemes, such as _leonardo_, _vermeer_, _picasso_, _Degas_, _Hiroshige_,  

Note that the schemes contained here are a mixture:

- some are high quality color maps with consistent perceptual contrast over their full range
- others are designed for general purpose and informal graphics work

Choose colorschemes with care! See the [Good practice](@ref) section, and also refer to Peter Kovesi's [PerceptualColourMaps](https://github.com/peterkovesi/PerceptualColourMaps.jl) package, or to Fabio Crameri's [Scientific Colour Maps](http://www.fabiocrameri.ch/colourmaps.php) for technical information.

This package relies on the [Colors.jl](https://github.com/JuliaGraphics/Colors.jl) package.

If you want to make more advanced ColorSchemes, use linear-segment dictionaries or indexed lists, and use functions to generate color values, see the `make_colorscheme()` function in the [ColorSchemeTools.jl](https://github.com/JuliaGraphics/ColorSchemeTools.jl) package.

## Installation and basic usage

Install the package as follows:

```julia
import Pkg
Pkg.add("ColorSchemes")
```

or, at the REPL:

```julia
] add ColorSchemes
```

Usage:

```julia
using ColorSchemes

ColorSchemes.Purples_5 
# => a ColorScheme 

colorschemes[:Purples_5]
# => a ColorScheme 

ColorSchemes.Purples_5.colors
# => array of five RGB colors

ColorSchemes.Purples_5.colors[3]
# => the third color in the colorscheme

get(ColorSchemes.Purples_5, 0.5)
# => the midway point of the colorscheme 

colorschemes
# => Dict{Symbol, ColorScheme} with 1150 entries

findcolorscheme("purple")
# => display list of matching schemes

ColorScheme([colorant"red", colorant"green", colorant"blue"])
# new colorscheme from Colors.jl named colors

get(ColorSchemes.darkrainbow, range(0.0, 1.0, length=20)) |> ColorScheme
# new colorscheme by resampling existing

resample(ColorSchemes.darkrainbow, 20)
# new colorscheme by resampling using `resample()` 
```

Original version by [cormullion](https://github.com/cormullion).

## Contributing a new colorscheme

If you think a new colorscheme would be a great addition for you and for Julians everywhere, you can contribute it as follows:

1. Add a file to the `data/` directory. The file should be a Julia file, with a `.jl` suffix.

2. Inside the file, define a colorscheme in this format, which calls [loadcolorscheme](@ref):

```julia
loadcolorscheme(:mynewcolorscheme, [
    RGB(0.0, 0.0, 0.0),
    RGB(0.5, 0.5, 0.5),
    RGB(1.0, 1.0, 1.0),
    ], 
    "category for my new scheme", # the category
    "black, white, and grey" # some descriptive keywords
    )
```

The new name - here `mynewcolorscheme` - should be a valid Julia variable name.

3. If you're adding the new colorscheme to an existing category, it will appear in the catalog document automatically.

4. Otherwise, to add a new category to the catalog (which will add all the colorschemes in that category), add this code to `catalogue.md`:

```markdown
    ```@example catalog
    using Luxor, ColorSchemes # hide
    ColorSchemeCategory("category for my new scheme") # hide
    ```
```

5. If there's a license file, add it to `data/` as well. (This is a courtesy thing rather than a legal thing.)

6. Add your new file to the include list in the function `src/ColorSchemes.jl/loadallschemes` (around line 118).

## Documentation

This documentation was built using [Documenter.jl](https://github.com/JuliaDocs).

```@example
using Dates # hide
println("Documentation built $(Dates.now()) with Julia $(VERSION)") # hide
```
