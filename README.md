# FamaFrenchData.jl

![Lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg)<!--
![Lifecycle](https://img.shields.io/badge/lifecycle-maturing-blue.svg)
![Lifecycle](https://img.shields.io/badge/lifecycle-stable-green.svg)
![Lifecycle](https://img.shields.io/badge/lifecycle-retired-orange.svg)
![Lifecycle](https://img.shields.io/badge/lifecycle-archived-red.svg)
![Lifecycle](https://img.shields.io/badge/lifecycle-dormant-blue.svg) -->
[![Build Status](https://travis-ci.com/tbeason/FamaFrenchData.jl.svg?branch=master)](https://travis-ci.com/tbeason/FamaFrenchData.jl)
[![codecov.io](http://codecov.io/github/tbeason/FamaFrenchData.jl/coverage.svg?branch=master)](http://codecov.io/github/tbeason/FamaFrenchData.jl?branch=master)
<!--
[![Documentation](https://img.shields.io/badge/docs-stable-blue.svg)](https://tbeason.github.io/FamaFrenchData.jl/stable)
[![Documentation](https://img.shields.io/badge/docs-master-blue.svg)](https://tbeason.github.io/FamaFrenchData.jl/dev)
-->

A Julia package for easy access to the [Ken French Data Library](https://mba.tuck.dartmouth.edu/pages/faculty/ken.french/data_library.html). The Ken French Data Library is one of the most highly used publicly available data sources for financial investments and asset pricing research.

Working with the data is sometimes tedious because the downloadable files come (1) compressed in `zip` archives and (2) having non-standard `csv` layouts. This package handles both of those hurdles, allowing users to get to the data faster.


## Usage

To add the package, type `] add FamaFrenchData` at the Julia REPL.

Once added, type `using FamaFrenchData` to import the package.

The package exports 3 functions: `readFamaFrench`, `downloadFamaFrench`, and `listFamaFrench`.

For help with any of these functions, use `?` at the REPL (eg. `?readFamaFrench`).

## Example 
The Fama-French 3 factor model is a commonly used empirical asset pricing model. This example retrieves the full time series of FF3 monthly and annual returns.

```julia
using FamaFrenchData, DataFrames

tables, tablenotes, filenotes = readFamaFrench("F-F_Research_Data_Factors")

FF3_monthly = tables[1]
FF3_annual = tables[2]
```

If you would rather store the file locally (perhaps so your code is reproducible later on), use `downloadFamaFrench`.

```julia
savename = "path/to/my/file.csv"
downloadFamaFrench(savename,"F-F_Research_Data_Factors")
tables, tablenotes, filenotes = readFamaFrench(savename) # also reads local files
```

To get a list of all of the available table names, use `listFamaFrench`.

```julia
FFnames = listFamaFrench()
```

## Additional Notes

 - Original files use `-99.99` or `-999` to encode missing values, I attempt to replace these with `missing`.
 - Original files have no column heading for column 1, I name this column `:Date`. It maintains the parsed type of `Int` because it can take several different forms: `20011231`,`200112`,`2001`.
 - I have not verified that all tables are parsed correctly.
 - Breakpoints files require the keyword argument `header=false`


## Disclaimer


I am not affiliated with the Ken French Data Library. This package does not "ship with" the data, just provides easier access to it. Other than the changes that I have explicitly stated, I do not alter the data; however, it is your responsibility to verify that the data is correct.
