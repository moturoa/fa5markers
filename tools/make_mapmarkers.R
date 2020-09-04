

# This script generates all map markers using all fontawesome icons,
# in many colors.

# The marker template is taken from leaflet.AwesomeMarkers plugin,
# see
# system.file("htmlwidgets/plugins/Leaflet.awesome-markers/images", package = "leaflet")

#----- Packages
library(magick)
library(glue)

# remotes::install_github("rstudio/fontawesome")
library(fontawesome)

#----- Icon list
# Not available? First run tools/generate_fa_sysdata.R
load("data/fa_tbl.rda")
fa_names <- fa_tbl$name

# Template with marker images
markers_img <- image_read("tools/markers-soft.png")

marker_colors <- c("red","orange","green","blue","purple",
            "darkred","darkblue","darkgreen","darkpurple",
            "navy","salmon","beige","lightgreen","lightblue",
            "pink","darkpink")


# Temp dir for fa icons.
icon_dir <- "tools/icons"
if(!dir.exists(icon_dir))dir.create(icon_dir)

# Output dir for markers with icons.
out_path <- "inst/mapmarkers"

# Function to make 1 map marker
make_icon <- function(name, marker_color, icon_color = "white"){

  out_path_color <- file.path(out_path, marker_color)
  if(!dir.exists(out_path_color))dir.create(out_path_color)

  i_color <- match(marker_color, marker_colors)

  png_icon_path <- glue::glue("{icon_dir}/{name}.png")
  fa_try <- try(fa_png(name, file = png_icon_path, height = 64, fill = icon_color))
  if(inherits(fa_try, "try-error")){
    warning(paste(name, "not found"))
    return(NULL)
  }

  out_path <- file.path(out_path_color, basename(png_icon_path))

  image_composite(
    image_crop(markers_img, glue::glue("36x45+{36*(i_color-1)}+0")),
    image_read(png_icon_path) %>% image_scale("16"),
    offset = "+10+11"
  ) %>%
    image_write(out_path)

}


# Make all icons
these_colors <- c("red","orange","green","blue","purple","darkred","darkblue","darkgreen","darkpurple","navy")
for(i in seq_along(fa_names)){

  for(col in these_colors){
    make_icon(fa_names[i], marker_color = col)
  }
  message(i," - ", fa_names[i])
}


