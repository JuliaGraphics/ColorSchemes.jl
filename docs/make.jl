using Documenter, ColorSchemes, Luxor

# before generating the documents, build the list of colorschemes
# and save it in a .md file

function drawscheme(schemename;
        swatchwidth=500,
        swatchheight=20)

    # create swatch
    cols = colorschemes[schemename].colors
    l = length(cols)
    Drawing(swatchwidth, swatchheight, :svg)
    setline(0.5)
    origin()
    t = Tiler(swatchwidth, swatchheight, 1, l, margin=0)
    for (i, c) in enumerate(cols)
        sethue(c)
        box(t, i, :fillstroke)
    end
    finish()

    swatch = svgstring()

    # fill the template
    schemetemplate = """
    <div class="cell_schemename">:$(schemename)</div>
    <div class="cell_swatch">$(swatch)</div>
    """
    return schemetemplate
end

function write_all_schemes_in_category(f, category)
    # start a table for this category
    write(f,
        """
        ## Category: $category
        ```@raw html
        <div id="grid-col">
        """)

    # add row for each scheme
    schemes = filter(s -> occursin(category, colorschemes[s].category), collect(keys(colorschemes))) # hide
    for scheme in sort(schemes)
        write(f, drawscheme(scheme))
    end

    # end table for this category
    write(f, """
        </div>
        ```
        """)
end

open("docs/src/catalogue.md", "w") do f
    write(f, """
    # Catalogue of all colorschemes

    This section lists all the colorschemes provided. Refer
    to the [References](@ref) section for links to the original
    sources for these.
    """)
    # a table for each category
    write_all_schemes_in_category(f, "colorbrewer")
    write_all_schemes_in_category(f, "cmocean")
    write_all_schemes_in_category(f, "scientific")
    write_all_schemes_in_category(f, "matplotlib")
    write_all_schemes_in_category(f, "gnuplot")
    write_all_schemes_in_category(f, "colorcet")
    write_all_schemes_in_category(f, "seaborn")
    write_all_schemes_in_category(f, "tableau")
    write_all_schemes_in_category(f, "cvd")
    write_all_schemes_in_category(f, "flags")
    write_all_schemes_in_category(f, "general")
end

makedocs(
    modules = [ColorSchemes],
    sitename = "ColorSchemes",
    format = Documenter.HTML(
        prettyurls = get(ENV, "CI", nothing) == "true",
        assets = ["assets/colorschemes-docs.css"]),
    pages = Any[
        "Introduction"      => "index.md",
        # "Gallery"           => "gallery.md",
        "Catalogue"         => "catalogue.md",
        "Basic usage"       => "basics.md",
        "Finding colors"    => "finding.md",
        "Plotting"          => "plotting.md",
        "Images"            => "images.md",
        "References"        => "references.md",
        "Index"             => "functionindex.md"
    ]
)

deploydocs(
    repo = "github.com/JuliaGraphics/ColorSchemes.jl.git",
    target = "build"
)
