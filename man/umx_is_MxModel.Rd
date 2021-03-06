% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/misc_and_utility.r
\name{umx_is_MxModel}
\alias{umx_is_MxModel}
\title{umx_is_MxModel}
\usage{
umx_is_MxModel(obj)
}
\arguments{
\item{obj}{an object to be tested to see if it is an OpenMx \code{\link{mxModel}}}
}
\value{
- Boolean
}
\description{
Utility function returning a binary answer to the question "Is this an OpenMx model?"
}
\examples{
m1 = mxModel("test")
if(umx_is_MxModel(m1)){
	message("nice OpenMx model!")
}
}
\references{
- \url{http://www.github.com/tbates/umx}
}
\seealso{
Other Test: \code{\link{umx_check_OS}},
  \code{\link{umx_check_model}},
  \code{\link{umx_check_names}},
  \code{\link{umx_check_parallel}},
  \code{\link{umx_check}}, \code{\link{umx_has_CIs}},
  \code{\link{umx_has_been_run}},
  \code{\link{umx_has_means}},
  \code{\link{umx_has_square_brackets}},
  \code{\link{umx_is_MxMatrix}}, \code{\link{umx_is_RAM}},
  \code{\link{umx_is_cov}},
  \code{\link{umx_is_endogenous}},
  \code{\link{umx_is_exogenous}},
  \code{\link{umx_is_ordered}}
}

