#!/usr/bin/env julia

VERSION >= v"0.4.0" && __precompile__()

"""
A colorscheme is an array of colors.

To use:

    using ColorSchemes, Colors

and

    using Images, FileIO

if you want image input and output.

Functions:

    extract(file)
        - extract a new colorscheme from an image file, return colorscheme
    extract_weighted_colors(file, n=10, i=10, tolerance=0.01; shrink = 1))
        - return a colorscheme and weights for each entry
    loadcolorscheme("name")
        - load a predefined colorscheme from file (see the ../data directory)
    colorscheme(cscheme, n)
        - return a single color from a color scheme based on location of n (0-1) in cscheme
    sortcolorscheme(cscheme)
        - sort a colorscheme
    colorscheme_weighted(cscheme, weights)
        - return a weighted colorscheme, given a colorscheme and an array of weights for each entry
    savecolorscheme(cscheme, filename, comment)
        - save a colorscheme in the file with an optional comment
    colorscheme_to_image(cscheme, m, h)
        - save colorscheme as image by repeating each color m times in h rows
    list()
        - return array of available colorschemes in ../data
"""

module ColorSchemes

using Images, Colors, Clustering, FileIO

export extract,
    colorscheme,
    loadcolorscheme,
    savecolorscheme,
    sortcolorscheme,
    colorscheme_weighted,
    extract_weighted_colors,
    list,
    colorscheme_to_image

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
    return extract_weighted_colors(imfile, n, i, tolerance; kwargs...)[1] # throw away the weights
end

"""
    extract colors and weights of the clusters of colors in an image file

    extract_weighted_colors(imfile, n=10, i=10, tolerance=0.01; shrink = 1)

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

    returns a new colorscheme of length `length` (default 50) where the proportion of each color in `colorscheme` is represented by the associated weight of each entry

    eg:

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
Compare two colors, using Luv - field defaults to luminance :l but could be :u or :v
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
    Sort a colorscheme using a Luv field, defaults to luminance :l but could be :u or :v

    sortcolorscheme(colorscheme, field; kwargs...)
"""

function sortcolorscheme(colorscheme, field = :l; kwargs...)
    sort(colorscheme, lt = (x,y) -> compare_colors(x, y, field); kwargs...)
end

"""
Load a named colorscheme from a file.

    leo  = loadcolorscheme("leonardo.txt")
    leo  = loadcolorscheme("leonardo")
    dali = loadcolorscheme("my_dali.txt")
    hok  = loadcolorscheme("/Users/me/julia/hokusai")

loads a colorscheme from ../data or the current directory or the named directory

"""

function loadcolorscheme(cs::AbstractString)
    # look in data directory with ".txt"
    if isfile(Pkg.dir("ColorSchemes", "data", cs * ".txt"))
        filename = Pkg.dir("ColorSchemes", "data", cs * ".txt")
    # perhaps without suffix?
    elseif isfile(Pkg.dir("ColorSchemes", "data", cs))
        filename = Pkg.dir("ColorSchemes", "data", cs)
    # or look in current directory with ".txt" suffix
    elseif isfile(cs * ".txt")
        filename = cs * ".txt"
    elseif isfile(cs)
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
colorscheme(cscheme, x)

find the nearest color in `cscheme` corresponding to a point `x` between 0 and 1)

returns a single color
"""

function colorscheme(cscheme::AbstractVector, x)
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

write a colorscheme to a file

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

"""
read available color schemes in Pkg.dir("ColorSchemes", "data") and
return an array of strings
"""

function list()
           # read all filenames from directory
           schemes = AbstractString[]
           files = filter(f -> ismatch(Regex("^[a-z]+\.txt"), f), readdir(Pkg.dir("ColorSchemes", "data")))
           for i in files
               i_less = replace(i, ".txt", "")
               push!(schemes, i_less)
           end
           return schemes
       end
"""

save a colorscheme as an image by repeating each color m times in h rows

    leo = loadcolorscheme("leonardo.txt")
    img = colorscheme_to_image(leo, 50, 200)
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
