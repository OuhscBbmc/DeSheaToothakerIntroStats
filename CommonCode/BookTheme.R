#For fonts, see Chang (2013) Recipe 14.6.  Install ghostscript (http://www.ghostscript.com/download/gsdnld.html),
# before installing the `extrafont` package.
#Run the following three lines of code once per machine (not once per session).
# install.packages("extrafont")
# require(extrafont) 
# extrafont::font_import()
# extrafont::fonts() #This just lists the available fonts for you to read

require(extrafont) 
require(ggplot2)

# extrafont::fonttable()
extrafont::loadfonts() #Run this once per session.
Sys.setenv(R_GSCMD = "C:/Program Files/gs/gs9.10/bin/gswin64c.exe")

# Documentation for modifiable theme elements can be found at http://docs.ggplot2.org/current/theme.html
BookTheme <- theme_bw() +
  theme(text = element_text(family="Times New Roman"))
#   theme(text = element_text(family="Times New Roman"))

#Internal notes:
# * The “Pre-Press Manager” said the dimensions of the images cannot exceed these dimensions:  33 picas wide x 51 picas tall. (5.5" x 8.5")

# list.files(system.file("enc", package="grDevices"))
