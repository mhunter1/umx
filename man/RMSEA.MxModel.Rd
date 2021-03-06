% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/fit_and_reporting.r
\name{RMSEA.MxModel}
\alias{RMSEA.MxModel}
\title{RMSEA function for MxModels}
\usage{
\method{RMSEA}{MxModel}(x, ci.lower = 0.05, ci.upper = 0.95, digits = 3)
}
\arguments{
\item{x}{an \code{\link{mxModel}} from which to get RMSEA}

\item{ci.lower}{the lower CI to compute}

\item{ci.upper}{the upper CI to compute}

\item{digits}{digits to show (defaults to 3)}
}
\value{
- object containing the RMSEA and lower and upper bounds
}
\description{
Compute the confidence interval on RMSEA
}
\examples{
require(umx)
data(demoOneFactor)
latents  = c("G")
manifests = names(demoOneFactor)
m1 <- umxRAM("One Factor", data = mxData(cov(demoOneFactor), type = "cov", numObs = 500),
	umxPath(latents, to = manifests),
	umxPath(var = manifests),
	umxPath(var = latents, fixedAt = 1.0)
)
RMSEA(m1)
}
\references{
- \url{https://github.com/simsem/semTools/wiki/Functions}, \url{https://github.com/tbates/umx}
}
\seealso{
Other Reporting functions: \code{\link{RMSEA.summary.mxmodel}},
  \code{\link{RMSEA}}, \code{\link{confint.MxModel}},
  \code{\link{extractAIC.MxModel}},
  \code{\link{logLik.MxModel}}, \code{\link{plot.MxModel}},
  \code{\link{residuals.MxModel}},
  \code{\link{umxCI_boot}}, \code{\link{umxCI}},
  \code{\link{umxCompare}}, \code{\link{umxExpCov}},
  \code{\link{umxExpMeans}}, \code{\link{umxFitIndices}},
  \code{\link{umxPlotACEcov}}, \code{\link{umxPlotACE}},
  \code{\link{umxStandardizeModel}},
  \code{\link{umxSummary.MxModel}},
  \code{\link{umxSummaryACE}}, \code{\link{umx_drop_ok}}
}

