

library(fa5markers)
tst <- read.csv2("c:/repos/rro_app/data/SBI_branches_include.csv") %>%
  setNames(c("sbi","sbi_omschrijving")) %>%
  slice(1:30)

dat <- expand.grid(lat = 1:6, lon = 1:6)[1:nrow(tst),]
icons <- kvkIcons(tst$sbi)

leaflet() %>%
  addMarkers(data = dat, icon = kvkIcons(tst$sbi))


icons <- kvkIcons(tst$sbi, names_only = TRUE)
cbind(tst$sbi_omschrijving, icons)
