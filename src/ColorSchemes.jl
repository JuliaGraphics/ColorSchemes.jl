#!/usr/bin/env julia

VERSION >= v"0.4.0" && __precompile__()

"""
A colorscheme is an array of colors.

    using ColorSchemes, Colors

    extract(file)
        - extract a new colorscheme from image file, return colorscheme
    extract_weighted_colors(file, n=10, i=10, tolerance=0.01; shrink = 1))
        - return a colorscheme and weights for each entry
    loadcolorscheme("name")
        - load a predefined colorscheme from file (see ../data)
    colorscheme(cscheme, n)
        - return a single color from a color scheme based on location of n (0-1) in scheme
    sortcolorscheme(cscheme)
        - sort a colorscheme
    colorscheme_weighted(cscheme, weights)
        - return a weighted colorscheme, given a colorscheme and weights for each entry
    make_colorschemefile(newschemename, cscheme)
        - make a colorscheme file
"""

module ColorSchemes

using Images, Colors, Clustering

export extract, colorscheme,
    loadcolorscheme, sortcolorscheme,
    colorscheme_weighted,
    make_colorschemefile,
    extract_weighted_colors

# convert a value between oldmin/oldmax to equivalent value between newmin/newmax

remap(value, oldmin, oldmax, newmin, newmax) = ((value - oldmin) / (oldmax - oldmin)) * (newmax - newmin) + newmin

"""
extract() extracts the most common colors from an image from imagefile by
finding `n` dominant colors, using i iterations. You can shrink image before
clustering.

    extract(imfile, n=10, i=10, tolerance=0.01; shrink=n)

returns a colorscheme (an array of colors)
"""

function extract(imfile, n=10, i=10, tolerance=0.01; kwargs...)
    # throw away the weights
    return extract_weighted_colors(imfile, n, i, tolerance; kwargs...)[1]
end

"""
    extract colors and weights of the clusters of colors in an image file

    extract_weighted_colors(imfile, n=10, i=10, tolerance=0.01; shrink = 1)

    pal, wts = extract_weighted_colors(imfile, n, i, tolerance; shrink = 1)
"""

function extract_weighted_colors(imfile, n=10, i=10, tolerance=0.01; shrink = 1)
    img = imread(imfile)
    w, h = size(img)
    neww = round(Int, w/shrink)
    newh = round(Int, w/shrink)
    smaller_image = Images.imresize(img, (neww, newh))
    imdata = convert(Array{Float64}, raw(separate(smaller_image).data))/256
    w, h, nchannels = size(imdata)
    d = transpose(reshape(imdata, w*h, nchannels))
    R = kmeans(d, n, maxiter=i, tol=tolerance)
    colscheme = RGB{Float64}[]
    for i in 1:nchannels:length(R.centers)
        push!(colscheme, RGB(R.centers[i], R.centers[i+1], R.centers[i+2]))
    end
    return colscheme, R.cweights/sum(R.cweights)
end

"""
    colorscheme_weighted(colorscheme, weights, l)

returns a colorscheme of length l where the proportion of each color is represented by the weight of each entry

    colorscheme_weighted(extract_weighted_colors("hokusai.jpg")...)
"""

function colorscheme_weighted(cscheme, weights, l = 750)
    iweights = map(n -> convert(Integer, round(n * l)), weights)
    a = Array(RGB{Float64},0)
    for n in 1:length(cscheme)
        a = vcat(a, repmat([cscheme[n]], iweights[n]))
    end
    return a
end

"""
Compare two colors, using Luv - field defaults to :l but could be :u or :v
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
Sort a colorscheme using a Luv field, defaults to :l
"""

function sortcolorscheme(colorscheme, field = :l; kwargs...)
    sort(colorscheme, lt = (x,y) -> compare_colors(x, y, field); kwargs...)
end

"""
Load a named colorscheme from a file. (Files don't have suffixes?)

    loadcolorscheme("leonardo")
    loadcolorscheme("dali")
    loadcolorscheme("/Users/me/julia/hokusai")

loads a colorscheme from ../data or current directory
"""

function loadcolorscheme(cs::AbstractString)
    if isfile(Pkg.dir("ColorSchemes", "data", cs))
        include(Pkg.dir("ColorSchemes", "data", cs))
    elseif isfile(cs)
        include(cs)
    elseif isfile(cs * ".jl")
        include(cs * ".jl")
    end
end

"""
colorscheme(cscheme, x)

find a color in scheme corresponding to point x (between 0 and 1)

returns a single color
"""

function colorscheme(cscheme::AbstractVector, x)
    x = clamp(x, 0, 1) # must be between 0 and 1
    before_fp = remap(x, 0.0, 1.0, 1, length(cscheme))
    before = convert(Int, round(before_fp, RoundDown))
    after =  min(before + 1, length(cscheme))
    # blend between the two colors adjacent to the point
    cpt = before_fp - before
    return weighted_color_mean(1 - cpt, cscheme[before], cscheme[after])
end

"""
make_colorschemefile(newschemename, cscheme)

write a colorscheme to a file

    make_colorschemefile("hokusai_1", extract("/tmp/1920px-Great_Wave_off_Kanagawa2.jpg"))

newschemename should be valid Julia variable name...
"""

function make_colorschemefile(cschemename, cscheme)
    cschemefile = open("$(cschemename)", "w")
    write(cschemefile, "const $(cschemename) = [")
    for (i, p) in enumerate(cscheme)
        write(cschemefile, "$(p),")
    end
    write(cschemefile, "]")
    close(cschemefile)
end

end
