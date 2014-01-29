#For fonts, see Chang (2013) Recipe 14.6.  Install ghostscript (http://www.ghostscript.com/download/gsdnld.html),
# before installing the `extrafont` package.
#Run the following three lines of code once per machine (not once per session).
# install.packages("extrafont")
# require(extrafont) 
# extrafont::font_import()
# extrafont::fonts() #This just lists the available fonts for you to read; similar to extrafont::fonttable()

require(extrafont) 
require(grid)
require(ggplot2)
require(dichromat)
require(RColorBrewer)

#########################################################
### Define theme elements for ggplot2 graphs
#########################################################
# Documentation for modifiable theme elements can be found at http://docs.ggplot2.org/current/theme.html
BookTheme <- theme_bw() +
  theme(axis.text = element_text(colour="gray40")) +
  theme(axis.title = element_text(colour="gray40")) +
  theme(panel.border = element_rect(colour="gray80")) +
  theme(axis.ticks = element_line(colour="gray80"))

NoGridOrYLabelsTheme <- BookTheme  + 
  theme(axis.ticks.y = element_blank()) +
  theme(panel.grid = element_blank()) +
  theme(plot.margin=unit(c(.1,.2,.2,0), "lines"))

#########################################################
### Define palettes for variable sets, so they're consistent across graphs & chapters
#########################################################
transformColor <- function( palette ) {
  return( palette )
#   return( dichromat(palette, "deutan") )
#   return( dichromat(palette, "protan") )
#   return( dichromat(palette, "tritan") )
# Also see The Color Oracle application (http://colororacle.org/)
}

palettePregancyDelivery <- transformColor(adjustcolor(brewer.pal(3, "Accent"), alpha.f=1)[1:2])
palettePregancyDeliveryBad <- transformColor( c("#FF0000CC", "#00FFFFCC")) #Translucent red & cyan

palettePregancyGroup <- transformColor(adjustcolor(brewer.pal(3, "Dark2"), alpha.f=1)[1:2])
palettePregancyGroupBad <- transformColor(adjustcolor(c("blue", "maroon"), alpha.f=.7))

paletteObesityState <- transformColor(adjustcolor(brewer.pal(5, "Set1"))[c(1,2)])
paletteObesityState <- transformColor(adjustcolor(brewer.pal(5, "Dark2"))[c(2,3)])

paletteWorldDeathsRestricted <- c("#497862", "#A54891") #Hand-picked
paletteWorldDeathsRestrictedFaint <- adjustcolor(paletteWorldDeathsRestricted, alpha.f=.2)

# palettePregancy <- RColorBrewer::brewer.pal(n=4, name="Set2")[3:4]
# paletteObesityState <-  adjustcolor(brewer.pal(4, "Set2"))[3:4]
# paletteObesityStateBad <- adjustcolor(c("green", "red"), alpha.f=.7)

#Named colors in R:
# http://research.stowers-institute.org/efg/R/Color/Chart/ColorChart.pdf


#########################################################
### Declare functions used in multiple chapters
#########################################################
#This function is directly from Recipe 13.3 in Chang (2013).
LimitRange <- function( fun, min, max ) { 
  function( x ) {
    y <- fun(x)
    y[(x < min) | (max < x)] <- NA
    return( y )
  }
}
#########################################################
### Establish the font
#########################################################
## These three lines will use a nondefault font.
# extrafont::loadfonts() #Run this once per session.
# Sys.setenv(R_GSCMD = "C:/Program Files/gs/gs9.10/bin/gswin64c.exe")
# BookTheme <- BookTheme +  theme(text = element_text(family="Times New Roman"))

#########################################################
### Internal notes
#########################################################
# * The Pre-Press Manager said the dimensions of the images cannot exceed these dimensions: 33 picas wide x 51 picas tall. (5.5" x 8.5")
# *Physical Page width 7"x10"

# list.files(system.file("enc", package="grDevices"))

#########################################################
### Palettes to consider for future graphs
#########################################################
# https://github.com/jrnold/ggthemes
