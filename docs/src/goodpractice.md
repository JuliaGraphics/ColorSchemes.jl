```@setup catalog
using Luxor, ColorSchemes, Colors

function draw_lightness_swatch(cs::ColorScheme, width = 800, height=150;
		name="")
	@drawsvg begin
		hmargin= 30
		vmargin= 20
		bb = BoundingBox(Point(-width/2 + hmargin, -height/2 + vmargin), Point(width/2 - hmargin, height/2 - vmargin))

		background("black")
		fontsize(8)
		sethue("white")
		setline(0.5)
		box(bb, :stroke)

		tickline(boxbottomleft(bb), boxbottomright(bb), major = 9, axis=false,
			major_tick_function = (n, pos; startnumber, finishnumber, nticks) ->
				text(string(n/10), pos + (0, 12), halign=:center)
			)

		tickline(boxbottomright(bb), boxtopright(bb), major = 9, axis=false,
			major_tick_function = (n, pos; startnumber, finishnumber, nticks) ->
				text(string(10n), pos + (0, 20), angle=π/2, halign=:right, valign=:middle)
			)

		text("lightness", boxtopleft(bb) + (10, 10), halign=:right, angle=-π/2)

		fontsize(12)
		L = 70
		sw = width/L
		saved = Point[]
		for i in range(0.0, 1.0, length=L)
			pos = between(boxmiddleleft(bb), boxmiddleright(bb), i)
			color = get(cs, i)
			setcolor(color)
			labcolor = convert(Lab, color)
			lightness = labcolor.l
			lightnesspos = pos + (0, boxheight(bb)/2 - rescale(labcolor.l, 0, 100, 0, boxheight(bb)))
			push!(saved, lightnesspos)
			circle(lightnesspos, 5, :fill)

		end

#		setline(1)
#		sethue("black")
#		line(saved[1], saved[end], :stroke)
#		setline(0.8)
#		line(saved[1], saved[end], :stroke)

        sethue("white")
		text(name, boxtopcenter(bb) + (0, -6), halign=:center)
	end width height
end
```

# Good practice

There are hundreds of colorschemes in this package, and they're useful for many different purposes. However, if you're intending to use a colorscheme for communicating features of a scientific dataset, you should choose it with care.

## Perceptual uniformity

You should choose a __perceptually uniform__ colorscheme: a set of colors arranged so that equal steps in data are _perceived_ by the viewer as equal steps in the color space.

Researchers[^Kovesi][^ZhouHansen] have found that the human brain perceives changes in the lightness parameter as changes in the data much better than, for example, changes in hue. So sequential colorschemes with monotonically increasing lightness values will be better interpreted by the viewer.

The **Lab color space** represents a color with three components: Lightness, RedGreen, and YellowBlue. The Lightness parameter can be used to indicate how uniform the colors will be perceived by viewers.

In the following diagrams, the Lightness Lab component of each color step is plotted in `y` as `x` moves through the colorscheme. You can see how the lightness increases evenly in the recommended schemes.

## Recommended

### Sequential

Good choices include `viridis`, `inferno`, `plasma`, `magma`:

```@example catalog
using Luxor, ColorSchemes, Colors # hide
d1 = draw_lightness_swatch(ColorSchemes.viridis, 400, 150 ; name="viridis") # hide
d2 = draw_lightness_swatch(ColorSchemes.inferno, 400, 150 ; name="inferno") # hide
hcat(d1, d2) # hide
```

```@example catalog
using Luxor, ColorSchemes, Colors # hide
d1 = draw_lightness_swatch(ColorSchemes.plasma, 400, 150 ; name="plasma") # hide
d2 = draw_lightness_swatch(ColorSchemes.magma, 400, 150 ; name="magma") # hide
hcat(d1, d2) # hide
```

ColorCET schemes (`findcolorscheme("colorcet")` will return the very long names to save you typing them):

```@example catalog
using Luxor, ColorSchemes, Colors # hide
d1 = draw_lightness_swatch(ColorSchemes.linear_kbc_5_95_c73_n256, 400, 150 ; name="linear_kbc_5_95_c73_n256") # hide
d2 = draw_lightness_swatch(ColorSchemes.linear_tritanopic_krjcw_5_95_c24_n256, 400, 150 ; name="linear_tritanopic_krjcw_5_95_c24_n256") # hide
hcat(d1, d2) # hide
```

Fabio Crameri's Scientific colorschemes:

```@example catalog
using Luxor, ColorSchemes, Colors # hide
d1 = draw_lightness_swatch(ColorSchemes.tokyo, 400, 150 ; name="tokyo") # hide
d2 = draw_lightness_swatch(ColorSchemes.devon, 400, 150 ; name="devon") # hide
hcat(d1, d2) # hide
```

```@example catalog
using Luxor, ColorSchemes, Colors # hide
d1 = draw_lightness_swatch(ColorSchemes.hawaii, 400, 150 ; name="hawaii") # hide
d2 = draw_lightness_swatch(ColorSchemes.buda, 400, 150 ; name="buda") # hide
hcat(d1, d2) # hide
```

### Diverging

For diverging colorschemes, the lightness values of the extremes should be broadly equivalent.
As well as the `diverging-` ColorCET colorschemes, there are suitable schemes in Scientific, ColorBrewer, and others.

```@example catalog
using Luxor, ColorSchemes, Colors # hide
d1 = draw_lightness_swatch(ColorSchemes.RdBu, 400, 150 ; name="RdBu") # hide
d2 = draw_lightness_swatch(ColorSchemes.BrBg, 400, 150 ; name="BrBg") # hide
hcat(d1, d2) # hide
```

```@example catalog
using Luxor, ColorSchemes, Colors # hide
d1 = draw_lightness_swatch(ColorSchemes.RdBu, 400, 150 ; name="RdBu") # hide
d2 = draw_lightness_swatch(ColorSchemes.BrBg, 400, 150 ; name="BrBg") # hide
hcat(d1, d2) # hide
```

```@example catalog
using Luxor, ColorSchemes, Colors # hide
d1 = draw_lightness_swatch(ColorSchemes.diverging_bwr_55_98_c37_n256, 400, 150 ; name="diverging_bwr_55_98_c37_n256") # hide
d2 = draw_lightness_swatch(ColorSchemes.diverging_rainbow_bgymr_45_85_c67_n256, 400, 150 ; name="diverging_rainbow_bgymr_45_85_c67_n256") # hide
hcat(d1, d2) # hide
```					  

## Less suitable for data visualization

Colorschemes with rapid changes in lightness are less suitable, because the viewer's interpretation of a region of data might be influenced by the coloring, rather than by the data values.

```@example catalog
using Luxor, ColorSchemes, Colors # hide
d1 = draw_lightness_swatch(ColorSchemes.gnuplot, 400, 150 ; name="gnuplot") # hide
d2 = draw_lightness_swatch(ColorSchemes.jet, 400, 150 ; name="jet") # hide
hcat(d1, d2) # hide
```

```@example catalog
using Luxor, ColorSchemes, Colors # hide
d1 = draw_lightness_swatch(ColorSchemes.Hiroshige, 400, 150 ; name="Hiroshige") # hide
d2 = draw_lightness_swatch(ColorSchemes.Hokusai1, 400, 150 ; name="Hokusai1") # hide
hcat(d1, d2) # hide
```

```@example catalog
using Luxor, ColorSchemes, Colors # hide
d1 = draw_lightness_swatch(ColorSchemes.dracula, 400, 150 ; name="dracula") # hide
d2 = draw_lightness_swatch(ColorSchemes.cubehelix, 400, 150 ; name="cubehelix") # hide
hcat(d1, d2) # hide
```

## References

[^Kovesi]:
	Good Colour Maps: How to Design Them |
	Peter Kovesi |
	arXiv:1509.03700 [cs.GR] |
	https://doi.org/10.48550/arXiv.1509.03700

[^ZhouHansen]:
	A Survey of Colormaps in Visualization |
	Liang Zhou, Charles D Hansen |
	https://pubmed.ncbi.nlm.nih.gov/26513793/
