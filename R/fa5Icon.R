#' Make a map marker with a FontAwesome 5 icon
#' @description Makes an icon for use in `leaflet` with the `makeIcon` function.
#' @param name Name of the icon ("anchor")
#' @param color One of 11 colors
#' @export
#' @importFrom glue glue
fa5Icon <- function(name, color =  c("blue","darkblue","darkgreen","darkpurple",
                                             "darkred","green","navy","orange","pink",
                                             "purple","red")){

  color <- match.arg(color)

  icon_url <- system.file(glue("mapmarkers/{color}/{name}.png"), package = "fa5markers")

  makeIcon(icon_url,
           iconWidth = 36,
           iconHeight = 45,
           iconAnchorX = 18,
           iconAnchorY = 45)


}

