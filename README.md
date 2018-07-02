# Northern Irish migration study

## Overview

This repository contains empirical data and analysis on Northern Irish migration that complements a [recent article](/references/scotlands-populaiton-needs-and-migraiton-policy.pdf) published by the Scottish government on migration policy. The article essentially looked for a regionally tailored system of migration for their own country. They found the economic cost of reduced migration, particularly due to the impact of Brexit, would be in the region of almost £5bn per year by 2040. The same analysis should be done for Northern Ireland.

The purpose of this repositorty is to produce a number of models, charts and graphics that complement the Scottish study for the case of Northern Ireland. 

## Data

All data used in this study can be found in the `data` directory of this repository. Specifically, we pull from three main data sources:  

- Long-term migration statistics are collected from the [Northern Ireland Statistics and Research Agency (NISRA)](https://www.nisra.gov.uk/statistics/population/long-term-international-migration-statistics).

- UK-wide regional data and migration variants are collected from the [Office of National Statistics (ONS)](https://www.ons.gov.uk/peoplepopulationandcommunity/populationandmigration/populationprojections/bulletins/nationalpopulationprojections/2016basedstatisticalbulletin). 

- County and parliamentary-level map data are gathered from [Open Data Northern Ireland (ODNI)](https://www.opendatani.gov.uk/dataset/osni-open-data-largescale-boundaries-ni-outline1).

## Install requirements

We use `R` as the primary language for performing the analysis. Due to this, [base `R`](https://www.r-project.org/) needs to be installed. Moreover, a small number of `R` packages are required to run the analysis. These can be installed by running the `requirements.R` script, which can be found at the root of the `MigrationNI` directory. Therefore, from the terminal:
```
cd <path/to/MigrationNI>
Rscript requirements.R
```
Note that this installation script is only written for Ubuntu.

## Resulting images

The charts and graphics can be found in the [`images/editied`](https://github.com/O1sims/MigrationNI/tree/master/images/edited) directory. Here you will find another Markdown file documenting each image.

## Contact

Please contact [me](mailto:sims.owen@gmail.com) with regards any issues or queries that you have.
