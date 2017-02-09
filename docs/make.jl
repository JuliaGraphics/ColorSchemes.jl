using Documenter, ColorSchemes

makedocs(
  modules = [ColorSchemes],
  format = :html,
  sitename = "ColorSchemes",
  pages    = Any[
    "Introduction"   => "index.md",
    "Plotting"       => "plotting.md",
    "Images"         => "images.md",
    "Index"          => "functionindex.md"
    ]
  )

deploydocs(
    repo = "github.com/cormullion/ColorSchemes.jl.git",
    target = "build",
    julia  = "0.5",
    osname = "osx",
    deps = nothing,
    make = nothing,
)
