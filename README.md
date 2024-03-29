# FamaFrenchData.jl

<!-- [![Documentation](https://img.shields.io/badge/docs-stable-blue.svg)](https://tbeason.github.io/FamaFrenchData.jl/stable) -->
<!-- ![Lifecycle](https://img.shields.io/badge/lifecycle-maturing-blue.svg) -->
<!-- ![Lifecycle](https://img.shields.io/badge/lifecycle-stable-green.svg) -->
<!-- ![Lifecycle](https://img.shields.io/badge/lifecycle-retired-orange.svg) -->
<!-- ![Lifecycle](https://img.shields.io/badge/lifecycle-archived-red.svg) -->
<!-- ![Lifecycle](https://img.shields.io/badge/lifecycle-dormant-blue.svg)  -->
[![Documentation](https://img.shields.io/badge/docs-stable-blue.svg)](https://tbeason.github.io/FamaFrenchData.jl/stable)
![Lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg)
[![CI](https://github.com/tbeason/FamaFrenchData.jl/workflows/CI/badge.svg)](https://github.com/tbeason/FamaFrenchData.jl/actions?query=workflow%3ACI)
[![codecov.io](http://codecov.io/github/tbeason/FamaFrenchData.jl/coverage.svg?branch=master)](http://codecov.io/github/tbeason/FamaFrenchData.jl?branch=master)


A Julia package for easy access to the [Ken French Data Library](https://mba.tuck.dartmouth.edu/pages/faculty/ken.french/data_library.html). The Ken French Data Library is one of the most highly used publicly available data sources for financial investments and asset pricing research.

Working with the data is sometimes tedious because the downloadable files come (1) compressed in `zip` archives and (2) having non-standard `csv` layouts. This package handles both of those hurdles, allowing users to get to the data faster.


## Usage

To add the package, type `] add FamaFrenchData` at the Julia REPL.

Once added, type `using FamaFrenchData` to import the package.

The package exports 3 functions: `readFamaFrench`, `downloadFamaFrench`, and `listFamaFrench`.

For help with any of these functions, use `?` at the REPL (eg. `?readFamaFrench`).

Please consult the online [documentation](https://tbeason.github.io/FamaFrenchData.jl/stable) for additional detail.

## Example 
The Fama-French 3 factor model is a commonly used empirical asset pricing model. This example retrieves the full time series of FF3 monthly and annual returns.

```julia
using FamaFrenchData, DataFrames

# read the Fama-French 3 factors (monthly and annual)
tables, tablenotes, filenotes = readFamaFrench("F-F_Research_Data_Factors")

FF3_monthly = tables[1]
FF3_annual = tables[2]

# read the Fama-French 3 factors (daily)
tablesd, tablenotesd, filenotesd = readFamaFrench("F-F_Research_Data_Factors_Daily")
FF3_daily = tables[1]

# read the 25 Size-B/M portfolios (monthly and annual)
tables25, tablenotes25, filenotes25 = readFamaFrench("25_Portfolios_5x5")
FF_ME_BM_25 = tables25[1]
```


## Disclaimer


I am not affiliated with the Ken French Data Library. This package does not "ship with" the data, just provides easier access to it. Other than the changes that I have explicitly stated, I do not alter the data; however, it is your responsibility to verify that the data is correct.
