| **Documentation**                       | **Build Status**                                                                                |
|:--------------------------------------- |:----------------------------------------------------------------------------------------------- |
| [![][docs-stable-img]][docs-stable-url] [![][docs-latest-img]][docs-latest-url] | [![][travis-img]][travis-url] [![][appveyor-img]][appveyor-url] [![][codecov-img]][codecov-url] |

## ColorSchemes

This package provides a collection of colorschemes:

- scientifically devised colorschemes from ColorBrewer, CMOcean, ScientificColorMaps, ColorCet, and Seaborn
- popular old favourites such as _viridis_, _inferno_, and _magma_ from MATPlotLib
- old masters' colorschemes, such as _leonardo_, _vermeer_, and _picasso_
- variously themed colorschemes such as _sunset_, _coffee_, _neon_, and _pearl_

Note that the schemes contained here are a mixture:

- some are high quality color maps with consistent perceptual contrast over their full range
- others are designed for general purpose and informal graphics work

Choose colorschemes with care! Refer to Peter Kovesi's [PerceptualColourMaps](https://github.com/peterkovesi/PerceptualColourMaps.jl) package, or to Fabio Crameri's [Scientific Colour Maps](http://www.fabiocrameri.ch/colourmaps.php) for more information.

If you want to make more advanced ColorSchemes, use linear-segment dictionaries or indexed lists, and use functions to generate color values, see the `make_colorscheme()` function in the [ColorSchemeTools.jl](https://github.com/JuliaGraphics/ColorSchemeTools.jl) package.

[docs-stable-img]: https://img.shields.io/badge/docs-stable%20release-blue.svg
[docs-stable-url]: https://JuliaGraphics.github.io/ColorSchemes.jl/stable/

[docs-latest-img]: https://img.shields.io/badge/docs-in_development-orange.svg
[docs-latest-url]: https://JuliaGraphics.github.io/ColorSchemes.jl/latest/

[travis-img]: https://travis-ci.com/JuliaGraphics/ColorSchemes.jl.svg?branch=master
[travis-url]: https://travis-ci.com/JuliaGraphics/ColorSchemes.jl

[appveyor-img]: https://ci.appveyor.com/api/projects/status/59hherf65c713iaw/branch/master?svg=true
[appveyor-url]: https://ci.appveyor.com/project/cormullion/colorschemetools-jl

[codecov-img]: https://codecov.io/gh/JuliaGraphics/ColorSchemes.jl/branch/master/graph/badge.svg
[codecov-url]: https://codecov.io/gh/JuliaGraphics/ColorSchemes.jl
