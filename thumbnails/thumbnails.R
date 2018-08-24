rm(list=ls(all=TRUE)) #Clear the memory of variables from previous run. This is not called by knitr, because it's above the first chunk.

# ---- load-packages ------------------------------------------------------
library(magrittr)

# ---- declare-globals ------------------------------------------------------

display <- function( path ) {
  # cat(path, "\n\n")
  # cat(sprintf("[![%s](%s)](%s)\n\n", basename(path), path, "path"))
  cat(sprintf("![%s](../%s)\n\n", basename(path), path))
}

# ---- load-data ------------------------------------------------------

# ---- tweak-data ------------------------------------------------------
# (This code chunk is intentionally empty.)


# ---- display ----------------------------------------------------------
files <- list.files(
  recursive = T,
  full.names = T,
  include.dirs = F,
  pattern   = "*.png"
)

files[1:10] %>% 
  purrr::walk(display)
