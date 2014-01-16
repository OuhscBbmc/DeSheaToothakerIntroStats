#For fonts, see Chang (2013) Recipe 14.6.  Install ghostscript (http://www.ghostscript.com/download/gsdnld.html),
# before installing the `extrafont` package.
#Run the following three lines of code once per machine (not once per session).
# install.packages("extrafont")
# require(extrafont) 
# extrafont::font_import()
# extrafont::fonts() #This just lists the available fonts for you to read; similar to extrafont::fonttable()

require(extrafont) 
require(ggplot2)


#########################################################
### Define theme elements for ggplot2 graphs
#########################################################
# Documentation for modifiable theme elements can be found at http://docs.ggplot2.org/current/theme.html
BookTheme <- theme_bw() +
  theme(axis.text.x=element_text(colour="gray40")) +
  theme(axis.title.x=element_text(colour="gray40")) +
  theme(panel.border = element_rect(colour="gray80"))

#########################################################
### Define palettes for variable sets, so they're consistent across graphs & chapters
#########################################################

#palettePregancy <- RColorBrewer::brewer.pal(n=4, name="Set2")[3:4]
palettePregancyDelivery <-  adjustcolor(brewer.pal(3, "Accent"), alpha.f=1)[1:2]
palettePregancyDeliveryBad <- c("#FF0000CC", "#00FFFFCC") #Translucent red & cyan

palettePregancyGroup <-  adjustcolor(brewer.pal(3, "Dark2"), alpha.f=1)[1:2]
palettePregancyGroupBad <- adjustcolor(c("blue", "maroon"), alpha.f=.7)

#paletteObesityState <-  adjustcolor(brewer.pal(4, "Set2"))[3:4]
paletteObesityState <-  adjustcolor(brewer.pal(5, "Set1"))[c(1,2)]
paletteObesityState <-  adjustcolor(brewer.pal(5, "Dark2"))[c(2,3)]
# paletteObesityStateBad <- adjustcolor(c("green", "red"), alpha.f=.7)

 
## These three lines will use a nondefault font.
# extrafont::loadfonts() #Run this once per session.
# Sys.setenv(R_GSCMD = "C:/Program Files/gs/gs9.10/bin/gswin64c.exe")
# BookTheme <- BookTheme +  theme(text = element_text(family="Times New Roman"))


#Internal notes:
# * The Pre-Press Manager said the dimensions of the images cannot exceed these dimensions: 33 picas wide x 51 picas tall. (5.5" x 8.5")

# list.files(system.file("enc", package="grDevices"))
