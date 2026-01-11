import PrecompileTools

PrecompileTools.@compile_workload begin
    get(ColorSchemes.leonardo, 0.5)
    get(ColorSchemes.leonardo, [0.0 1.0; -1.0 2.0])
    loadcolorscheme(:flag_blank, [
            RGB(1.1, 1.1, 1.1),
            RGB(1.1, 1.1, 1.1),
            RGB(1.1, 1.1, 1.1),
        ], "flags", "The flag of Blank")
end
