library(Autotuner)
library(mtbls2)  

# Getting a list of paths concatentated
rawPaths <- c(
    system.file("/app/testing/daniel_data/Std_01_1.mzML", package = "mtbls2"),
    system.file("/app/testing/daniel_data/Std_01_2.mzML", package = "mtbls2")
    )

rawPaths =  c("/app/testing/daniel_data/Std_01_1.mzML", "/app/testing/daniel_data/Std_01_2.mzML")


print(getwd())
print(rawPaths)

if(!all(file.exists(rawPaths))) {
    stop("Not all files matched here exist.")
}

print("MING2")
print(rawPaths)

# Metadata processing
metadata <- read.table("/app/testing/daniel_data/metadata.csv", sep=",", header = TRUE, stringsAsFactors = FALSE)
print(metadata)

rawPaths <- metadata$filename
rawPaths <- paste0("/app/testing/daniel_data", "/", rawPaths)
print("MING")
print(rawPaths)

#metadata <- metadata[sub("mzData/", "", metadata$Raw.Spectral.Data.File) %in% 
#                         basename(rawPaths),]

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

print("OUTPUT PARAMETERS")
print(params)