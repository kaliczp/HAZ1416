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
## End of year duplication removed
fulldir.df <- fulldir.df[!(fulldir.df[,"fname"] == "HAZc31.TXT" & fulldir.df[,"year"] == 2015),]

## Submodule added
## git submodule add https://github.com/kaliczp/smartbe

source("smartbe/smartbe.R")
library(xts)

ttmp <- smartbe(paste0(fulldir.df[1, "year"], "/konvertalt/", fulldir.df[1, "fname"]), channel = fulldir.df[1, "channel"])
ttdata <- data.frame(Stage = ttmp[,2], Filenr = 1)
haz.xts <- xts(ttdata, as.POSIXct(gsub("\\.","-",ttmp[,1])))
for(tti in 2:nrow(fulldir.df)) {
    print(tti)
    ttmp <- smartbe(paste0(fulldir.df[tti, "year"], "/konvertalt/", fulldir.df[tti, "fname"]), channel = fulldir.df[tti, "channel"])
    ttdata <- data.frame(Stage = ttmp[,2], Filenr = tti)
    if(length(grep("[a-z]", ttmp[1,"DateTime"])) > 0) {
        ## Character date format
        ttimestamp <- as.POSIXct(strptime(head(ttmp[,1]), format = "%Y. %B %d. %T"))
    } else {
        ## Numeric date format
        ttimestamp <- as.POSIXct(gsub("\\.","-",ttmp[,1]))
    haz.xts <- c(haz.xts, xts(ttdata, ttimestamp))
    }
}

plot(haz.xts)
