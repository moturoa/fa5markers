
library(fa5markers)

library(dplyr)
library(stringr)
library(glue)
library(leaflet)

.icon_mapping <- read.csv2("test/sbi_icon_mapping.csv", colClasses = "character") %>%
  setNames(c("sbi","fontawesomename"))
.icon_mapping$sbi[nchar(.icon_mapping$sbi) == 1] <- paste0("0",.icon_mapping$sbi[nchar(.icon_mapping$sbi) == 1])

.sbi_codes <- read.csv2("test/sbi_all_codes.csv")


find_icon_for_sbi <- function(sbi_code, default = "home"){

  # sbi_code mag een vector zijn
  sbi_ <- as.character(sbi_code)

  supp_sbi <- unique(.icon_mapping$sbi)

  i_icon <- sapply(sbi_,USE.NAMES = FALSE, function(sbi_lookup){

    for(i in 1:nchar(sbi_lookup)){

      # make the sbi one char shorter
      substr_sbi <- as.integer(substr(sbi_lookup, 1, nchar(sbi_lookup)+ 1 - i))

      # if match; return fontawesome name
      if (substr_sbi %in% supp_sbi) {

        matches <- .icon_mapping %>%
          dplyr::filter(sbi == !!substr_sbi) %>%
          dplyr::select(fontawesomename)

        return(as.character(matches[1,1]))
      }
      # if nothing matches; use a default
      else if (i == nchar(sbi_lookup)) {
        return(as.character(default))
      }
    }
    return(NULL)

  })

  i_icon

}



.sbi_codes$sbi_fix <- .sbi_codes$sbi %>%
  str_replace_all("[.]", "") %>%
  str_trim

find_icon_for_sbi(sbis[50])


x <- "8891"
.icon_mapping$sbi





test_icon <- function(){
  i <- sample(1:nrow(.sbi_codes),1)
  s <- .sbi_codes$sbi_fix[i]
  print(.sbi_codes[i,])

  fa <- lookup_sbi_icon(s)
  icon_url <- system.file(glue("mapmarkers/blue/{fa}.png"), package = "fa5markers")

  icon_ <- makeIcon(icon_url,
                    iconWidth = 36,
                    iconHeight = 45,
                    iconAnchorX = 18,
                    iconAnchorY = 45)

  leaflet() %>%
    addMarkers(data = tibble(lon=1,lat=1),
               icon = icon_)

}


y <- c("4759","3316")

sapply(y, lookup_sbi_icon)



lookup_sbi_icon <- function(x, default = "home"){

  mtch <- startsWith(x, .icon_mapping$sbi)

  if(!any(mtch))return(default)

  sbi_mtch <- .icon_mapping$sbi[mtch]
  sbi_lookup <- sbi_mtch[which.max(nchar(sbi_mtch))]

  .icon_mapping$fontawesome[.icon_mapping$sbi == sbi_lookup]
}


kvkIcons <- function(x, color = c("blue","darkblue","darkgreen","darkpurple",
                                  "darkred","green","navy","orange","pink",
                                  "purple","red"),
                     names_only = FALSE){

  color <- match.arg(color)

  x <- as.character(x)

  # alleen nummers overhouden
  x <- str_replace_all(x, "[^[0-9]]", "") %>%
    str_trim

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


tst <- read.csv2("c:/repos/rro_app/data/SBI_branches_include.csv") %>%
  setNames(c("sbi","sbi_omschrijving")) %>%
  slice(1:30)

dat <- expand.grid(lat = 1:6, lon = 1:6)[1:nrow(tst),]
icons <- kvkIcons(tst$sbi)

leaflet() %>%
  addMarkers(data = dat, icon = kvkIcons(tst$sbi))



