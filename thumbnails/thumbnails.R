rm(list=ls(all=TRUE)) #Clear the memory of variables from previous run. This is not called by knitr, because it's above the first chunk.

# ---- load-packages ------------------------------------------------------
library(magrittr)

# ---- declare-globals ------------------------------------------------------
url_repo      <- "https://github.com/OuhscBbmc/DeSheaToothakerIntroStats/blob/master"
image_width   <- 300L

display <- function( path ) {
  # cat(path, "\n\n")
  # cat(sprintf("[![%s](%s)](%s)\n\n", basename(path), path, "path"))
  cat(sprintf("![%s](../%s)\n\n", basename(path), path))
}

# ---- load-data ------------------------------------------------------
files <- list.files(
  recursive = T,
  full.names = F,
  include.dirs = F,
  pattern   = "*.png"
)

ds <- files[1:20] %>% 
  tibble::tibble(
    file = .
  ) %>% 
  dplyr::mutate(
    caption       = basename(file),
    path_local    = paste0("../", file),
    path_remote   = file.path(url_repo, file)
  ) %>% 
  dplyr::mutate(
    link = sprintf(
      '<a href="%s"><img border="0" alt="%s" src="%s" width="%i"></a>',
      path_remote,
      caption,
      path_local,
      image_width
    )
    # md            = sprintf("![%s](%s)\n\n", caption, path),
    # entry     = md
  )
ds
# <a href="https://www.w3schools.com"><img border="0" alt="W3Schools" src="logo_w3s.gif" width="100"></a>

# ---- tweak-data ------------------------------------------------------
# (This code chunk is intentionally empty.)


# ---- display ----------------------------------------------------------

# ds$entry[1:15] %>%
#   # dplyr::slice(1:15) %>%
#   purrr::pwalk(function(x) cat(x, "\n"))
cat(ds$link[1:15], sep="\n")
# purrr::pwalk(~cat(., "\n"))

# files[1:10] %>% 
#   purrr::walk(display)
