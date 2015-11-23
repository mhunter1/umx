% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/build_run_modify.r
\name{umxCP}
\alias{umxCP}
\title{umxCP}
\usage{
umxCP(name = "CP", selDVs, dzData, mzData, suffix = NULL, nFac = 1,
  freeLowerA = FALSE, freeLowerC = FALSE, freeLowerE = FALSE,
  correlatedA = FALSE, equateMeans = T, dzAr = 0.5, dzCr = 1,
  addStd = T, addCI = T, numObsDZ = NULL, numObsMZ = NULL)
}
\arguments{
\item{name}{The name of the model (defaults to "CP")}

\item{selDVs}{The variables to include}

\item{dzData}{The DZ dataframe}

\item{mzData}{The MZ dataframe}

\item{suffix}{The suffix for twin 1 and twin 2, often "_T" (defaults to NULL) With this, you can
omit suffixes from names in SelDV, i.e., just "dep" not c("dep_T1", "dep_T2")}

\item{nFac}{How many common factors (default = 1)}

\item{freeLowerA}{Whether to leave the lower triangle of A free (default = F)}

\item{freeLowerC}{Whether to leave the lower triangle of C free (default = F)}

\item{freeLowerE}{Whether to leave the lower triangle of E free (default = F)}

\item{correlatedA}{?? (default = F)}

\item{equateMeans}{Whether to equate the means across twins (defaults to T)}

\item{dzAr}{The DZ genetic correlation (defaults to .5, vary to examine assortative mating)}

\item{dzCr}{The DZ "C" correlation (defaults to 1: set to .25 to make an ADE model)}

\item{addStd}{Whether to add the algebras to compute a std model (defaults to TRUE)}

\item{addCI}{Whether to add the interval requests for CIs (defaults to TRUE)}

\item{numObsDZ}{= not yet implemented: Ordinal Number of DZ twins: Set this if you input covariance data}

\item{numObsMZ}{= not yet implemented: Ordinal Number of MZ twins: Set this if you input covariance data}
}
\value{
- \code{\link{mxModel}}
}
\description{
Make a 2-group Common Pathway model
}
\details{
The following figure shows the CP model as a path diagram:

\figure{CP.png}
}
\examples{
require(umx)
data(twinData) 
zygList = c("MZFF", "MZMM", "DZFF", "DZMM", "DZOS")
twinData$ZYG = factor(twinData$zyg, levels = 1:5, labels = zygList)
selDVs = c("ht", "wt")
mzData <- subset(twinData, ZYG == "MZFF", umx_paste_names(selDVs, "", 1:2))
dzData <- subset(twinData, ZYG == "DZFF", umx_paste_names(selDVs, "", 1:2))
m1 = umxCP(selDVs = selDVs, dzData = dzData, mzData = mzData, suffix = "")
m1 = umxRun(m1)
umxSummary(m1, dotFilename=NA) # dotFilename = NA to avoid opening a plot window during CRAN check
umxGetParameters(m1, "^c", free = TRUE)
m2 = umxReRun(m1, update = "(cs_.*$)|(c_cp_)", regex = TRUE, name = "dropC")
umxSummaryCP(m2, comparison = m1, dotFilename = NA)
umxCompare(m1, m2)
}
\references{
- \url{http://www.github.com/tbates/umx}
}
\seealso{
- \code{\link{plot}()}, \code{\link{umxSummary}()} work for IP, CP, GxE, SAT, and ACE models.

Other Twin Modeling Functions: \code{\link{umxACESexLim}},
  \code{\link{umxACE}}, \code{\link{umxCF_SexLim}},
  \code{\link{umxGxE_window}}, \code{\link{umxGxE}},
  \code{\link{umxIP}}, \code{\link{umxPlotCP}},
  \code{\link{umxPlotGxE}}, \code{\link{umxSummaryACE}},
  \code{\link{umxSummaryCP}}, \code{\link{umxSummaryGxE}},
  \code{\link{umxSummaryIP}}, \code{\link{umx}}
}
