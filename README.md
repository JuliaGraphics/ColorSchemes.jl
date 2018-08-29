[![ColorSchemes](http://pkg.julialang.org/badges/ColorSchemes_0.7.svg)](http://pkg.julialang.org/?pkg=ColorSchemes&ver=0.7)
<!-- [![ColorSchemes](http://pkg.julialang.org/badges/ColorSchemes_1.0.svg)](http://pkg.julialang.org/?pkg=ColorSchemes&ver=1.0) -->

[![Build Status](https://travis-ci.org/JuliaGraphics/ColorSchemes.jl.svg?branch=master)](https://travis-ci.org/JuliaGraphics/ColorSchemes.jl)
[![Build Status](https://ci.appveyor.com/api/projects/status/github/cormullion/ColorSchemes.jl?branch=master&svg=true)](https://ci.appveyor.com/project/cormullion/ColorSchemes-jl)

[![](https://img.shields.io/badge/docs-stable-blue.svg)](https://JuliaGraphics.github.io/ColorSchemes.jl/stable) [![](https://img.shields.io/badge/docs-latest-blue.svg)](https://JuliaGraphics.github.io/ColorSchemes.jl/latest)

## ColorSchemes

![big picture](docs/src/assets/figures/snapshot.png)

This package provides tools for working with colorschemes and colormaps. It provides many pre-made colormaps and schemes:

- scientifically devised colorschemes from ColorBrewer and CMOcean
- popular old favourites such as _viridis_, _inferno_, and _magma_ from MATPlotLib
- old masters' colorschemes, such as _leonardo_, _vermeer_, and _picasso_
- variously themed colorschemes such as _sunset_, _coffee_, _neon_, and _pearl_

In addition, you can extract colorschemes from images, and replace an image colorscheme with another.

*The package is designed for general purpose and informal graphics work. For high quality color maps that have consistent perceptual contrast over their full range, refer to Peter Kovesi's [PerceptualColourMaps](https://github.com/peterkovesi/PerceptualColourMaps.jl) package.*

This package relies on the [Colors.jl](https://github.com/JuliaGraphics/Colors.jl), [Images.jl](https://github.com/JuliaImages/Images.jl), and [Clustering.jl](https://github.com/JuliaStats/Clustering.jl) packages.
