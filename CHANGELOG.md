# Changelog

## [v3.26.0] - 2024-07-21

### Added

- Pride palette
- ScientificColorSchemes v8.0 now includes Categorical palettes

### Removed

### Deprecated

###################################################################

## [v3.25.0] - 2024-05-09

### Added

- mpetroff's accessible-color-cycles (https://github.com/mpetroff/accessible-color-cycles) (thanks @moelf!)

- ibm_cvd (Color Blind Safe Palette of IBM Design Language v1 Color Names: Ultramarine 40, Indigo 50, Magenta 50 , Orange 40, Gold 20, Black 100) (thanks @ValentinKaisermayer
)

- Studio Ghibli palettes (https://github.com/ewenme/ghibli) (thanks @tecosaur!)

### Removed

### Deprecated

###################################################################

## [v3.24.0] - 2023-09-21 09:04:58

### Added

- Wes Anderson palettes (https://github.com/karthik/wesanderson)

- Pacific North West palettes (https://github.com/jakelawlor/PNWColors)

## Changed

- updated ScientificColorSchemes to version 8.0.0. Note that some schemes (grayC
  bilbao lajolla acton bamako batlowK tokyo) have been changed (or reversed)
  slightly since their 7.0 release - see [version history
  (PDF)](https://www.fabiocrameri.ch/ws/media-library/d799f7fecb4e439998e43597cd397a6c/readme_scientificcolourmaps.pdf)
  for details.

- use Documenter v1

### Removed

### Deprecated

###################################################################

## [v3.23.0] - 2023-08-08

### Added

- kindlmann 

## Changed

- CompatHelper.yml

### Removed

### Deprecated

###################################################################

## [v3.22.0] - 2023-07-21 12:45:58

### Added

## Changed

- ColorVectorSpace to v0.10

### Removed

### Deprecated

###################################################################

## [v3.21.0] - 2023-04023 09:00

### Added

## Changed

- use `===` for symbols (thanks @t-bltg)

- updated Scientific ColorMaps (thanks @jarredclloyd)

### Removed

### Deprecated

###################################################################

## [v3.20.0] - 2022-11-28 09:53

### Added

- we took Paul Tol seriously (#102) (thanks @tecosaur!)
- SnoopPrecompile dep
- twelvebitrainbow

## Changed

### Removed

### Deprecated

###################################################################

## [v3.19.0] - 2022-06-23 10:51

### Added

- cividis - thanks @t-bltg! 

## Changed

error handling - #95 - thanks @adrhill!

### Removed

### Deprecated

###################################################################

## [v3.18.0] - 2022-05-06

### Added

- some more MetBrewer palettes

- some more ColorBrewer palettes

- add dependency on ColorVectorSpaces

## Changed

- optimized `get()` - #91 - thanks @stevengj !

### Removed

### Deprecated

###################################################################

## [v3.17.1] - 2022-02-11

### Added

## Changed

### Removed

- unnecessary dependency on Luxor (thanks @fredrikekre)

### Deprecated

###################################################################

## [v3.17] - 2022-02-08

### Added

- added misc Julia colors (thanks @davibarreira)
- added fastie/NDVI (thanks @lazarusA)
- added nordtheme (thanks Stefano Meschiari)

## Changed

### Removed

### Deprecated

###################################################################
## [v3.16] - 2022-01-11

### Added

- added MetBrewer palettes (thanks @BlakeRMills & @briochemc)

## Changed

### Removed

### Deprecated

###################################################################

## [v3.15] - 2021-09-25

### Added

- :websafe (thanks @adrhill!)
- :dracula
- :vanhelsing

## Changed

- findcolorscheme() returns list of matching scheme names as symbols

### Removed

### Deprecated

## [v3.14] - 2021 August 10

### Added

- `*` concatenates two colorschemes

## Changed

- dependency on StaticArrays
- norwegian flag colors

### Removed

### Deprecated

## [v3.13] - 2021 July 8

### Added

## Changed

- docs: swatches now SVG, after Documenter 0.27 released
- docs: catalogue of schemes reworked

### Removed

### Deprecated

## [v3.12.1] - 2021 April 21

### Added

## Changed

- export reverse()

### Removed

### Deprecated

## [v3.12.0] - 2021 April 14

### Added

- iteration fix - (#63)
- missing Colorcet -  (#65)

## Changed

### Removed

### Deprecated

## [v3.11.0] - 2021 March 25

### Added

- cvd/colorblind friendly schemes added (#51)

## Changed

- use github rather than Travis
- fixed test #61

### Removed

### Deprecated

## [v3.10.1] - 2020 September 28

### Added

- more ggthemes/tableau scheme added (thanks ohmsweetohm1!)

## Changed

- fixed empty range (#43)

### Removed

### Deprecated


## [v3.10.0] - 2020 September 19

### Added

- ggthemes/tableau scheme added (thanks ohmsweetohm1!)

## Changed

- renamed cmocean grey -> greys
- renamed general grays -> grays1

### Removed

### Deprecated

## [v3.9.0] - 2020 April 27

### Added

## Changed

- added Seaborn
- documentation of colorschemes

### Removed

### Deprecated

## [v3.8.0] - 2020 April 18

### Added

## Changed

- use StaticArrays
- performance improvements (thanks rafaqz)

### Removed

### Deprecated

## [v3.7.0] - 2020 April 12

### Added

- getindex
- lastindex

### Changed

### Removed

### Deprecated

## [v3.6.0] - 2020 February 14

### Added

- added scientific color schemes from Fabio Crameri
- update travis
- (slightly) better documents for schemes
- transparent logo/icon

### Changed

### Removed

### Deprecated

## [v3.5.0] - October 14

### Added

- get(scheme, ::Gray) method added
- dependencies on ColorTypes and FixedPointNumbers

### Changed

### Removed

### Deprecated

## [v3.4.0] - 2019-08-21

### Added

- turbo

### Changed

### Removed

### Deprecated

## [v3.3.0] - 2019-06-01

### Added

### Changed

- REQUIRE -> Project.toml

### Removed

### Deprecated

## [v3.2.0] - minor updates - 2019-03-25

### Added

- reverse() for ColorScheme
- docs update

### Changed

-

### Removed

-

### Deprecated

-

## [v3.1.0] - minor changes - 2019-02-15

### Added

- twilight added
- reverse() for ColorScheme

### Changed

-

### Removed

-

### Deprecated

-

## [v3.0.0] - re-factored - 2019-01-24

### Added

- many functions moved from ColorSchemes v2.0.0
- loadcolorscheme()
- findcolorscheme()

### Changed

- nearly everything

### Removed

- all functionality using Images and Clustering moved to ColorSchemeTools

### Deprecated

-
