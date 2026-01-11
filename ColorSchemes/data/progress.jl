# color values from https://www.flagcolorcodes.com/progress-pride

# The Pride Progress Flag was designed in 2018 by graphic designer Daniel Quasar
# the six colors from Gilbert Baker's flag
# plus colors for skin color
# plus colors from flag for the trans community: 
# "the traditional color, light blue, for boys, pink for girls, and a
# single white stripe for those who are transitioning, gender neutral, or
# intersex."

# hexcodes = [
# "#E40303", # red
# "#FF8C00", # orange
# "#FFED00", # yellow
# "#008026", # green
# "#24408E", # indigo
# "#732982", # violet
# "#FFFFFF", # white
# "#FFAFC8", # pink
# "#74D7EE", # light blue
# "#613915", # brown
# "#000000", # black
# ]
# colvalues = map(c -> parse(Colorant, c), hexcodes)

loadcolorscheme(:progress, [
    RGB{Float64}(0.894,0.012,0.012), # red LGBT 1/6 
    RGB{Float64}(1.0, 0.549, 0.0), # orange LGBT 2/6 
    RGB{Float64}(1.0, 0.929, 0.0), # yellow LGBT 3/6 
    RGB{Float64}(0.0, 0.502, 0.149), # green LGBT 4/6  
    RGB{Float64}(0.141, 0.251, 0.557), # indigo LGBT 5/6 
    RGB{Float64}(0.451, 0.161, 0.51), # violet LGBT 6/6 
    RGB{Float64}(1.0,1.0,1.0), # white trans 1/3
    RGB{Float64}(1.0,0.686,0.784), # pink trans 2/3
    RGB{Float64}(0.455,0.843,0.933), # light blue trans 3/3
    RGB{Float64}(0.38,0.224,0.082), # brown progress 1/2
    RGB{Float64}(0.0,0.0,0.0), # black progress 2/2
], "pride", "pride progress gay trans LGBT LGBTQ"
)
