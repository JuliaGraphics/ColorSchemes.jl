# color vision deficiency (CVD) -  (color blind) - friendly
# https://zenodo.org/record/3381072
# Creative Commons Attribution 4.0 International
# 8, 12, and 15 color palettes for deuteranopia color blindness
# Martin Krzywinski martink@bcgsc.ca
# Methods and details: http://mkweb.bcgsc.ca/colorblind

#From Paul Tol: https://personal.sron.nl/~pault/
loadcolorscheme(:tol_bright, [
    colorant"#4477AA",
    colorant"#EE6677",
    colorant"#228833",
    colorant"#CCBB44",
    colorant"#66CCEE",
    colorant"#AA3377",
    colorant"#BBBBBB"
], "cvd", "cvd friendly, color blind friendly")

loadcolorscheme(:tol_highcontrast, [
    colorant"#004488",
    colorant"#DDAA33",
    colorant"#BB5566",
], "cvd", "cvd friendly, color blind friendly")

loadcolorscheme(:tol_vibrant, [
    colorant"#EE7733",
    colorant"#0077BB",
    colorant"#33BBEE",
    colorant"#EE3377",
    colorant"#CC3311",
    colorant"#009988",
    colorant"#BBBBBB",
], "cvd", "cvd friendly, color blind friendly")

loadcolorscheme(:tol_muted, [
    colorant"#332288",
    colorant"#88CCEE",
    colorant"#44AA99",
    colorant"#117733",
    colorant"#999933",
    colorant"#DDCC77",
    colorant"#CC6677",
    colorant"#882255",
    colorant"#AA4499",
], "cvd", "cvd friendly, color blind friendly")

loadcolorscheme(:tol_medcontrast, [
    colorant"#6699CC",
    colorant"#004488",
    colorant"#EECC66",
    colorant"#994455",
    colorant"#997700",
    colorant"#EE99AA",
], "cvd", "cvd friendly, color blind friendly")

loadcolorscheme(:tol_light, [
    colorant"#77AADD",
    colorant"#EE8866",
    colorant"#EEDD88",
    colorant"#FFAABB",
    colorant"#99DDFF",
    colorant"#44BB99",
    colorant"#BBCC33",
    colorant"#AAAA00",
    colorant"#DDDDDD"
], "cvd", "cvd friendly, color blind friendly")

loadcolorscheme(:tol_sunset, [
    colorant"#364B9A",
    colorant"#4A7BB7",
    colorant"#6EA6CD",
    colorant"#98CAE1",
    colorant"#C2E4EF",
    colorant"#EAECCC",
    colorant"#FEDA8B",
    colorant"#FDB366",
    colorant"#F67E4B",
    colorant"#DD3D2D",
    colorant"#A50026",
], "cvd", "cvd friendly, color blind friendly")

loadcolorscheme(:tol_BuRd, [
    colorant"#2166AC",
    colorant"#4393C3",
    colorant"#92C5DE",
    colorant"#D1E5F0",
    colorant"#F7F7F7",
    colorant"#FDDBC7",
    colorant"#F4A582",
    colorant"#D6604D",
    colorant"#B2182B",
], "cvd", "cvd friendly, color blind friendly")

colorschemes[:tol_bu_rd] = colorschemes[:tol_BuRd] # For compat.

loadcolorscheme(:tol_PRGn, [
    colorant"#762A83",
    colorant"#9970AB",
    colorant"#C2A5CF",
    colorant"#E7D4E8",
    colorant"#F7F7F7",
    colorant"#D9F0D3",
    colorant"#ACD39E",
    colorant"#5AAE61",
    colorant"#1B7837",
], "cvd", "cvd friendly, color blind friendly")

colorschemes[:tol_prgn] = colorschemes[:tol_PRGn] # For compat.

loadcolorscheme(:tol_nightfall, [
    colorant"#125A56",
    colorant"#00767B",
    colorant"#238F9D",
    colorant"#42A7C6",
    colorant"#60BCE9",
    colorant"#9DCCEF",
    colorant"#C6DBED",
    colorant"#DEE6E7",
    colorant"#ECEADA",
    colorant"#F0E6B2",
    colorant"#F9D576",
    colorant"#FFB954",
    colorant"#FD9A44",
    colorant"#F57634",
    colorant"#E94C1F",
    colorant"#D11807",
    colorant"#A01813"],
    "cvd", "cvd friendly, color blind friendly")

loadcolorscheme(:tol_land_cover, [
    colorant"#5566AA",
    colorant"#117733",
    colorant"#44AA66",
    colorant"#55AA22",
    colorant"#668822",
    colorant"#99BB55",
    colorant"#558877",
    colorant"#88BBAA",
    colorant"#AADDCC",
    colorant"#44AA88",
    colorant"#DDCC66",
    colorant"#FFDD44",
    colorant"#FFEE88",
    colorant"#BB0011",
], "cvd", "cvd friendly, color blind friendly")

colorschemes[:ground_cover] = colorschemes[:tol_land_cover] # For compat.

loadcolorscheme(:tol_YlOrBr, [
    colorant"#FFFFE5",
    colorant"#FFF7BC",
    colorant"#FEE391",
    colorant"#FEC44F",
    colorant"#FB9A29",
    colorant"#EC7014",
    colorant"#CC4C02",
    colorant"#993404",
    colorant"#662506",
], "cvd", "cvd friendly, color blind friendly")

colorschemes[:tol_ylorbr] = colorschemes[:tol_YlOrBr]

loadcolorscheme(:tol_iridescent, [
    colorant"#FEFBE9",
    colorant"#FCF7D5",
    colorant"#F5F3C1",
    colorant"#EAF0B5",
    colorant"#DDECBF",
    colorant"#D0E7CA",
    colorant"#C2E3D2",
    colorant"#B5DDD8",
    colorant"#A8D8DC",
    colorant"#9BD2E1",
    colorant"#8DCBE4",
    colorant"#81C4E7",
    colorant"#7BBCE7",
    colorant"#7EB2E4",
    colorant"#88A5DD",
    colorant"#9398D2",
    colorant"#9B8AC4",
    colorant"#9D7DB2",
    colorant"#9A709E",
    colorant"#906388",
    colorant"#805770",
    colorant"#684957",
    colorant"#46353A",
], "cvd", "cvd friendly, color blind friendly")

colorschemes[:Iridescent] = colorschemes[:tol_iridescent] # For compat.

loadcolorscheme(:tol_incandescent, [
     colorant"#CEFFFF",
     colorant"#C6F7D6",
     colorant"#A2F49B",
     colorant"#BBE453",
     colorant"#D5CE04",
     colorant"#E7B503",
     colorant"#F19903",
     colorant"#F6790B",
     colorant"#F94902",
     colorant"#E40515",
     colorant"#A80003"
], "cvd", "cvd friendly, color blind friendly")

loadcolorscheme(:tol_rainbow, [
    colorant"#E8ECFB",
    colorant"#D9CCE3",
    colorant"#D1BBD7",
    colorant"#CAACCB",
    colorant"#BA8BD4",
    colorant"#AE76A3",
    colorant"#AA6F9E",
    colorant"#994F88",
    colorant"#882E72",
    colorant"#1965B0",
    colorant"#437DBF",
    colorant"#5289C7",
    colorant"#6195CF",
    colorant"#7BAFDE",
    colorant"#4EB265",
    colorant"#90C987",
    colorant"#CAE0AB",
    colorant"#F7F056",
    colorant"#F7CB45",
    colorant"#F6C141",
    colorant"#F4A736",
    colorant"#F1932D",
    colorant"#EE8026",
    colorant"#E8601C",
    colorant"#E65518",
    colorant"#DC050C",
    colorant"#A5170E",
    colorant"#72190E",
    colorant"#42150A",
], "cvd", "cvd friendly, color blind friendly")

#From Color Universal Design (CUD): https://jfly.uni-koeln.de/color/
loadcolorscheme(:okabe_ito, [
    colorant"#E69F00",
    colorant"#56B4E9",
    colorant"#009E73",
    colorant"#F0E442",
    colorant"#0072B2",
    colorant"#D55E00",
    colorant"#CC79A7",
    colorant"#000000"
], "cvd", "cvd friendly, color blind friendly")

# 8, 12, and 15 color palettes for deuteranopia color blindness
# Martin Krzywinski martink@bcgsc.ca
# Methods and details: http://mkweb.bcgsc.ca/colorblind

loadcolorscheme(:mk_8, [
    colorant"#000000",
    colorant"#2271B2",
    colorant"#3DB7E9",
    colorant"#F748A5",
    colorant"#359B73",
    colorant"#d55e00",
    colorant"#e69f00",
    colorant"#f0e442",
], "cvd", "cvd friendly, color blind friendly")

loadcolorscheme(:mk_12, [
    colorant"#9F0162",
    colorant"#009F81",
    colorant"#FF5AAF",
    colorant"#00FCCF",
    colorant"#8400CD",
    colorant"#008DF9",
    colorant"#00C2F9",
    colorant"#FFB2FD",
    colorant"#A40122",
    colorant"#E20134",
    colorant"#FF6E3A",
    colorant"#FFC33B",
], "cvd", "cvd friendly, color blind friendly")

loadcolorscheme(:mk_15, [
    colorant"#68023F",
    colorant"#008169",
    colorant"#EF0096",
    colorant"#00DCB5",
    colorant"#FFCFE2",
    colorant"#003C86",
    colorant"#9400E6",
    colorant"#009FFA",
    colorant"#FF71FD",
    colorant"#7CFFFA",
    colorant"#6A0213",
    colorant"#008607",
    colorant"#F60239",
    colorant"#00E307",
    colorant"#FFDC3D",
], "cvd", "cvd friendly, color blind friendly")
