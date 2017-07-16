# Introduction to ColorSchemes

This package provides tools for working with colorschemes and colormaps. As well as providing many pre-made colormaps and schemes, this package allows you to extract colorschemes from images and use them in other graphics programs.

_This package is designed for general purpose and informal graphics work. For high quality color maps that have consistent perceptual contrast over their full range, refer to Peter Kovesi's [PerceptualColourMaps](https://github.com/peterkovesi/PerceptualColourMaps.jl) package._

This package relies on the [Colors.jl](https://github.com/JuliaGraphics/Colors.jl) package and [Images.jl](https://github.com/JuliaImages/Images.jl).

## Current status

ColorSchemes requires Julia version 0.6, and makes use of the Images.jl and Clustering.jl packages.

## Installation and basic usage

Install the package as follows:

```
Pkg.add("ColorSchemes")
```

and to use it:

```
using ColorSchemes
```

Original version by [cormullion](https://github.com/cormullion).
