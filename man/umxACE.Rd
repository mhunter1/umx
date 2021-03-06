% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/build_run_modify.r
\name{umxACE}
\alias{umxACE}
\title{umxACE}
\usage{
umxACE(name = "ACE", selDVs, dzData, mzData, suffix = NULL, dzAr = 0.5,
  dzCr = 1, addStd = TRUE, addCI = TRUE, numObsDZ = NULL,
  numObsMZ = NULL, boundDiag = NULL, weightVar = NULL,
  equateMeans = TRUE, bVector = FALSE, hint = c("none", "left_censored"),
  autoRun = getOption("umx_auto_run"))
}
\arguments{
\item{name}{The name of the model (defaults to"ACE")}

\item{selDVs}{The variables to include from the data}

\item{dzData}{The DZ dataframe}

\item{mzData}{The MZ dataframe}

\item{suffix}{The suffix for twin 1 and twin 2, often "_T" (defaults to NULL) With this, you can
omit suffixes from names in SelDV, i.e., just "dep" not c("dep_T1", "dep_T2")}

\item{dzAr}{The DZ genetic correlation (defaults to .5, vary to examine assortative mating)}

\item{dzCr}{The DZ "C" correlation (defaults to 1: set to .25 to make an ADE model)}

\item{addStd}{Whether to add the algebras to compute a std model (defaults to TRUE)}

\item{addCI}{Whether to add intervals to compute CIs (defaults to TRUE)}

\item{numObsDZ}{= Number of DZ twins: Set this if you input covariance data}

\item{numObsMZ}{= Number of MZ twins: Set this if you input covariance data}

\item{boundDiag}{= Whether to bound the diagonal of the a, c, and e matrices}

\item{weightVar}{= If provided, a vector objective will be used to weight the data. (default = NULL)}

\item{equateMeans}{Whether to equate the means across twins (defaults to TRUE)}

\item{bVector}{Whether to compute row-wise likelihoods (defaults to FALSE)}

\item{hint}{An analysis hint. Options include "none", (default) "left_censored". Default does nothing.}

\item{autoRun}{Whether to mxRun the model (default TRUE: the estimated model will be returned)}
}
\value{
- \code{\link{mxModel}} of subclass mxModel.ACE
}
\description{
Make a 2-group ACE Cholesky Twin model (see Details below)
}
\details{
A common task in twin modelling involves using the genetic and environmental differences 
between large numbers of pairs of mono-zygotic (MZ) and di-zygotic (DZ) twins reared together
to model the genetic and environmental structure of one, or, typically, several phenotypes
(measured behaviors).

umxACE supports a core model in behavior genetics, known as the ACE Cholesky model
(Cardon and Neale, 1996). This model decomposes phenotypic variance into Additive genetic, 
unique environmental (E) and, optionally, either common or shared-environment (C) or 
non-additive genetic effects (D). This latter restriction emerges due to a lack of degrees of 
freedom to simultaneously model C and D with only MZ and DZ twin pairs {ref?}. The Cholesky or 
lower-triangle decomposition allows a model which is both sure to be solvable, and also to 
account for all the variance (with some restrictions) in the data. This model creates as 
many latent A C and E variables as there are phenotypes, and, moving from left to 
right, decomposes the variance in each component into successively restricted 
factors. The following figure shows how the ACE model appears as a path diagram:

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
names(tmpTwin)
# "fam", "age", "zyg", "part", "wt1", "wt2", "ht1", "ht2", "htwt1", "htwt2", "bmi1", "bmi2"

# Set zygosity to a factor
labList = c("MZFF", "MZMM", "DZFF", "DZMM", "DZOS")
tmpTwin$zyg = factor(tmpTwin$zyg, levels = 1:5, labels = labList)

# Pick the variables
selDVs = c("bmi1", "bmi2") # nb: Can also give base name, (i.e., "bmi") AND set suffix.
# the function will then make the varnames for each twin using this:
# for example. "VarSuffix1" "VarSuffix2"
mzData <- tmpTwin[tmpTwin$zyg \%in\% "MZFF", selDVs]
dzData <- tmpTwin[tmpTwin$zyg \%in\% "DZFF", selDVs]
mzData <- mzData[1:200,] # just top 200 so example runs in a couple of secs
dzData <- dzData[1:200,]
m1 = umxACE(selDVs = selDVs, dzData = dzData, mzData = mzData)
umxSummary(m1, showStd=TRUE)
umxSummaryACE(m1)
\dontrun{
plot(m1)
}
# ADE model (DZ correlation set to .25)
m2 = umxACE("ADE", selDVs = selDVs, dzData = dzData, mzData = mzData, dzCr = .25)
m2 = umxRun(m2)
umxCompare(m2, m1) # ADE is better
umxSummary(m2) # nb: though this is ADE, columns are labeled ACE


# ===================
# = Ordinal example =
# ===================
require(umx)
data(twinData)
tmpTwin <- twinData
names(tmpTwin)
# "fam", "age", "zyg", "part", "wt1", "wt2", "ht1", "ht2", "htwt1", "htwt2", "bmi1", "bmi2"

# Set zygosity to a factor
labList = c("MZFF", "MZMM", "DZFF", "DZMM", "DZOS")
tmpTwin$zyg = factor(tmpTwin$zyg, levels = 1:5, labels = labList)

# Cut bmi colum to form ordinal obesity variables
ordDVs = c("obese1", "obese2")
selDVs = c("obese")
obesityLevels = c('normal', 'overweight', 'obese')
cutPoints <- quantile(tmpTwin[, "bmi1"], probs = c(.5, .2), na.rm = TRUE)
tmpTwin$obese1 <- cut(tmpTwin$bmi1, breaks = c(-Inf, cutPoints, Inf), labels = obesityLevels) 
tmpTwin$obese2 <- cut(tmpTwin$bmi2, breaks = c(-Inf, cutPoints, Inf), labels = obesityLevels) 
# Make the ordinal variables into mxFactors (ensure ordered is TRUE, and require levels)
tmpTwin[, ordDVs] <- mxFactor(tmpTwin[, ordDVs], levels = obesityLevels)
mzData <- tmpTwin[tmpTwin$zyg \%in\% "MZFF", umx_paste_names(selDVs, "", 1:2)]
dzData <- tmpTwin[tmpTwin$zyg \%in\% "DZFF", umx_paste_names(selDVs, "", 1:2)]
mzData <- mzData[1:200,] # just top 200 so example runs in a couple of secs
dzData <- dzData[1:200,]
str(mzData)
m1 = umxACE(selDVs = selDVs, dzData = dzData, mzData = mzData, suffix = '')
\dontrun{
umxSummary(m1)
plot(m1)
}

# ============================================
# = Bivariate continuous and ordinal example =
# ============================================
data(twinData)
tmpTwin <- twinData
selDVs = c("wt", "obese")
# Set zygosity to a factor
labList = c("MZFF", "MZMM", "DZFF", "DZMM", "DZOS")
tmpTwin$zyg = factor(tmpTwin$zyg, levels = 1:5, labels = labList)

# Cut bmi column to form ordinal obesity variables
ordDVs = c("obese1", "obese2")
obesityLevels = c('normal', 'overweight', 'obese')
cutPoints <- quantile(tmpTwin[, "bmi1"], probs = c(.5, .2), na.rm = TRUE)
tmpTwin$obese1 <- cut(tmpTwin$bmi1, breaks = c(-Inf, cutPoints, Inf), labels = obesityLevels) 
tmpTwin$obese2 <- cut(tmpTwin$bmi2, breaks = c(-Inf, cutPoints, Inf), labels = obesityLevels) 
# Make the ordinal variables into mxFactors (ensure ordered is TRUE, and require levels)
tmpTwin[, ordDVs] <- mxFactor(tmpTwin[, ordDVs], levels = obesityLevels)
mzData <- tmpTwin[tmpTwin$zyg \%in\% "MZFF", umx_paste_names(selDVs, "", 1:2)]
dzData <- tmpTwin[tmpTwin$zyg \%in\% "DZFF", umx_paste_names(selDVs, "", 1:2)]
mzData <- mzData[1:200,] # just top 200 so example runs in a couple of secs
dzData <- dzData[1:200,]
str(mzData)
m1 = umxACE(selDVs = selDVs, dzData = dzData, mzData = mzData, suffix = '')
m1 = umxRun(m1)
umxSummary(m1)


# =======================================
# = Mixed continuous and binary example =
# =======================================
require(umx)
data(twinData)
tmpTwin <- twinData
labList = c("MZFF", "MZMM", "DZFF", "DZMM", "DZOS")
tmpTwin$zyg = factor(tmpTwin$zyg, levels = 1:5, labels = labList)
# Cut to form category of 20\% obese subjects
cutPoints <- quantile(tmpTwin[, "bmi1"], probs = .2, na.rm = TRUE)
obesityLevels = c('normal', 'obese')
tmpTwin$obese1 <- cut(tmpTwin$bmi1, breaks = c(-Inf, cutPoints, Inf), labels = obesityLevels) 
tmpTwin$obese2 <- cut(tmpTwin$bmi2, breaks = c(-Inf, cutPoints, Inf), labels = obesityLevels) 
# Make the ordinal variables into mxFactors (ensure ordered is TRUE, and require levels)
ordDVs = c("obese1", "obese2")
tmpTwin[, ordDVs] <- mxFactor(tmpTwin[, ordDVs], levels = obesityLevels)
selDVs = c("wt", "obese")
mzData <- tmpTwin[tmpTwin$zyg == "MZFF", umx_paste_names(selDVs, "", 1:2)]
dzData <- tmpTwin[tmpTwin$zyg == "DZFF", umx_paste_names(selDVs, "", 1:2)]
mzData <- mzData[1:200,] # just top 200 so example runs in a couple of secs
dzData <- dzData[1:200,]
str(mzData)
umx_paste_names(selDVs, "", 1:2)
m1 = umxACE(selDVs = selDVs, dzData = dzData, mzData = mzData, suffix = '')
m1 = umxRun(m1)
umxSummary(m1)

# ===================================
# Example with covariance data only =
# ===================================

require(umx)
data(twinData)
tmpTwin <- twinData
labList = c("MZFF", "MZMM", "DZFF", "DZMM", "DZOS")
tmpTwin$zyg = factor(tmpTwin$zyg, levels = 1:5, labels = labList)
selDVs = c("wt1", "wt2")
mz = cov(tmpTwin[tmpTwin$zyg \%in\% "MZFF", selDVs], use = "complete")
dz = cov(tmpTwin[tmpTwin$zyg \%in\% "DZFF", selDVs], use = "complete")
m1 = umxACE(selDVs= selDVs, dzData=dz, mzData=mz, numObsDZ=nrow(dzData), numObsMZ=nrow(mzData))
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
  \code{\link{umxACEcov}}, \code{\link{umxCF_SexLim}},
  \code{\link{umxCP}}, \code{\link{umxGxE_window}},
  \code{\link{umxGxE}}, \code{\link{umxIP}},
  \code{\link{umxPlotCP}}, \code{\link{umxPlotGxE}},
  \code{\link{umxSummaryACEcov}},
  \code{\link{umxSummaryACE}}, \code{\link{umxSummaryCP}},
  \code{\link{umxSummaryGxE}}, \code{\link{umxSummaryIP}},
  \code{\link{umx_make_TwinData}}, \code{\link{umx}}
}

