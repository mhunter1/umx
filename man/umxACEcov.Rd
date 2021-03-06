% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/build_run_modify.r
\name{umxACEcov}
\alias{umxACEcov}
\title{umxACEcov}
\usage{
umxACEcov(name = "ACEcov", selDVs, selCovs, dzData, mzData, suffix = NULL,
  dzAr = 0.5, dzCr = 1, addStd = TRUE, addCI = TRUE, boundDiag = NULL,
  equateMeans = TRUE, bVector = FALSE, hint = c("none", "left_censored"),
  autoRun = getOption("umx_auto_run"))
}
\arguments{
\item{name}{The name of the model (defaults to"ACE")}

\item{selDVs}{The variables to include from the data (do not include suffixes)}

\item{selCovs}{The covariates to include from the data (do not include suffixes)}

\item{dzData}{The DZ dataframe}

\item{mzData}{The MZ dataframe}

\item{suffix}{The suffix for twin 1 and twin 2, often "_T" (defaults to NULL) With this, you can
omit suffixes from names in SelDV, i.e., just "dep" not c("dep_T1", "dep_T2")}

\item{dzAr}{The DZ genetic correlation (defaults to .5, vary to examine assortative mating)}

\item{dzCr}{The DZ "C" correlation (defaults to 1: set to .25 to make an ADE model)}

\item{addStd}{Whether to add the algebras to compute a std model (defaults to TRUE)}

\item{addCI}{Whether to add intervals to compute CIs (defaults to TRUE)}

\item{boundDiag}{= Whether to bound the diagonal of the a, c, and e matrices}

\item{equateMeans}{Whether to equate the means across twins (defaults to TRUE)}

\item{bVector}{Whether to compute row-wise likelihoods (defaults to FALSE)}

\item{hint}{An analysis hint. Options include "none", (default) "left_censored". Default does nothing.}

\item{autoRun}{Whether to run the model and return it, or just return it}
}
\value{
- \code{\link{mxModel}} of subclass mxModel.ACEcov
}
\description{
Make a 2-group ACE Cholesky Twin model with covariates modeled (see Details below)
}
\details{
A common task in twin modelling involves using the genetic and environmental differences 
between large numbers of pairs of mono-zygotic (MZ) and di-zygotic (DZ) twins reared together
to model the genetic and environmental structure of one, or, typically, several phenotypes
(measured behaviors).

umxACEcov supports a core model in behavior genetics, known as the ACE Cholesky model
(Cardon and Neale, 1996), supplemented with covariates.
The ACE model decomposes phenotypic variance into Additive genetic, 
unique environmental (E) and, either common xor shared-environment (C) or 
non-additive genetic effects (D). The following figure shows how the ACE model appears as a path diagram:

\figure{ACE.png}

\strong{Data Input}
The function flexibly accepts raw data, and also summary covariance data 
(in which case the user must also supple numbers of observations for the two input data sets).

\strong{Ordinal Data}
In an important capability, the model transparently handles ordinal (binary or multi-level
ordered factor data) inputs, and can handle mixtures of continuous, binary, and ordinal
data in any combination. An experimental feature is under development to allow Tobit modelling.

The function also supports weighting of individual data rows. In this case,
the model is estimated for each row individually, then each row likelihood
is multiplied by its weight, and these weighted likelyhoods summed to form
the model-likelihood, which is to be minimised.
This feature is used in the non-linear GxE model functions.

\strong{Additional features}
The umxACE function supports varying the DZ genetic association (defaulting to .5)
to allow exploring assortative mating effects, as well as varying the DZ \dQuote{C} factor
from 1 (the default for modelling family-level effects shared 100% by twins in a pair),
to .25 to model dominance effects.
}
\examples{
# Height, weight, and BMI data from Australian twins. 
# The total sample has been subdivided into a young cohort, aged 18-30 years,
# and an older cohort aged 31 and above.
# Cohort 1 Zygosity is coded as follows: 
# 1 == MZ females 2 == MZ males 3 == DZ females 4 == DZ males 5 == DZ opposite sex pairs
# tip: ?twinData to learn more about this data set
require(umx)
data(twinData)
tmpTwin <- twinData
# add age 1 and age 2 columns
tmpTwin$age1 = tmpTwin$age2 = tmpTwin$age
# Pick the variables. We will use base names (i.e., "bmi") and set suffix.
selDVs  = c("bmi")
selCovs = c("age")
selVars = umx_paste_names(c(selDVs, selCovs), textConstant = "", suffixes= 1:2)
# just top 200 so example runs in a couple of secs
mzData = subset(tmpTwin, zyg == 1, selVars)[1:200, ]
dzData = subset(tmpTwin, zyg == 3, selVars)[1:200, ]
# TODO update for new dataset variable zygosity
# mzData = subset(tmpTwin, zygosity == "MZFF", selVars)[1:200, ]
# dzData = subset(tmpTwin, zygosity == "DZFF", selVars)[1:200, ]
m1 = umxACEcov(selDVs = selDVs, selCovs = selCovs, dzData = dzData, mzData = mzData, 
	 suffix = "", autoRun = TRUE)
umxSummary(m1)
\dontrun{
plot(m1)
}
}
\references{
- \url{http://www.github.com/tbates/umx}
}
\seealso{
Other Twin Modeling Functions: \code{\link{umxACESexLim}},
  \code{\link{umxACE}}, \code{\link{umxCF_SexLim}},
  \code{\link{umxCP}}, \code{\link{umxGxE_window}},
  \code{\link{umxGxE}}, \code{\link{umxIP}},
  \code{\link{umxPlotCP}}, \code{\link{umxPlotGxE}},
  \code{\link{umxSummaryACEcov}},
  \code{\link{umxSummaryACE}}, \code{\link{umxSummaryCP}},
  \code{\link{umxSummaryGxE}}, \code{\link{umxSummaryIP}},
  \code{\link{umx_make_TwinData}}, \code{\link{umx}}
}

