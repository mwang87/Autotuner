% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/findPeakWidth.R
\name{findPeakWidth}
\alias{findPeakWidth}
\title{findPeakWidth}
\usage{
findPeakWidth(approvScorePeaks, mzDb, header, sortedAllEIC, boundaries, ppmEst)
}
\arguments{
\item{approvScorePeaks}{A data.frame containing information on the
retained bins.}

\item{mzDb}{A list of data.frames containing the m/z and intensity values
from each scan's mass spectra.}

\item{header}{A data.fame containing metadata on the sample like
spectra type (MS1 vs MS2), retention time, and scan count.}

\item{sortedAllEIC}{A data.frame containing observed EIC values along with
their corresponsing scan ID.}

\item{boundaries}{A numeric vector with indicies representing the scans
bounding the original TIC peak.}

\item{ppmEst}{A scalar value representing the calculated ppm error
used to generate data.}
}
\value{
This function returns a scalar value representing an estimate for
the maximal peak width across samples.
}
\description{
This function is designed to find the maximum peakwidth of an
EIC observed within a given TIC peak. It does so by using checkBounds to
estimate width in time of a peak and countMaxima
to determine if a peak may be made up from two similar structural isomers.
}
