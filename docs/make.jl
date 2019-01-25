using Documenter, ColorSchemes

makedocs(
    modules = [ColorSchemes],
    sitename = "ColorSchemes",
    format = Documenter.HTML(prettyurls = get(ENV, "CI", nothing) == "true"),
    pages    = Any[
        "Introduction"      => "index.md",
        "Basic usage"       => "basics.md",
        "Finding colors"    => "finding.md",
        "Plotting"          => "plotting.md",
        "Images"            => "images.md",
        "Index"             => "functionindex.md"
    ]
)

deploydocs(
    repo = "github.com/JuliaGraphics/ColorSchemes.jl.git",
    target = "build"
)
