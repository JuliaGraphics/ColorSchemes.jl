# generate pictures of builtin data
# usage: drawallswatches("/tmp/colorschemes.png", 1000, 3500, ncols=5)

using Colors, ColorSchemes, Luxor

"convert color to grayscale using luminance value"
function grayify(col)
    luv = convert(Luv, RGB(col.r, col.g, col.b))
    t = rescale(luv.l, 0, 100, 0, 1)
    return (t, t, t)
end

function draw_swatch(cschemename, pos, tilewidth, tileheight)
    cscheme = colorschemes[cschemename]
    schemelength = length(cscheme)

    gsave()
    translate(pos)

    # do a single pane, to get margins etc.
    panes = Tiler(tilewidth, tileheight, 1, 1, margin=10)
    panewidth = panes.tilewidth
    paneheight = panes.tileheight

    # draw swatch
    swatchwidth = panewidth/schemelength
    for (i, p) in enumerate(cscheme.colors)
        sethue(p)
        box(Point(O.x - panewidth/2 + (i * swatchwidth) - swatchwidth/2, O.y - (paneheight/3)), swatchwidth, paneheight/3 - 2, :fillstroke)
    end

    # draw blend
    stepping = 0.0005
    bxwidth = panewidth * stepping

    for i in 0:stepping:1
        c = get(cscheme, i)
        sethue(c)
        xpos = rescale(i, 0, 1, O.x - panewidth/2, O.x + panewidth/2 - bxwidth)
        box(Point(xpos + bxwidth/2, O.y), bxwidth, paneheight/3 - 2, :fillstroke)
    end

    # draw a (calculated) luminance graph of this scheme
    stepping = 0.01
    bxwidth = panewidth * stepping
    for i in 0:stepping:1
        c = get(cscheme, i)
        lum = grayify(c)
        sethue(lum...)
        xpos = rescale(i, 0, 1, O.x - panewidth/2, O.x + panewidth/2 - bxwidth)
        doty = lum[1]
        rect(Point(xpos + bxwidth/2, O.y + paneheight/2 - 2),
            bxwidth,
            -(doty * (paneheight/3 - 2)),
            :fill)
    end

    sethue("black")
    text(string(cschemename), Point(O.x, O.y - paneheight/2 - 2), halign=:center)
    grestore()
end

"work out how many rows/columns"
function howmanyrowscolumns(n)
    numberofrows = convert(Int, floor(sqrt(n * imageheight/imagewidth)))
    numberofcols = convert(Int, ceil(n/numberofrows))
    return numberofrows, numberofcols
end

"""
    drawallswatches("/tmp/swatches.png", 1000, 3500)
    drawallswatches("/tmp/swatches.pdf", 1000, 3500, nrows=80, ncols=5)
    drawallswatches("/tmp/swatches.pdf", 1000, 1000, "a")
    drawallswatches("/tmp/swatches.pdf", 1000, 3500, "[Pp]astel", ncols=3)

Show all swatches, or show only swatches whose names contain some characters.

You can specify the numbers of rows and columns of the output, although you'll only see
`nrows * ncols` of the total.
"""
function drawallswatches(fname, imagewidth=1000, imageheight=1000, selector=".*";
       font=12,
       nrows=0,
       ncols=0)

    selectedschemes = filter(nm -> occursin(Regex(selector), string(nm)), colorschemes)

    S = sort!(collect(keys(selectedschemes)), lt = (a, b) -> lowercase(string(a)) < lowercase(string(b)))

    todo = length(S)

    if nrows == ncols == 0
        nrows, ncols = howmanyrowscolumns(todo)
    elseif nrows == 0
        nrows=convert(Int, ceil(todo/ncols))
    elseif ncols == 0
        ncols=convert(Int, ceil(todo/nrows))
    end

    Drawing(imagewidth, imageheight, fname)
    background("white")
    origin()

    tiles = Tiler(imagewidth, imageheight, nrows, ncols, margin=5)
    setline(0.5)
    fontsize(font)
    counter = 0
    for (pos, n) in tiles
        if n > todo
            break
        end
        draw_swatch(S[n], pos, tiles.tilewidth, tiles.tileheight)
        counter += 1
    end
    sethue("black")
    text("showing $(counter) of $(length(S)) selected from $(length(S)) installed", 0, imageheight/2 - 5, halign=:center)
    finish()
    preview()
end

drawallswatches("/tmp/colorschemes.png", 1000, 3500, ncols=5)
