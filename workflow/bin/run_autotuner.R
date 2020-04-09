#!/usr/bin/env Rscript

library(Autotuner)
library(tools)
args = commandArgs(trailingOnly=TRUE)

print(args)

# Loading Metadata which should include all files
metadata <- read.table(args[1], sep=",", header = TRUE, stringsAsFactors = FALSE)
rawPaths <- metadata$filename
rawPaths <- paste0("./", args[2], "/", rawPaths)

if(!all(file.exists(rawPaths))) {
    stop("Not all files matched here exist.")
}


# Creating AutoTuner
Autotuner <- createAutotuner(rawPaths,
                             metadata,
                             file_col = "filename",
                             factorCol = "sample_type")

# Tuning signal
lag <- 25
threshold<- 3.1
influence <- 0.1
massThresh <- .005
returned_peaks <- 10
signals <- lapply(getAutoIntensity(Autotuner), 
                 ThresholdingAlgo, lag, threshold, influence)


Autotuner <- isolatePeaks(Autotuner = Autotuner, 
                          returned_peaks = returned_peaks, 
                          signals = signals)


eicParamEsts <- EICparams(Autotuner = Autotuner, 
                          massThresh = massThresh, 
                          verbose = TRUE,
                          returnPpmPlots = FALSE,
                          useGap = TRUE)

params = returnParams(eicParamEsts, Autotuner)

write.csv(params[1],args[3], row.names=FALSE, sep="\t")
write.csv(params[2],args[4], row.names=FALSE, sep="\t")
