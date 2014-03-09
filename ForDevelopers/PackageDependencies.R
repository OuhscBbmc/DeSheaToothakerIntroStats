#This code checks the user's installed packages against a list of packages (that we've manually compiled) 
#   necessary for our 'MReporting' repository to be fully operational. Missing packages are installed, while existing packages are not.
#   If anyone sees a package that should be on there, please tell me.
rm(list=ls(all=TRUE)) #Clear the memory for any variables set from any previous runs.

packagesToInstall <- c(
    "colorspace" #Explicit control over the HCL color scheme
#   , "devtools" #package development
  , "epade" #has the 3D barchart used in 
  , "ggplot2" #Graphing
  , "ggthemes" #Extra themes, scales and geoms for ggplot
  , "ggmap" #Maps & graphics, based on ggplot
  , "googleVis" #JavaScript-based visualizations, like scrollable tables
#   , "grid" #The underlying framework for the graphics used in this pacakge
#   , "gridBase" #Additional grid functions
  , "knitr" #For reporting
  , "lubridate" #Consistent/convienent function signatures for manipulating dates
  , "MASS" #for generating multivariate normal distributions, among other things
  , "mnormt" #For calculating density of multivariate normal distribution
  , "plotrix" #Has extra graphing functions
  , "plyr" #Important for most of our data manipulation
  , "RColorBrewer" #Explicit control over the Color Brewer colors.  See http://colorbrewer2.org/
  , "rgl" #3D plotting
  , "reshape2" #Data manipulation not covered in plyr
  , "scales" #Formating values in graphs
#   , "stringr" #Consistent/convienent function signatures for manipulating text
  , "testit" #has the useful `assert()` function
) 

for( packageName in packagesToInstall ) {
  available <- require(packageName, character.only=TRUE) #Loads the packages, and indicates if it's available
  if( !available ) {
    install.packages(packageName, dependencies=TRUE)
    require( packageName, character.only=TRUE)
  }
}

update.packages(ask="graphics", checkBuilt=TRUE)

#There will be a warning message for every  package that's called but not installed.  It will look like:
#    Warning message:
#        In library(package, lib.loc = lib.loc, character.only = TRUE, logical.return = TRUE,  :
#        there is no package called 'bootstrap'
#If you see the message (either in here or in another piece of the project's code),
#   then run this again to make sure everything is installed.  You shouldn't get a warning again.