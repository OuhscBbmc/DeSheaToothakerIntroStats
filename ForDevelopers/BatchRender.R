rm(list=ls(all=TRUE)) #Clear the memory of variables from previous run. This is not called by knitr, because it's above the first chunk.

reportNames <- c(paste0("Chapter", sprintf("%02d", c(2:5, 7:14))), "Tables")
reportPaths <- sprintf("./%1$s/%1$s.Rmd", reportNames)
for( reportPath in reportPaths ) {
  print(paste("Rendering", reportPath))
  rmarkdown::render(reportPath, output_format="all")
}

# rmarkdown::md_document()
# rmarkdown::render("./Chapter04/Chapter04.Rmd", output_format="all")
