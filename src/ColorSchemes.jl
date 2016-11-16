#!/usr/bin/env julia

__precompile__()

"""
A colorscheme is an array of colors. To use the package:

    using ColorSchemes, Colors

and, if you want image input and output:

    using Images, FileIO

The names of the registered (built-in) colorschemes are listed in the `schemes` array.

To use one of the built-in colorschemes, use the symbol:

    julia> ColorSchemes.picasso

or you can import it:

    julia> import ColorSchemes.pigeon
    julia> pigeon

## Functions:

    extract(file)
        - extract a new colorscheme from an image file, return a colorscheme
    extract_weighted_colors(file, n=10, i=10, tolerance=0.01; shrink = 2))
        - return a colorscheme and weights for each entry
    get(cscheme, n)
        - return a single color from a color scheme based on location of n (0-1) in cscheme
    colorscheme_weighted(cscheme, weights)
        - return a weighted colorscheme, given a colorscheme and an array of weights for each entry
    colorscheme_to_image(cscheme, m, h)
        - make an image of a scheme by repeating each color m times in h rows
    image_to_swatch(imagefilepath, samples, destinationpath)
        - extract a colorscheme and save it as a swatch PNG in the destination file
    savecolorscheme(cscheme, filename, comment)
        - save a colorscheme in the file with an optional comment
    schemes
        - an array of names of all the loaded schemes
    sortcolorscheme(cscheme)
        - sort a colorscheme
"""

module ColorSchemes

using Images, Colors, Clustering, FileIO

const schemes = Symbol[]

"load variable and values, and add variable to list at the same time"
macro reg(vname, args)
    quote
        $(esc(push!(schemes, vname)))
        $(esc(vname)) = $(args)
    end
end

# load the installed schemes
include(dirname(@__FILE__) * "/../data/allcolorschemes.jl")
include(dirname(@__FILE__) * "/../data/colorbrewerschemes.jl")

# the `schemes` array now contains the names of the readymade ColorSchemes

export
    colorscheme_to_image,
    colorscheme_weighted,
    extract_weighted_colors,
    extract,
    get,
    image_to_swatch,
    savecolorscheme,
    schemes,
    sortcolorscheme

# convert a value between oldmin/oldmax to equivalent value between newmin/newmax

remap(value, oldmin, oldmax, newmin, newmax) = ((value - oldmin) / (oldmax - oldmin)) * (newmax - newmin) + newmin

"""
    extract(imfile, n=10, i=10, tolerance=0.01; shrink=n)

`extract()` extracts the most common colors from an image from the image file `imfile` by
finding `n` dominant colors, using `i` iterations. You can (and probably should) shrink larger images before
running this function.

Returns a colorscheme (an array of colors)
"""

function extract(imfile, n=10, i=10, tolerance=0.01; kwargs...)
    return extract_weighted_colors(imfile, n, i, tolerance; kwargs...)[1] # throw away the weights
end

"""
    extract_weighted_colors(imfile, n=10, i=10, tolerance=0.01; shrink = 2)

Extract colors and weights of the clusters of colors in an image file.

Example:

    pal, wts = extract_weighted_colors(imfile, n, i, tolerance; shrink = 2)
"""

function extract_weighted_colors(imfile, n=10, i=10, tolerance=0.01; shrink = 2)
    img = load(imfile)
    w, h = size(img)
    neww = round(Int, w/shrink)
    newh = round(Int, h/shrink)
    smaller_image = Images.imresize(img, (neww, newh))
    imdata = convert(Array{Float64}, raw(separate(smaller_image).data))/256
    w, h, numchannels = size(imdata)
    d = transpose(reshape(imdata, w*h, numchannels))
    R = kmeans(d, n, maxiter=i, tol=tolerance)
    colscheme = RGB{Float64}[]
    for i in 1:numchannels:length(R.centers)
        push!(colscheme, RGB(R.centers[i], R.centers[i+1], R.centers[i+2]))
    end
    return colscheme, R.cweights/sum(R.cweights)
end

"""
    colorscheme_weighted(colorscheme, weights, length)

Returns a new colorscheme of length `length` (default 50) where the proportion of each color
in `colorscheme` is represented by the associated weight of each entry.

Examples:

    colorscheme_weighted(extract_weighted_colors("hokusai.jpg")...)
    colorscheme_weighted(extract_weighted_colors("filename00000001.jpg")..., 500)
"""
function colorscheme_weighted{C<:Colorant}(cscheme::Vector{C}, weights, l = 50)
    iweights = map(n -> convert(Integer, round(n * l)), weights)
    #   adjust highest or lowest so that length of result is exact
    while sum(iweights) < l
        val,ix = findmin(iweights)
        iweights[ix]=val+1
    end
    while sum(iweights) > l
        val,ix = findmax(iweights)
        iweights[ix]=val-1
    end
    a = Array(RGB{Float64},0)
    for n in 1:length(cscheme)
        a = vcat(a, repmat([cscheme[n]], iweights[n]))
    end
    return a
end

"""
    compare_colors(color_a, color_b, field = :l)

Compare two colors, using the Luv colorspace. `field` defaults to luminance `:l` but could be `:u`
or `:v`.
"""
function compare_colors(color_a, color_b, field = :l)
    if 1 < color_a.r < 255
        fac = 255
    else
        fac = 1
    end
    luv1 = convert(Luv, RGB{U8}(color_a.r/fac, color_a.g/fac, color_a.b/fac))
    luv2 = convert(Luv, RGB{U8}(color_b.r/fac, color_b.g/fac, color_b.b/fac))
    return getfield(luv1, field) < getfield(luv2, field)
end

"""
    sortcolorscheme(colorscheme, field; kwargs...)

Sort a colorscheme using the Luv colorspace, defaults to luminance `:l` but could be `:u` or `:v`.
"""
function sortcolorscheme{C<:Colorant}(colorscheme::Vector{C}, field = :l; kwargs...)
    sort(colorscheme, lt = (x,y) -> compare_colors(x, y, field); kwargs...)
end

# obsolete in colorschemes0.6
function readcolorscheme(cs::AbstractString)
    error("this function is no longer useful in version >= 0.6")
    if isfile(cs)
        inputfilename = cs
    else # not found
        inputfilename = ""
    end
    temp = ColorTypes.RGB{Float64}[]
    if ! isempty(inputfilename)
        try
            colorschemefile = open(inputfilename)
            for ln in eachline(colorschemefile)
                if startswith(ln, "#") # comment lines...
                    # println(chomp(ln))
                elseif isempty(chomp(ln))
                    # empty line
                else
                    (r, g, b) = map(parse, split(ln, "\t"))
                    push!(temp, RGB(r, g, b))
                end
            end
            close(colorschemefile)
        catch err
            error("$err trying to read colorscheme file $inputfilename")
        end
    end
    if length(temp) == 0
        warn("empty color scheme")
    end
    return temp
end

import Base.get
"""
    get(cscheme, x)

Find the nearest color in `cscheme` corresponding to a point `x` between 0 and 1)

Returns a single color.
"""
function get{C<:Colorant}(cscheme::Vector{C}, x)
    x = clamp(x, 0.0, 1.0)
    before_fp = remap(x, 0.0, 1.0, 1, length(cscheme))
    before = convert(Int, round(before_fp, RoundDown))
    after =  min(before + 1, length(cscheme))
    # blend between the two colors adjacent to the point
    cpt = before_fp - before
    return weighted_color_mean(1 - cpt, cscheme[before], cscheme[after])
end

"""
    savecolorscheme(cscheme, filename, comment)

Write a colorscheme to a file.

Example:

    savecolorscheme(
        extract("/tmp/1920px-Great_Wave_off_Kanagawa2.jpg"),
            "/tmp/hok.txt",
            "Hokusai Great Wave")

To read a text file in and register it in `schemes`, you can try the `@reg` macro:

    ColorSchemes.@reg monalisa include("/tmp/mona.txt")
"""
function savecolorscheme{C<:Colorant}(cs::Vector{C}, file::AbstractString, comment="comment")
    fhandle = open(file, "w")
    write(fhandle, string("# ", comment, "\n"))
    write(fhandle, string("# created $(now())\n"))
    write(fhandle, string("[\n", join(cs, ",\n"), "\n]"))
    close(fhandle)
end

# deprecated in colorschemes 0.6
function list()
    # read all filenames from directory
    files = filter(f -> ismatch(Regex("^[a-z]+\.txt"), f), readdir(Pkg.dir("ColorSchemes", "data")))
    schemelist = String[]
    for i in files
        i_less = replace(i, ".txt", "")
        push!(schemelist, i_less)
    end
    return schemelist
end

"""
    colorscheme_to_image(cs, m, h)

Make an image from a colorscheme as an image by repeating each color `m` times in `h` rows.

Examples:

    using FileIO

    img = colorscheme_to_image(ColorSchemes.leonardo, 50, 200)
    save("/tmp/cs_image.png", img)

    save("/tmp/blackbody.png", colorscheme_to_image(blackbody, 100, 100))

"""
function colorscheme_to_image{C<:Colorant}(cs::Vector{C}, m, h)
    a = Array(ColorTypes.RGB{Float64}, m, h)
    fill!(a, cs[1]) # first color goes here
    for n in 2:length(cs) # rest here
        a = vcat(a, repmat([cs[n]], m, h))
    end
    return Image(a)
end

"""
    image_to_swatch(imagefilepath, samples, destinationpath)

Extract a colorscheme from the image in `imagefilepath` to a swatch image PNG in `destinationpath`.

    image_to_swatch("doc/monalisa.jpg", 50, "/tmp/monalisaswatch")
"""
function image_to_swatch(imagefilepath, samples, destinationpath)
    temp = sortcolorscheme(extract(imagefilepath, samples))
    savecolorscheme(temp, string(destinationpath, ".txt"), string(" $(samples) from $(imagefilepath)"))
    schemename = include(string(destinationpath, ".txt"))
    img = colorscheme_to_image(schemename, 50, 200)
    imageoutfilepath = string(destinationpath, ".png")
    save(imageoutfilepath, img)
end

end
