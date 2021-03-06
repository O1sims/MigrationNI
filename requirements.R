#' Install required R packages
#'
#' @title Install R Packages
#'
#' @description This script installs all necessary packages that have not
#'  already been installed.
#'
#' @details The installation process is as follows:
#'  (1) Check whether each package has ready been installed on the system;
#'  (2) Install any missing packages securly from CRAN; and
#'  (3) Install gEcon from source.
#'
#' Note that this file is an Rscript, not a function.


# CRAN mirror
cranRepo <- 'http://cran.us.r-project.org'

# Install devtools if not installed already
# Required for installing versions
if (!("devtools" %in% installed.packages())) {
  utils::install.packages(
    "devtools",
    repos = cranRepo)
}

# CRAN packges to install with versions
packageList <- list(
  "ggplot2" = "2.2.1",
  "magrittr" = "1.5",
  "ggthemes" = "3.5.0",
  "rgdal" = "	1.3-3",
  "jsonlite" = "1.5",
  "nleqslv" = "	3.3.2",
  "Matrix" = "1.2-14",
  "MASS" = "7.3-50",
  "Rcpp" = "0.12.17")

# Generate an array of packages that have not already been installed
newPackages <- subset(names(packageList), 
                      !(names(packageList) %in% installed.packages()))

# Install any new packages from CRAN
if (length(newPackages) > 0) {
  for (package in newPackages) {
    devtools::install_version(
      package = package,
      version = packageList[[package]],
      repos = cranRepo)
  }
}

# Install gEcon from source (Ubuntu)
install.packages(
  "http://gecon.r-forge.r-project.org/files/gEcon_1.1.0.tar.gz",
  repos = NULL, 
  type = "source")
