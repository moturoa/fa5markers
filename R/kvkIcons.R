
#' Make map markers for KvK branches
#' @param x Vector of SBI codes (e.g. "01.11.1","6723","6"), with or without periods and spaces.
#' @param color Color of the map marker (one of a number of choices, not free to set).
#' @param names_only If TRUE, returns only the fontawesome name of the icon (for testing), otherwise (an)
#' icon(s) made with leaflet::makeIcon
#' @export
#' @importFrom stringr str_trim str_replace_all
kvkIcons <- function(x, color = c("blue","darkblue","darkgreen","darkpurple",
                                  "darkred","green","navy","orange","pink",
                                  "purple","red"),
                     names_only = FALSE){

  color <- match.arg(color)

  x <- as.character(x)

  # alleen nummers overhouden
  x <- stringr::str_replace_all(x, "[^[0-9]]", "") %>%
    stringr::str_trim(.)

  # "1" etc. moet "01" etc. zijn.
  x[nchar(x) == 1] <- paste0("0", x[nchar(x) == 1])

  fa <- sapply(x, lookup_sbi_icon, USE.NAMES = FALSE)

  if(names_only)return(fa)

  icon_url <- system.file(glue("mapmarkers/{color}/{fa}.png"), package = "fa5markers")

  makeIcon(icon_url,
           iconWidth = 36,
           iconHeight = 45,
           iconAnchorX = 18,
           iconAnchorY = 45)


}


lookup_sbi_icon <- function(x, default = "home"){

  mtch <- startsWith(x, kvk_icon_mapping$sbi)

  if(!any(mtch))return(default)

  sbi_mtch <- kvk_icon_mapping$sbi[mtch]
  sbi_lookup <- sbi_mtch[which.max(nchar(sbi_mtch))]

  kvk_icon_mapping$fontawesome[kvk_icon_mapping$sbi == sbi_lookup]
}
