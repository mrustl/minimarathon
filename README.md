[![R-CMD-check](https://github.com/mrustl/minimarathon/workflows/R-CMD-check/badge.svg)](https://github.com/mrustl/minimarathon/actions?query=workflow%3AR-CMD-check)
[![pkgdown](https://github.com/mrustl/minimarathon/workflows/pkgdown/badge.svg)](https://github.com/mrustl/minimarathon/actions?query=workflow%3Apkgdown)
[![codecov](https://codecov.io/github/mrustl/minimarathon/branch/main/graphs/badge.svg)](https://codecov.io/github/mrustl/minimarathon)
[![Project Status](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![CRAN_Status_Badge](https://www.r-pkg.org/badges/version/minimarathon)]()
[![R-Universe_Status_Badge](https://mrustl.r-universe.dev/badges/minimarathon)](https://mrustl.r-universe.dev/)

# minimarathon

R Package for Visualising Results from BWB Minimarathon.

## Installation

For details on how to install KWB-R packages checkout our [installation tutorial](https://kwb-r.github.io/kwb.pkgbuild/articles/install.html).

```r
### Optionally: specify GitHub Personal Access Token (GITHUB_PAT)
### See here why this might be important for you:
### https://kwb-r.github.io/kwb.pkgbuild/articles/install.html#set-your-github_pat

# Sys.setenv(GITHUB_PAT = "mysecret_access_token")

# Install package "remotes" from CRAN
if (! require("remotes")) {
  install.packages("remotes", repos = "https://cloud.r-project.org")
}

# Install KWB package 'minimarathon' from GitHub
remotes::install_github("mrustl/minimarathon")
```

## Documentation

Release: [https://mrustl.github.io/minimarathon](https://mrustl.github.io/minimarathon)

Development: [https://mrustl.github.io/minimarathon/dev](https://mrustl.github.io/minimarathon/dev)
