fulldir.df <- data.frame(year = numeric(), fname = character())
for(ttyear in 2014:2016) {
    dircontent <- dir(path = paste0("./", ttyear, "/konvertalt"))
    ttnocsak <- dircontent[grep("csak", dircontent, invert = TRUE)]
    ttnomegj <- ttnocsak[grep("megj", ttnocsak, invert = TRUE)]
    dircontent.df <- data.frame(year = ttyear,
                                fname = ttnomegj
                                )
    fulldir.df <- rbind(fulldir.df, dircontent.df)
}

different.setup <- 1
fulldir.df <- cbind(fulldir.df, channel = 1)
fulldir.df[different.setup, "channel"]  <- 0

## Submodule added
## git submodule add https://github.com/kaliczp/smartbe

source("smartbe/smartbe.R")
smartbe(paste0(fulldir.df[1, "year"], "/konvertalt/", fulldir.df[1, "fname"]), channel = fulldir.df[1, "channel"])
smartbe(paste0(fulldir.df[1, "year"], "/konvertalt/", fulldir.df[2, "fname"]), channel = fulldir.df[1, "channel"])
