# Changelog

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
