# Paraview Fast Colormap
# It is the new default colormap for Paraview. It replaced the Cool to Warm colormap in 2024 [1]. It is a perceptually uniform colormap that is designed to be visually appealing and easy to interpret. It is based on a combination of blue, cyan, green, yellow, orange, and red colors.
#
# Reference: F. Samsel, W.A. Scott, K. Moreland, A New Default Colormap for ParaView, in IEEE Computer Graphics and Applications, vol. 44, no. 04, pp. 150-160, 2024.
#
# Link to colormap json file:
# https://github.com/kennethmoreland-com/kennethmoreland-com.github.io/blob/f0f50dcfda94c8e4c9c4927f78a98ff419fea450/content/color-advice/fast/fast.json

loadcolorscheme(:fast, [
        RGB(0.056399999999999992,0.056399999999999992, 0.46999999999999997),
        RGB(0.24300000000000013, 0.46035000000000043, 0.81000000000000005),
        RGB(0.35681438265435211, 0.74502464853631423, 0.95436770289372197),
        RGB(0.68820000000000003, 0.93000000000000005, 0.91790999999999989),
        RGB(0.89949595512059022, 0.944646394975174, 0.7686567142818399),
        RGB(0.92752075996107142, 0.62143890917391775, 0.31535705838676426),
        RGB(0.80000000000000004, 0.35200000000000009, 0.15999999999999998),
        RGB(0.58999999999999997, 0.076700000000000129, 0.11947499999999994)
    ], "general", "Paraview Fast colormap")