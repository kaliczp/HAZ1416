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

different.setup <- c(1,3:nrow(fulldir.df))
fulldir.df <- cbind(fulldir.df, channel = 1)
fulldir.df[different.setup, "channel"]  <- 0

## Submodule added
## git submodule add https://github.com/kaliczp/smartbe

source("smartbe/smartbe.R")
library(xts)

ttmp <- smartbe(paste0(fulldir.df[1, "year"], "/konvertalt/", fulldir.df[1, "fname"]), channel = fulldir.df[1, "channel"])
haz.xts <- xts(ttmp[,2], as.POSIXct(gsub("\\.","-",ttmp[,1])))

tti <- 2
print(tti)
ttmp <- smartbe(paste0(fulldir.df[tti, "year"], "/konvertalt/", fulldir.df[tti, "fname"]), channel = fulldir.df[tti, "channel"])
haz.xts <- c(haz.xts, xts(ttmp[,2], as.POSIXct(gsub("\\.","-",ttmp[,1]))))

plot(haz.xts)
