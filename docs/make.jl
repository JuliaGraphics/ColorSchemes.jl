using Documenter, ColorSchemes

makedocs(
  modules = [ColorSchemes],
  format = :html,
  sitename = "ColorSchemes",
  pages    = Any[
    "Introduction"   => "index.md",
    "Basic usage"    => "basics.md",
    "Plotting"       => "plotting.md",
    "Images"         => "images.md",
    "Index"          => "functionindex.md"
    ]
  )

deploydocs(
    repo = "github.com/JuliaGraphics/ColorSchemes.jl.git",
    target = "build",
    julia  = "0.6",
    osname = "osx",
    deps = nothing,
    make = nothing,
)
