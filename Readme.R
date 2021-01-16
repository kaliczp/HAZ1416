ttyear <- 2014
dircontent <- dir(path = paste0("./", ttyear, "/konvertalt"))
dircontent.df <- data.frame(year = ttyear,
                            fname = dircontent[grep("csak", dircontent, invert = TRUE)]
                            )

## Submodule added
## git submodule add https://github.com/kaliczp/smartbe

source("smartbe/smartbe.R")
smartbe(paste0(dircontent.df[1, "year"], "/konvertalt/", dircontent.df[1, "fname"]), channel=0)
smartbe(paste0(dircontent.df[1, "year"], "/konvertalt/", dircontent.df[2, "fname"]))
