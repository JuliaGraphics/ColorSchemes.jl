#!/usr/bin/env julia

using Colors, ColorSchemes

function draw_swatches()
    cd(Pkg.dir("ColorSchemes", "data"))
    imagewidth, imageheight = 800, 3000
    margin = 20
    swatch_height = 15
    # send output to file
    fhandle = open("/tmp/colorschemes.svg", "w")
    # write svg header
    println(fhandle, """<svg xmlns="http://www.w3.org/2000/svg" version="1.1" width="$(imagewidth)" height="$(imageheight)"> \n
<rect x="0" y="0" width="$(imagewidth)" height="$(imageheight)" fill="white" /> \n """)
    # title
    println(fhandle, """<text x="$(margin)" y="$(margin - margin/2)" font-size="14px" font-family="Helvetica-Bold">Colorschemes</text>\n""")

    files = readdir()
    y   = 50
    for f in filter(f -> f != ".DS_Store", files)
        cs = loadcolorscheme(f)
        w = (imagewidth - margin - margin - 50) / length(cs)
        println(fhandle, """<text x="$(margin)" y="$(y-5)" fill="black" font-size="10px" font-family="Futura">$f</text>\n""")
        x = margin
        #swatch
        for (i, p) in enumerate(cs)
            r, g, b = convert(Int, round(256 * p.r)), convert(Int, round(256 * p.g)), convert(Int, round(256 * p.b))
            println(fhandle, """<rect x="$(x)" y="$(y)" width="$(w)" height="$(swatch_height)"  stroke="none" fill="rgb($r, $g, $b)" /> \n """)
            x = margin + (i * w)
        end
        y += 20
        #blend
        stepping = 0.001
        printwidth = (imagewidth - margin - margin - 50)
        @show printwidth
        for i in 0:stepping:1
            c = colorscheme(cs, i)
            r, g, b = convert(Int, round(256 * c.r)), convert(Int, round(256 * c.g)), convert(Int, round(256 * c.b))
            x = margin + (i * printwidth)
            println(fhandle, """<rect x="$(x)" y="$(y)" width="$(1 + printwidth * stepping)" height="$(swatch_height)"  stroke="none" fill="rgb($r, $g, $b)" /> \n """)
        end
        y += 35
    end
    println(fhandle, "</svg>")
    close(fhandle)
    run(`open /tmp/colorschemes.svg`)
end

draw_swatches()
