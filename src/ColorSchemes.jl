#!/usr/bin/env julia

__precompile__()

"""
A colorscheme is an array of colors.

To use:

    using ColorSchemes, Colors

and, if you want image input and output, perhaps:

    using Images, FileIO

The names of the registered (built-in) colorschemes are listed in the `schemes` array.

To use one of the built-in colorschemes, use the symbol:

    julia> ColorSchemes.picasso
    32-element Array{ColorTypes.RGB{Float64},1}:
     RGB{Float64}(0.126202,0.0643898,0.0299272)
     RGB{Float64}(0.170828,0.0962327,0.107606)
     ...
     RGB{Float64}(0.916402,0.893214,0.264582)
     RGB{Float64}(0.913858,0.894725,0.474638)
     RGB{Float64}(0.888974,0.881089,0.882728)

or you can import any that you want:

    julia> import ColorSchemes.pigeon

    julia> pigeon
    6-element Array{ColorTypes.RGB{Float64},1}:
    RGB{Float64}(0.195819,0.174945,0.218631)
    RGB{Float64}(0.316089,0.333408,0.367098)
    RGB{Float64}(0.390402,0.464561,0.429587)
    RGB{Float64}(0.600788,0.611074,0.601862)
    RGB{Float64}(0.860933,0.776316,0.843276)
    RGB{Float64}(1.0,1.0,1.0)

Functions:

    extract(file)
        - extract a new colorscheme from an image file, return a colorscheme
    extract_weighted_colors(file, n=10, i=10, tolerance=0.01; shrink = 1))
        - return a colorscheme and weights for each entry
    colorscheme_weighted(cscheme, weights)
        - return a weighted colorscheme, given a colorscheme and an array of weights for each entry
    colorscheme_to_image(cscheme, m, h)
        - make an image of a scheme by repeating each color m times in h rows
    savecolorscheme(cscheme, filename, comment)
        - save a colorscheme in the file with an optional comment
    sample(cscheme, n)
        - return a single color from a color scheme based on location of n (0-1) in cscheme
    sortcolorscheme(cscheme)
        - sort a colorscheme
"""

module ColorSchemes

using Images, Colors, Clustering, FileIO

const schemes = Symbol[]

macro reg(vname, args)
    quote
        $(esc(push!(schemes, vname)))
        $(esc(vname)) = $(args)
    end
end

# load the installed schemes
include(dirname(@__FILE__) * "/../data/allcolorschemes.jl")
include(dirname(@__FILE__) * "/../data/colorbrewerschemes.jl")

# the `schemes` variable now contains the names of the readymade ColorSchemes

export extract,
    sample,
    loadcolorscheme,
    savecolorscheme,
    sortcolorscheme,
    colorscheme_weighted,
    extract_weighted_colors,
    colorscheme_to_image,
    schemes

# convert a value between oldmin/oldmax to equivalent value between newmin/newmax

remap(value, oldmin, oldmax, newmin, newmax) = ((value - oldmin) / (oldmax - oldmin)) * (newmax - newmin) + newmin

"""
    extract(imfile, n=10, i=10, tolerance=0.01; shrink=n)

extract() extracts the most common colors from an image from imagefile by
finding `n` dominant colors, using i iterations. You can shrink image before
clustering.

Returns a colorscheme (an array of colors)
"""

function extract(imfile, n=10, i=10, tolerance=0.01; kwargs...)
    return extract_weighted_colors(imfile, n, i, tolerance; kwargs...)[1] # throw away the weights
end

"""
    extract_weighted_colors(imfile, n=10, i=10, tolerance=0.01; shrink = 1)

Extract colors and weights of the clusters of colors in an image file

Example:

    pal, wts = extract_weighted_colors(imfile, n, i, tolerance; shrink = 1)
"""

function extract_weighted_colors(imfile, n=10, i=10, tolerance=0.01; shrink = 1)
    img = load(imfile)
    w, h = size(img)
    neww = round(Int, w/shrink)
    newh = round(Int, w/shrink)
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
function colorscheme_weighted(cscheme, weights, l = 50)
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

Compare two colors, using Luv colors. `field` defaults to luminance `:l` but could be `:u`
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

Sort a colorscheme using Luv colors, defaults to luminance `:l` but could be `:u` or `:v`.
"""
function sortcolorscheme(colorscheme, field = :l; kwargs...)
    sort(colorscheme, lt = (x,y) -> compare_colors(x, y, field); kwargs...)
end

# obsolete in colorschemes0.6
function readcolorscheme(cs::AbstractString)
    if isfile(cs)
        filename = cs
    else # not found
        filename = ""
    end
    temp = ColorTypes.RGB{Float64}[]
    if ! isempty(filename)
        try
            colorschemefile = open(filename)
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
            println("$err trying to read colorscheme file $filename")
        end
    end
    if length(temp) == 0
        warn("empty color scheme")
    end
    return temp
end

"""
    sample(cscheme, x)

Find the nearest color in `cscheme` corresponding to a point `x` between 0 and 1)

Returns a single color.
"""
function sample(cscheme::AbstractVector, x)
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

"""
function savecolorscheme(cs, file::AbstractString, comment="comment")
    fhandle = open(file, "w")
    write(fhandle, string("# ", comment, "\n"))
    write(fhandle, string("# created $(now())\n"))
    for each_color in cs
        write(fhandle, string(each_color.r, "\t", each_color.g, "\t", each_color.b, "\n"))
    end
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

Example:

    img = colorscheme_to_image(ColorSchemes.leonardo, 50, 200)
    save("/tmp/cs_image.png", img)
"""
function colorscheme_to_image(cs, m, h)
    a = Array(ColorTypes.RGB{Float64}, m, h)
    fill!(a, cs[1]) # first color goes here
    for n in 2:length(cs) # rest here
        a = vcat(a, repmat([cs[n]], m, h))
    end
    return Image(a)
end

end
