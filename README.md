<img src="https://github.com/O1sims/MigrationNI/raw/master/presentation/images/cbi-logo.png" height="75px" width="160px" align="right" />

# Northern Irish migration study

## Overview

This repository contains empirical data and analysis on Northern Irish migration that complements a [recent article](/references/scotlands-populaiton-needs-and-migraiton-policy.pdf) published by the Scottish government on migration policy. The article looks for a regionally tailored system of migration for Scotland. They find the economic cost of reduced migration, particularly due to the impact of Brexit, would be in the region of almost £5bn per year by 2040. The same analysis should be done for Northern Ireland.

The purpose of this repositorty is to produce a number of models, charts and figures that complement the Scottish study for the case of Northern Ireland.

## Data

All data used in this study can be found in the `data` directory of this repository. Specifically, we pull from three main data sources:  

- Long-term migration statistics are collected from the [Northern Ireland Statistics and Research Agency (NISRA)](https://www.nisra.gov.uk/statistics/population/long-term-international-migration-statistics).

- UK-wide regional data and migration variants are collected from the [Office of National Statistics (ONS)](https://www.ons.gov.uk/peoplepopulationandcommunity/populationandmigration/populationprojections/bulletins/nationalpopulationprojections/2016basedstatisticalbulletin).

- County and parliamentary-level map data for Northern Ireland are gathered from [Open Data Northern Ireland (ODNI)](https://www.opendatani.gov.uk/dataset/osni-open-data-largescale-boundaries-ni-outline1).

A complete list of all data sources can be found [here](https://github.com/O1sims/MigrationNI/tree/master/figures/edited/README.md).

## Requirements

We use `R` as the primary language for performing econometric and statistical analysis. To reproduce the figures and analysis, [base `R`](https://www.r-project.org/) needs to be installed. Moreover, a small number of `R` packages are required to run the analysis. These can be installed by running the `requirements.R` script, which can be found at the root of the `MigrationNI` directory. Therefore, from the terminal:
```
cd <path/to/MigrationNI>
Rscript requirements.R
```
Note that this installation script is only written for Ubuntu.

## Run analysis

You can run the full analysis and generate the figures using the `main.R` script. This can be run within the `R` enviornment itself, or alternatively can be run from the terminal with the following commands:
```
cd <path/to/MigrationNI>
Rscript main.R
``` 

## Resulting figures

The resulting charts and figures can be found in the [`figures/editied`](https://github.com/O1sims/MigrationNI/tree/master/figures/edited) directory. Here, you will find another [README](https://github.com/O1sims/MigrationNI/tree/master/figures/edited/README.md) file which documents each figure.

## Presentation

A presentation was delivered to the CBI Northern Ireland on the impact of Brexit to the Northern Irish economy. This provided a brief overview of the impact of Brexit on three important economic areas: migration, trade and investment. A PDF and an ODP version of the presentation can be found in the [`presentation`](https://github.com/O1sims/MigrationNI/tree/master/presentation) directory.

## Contact

Please contact [me](mailto:sims.owen@gmail.com) with regards any issues or queries that you have.
