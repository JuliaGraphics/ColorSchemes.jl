using Documenter, Luxor, ColorSchemes

makedocs(
    modules = [ColorSchemes],
    sitename = "ColorSchemes",
    warnonly = true,
    format = Documenter.HTML(
        size_threshold = nothing,
        prettyurls = get(ENV, "CI", nothing) == "true",
        assets = ["assets/colorschemes-docs.css"]),
    pages = Any[
        "Introduction"      => "index.md",
        "Catalogue"         => "catalogue.md",
        "Basic usage"       => "basics.md",
        "Good practice"     => "goodpractice.md",
        "Finding colors"    => "finding.md",
        "Plotting"          => "plotting.md",
        "Images"            => "images.md",
        "Index"             => "functionindex.md"
    ]
)

deploydocs(
    push_preview = true,
    repo = "github.com/JuliaGraphics/ColorSchemes.jl.git",
    target = "build"
)
