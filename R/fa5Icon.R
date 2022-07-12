#' Make a map marker with a FontAwesome 5 icon
#' @description Makes an icon for use in `leaflet` with the `makeIcon` function.
#' @param name Name of the icon ("anchor")
#' @param color One of 11 colors
#' @export
#' @importFrom glue glue
#' @importFrom leaflet makeIcon
fa5Icon <- function(name, color = "blue"){

  if(!all(color %in% fa5_allowed_colors())){
    stop(paste("Some colors not valid, allowed colors:", paste(fa5_allowed_colors(), collapse = ",")))
  }
  
  if(length(color) != length(name) & length(color) > 1){
    stop("Either specify a single color for all icons, or a vector of colors with the same length as 'name'")
  }

  icon_url <- system.file(glue::glue("mapmarkers/{color}/{name}.png"), package = "fa5markers")

  f_ex <- file.exists(icon_url)
  if(!(all(f_ex))){
    warning(paste("Not all icon names found: ", paste(unique(name[!f_ex]), collapse=",")))
    name[!f_ex] <- "question-circle"
    icon_url <- system.file(glue::glue("mapmarkers/{color}/{name}.png"), package = "fa5markers")
  }
  
  leaflet::makeIcon(icon_url,
           iconWidth = 36,
           iconHeight = 45,
           iconAnchorX = 18,
           iconAnchorY = 45)


}




fa5_allowed_colors <- function(){
  c("blue","darkblue","darkgreen","darkpurple",
    "darkred","green","navy","orange","pink",
    "purple","red")
}
