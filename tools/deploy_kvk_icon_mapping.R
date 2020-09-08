


kvk_icon_mapping <- read.csv2("test/sbi_icon_mapping.csv", colClasses = "character") %>%
  setNames(c("sbi","fontawesomename"))
kvk_icon_mapping$sbi[nchar(kvk_icon_mapping$sbi) == 1] <- paste0("0",kvk_icon_mapping$sbi[nchar(kvk_icon_mapping$sbi) == 1])


usethis::use_data(kvk_icon_mapping, overwrite = TRUE)

