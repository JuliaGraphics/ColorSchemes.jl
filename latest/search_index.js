var documenterSearchIndex = {"docs": [

{
    "location": "index.html#",
    "page": "Introduction",
    "title": "Introduction",
    "category": "page",
    "text": ""
},

{
    "location": "index.html#Introduction-to-ColorSchemes-1",
    "page": "Introduction",
    "title": "Introduction to ColorSchemes",
    "category": "section",
    "text": "This package provides tools for working with colorschemes and colormaps. As well as providing many pre-made colormaps and schemes, this package allows you to extract colorschemes from images and use them in plots or other graphics programs.This package relies on the Colors.jl package and Images.jl.Please submit issues and pull requests."
},

{
    "location": "index.html#Current-status-1",
    "page": "Introduction",
    "title": "Current status",
    "category": "section",
    "text": "ColorSchemes requires Julia version 0.6, and makes use of the Images.jl and Clustering.jl packages."
},

{
    "location": "index.html#Installation-and-basic-usage-1",
    "page": "Introduction",
    "title": "Installation and basic usage",
    "category": "section",
    "text": "Install the package as follows:Pkg.add(\"ColorSchemes\")and to use it:using ColorSchemesOriginal version by cormullion."
},

{
    "location": "index.html#ColorSchemes.extract",
    "page": "Introduction",
    "title": "ColorSchemes.extract",
    "category": "Function",
    "text": "extract(imfile, n=10, i=10, tolerance=0.01; shrink=n)\n\nextract() extracts the most common colors from an image from the image file imfile by finding n dominant colors, using i iterations. You can (and probably should) shrink larger images before running this function.\n\nReturns a colorscheme (an array of colors)\n\n\n\n"
},

{
    "location": "index.html#Basics-1",
    "page": "Introduction",
    "title": "Basics",
    "category": "section",
    "text": "A colorscheme is an array of colors:32-element Array{RGB{Float64},1}:\n    RGB{Float64}(0.0548203,0.016509,0.0193152)\n    RGB{Float64}(0.0750816,0.0341102,0.0397083)\n    RGB{Float64}(0.10885,0.0336675,0.0261204)\n    RGB{Float64}(0.100251,0.0534243,0.0497594)\n    ...\n    RGB{Float64}(0.85004,0.540122,0.136212)\n    RGB{Float64}(0.757552,0.633425,0.251451)\n    RGB{Float64}(0.816472,0.697015,0.322421)\n    RGB{Float64}(0.933027,0.665164,0.198652)\n    RGB{Float64}(0.972441,0.790701,0.285136)The names of the built-in colorschemes are stored in the schemes array:julia> schemes\n336-element Array{Symbol,1}:\n:alpine         \n:aquamarine     \n:army           \n:atlantic       \n:aurora         \n:autumn         \n:avocado        \n:beach          \n:blackbody      \n...\n:PiYG_10        \n:PiYG_11        \n:magma          \n:inferno        \n:plasma         \n:viridisTo access one of these built-in colorschemes, use its symbol:julia> ColorSchemes.leonardo\n\n32-element Array{RGB{Float64},1}:\n RGB{Float64}(0.0548203,0.016509,0.0193152)\n RGB{Float64}(0.0750816,0.0341102,0.0397083)\n RGB{Float64}(0.10885,0.0336675,0.0261204)\n RGB{Float64}(0.100251,0.0534243,0.0497594)\n ...\n RGB{Float64}(0.620187,0.522792,0.216707)\n RGB{Float64}(0.692905,0.56631,0.185515)\n RGB{Float64}(0.681411,0.58149,0.270391)\n RGB{Float64}(0.85004,0.540122,0.136212)\n RGB{Float64}(0.757552,0.633425,0.251451)\n RGB{Float64}(0.816472,0.697015,0.322421)\n RGB{Float64}(0.933027,0.665164,0.198652)\n RGB{Float64}(0.972441,0.790701,0.285136)(Image: \"leo color scheme\")By default, the names of the colorschemes aren't imported (there _are_ rather a lot of them). But to avoid using the prefixes, you can import the ones that you want:julia> import ColorSchemes.leonardo\njulia> leonardo\n32-element Array{RGB{Float64},1}:\n RGB{Float64}(0.0548203,0.016509,0.0193152)\n RGB{Float64}(0.0750816,0.0341102,0.0397083)\n RGB{Float64}(0.10885,0.0336675,0.0261204)\n RGB{Float64}(0.100251,0.0534243,0.0497594)\n ...\n RGB{Float64}(0.757552,0.633425,0.251451)\n RGB{Float64}(0.816472,0.697015,0.322421)\n RGB{Float64}(0.933027,0.665164,0.198652)\n RGB{Float64}(0.972441,0.790701,0.285136)You can reference a single value of a scheme once it's loaded:leonardo[3]\n\n-> RGB{Float64}(0.10884977211887092,0.033667530751245296,0.026120424375656533)Or you can 'sample' the scheme at any point between 0 and 1 using get:get(leonardo, 0.5)\n\n-> RGB{Float64}(0.42637271063618504,0.28028983973265065,0.11258024276603132)You can extract a colorscheme from an image. For example, here's an image of a famous painting:(Image: \"the mona lisa\")Use extract() to create a colorscheme from the original image:monalisa = extract(\"monalisa.jpg\", 10, 15, 0.01; shrink=2)which in this example creates a 10-color scheme (using 15 iterations and with a tolerance of 0.01; the image can be reduced in size, here by 2, before processing, to save time).(Image: \"mona lisa extraction\")10-element Array{RGB{Float64},1}:\nRGB{Float64}(0.0406901,0.0412985,0.0423865),\nRGB{Float64}(0.823493,0.611246,0.234261),\nRGB{Float64}(0.374688,0.363066,0.182004),\nRGB{Float64}(0.262235,0.239368,0.110915),\nRGB{Float64}(0.614806,0.428448,0.112495),\nRGB{Float64}(0.139384,0.124466,0.0715472),\nRGB{Float64}(0.627381,0.597513,0.340734),\nRGB{Float64}(0.955276,0.775304,0.37135),\nRGB{Float64}(0.497517,0.4913,0.269587),\nRGB{Float64}(0.880421,0.851357,0.538013),\nRGB{Float64}(0.738879,0.709218,0.441082)](Extracting colorschemes from images requires image importing and exporting abilities. These are platform-specific. On Linux/UNIX, ImageMagick can be used for importing and exporting images.)extractThe ColorSchemes module automatically loads a number of predefined schemes, shown in the following illustration. Each scheme is drawn in three ways: first, showing each color; next, a continuous blend obtained using get() with values ranging from 0 to 1 (stepping through the range 0:0.001:1); and finally a luminance graph shows how the luminance of the scheme varies as the colors change.It's generally agreed (search the web for \"Rainbow colormaps considered harmful\") that you should choose colormaps with smooth linear luminance gradients.(Image: \"all schemes\")(You can generate this file using ColorSchemes/docs/src/assets/figures/draw-swatches.jl, after obtaining the Luxor package to draw and label things.)You can list the names of built-in colorschemes in the ColorSchemes/data directory by looking in the schemes symbol. Look for matches with filter().julia> filter(x-> contains(string(x), \"temp\"), schemes)\n2-element Array{Symbol,1}:\n :lighttemperaturemap\n :temperaturemap\n\njulia> filter(x-> ismatch(r\"ma.*\", string(x)), schemes)\n5-element Array{Symbol,1}:\n:aquamarine         \n:lighttemperaturemap\n:temperaturemap     \n:magma              \n:plasmaschemesOf course you can easily make your own colorscheme by building an array:grays = [RGB{Float64}(i, i, i) for i in 0:0.1:1.0]or, slightly longer:reds = RGB{Float64}[]\n\nfor i in 0:0.05:1\n  push!(reds, RGB{Float64}(1, 1-i, 1-i))\nend"
},

{
    "location": "index.html#Base.get",
    "page": "Introduction",
    "title": "Base.get",
    "category": "Function",
    "text": "get(cscheme, x)\n\nFind the nearest color in a colorscheme cscheme corresponding to a point x between 0 and 1)\n\nReturns a single color.\n\n\n\n"
},

{
    "location": "index.html#Continuous-color-sampling-1",
    "page": "Introduction",
    "title": "Continuous color sampling",
    "category": "section",
    "text": "You can access the specific colors of a colorscheme by indexing (eg leonardo[2] or leonardo[2:20]). Or you can sample a colorscheme at a point between 0.0 and 1.0 as if it was a continuous range of colors:get(leonardo, 0.5)returnsRGB{Float64}(0.42637271063618504,0.28028983973265065,0.11258024276603132)(Image: \"get example\")The colors in the predefined colorschemes are usually sorted by LUV luminance, so this often makes sense.get"
},

{
    "location": "index.html#ColorSchemes.sortcolorscheme",
    "page": "Introduction",
    "title": "ColorSchemes.sortcolorscheme",
    "category": "Function",
    "text": "sortcolorscheme(colorscheme, field; kwargs...)\n\nSort (non-destructively) a colorscheme using a field of the LUV colorspace.\n\nThe default is to sort by the luminance field :l but could be by :u or :v.\n\n\n\n"
},

{
    "location": "index.html#Sorting-color-schemes-1",
    "page": "Introduction",
    "title": "Sorting color schemes",
    "category": "section",
    "text": "Use sortcolorscheme() to sort a scheme non-destructively in the LUV color space:sortcolorscheme(ColorSchemes.leonardo)\nsortcolorscheme(ColorSchemes.leonardo, rev=true)The default is to sort colors by their LUV luminance value, but you could try specifying the :u or :v LUV fields instead (sorting colors is another problem domain not really addressed in this package...):sortcolorscheme(colorscheme, :u)sortcolorscheme"
},

{
    "location": "index.html#ColorSchemes.extract_weighted_colors",
    "page": "Introduction",
    "title": "ColorSchemes.extract_weighted_colors",
    "category": "Function",
    "text": "extract_weighted_colors(imfile, n=10, i=10, tolerance=0.01; shrink = 2)\n\nExtract colors and weights of the clusters of colors in an image file.\n\nExample:\n\npal, wts = extract_weighted_colors(imfile, n, i, tolerance; shrink = 2)\n\n\n\n"
},

{
    "location": "index.html#ColorSchemes.colorscheme_weighted",
    "page": "Introduction",
    "title": "ColorSchemes.colorscheme_weighted",
    "category": "Function",
    "text": "colorscheme_weighted(colorscheme, weights, length)\n\nReturns a new colorscheme of length length (default 50) where the proportion of each color in colorscheme is represented by the associated weight of each entry.\n\nExamples:\n\ncolorscheme_weighted(extract_weighted_colors(\"hokusai.jpg\")...)\ncolorscheme_weighted(extract_weighted_colors(\"filename00000001.jpg\")..., 500)\n\n\n\n"
},

{
    "location": "index.html#Weighted-colorschemes-1",
    "page": "Introduction",
    "title": "Weighted colorschemes",
    "category": "section",
    "text": "Sometimes an image is dominated by some colors with others occurring less frequently. For example, there may be much more brown than yellow in a particular image. A colorscheme derived from this image can reflect this. You can extract both a set of colors and a set of numerical values or weights that indicate the proportions of colors in the image.using Images\ncs, wts = extract_weighted_colors(\"monalisa.jpg\", 10, 15, 0.01; shrink=2)The colorscheme is now in cs, and wts holds the various weights of each color:wts\n-> 10-element Array{Float64,1}:\n 0.294055\n 0.0899108\n 0.0808455\n 0.0555576\n 0.142818\n 0.0356599\n 0.0391717\n 0.112667\n 0.0596559\n 0.0896584With the colorscheme and the weights, you can make a colorscheme in which the more common colors take up more space in the scheme:colorscheme_weighted(cs, wts, len)Or in one go:colorscheme_weighted(extract_weighted_colors(\"monalisa.jpg\")...)Compare the weighted and unweighted versions of schemes extracted from the Hokusai image \"The Great Wave\":(Image: \"unweighted\")(Image: \"weighted\")extract_weighted_colors\ncolorscheme_weighted"
},

{
    "location": "plotting.html#",
    "page": "Plotting",
    "title": "Plotting",
    "category": "page",
    "text": ""
},

{
    "location": "plotting.html#Plotting-1",
    "page": "Plotting",
    "title": "Plotting",
    "category": "section",
    "text": ""
},

{
    "location": "plotting.html#Plots.jl-1",
    "page": "Plotting",
    "title": "Plots.jl",
    "category": "section",
    "text": "Tom Breloff's amazing superplotting package, Plots.jl can use colorschemes.With the contour() function, use cgrad() to read the colorscheme as a gradient. This renaissance-looking plot uses the leonardo scheme:using Plots, Colorschemes\n\nx = 1:0.3:20\ny = x\nf(x,y) = begin\n      sin(x) + cos(y)\n  end\ncontour(x, y, f, fill=true, seriescolor=cgrad(ColorSchemes.leonardo))(Image: \"contour\")(You can use c as a short cut for seriescolor.)With other plots, use the palette keyword:plot(Plots.fakedata(100, 20),\n    w=4,\n    background_color=ColorSchemes.vermeer[1],\n    palette=ColorSchemes.vermeer)(Image: \"palette\")You can list all colorschemes with a set of PyPlot heatmap plots:pyplot()\nz = (1:10)*(1:33)'\nmap(cs -> PlotUtils.register_gradient_colors(Symbol(cs), eval(ColorSchemes, cs)), schemes);\ncschemes = keys(PlotUtils._gradients)\nplot([heatmap(z,fc=cm,leg=false,title=cm,ticks=nothing, titlefont = font(8)) for cm=cschemes]..., size=(1500,1500))(Image: \"heatmaps\")"
},

{
    "location": "plotting.html#Gadfly-1",
    "page": "Plotting",
    "title": "Gadfly",
    "category": "section",
    "text": "Here's how you can use ColorSchemes in Gadfly:x = repeat(collect(1:20), inner=[20])\ny = repeat(collect(1:20), outer=[20])\nplot(x=x, y=y,\n    color=x+y,\n    Geom.rectbin,\n    Scale.ContinuousColorScale(p -> get(ColorSchemes.sunset, p)))(Image: \"gadfly\")"
},

{
    "location": "plotting.html#Winston-1",
    "page": "Plotting",
    "title": "Winston",
    "category": "section",
    "text": "If you prefer Winston.jl for plotting, you can use colorschemes with imagesc:using Winston\nklimt = ColorSchemes.klimt\nWinston.colormap(klimt)\nWinston.imagesc(reshape(1:10000,100,100))(Image: \"winston klimt\")Sometimes you'll want a smoother gradient with more colors. You can use get(scheme, n) to generate a more detailed array of colors, varying n from 0 to 1 by 0.001:brasstones = ColorSchemes.brass\nbrasstonesmooth = [get(brasstones, i) for i in 0:0.001:1]\nWinston.colormap(brasstonesmooth)\nWinston.imagesc(reshape(1:10000,100,100))(Image: \"winston brass tones)"
},

{
    "location": "plotting.html#PyPlot-1",
    "page": "Plotting",
    "title": "PyPlot",
    "category": "section",
    "text": "Colorschemes can be used with the cmap keyword in PyPlot:using PyPlot, Distributions\n\nsolar = ColorSchemes.solar\n\nn = 100\nx = linspace(-3, 3, n)\ny = linspace(-3,3,n)\n\nxgrid = repmat(x',n,1)\nygrid = repmat(y,1,n)\nz = zeros(n,n)\n\nfor i in 1:n\n    for j in 1:n\n        z[i:i,j:j] = pdf(MvNormal(eye(2)),[x[i];y[j]])\n    end\nend\n\nfig = PyPlot.figure(\"pyplot_surfaceplot\",figsize=(10,10))\nax = fig[:add_subplot](2,1,1, projection = \"3d\")\nax[:plot_surface](xgrid, ygrid, z, rstride=2,edgecolors=\"k\",\n    cstride=2,\n    cmap=ColorMap(solar),\n    alpha=0.8,\n    linewidth=0.25)(Image: \"pyplot\")"
},

{
    "location": "images.html#",
    "page": "Images",
    "title": "Images",
    "category": "page",
    "text": "# Images"
},

{
    "location": "images.html#ColorSchemes.colorscheme_to_image",
    "page": "Images",
    "title": "ColorSchemes.colorscheme_to_image",
    "category": "Function",
    "text": "colorscheme_to_image(cs, n=50, h=50)\n\nMake an image from a colorscheme by repeating each color n times in h rows.\n\nReturns the image as an array.\n\nExamples:\n\nusing FileIO\n\nimg = colorscheme_to_image(ColorSchemes.leonardo, 50, 200)\nsave(\"/tmp/cs_image.png\", img)\n\nsave(\"/tmp/blackbody.png\", colorscheme_to_image(ColorSchemes.blackbody, 10, 100))\n\n\n\n"
},

{
    "location": "images.html#ColorSchemes.image_to_swatch",
    "page": "Images",
    "title": "ColorSchemes.image_to_swatch",
    "category": "Function",
    "text": "image_to_swatch(imagefilepath, samples, destinationpath; rows=50, repeats=10)\n\nExtract a colorscheme from the image in imagefilepath to a swatch image PNG in destinationpath. This just runs sortcolorscheme(), colorscheme_to_image(), and save() in sequence.\n\nSpecify the number of colors. You can also specify the number of rows, and how many times each color is repeated in a row.\n\nimage_to_swatch(\"monalisa.jpg\", 10, \"/tmp/monalisaswatch.png\")\n\n\n\n"
},

{
    "location": "images.html#Saving-colorschemes-as-images-1",
    "page": "Images",
    "title": "Saving colorschemes as images",
    "category": "section",
    "text": "Sometimes you want to save a colorscheme, which is usually just a pixel thick, as a swatch or image. You can do this with colorscheme_to_image(). The second argument is the number of repetitions of each color in the row, the third is the total number of rows. The function returns an image which you can save using FileIO's save():using FileIO, ColorSchemes, Images, Colors\n\nimg = colorscheme_to_image(ColorSchemes.vermeer, 30, 400)\nsave(\"/tmp/cs_vermeer-30-300.png\", img)(Image: \"vermeer swatch\")The image_to_swatch() function extracts a colorscheme from the image in and saves it as a swatch in a PNG.colorscheme_to_image\nimage_to_swatch"
},

{
    "location": "images.html#ColorSchemes.colorscheme_to_text",
    "page": "Images",
    "title": "ColorSchemes.colorscheme_to_text",
    "category": "Function",
    "text": "colorscheme_to_text(cscheme, schemename, filename; comment=\"\")\n\nWrite a colorscheme to a Julia file in a format suitable for includeing.\n\nExample:\n\ncolorscheme_to_text(\n    extract(\"/tmp/1920px-Great_Wave_off_Kanagawa2.jpg\"),\n        \"hokusai_1\",\n        \"/tmp/hok.jl\",\n        comment=\"from Hokusai's Great Wave\")\n\nTo read a text file created thusly in and register it in schemes:\n\njulia> include(\"/tmp/hok.jl\")\njulia> schemes[end]\n:hokusai_1\njulia> get(hokusai_1, .4)\nRGB{Float64}(0.5787354153400166,0.49341844091747,0.22277034922842723)\n\n\n\n"
},

{
    "location": "images.html#ColorSchemes.@reg",
    "page": "Images",
    "title": "ColorSchemes.@reg",
    "category": "Macro",
    "text": "load a variable and some values, and add the symbol to the list of schemes\n\n\n\n"
},

{
    "location": "images.html#Colorschemes-to-text-files-1",
    "page": "Images",
    "title": "Colorschemes to text files",
    "category": "section",
    "text": "You can save a colorscheme as a text file with the imaginatively-titled colorscheme_to_text() function. colorscheme_to_text(ColorSchemes.vermeer, \"the_lost_vermeer\", \"/tmp/the_lost_vermeer.jl\")The file is basically a Julia file with the color values preceded by a valid symbol name and the @reg macro. When this file is loaded into Julia (using include()), the scheme is added to the list of available schemes in schemes.# created 2017-02-07T18:30:38.021\n@reg the_lost_vermeer [\nRGB{Float64}(0.045319841827409044,0.04074539053177987,0.033174030819406126),\nRGB{Float64}(0.06194243196273512,0.05903050212040492,0.05139710689483695),\nRGB{Float64}(0.08816176863597491,0.0835588842566198,0.07360482587419233),\n...\nRGB{Float64}(0.9481923826365111,0.8763149891872409,0.5495049783744819),\nRGB{Float64}(0.9564577470648753,0.8846308778140886,0.7723396650326797),\nRGB{Float64}(0.9689316860465117,0.9673077588593577,0.9478145764119602) ]colorscheme_to_text\n@reg"
},

{
    "location": "images.html#A-Julia-Julia-set:-colorschemes-and-Images-1",
    "page": "Images",
    "title": "A Julia Julia set: colorschemes and Images",
    "category": "section",
    "text": "Here's how you can use colorschemes when creating images with Images.jl. The code creates a Julia set and uses a colorscheme extracted from Vermeer's painting \"Girl with a Pearl Earring\".(Image: \"julia set\")using ColorSchemes, Images\n\nfunction julia(z, c, maxiter::Int64)\n    for n = 1:maxiter\n        if abs(z) > 2\n            return n\n        end\n        z = z^2 + c\n    end\n    return maxiter\nend\n\n# convert a value between oldmin/oldmax to equivalent value between newmin/newmax\nremap(value, oldmin, oldmax, newmin, newmax) = ((value - oldmin) / (oldmax - oldmin)) * (newmax - newmin) + newmin\n\nfunction draw(c, imsize;\n      xmin = -2, ymin = -2, xmax  =  2, ymax = 2,\n      filename = \"/tmp/julia-set.png\")\n    imOutput = zeros(RGB{Float32}, imsize, imsize)\n    maxiterations = 200\n    for col = linspace(xmin, xmax, imsize)\n        for row = linspace(ymin, ymax, imsize)\n            pixelcolor = julia(complex(row, col), c, maxiterations) / 256\n            xpos = convert(Int, round(remap(col, xmin, xmax, 1, imsize)))\n            ypos = convert(Int, round(remap(row, ymin, ymax, 1, imsize)))\n            imOutput[xpos, ypos] = get(ColorSchemes.vermeer, pixelcolor)\n        end\n    end\n    FileIO.save(filename, imOutput)\nend\n\ndraw(-0.4 + 0.6im, 1200)"
},

{
    "location": "functionindex.html#",
    "page": "Index",
    "title": "Index",
    "category": "page",
    "text": ""
},

{
    "location": "functionindex.html#Index-1",
    "page": "Index",
    "title": "Index",
    "category": "section",
    "text": ""
},

]}
