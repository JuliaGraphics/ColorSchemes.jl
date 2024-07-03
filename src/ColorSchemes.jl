"""
The ColorSchemes module provides simple access to color schemes (arrays of colors).

Use `get(cscheme, n)` with n varying from 0 to 1 to find a color at that point
in the color scheme `cscheme`, where 0 is the leftmost color, and 1 the rightmost.

Access the scheme's colors directly using `cscheme.colors`.

See also `getinverse()`.
"""
module ColorSchemes

import Base.get, Base.reverse, Base.*

using Colors, ColorTypes, FixedPointNumbers
import ColorVectorSpace

export ColorScheme,
       get,
       getinverse,
       colorschemes,
       loadcolorscheme,
       findcolorscheme,
       ColorSchemeCategory,
       ColourScheme,
       colourschemes,
       loadcolourscheme,
       findcolourscheme,
       ColourSchemeCategory

"""
    ColorScheme(colors, category, notes)

Create a ColorScheme from an array of colors. You can also name it, assign a
category to it, and add notes.

```julia
myscheme = ColorScheme([Colors.RGB(0.0, 0.0, 0.0), Colors.RGB(1.0, 1.0, 1.0)],
    "custom", "twotone, black and white")
```

"""
struct ColorScheme{V <: AbstractVector{<:Colorant},S1 <: AbstractString,S2 <: AbstractString}
    colors::V
    category::S1
    notes::S2
end

ColorScheme(colors::V, category::S1 = "", notes::S2 = "") where {V,S1,S2} =
    ColorScheme{V,S1,S2}(colors, category, notes)

# displaying swatches
Base.show(io::IO, m::MIME"image/svg+xml", cscheme::ColorScheme) = show(io, m, cscheme.colors)

# for making the catalogue pages in the docs
struct ColorSchemeCategory
    name :: String
end

Base.getindex(cs::ColorScheme, i::AbstractFloat) = get(cs, i)
Base.getindex(cs::ColorScheme, i::AbstractVector{<: AbstractFloat}) = get(cs, i)

"""
    loadcolorscheme(vname, colors, cat="", notes="")

Define a ColorScheme from a symbol and an array of colors,
and add it to the `colorschemes` dictionary. Optionally
specify a category and some notes.

### Example

This is an example (from `ColorsSchemes/data/flags.jl`) of how the supplied colorschemes are
loaded into the ColorSchemes dictionary.

```julia
loadcolorscheme(:flag_nu, [
        RGB(0.7843137254901961, 0.06274509803921569, 0.1803921568627451),
        RGB(0.00392156862745098, 0.12941176470588237, 0.4117647058823529),
        RGB(1.0, 1.0, 1.0),
        RGB(0.996078431372549, 0.8666666666666667, 0.0),
    ], "flags", "The flag of Niue")
```
"""
function loadcolorscheme(vname, colors, cat = "", notes = "")
    haskey(colorschemes, vname) && println("$vname overwritten")
    colorschemes[vname] = ColorSchemes.ColorScheme(colors, cat, notes)
    return colorschemes[vname]
end

"""
    colorschemes

An exported dictionary of pre-defined colorschemes:

```julia
colorschemes[:summer] |> show
   ColorScheme(
      ColorTypes.RGB{Float64}[
          RGB{Float64}(0.0,0.5,0.4), RGB{Float64}(0.01,0.505,0.4), RGB{Float64}(0.02,0.51,0.4), RGB{Float64}(0.03,0.515,0.4),
          ...
```

To choose a random ColorScheme:

```julia
scheme = rand(keys(colorschemes))
```

"""
const colorschemes = Dict{Symbol,ColorScheme}()

function loadallschemes()
    # load the installed schemes
    datadir = joinpath(dirname(@__DIR__), "data")
    include(joinpath(datadir, "allcolorschemes.jl"))
    include(joinpath(datadir, "colorbrewerschemes.jl"))
    include(joinpath(datadir, "matplotlib.jl"))
    include(joinpath(datadir, "cmocean.jl"))
    include(joinpath(datadir, "sampledcolorschemes.jl"))
    include(joinpath(datadir, "gnu.jl"))
    include(joinpath(datadir, "colorcetdata.jl"))
    include(joinpath(datadir, "scicolor.jl"))
    include(joinpath(datadir, "seaborn.jl"))
    include(joinpath(datadir, "tableau.jl"))
    include(joinpath(datadir, "cvd.jl"))
    include(joinpath(datadir, "flags.jl"))
    include(joinpath(datadir, "websafe.jl"))
    include(joinpath(datadir, "metbrewer.jl"))
    include(joinpath(datadir, "jcolors.jl"))
    include(joinpath(datadir, "nord.jl"))
    include(joinpath(datadir, "fastie.jl"))
    include(joinpath(datadir, "kindlmann.jl"))
    include(joinpath(datadir, "pnw.jl"))
    include(joinpath(datadir, "wesanderson.jl"))
    include(joinpath(datadir, "ghibli.jl"))
    include(joinpath(datadir, "feathers.jl"))
    include(joinpath(datadir, "progress.jl"))

    # create them as constants...
    for key in keys(colorschemes)
        @eval const $key = colorschemes[$(QuoteNode(key))]
    end
end

loadallschemes()

"""
    findcolorscheme(str;
        search_notes=true)

Find all colorschemes matching `str`. `str` is interpreted
as a regular expression (case-insensitive).

This returns an array of symbols which are the names of
matching schemes in the `colorschemes` dictionary.

```julia
julia> findcolorscheme("ice")

colorschemes containing "ice"

  seaborn_icefire_gradient
  seaborn_icefire_gradient  (notes) sequential, ice fire gradient...
  ice
  flag_is               (notes) The flag of Iceland...
  botticelli
  botticelli            (notes) palette from artist Sandro Bot...


 ...found 6 results for "ice"
```

To read the notes of a built-in colorscheme `cscheme`:

```julia
colorschemes[:cscheme].notes
```
"""
function findcolorscheme(str;
    search_notes = true)
    println("\ncolorschemes containing \"$str\"\n")
    counter = 0
    found   = Symbol[]
    for (k, v) in colorschemes
        if occursin(Regex(str, "i"), string(k))
            # found in name
            printstyled("  $(rpad(k, 20))\n", bold = true)
            counter += 1
            push!(found, k)
        elseif occursin(Regex(str, "i"), string(v.category))
            # found in category
            printstyled("  $(rpad(k, 20))", bold = true)
            println(" (category) $(v.category)")
            counter += 1
            push!(found, k)
        end
        if occursin(Regex(str, "i"), string(v.notes)) && search_notes == true
            # found in notes
            # avoid duplication
            if k ∉ found
                printstyled("  $(rpad(k, 20))", bold = true)
                l = min(30, length(v.notes))
                println("  (notes) $(v.notes[1:l])...")
                counter += 1
                push!(found, k)
            end
        end
    end
    if counter > 0
        println("\n\n ...found $counter result$(counter > 1 ? "s" : "") for \"$str\"")
    else
        println("\n\n ...nothing found for \"$str\"")
    end
    return found
end

# Interfaces
Base.length(cscheme::ColorScheme) = length(cscheme.colors)
Base.getindex(cscheme::ColorScheme, I) = cscheme.colors[I]
Base.size(cscheme::ColorScheme) = length(cscheme.colors)
Base.IndexStyle(::Type{<:ColorScheme}) = IndexLinear()

# iterable
function Base.iterate(cscheme::ColorScheme)
    if length(cscheme.colors) == 0
        return nothing
    end
    return (first(cscheme.colors), 1)
end

function Base.iterate(cscheme::ColorScheme, state)
    if state >= length(cscheme.colors)
        return nothing
    else
        return (cscheme.colors[state + 1], state + 1)
    end
end

Base.firstindex(cscheme::ColorScheme) = firstindex(cscheme.colors)
Base.lastindex(cscheme::ColorScheme) = lastindex(cscheme.colors)

# utility lerping function to convert a value between oldmin/oldmax to equivalent value between newmin/newmax
remap(value, oldmin, oldmax, newmin, newmax) =
    ((value .- oldmin) ./ (oldmax .- oldmin)) .* (newmax .- newmin) .+ newmin

const AllowedInput = Union{<:Real,AbstractArray{<:Real}}

defaultrange(x::Real) = zero(x), oneunit(x)
defaultrange(x::AbstractArray) = zero(eltype(x)), oneunit(eltype(x))

"""
    get(cscheme::ColorScheme, inData :: Array{Number, 2}, rangescale=:clamp)
    get(cscheme::ColorScheme, inData :: Array{Number, 2}, rangescale=(minVal, maxVal))

Return an RGB array of colors generated by applying the
colorscheme to the 2D input data.

If `rangescale` is `:clamp` the colorscheme is applied to
values between 0.0-1.0, and values outside this range get
clamped to the ends of the colorscheme.

If `rangescale` is `:extrema`, the colorscheme is
applied to the range `minimum(indata)..maximum(indata)`.

Else, if `rangescale` is `:centered`, the colorscheme is
applied to the range `-maximum(abs, indata)..maximum(abs, indata)`.

TODO: this function expects the colorscheme to consist of
RGB [0.0-1.0] values. It should work with more colortypes.

# Examples

```julia
img = get(colorschemes[:leonardo], rand(10,10)) # displays in Juno Plots window, but
save("testoutput.png", img)      # you'll need FileIO or similar to do this

img2 = get(colorschemes[:leonardo], 10.0 * rand(10, 10), :extrema)
img3 = get(colorschemes[:leonardo], 10.0 * rand(10, 10), (1.0, 9.0))

# Also works with PerceptualColourMaps
using PerceptualColourMaps # warning, installs PyPlot, PyCall, LaTeXStrings
img4 = get(PerceptualColourMaps.cmap("R1"), rand(10,10))
```
"""
function get(cscheme::ColorScheme, x::AllowedInput, rangemode::Symbol)
    rangescale = if rangemode === :clamp
        defaultrange(x)
    elseif rangemode === :extrema
        extrema(x)
    elseif rangemode === :centered
        (-1, 1) .* maximum(abs, x)
    else
        throw(ArgumentError("rangescale :$rangemode not supported, should be :clamp, :extrema, :centered or tuple (minVal, maxVal)"))
    end
    return get(cscheme, x, rangescale)
end

# optimized get(colorscheme, data) function #91 stevengj
# faster weighted_color_mean that assumes w ∈ [0,1] and
# exploits ColorVectorSpace operations for RGB and Gray types.
fast_weighted_color_mean(w::Real, c1, c2) = Colors.weighted_color_mean(w, c1, c2)
fast_weighted_color_mean(w::Real, c1::ColorVectorSpace.MathTypes, c2::ColorVectorSpace.MathTypes) = w*c1 + (1-w)*c2

function get(cscheme::ColorScheme, X::AllowedInput, rangescale::NTuple{2, <:Real} = defaultrange(X))
    rangemin, rangemax = !iszero(rangescale[2] - rangescale[1]) ?
                         rangescale : (zero(rangescale[1]), oneunit(rangescale[2]))
    scaleby = (length(cscheme) - 1) / (rangemax - rangemin)
    return map(X) do x
        xclamp = clamp(x, rangemin, rangemax)
        before_fp = (xclamp - rangemin) * scaleby + 1
        before = round(Int, before_fp, RoundDown)
        after = min(before + 1, length(cscheme))
        cpt = before_fp - before
        #  blend between the two colors adjacent to the point
        @inbounds fast_weighted_color_mean(1 - cpt, cscheme.colors[before], cscheme.colors[after])
    end
end

# Boolean just takes the start and end values of the scheme. Also avoid using a branch.
function get(cscheme::ColorScheme, x::Union{Bool, AbstractArray{Bool}})
    i = x .* (length(cscheme) .- 1) .+ 1
    return getindex.(Ref(cscheme.colors), i)
end

"""
    get(cs::ColorScheme, g::Color{T,1} where T<:Union{Bool, AbstractFloat, FixedPoint})

Return the color in `cs` that corresponds to the gray value `g`.
"""
function get(cs::ColorScheme, g::Color{T, 1} where {T <: Union{Bool, AbstractFloat, FixedPoint}})
    return get(cs, ColorTypes.gray(g)) # don't confuse with the 'grays' colorscheme
end

"""
    getinverse(cscheme::ColorScheme, c, range=(0.0, 1.0))

Computes where the provided Color `c` would fit in `cscheme`.

This is the inverse of `get()` — it returns the value `x` in the provided `range`
for which `get(scheme, x)` would most closely match the provided Color `c`.

# Examples

The first example asks: "where in the `leonardo` colorscheme will I find the nearest
color to red?":

```julia
julia> getinverse(colorschemes[:leonardo], RGB(1, 0, 0))
0.6248997995654847

julia> getinverse(ColorScheme([Colors.RGB(0,0,0), Colors.RGB(1,1,1)]),  Colors.RGB(.5,.5,.5))
0.5432555858022048

julia> cs = ColorScheme(range(Colors.RGB(0,0,0), stop=Colors.RGB(1,1,1), length=5))

julia> getinverse(cs, cs[3])
0.5
```
"""
function getinverse(cscheme::ColorScheme, c, rangescale::Tuple{Number, Number} = (0.0, 1.0))
    # TODO better error handling please
    length(cscheme) <= 1 && throw(ErrorException("ColorScheme of length $(length(cscheme)) is not long enough"))
    cdiffs = map(c_i -> colordiff(promote(c, c_i)...), cscheme.colors)
    closest = argmin(cdiffs)
    left = right = 0
    if closest == 1
        left = closest
        right = closest + 1
    elseif closest == length(cscheme)
        left = closest - 1
        right = closest
    else
        next_closest = cdiffs[closest - 1] < cdiffs[closest + 1] ? closest - 1 : closest + 1
        left = min(closest, next_closest)
        right = max(closest, next_closest)
    end
    v = left
    if cdiffs[left] != cdiffs[right] # prevents divide by zero
        v += (cdiffs[left] / (cdiffs[left] + cdiffs[right]))
    end
    return remap(v, 1, length(cscheme), rangescale...)
end

"""
    reverse(cscheme)

Make a new ColorScheme with the same colors as `cscheme` but in reverse order.
"""
Base.reverse(cscheme::ColorScheme) =
    ColorScheme(reverse(cscheme.colors), cscheme.category, cscheme.notes)

"""
    *(cscheme1, cscheme2)
    cscheme1 * cscheme2

Create new colorscheme by concatenating two colorschemes.
"""
*(cscheme1::ColorScheme, cscheme2::ColorScheme) = ColorScheme(vcat(cscheme1.colors, cscheme2.colors))

include("precompile.jl")

# Aliases - Oxford spelling       
const ColourScheme = ColorScheme
const colourschemes = colorschemes
const loadcolourscheme = loadcolorscheme
const findcolourscheme = findcolorscheme
const ColourSchemeCategory = ColorSchemeCategory

end
