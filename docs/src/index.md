```@meta
DocTestSetup = quote
    using ColorSchemes, Colors
end
```

# Introduction to ColorSchemes

This package provides tools for working with colorschemes and colormaps. It provides many pre-made colormaps and schemes:

- scientifically devised colorschemes from ColorBrewer and CMOcean
- popular old favourites such as _viridis_, _inferno_, and _magma_ from MATPlotLib
- old masters' colorschemes, such as _leonardo_, _vermeer_, and _picasso_
- variously themed colorschemes such as _sunset_, _coffee_, _neon_, and _pearl_

In addition, you can extract colorschemes from images, and replace an image colorscheme with another.

!!! Note

    The package is designed for general purpose and informal graphics work. For high quality color maps that have consistent perceptual contrast over their full range, refer to Peter Kovesi's [PerceptualColourMaps](https://github.com/peterkovesi/PerceptualColourMaps.jl) package.

This package relies on the [Colors.jl](https://github.com/JuliaGraphics/Colors.jl), [Images.jl](https://github.com/JuliaImages/Images.jl), and [Clustering.jl](https://github.com/JuliaStats/Clustering.jl) packages.

## Installation and basic usage

Install the package as follows:

```
] add ColorSchemes
```

and to use it:

```
using ColorSchemes
```

Original version by [cormullion](https://github.com/cormullion).
