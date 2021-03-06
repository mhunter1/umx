% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/misc_and_utility.r
\name{umx_check_names}
\alias{umx_check_names}
\title{umx_check_names}
\usage{
umx_check_names(namesNeeded, data, die = TRUE, no_others = FALSE)
}
\arguments{
\item{namesNeeded}{list of variable names to find}

\item{data}{data.frame (or matrix) to search in for names}

\item{die}{whether to die if the check fails (defaults to TRUE)}

\item{no_others}{Whether to test that the data contain no columns in addition to those in namesNeeded (defaults to FALSE)}
}
\description{
Check if a list of names are in the names() of a dataframe (or the of a matrix)
}
\examples{
require(umx)
data(demoOneFactor) # "x1" "x2" "x3" "x4" "x5"
umx_check_names(c("x1", "x2"), demoOneFactor)
umx_check_names(c("x1", "x2"), as.matrix(demoOneFactor))
umx_check_names(c("x1", "x2"), cov(demoOneFactor[,c("x1","x2")]))
umx_check_names(c("z1", "x2"), data = demoOneFactor, die = FALSE)
umx_check_names(c("x1", "x2"), data = demoOneFactor, die = FALSE, no_others = TRUE)
umx_check_names(c("x1","x2","x3","x4","x5"), data = demoOneFactor, die = FALSE, no_others = TRUE)
\dontrun{
umx_check_names(c("bad_var_name", "x2"), data = demoOneFactor, die = TRUE)
}
}
\references{
- \url{http://www.github.com/tbates/umx}
}
\seealso{
Other Building Functions: \code{\link{umx_cov_diag}}

Other Test: \code{\link{umx_check_OS}},
  \code{\link{umx_check_model}},
  \code{\link{umx_check_parallel}},
  \code{\link{umx_check}}, \code{\link{umx_has_CIs}},
  \code{\link{umx_has_been_run}},
  \code{\link{umx_has_means}},
  \code{\link{umx_has_square_brackets}},
  \code{\link{umx_is_MxMatrix}},
  \code{\link{umx_is_MxModel}}, \code{\link{umx_is_RAM}},
  \code{\link{umx_is_cov}},
  \code{\link{umx_is_endogenous}},
  \code{\link{umx_is_exogenous}},
  \code{\link{umx_is_ordered}}
}

