% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/misc_and_utility.r
\name{umx_time}
\alias{umx_time}
\title{umx_time}
\usage{
umx_time(model = NA, formatStr = c("simple", "std", "custom \%H \%M \%OS3"),
  tz = "GMT")
}
\arguments{
\item{model}{An \code{\link{mxModel}} from which to get the elapsed time}

\item{formatStr}{A format string, defining how to show the time (defaults to human readable)}

\item{tz}{time zone in which the model was executed (defaults to "GMT")}
}
\value{
- invisible time string
}
\description{
A function to compactly report how long a model took to execute. Comes with some preset styles
User can set the format with C-style string formatting.
}
\details{
The default is "simple", which gives only the biggest unit used. i.e., "x seconds" for times under 1 minute.
"std" shows time in the format adopted in OpenMx 2.0 e.g. "Wall clock time (HH:MM:SS.hh): 00:00:01.16"

If a list of models is provided, time deltas will also be reported.

If the model hasn't been run, this function will run it for you.
}
\examples{
require(umx)
umx_time('start')
data(demoOneFactor)
latents  = c("G")
manifests = names(demoOneFactor)
m1 <- mxModel("One Factor", type = "RAM", 
	manifestVars = manifests, latentVars = latents, 
	mxPath(from = latents, to = manifests),
	mxPath(from = manifests, arrows = 2),
	mxPath(from = latents, arrows = 2, free = FALSE, values = 1.0),
	mxData(cov(demoOneFactor), type = "cov", numObs = 500)
)
m1 = umxRun(m1, setLabels = TRUE, setValues = TRUE)
umx_time(m1)
m2 = umxRun(m1)
umx_time(c(m1, m2))
umx_time('stop')
# elapsed time: 05.23 seconds
}
\references{
- \url{http://www.github.com/tbates/umx}
}
\seealso{
Other Reporting Functions: \code{\link{summaryAPA}},
  \code{\link{umx_APA_pval}}, \code{\link{umx_aggregate}},
  \code{\link{umx_print}}, \code{\link{umx_show}},
  \code{\link{umx}}
}

