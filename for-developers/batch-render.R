rm(list=ls(all=TRUE)) #Clear the memory of variables from previous run. This is not called by knitr, because it's above the first chunk.

requireNamespace("pacman")

chaptersToRender <- c(2:5, 7:14)
reportNames <- c(sprintf("chapter-%02d", chaptersToRender), "tables")
reportPaths <- sprintf("./%1$s/%1$s.Rmd", reportNames)
for( reportPath in reportPaths ) {
  pacman::p_unload(pacman::p_loaded(), character.only = TRUE)
  print(paste("Rendering", reportPath))
  rmarkdown::render(reportPath, output_format="all", envir=new.env())
}

# rmarkdown::md_document()
# rmarkdown::render("./Chapter04/Chapter04.Rmd", output_format="all")
