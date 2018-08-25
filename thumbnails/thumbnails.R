rm(list=ls(all=TRUE)) #Clear the memory of variables from previous run. This is not called by knitr, because it's above the first chunk.

# ---- load-packages ------------------------------------------------------
library(magrittr)

# ---- declare-globals ------------------------------------------------------
url_repo      <- "https://github.com/OuhscBbmc/DeSheaToothakerIntroStats/blob/master"
image_width   <- 300L

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
    link_image = sprintf(
      '<a href="%s"><img border="0" alt="%s" src="%s" width="%i"></a>',
      path_remote,
      caption,
      path_local,
      image_width
    )
  ) %>% 
  dplyr::mutate(
    link_caption = sprintf(
      "[%s](%s)",
      caption,
      path_remote
    )
  )
# ds
# <a href="https://www.w3schools.com"><img border="0" alt="W3Schools" src="logo_w3s.gif" width="100"></a>

# ---- tweak-data ------------------------------------------------------
# (This code chunk is intentionally empty.)


# ---- display ----------------------------------------------------------
ds %>% 
  dplyr::select(
    name    = link_caption, 
    image   = link_image
  ) %>% 
  knitr::kable()
