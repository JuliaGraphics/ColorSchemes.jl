using Documenter, ColorSchemes, Luxor

makedocs(
    modules = [ColorSchemes],
    sitename = "ColorSchemes",
    format = Documenter.HTML(
        prettyurls = get(ENV, "CI", nothing) == "true",
        assets = ["assets/colorschemes-docs.css"]),
    pages = Any[
        "Introduction"      => "index.md",
        "Catalogue"         => "catalogue.md",
        # "Gallery"           => "gallery.md",
        "Basic usage"       => "basics.md",
        "Finding colors"    => "finding.md",
        "Plotting"          => "plotting.md",
        "Images"            => "images.md",
        #"References"        => "references.md",
        "Index"             => "functionindex.md"
    ]
)

deploydocs(
    repo = "github.com/JuliaGraphics/ColorSchemes.jl.git",
    target = "build"
)
