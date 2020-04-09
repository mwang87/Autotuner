library(Autotuner)
library(mtbls2)  

# Getting a list of paths concatentated
rawPaths <- c(
    system.file("mzData/MSpos-Ex2-cyp79-48h-Ag-1_1-B,3_01_9828.mzData", 
                             package = "mtbls2"),
    system.file("mzData/MSpos-Ex2-cyp79-48h-Ag-2_1-B,4_01_9830.mzData", 
                package = "mtbls2"),
    system.file("mzData/MSpos-Ex2-cyp79-48h-Ag-4_1-B,4_01_9834.mzData", 
                package = "mtbls2")
    )

if(!all(file.exists(rawPaths))) {
    stop("Not all files matched here exist.")
}

print(rawPaths)

# Metadata processing
metadata <- read.table(system.file(
    "a_mtbl2_metabolite_profiling_mass_spectrometry.txt", 
    package = "mtbls2"), header = TRUE, stringsAsFactors = FALSE)

metadata <- metadata[sub("mzData/", "", metadata$Raw.Spectral.Data.File) %in% 
                         basename(rawPaths),]

print(metadata)

# Creating AutoTuner
Autotuner <- createAutotuner(rawPaths,
                             metadata,
                             file_col = "Raw.Spectral.Data.File",
                             factorCol = "Factor.Value.genotype.")

# Tuning signal
lag <- 25
threshold<- 3.1
influence <- 0.1
signals <- lapply(getAutoIntensity(Autotuner), 
                 ThresholdingAlgo, lag, threshold, influence)



Autotuner <- isolatePeaks(Autotuner = Autotuner, 
                          returned_peaks = 10, 
                          signals = signals)


eicParamEsts <- EICparams(Autotuner = Autotuner, 
                          massThresh = .005, 
                          verbose = FALSE,
                          returnPpmPlots = FALSE,
                          useGap = TRUE)

returnParams(eicParamEsts, Autotuner)