#!/usr/bin/env julia

# generate pictures of builtin data
# usage: julia draw-swatches.jl > somewhere/colorschemes.svg

using Colors, ColorSchemes, Luxor

"convert color to grayscale using luminance value"

function grayify(col)
    luv = convert(Luv, RGB{U8}(col.r, col.g, col.b))
    t = rescale(luv.l, 0, 100, 0, 1)
    return (t, t, t)
end

function draw_swatch(cschemename, pos, tilewidth, tileheight)
    cschemevalues = eval(ColorSchemes, cschemename)
    schemelength = length(cschemevalues)

    gsave()
    translate(pos)

    # do a single pane, to get margins etc.
    panes = Tiler(tilewidth, tileheight, 1, 1, margin=10)
    panewidth = panes.tilewidth
    paneheight = panes.tileheight

    # draw swatch
    swatchwidth = panewidth/schemelength
    for (i, p) in enumerate(cschemevalues)
        sethue(p)
        box(Point(O.x - panewidth/2 + (i * swatchwidth) - swatchwidth/2, O.y - (paneheight/3)), swatchwidth, paneheight/3 - 2, :fill)
    end

    # draw blend
    stepping = 0.0005
    boxwidth = panewidth * stepping

    for i in 0:stepping:1
        c = sample(eval(ColorSchemes, cschemename), i)
        sethue(c)
        xpos = rescale(i, 0, 1, O.x - panewidth/2, O.x + panewidth/2 - boxwidth)
        box(Point(xpos + boxwidth/2, O.y), boxwidth, paneheight/3 - 2, :fill)
    end

    # draw a (calculated) luminance graph of this scheme
    stepping = 0.01
    boxwidth = panewidth * stepping
    for i in 0:stepping:1
        c = sample(eval(ColorSchemes, cschemename), i)
        lum = grayify(c)
        sethue(lum...)
        xpos = rescale(i, 0, 1, O.x - panewidth/2, O.x + panewidth/2 - boxwidth)
        doty = lum[1]
        rect(Point(xpos + boxwidth/2, O.y + paneheight/2 - 2),
            boxwidth,
            -(doty * (paneheight/3 - 2)),
            :fill)
    end

    sethue("black")
    text(string(cschemename), Point(O.x, O.y - paneheight/2 - 2), halign=:center)
    grestore()
end

function main(fname)
    imagewidth, imageheight = 1000, 3500
    Drawing(imagewidth, imageheight, fname)
    background("white")
    origin()
    tiles = Tiler(imagewidth, imageheight, 55, 6, margin=5)
    setline(0.5)
    fontsize(14)
    for (pos, n) in tiles
        if n > length(schemes)
            break
        end
        draw_swatch(schemes[n], pos, tiles.tilewidth, tiles.tileheight)
    end
    finish()
    preview()
end

main("/tmp/swatches.pdf")
