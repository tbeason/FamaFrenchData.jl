# FamaFrenchData.jl

[FamaFrenchData.jl](https://github.com/tbeason/FamaFrenchData.jl) is a Julia package providing access to the Fama-French data available on the [Ken French Data Library](https://mba.tuck.dartmouth.edu/pages/faculty/ken.french/data_library.html). Working with the data is sometimes tedious because the downloadable files come (1) compressed in `zip` archives and (2) having non-standard `csv` layouts. This package handles both of those hurdles, allowing users to get to the data faster.

## Usage

To add the package, type `] add FamaFrenchData` at the Julia REPL.

Once added, type `using FamaFrenchData` to import the package.

The package exports 4 functions: `readFamaFrench`, `downloadFamaFrench`, `listFamaFrench`, and `clearFamaFrenchCache`.

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
using FamaFrenchData, DataFrames

savename = "path/to/my/file.csv"
downloadFamaFrench(savename,"F-F_Research_Data_Factors")
tables, tablenotes, filenotes = readFamaFrench(savename) # also reads local files
```

To get a list of all of the available table names, use `listFamaFrench`.

```julia
using FamaFrenchData
FFnames = listFamaFrench()
```

## Caching

The package includes automatic caching functionality using [Scratch.jl](https://github.com/JuliaPackaging/Scratch.jl) to improve performance and reduce network requests. Downloaded data is cached locally and automatically expires after 24 hours (since the data is updated at most daily).

### How Caching Works

- **First call**: Downloads data from the web and caches it in a persistent scratch space
- **Subsequent calls**: Uses cached data if it's less than 24 hours old
- **After 24 hours**: Automatically downloads fresh data and updates the cache

### Customizing Cache Behavior

```julia
# Use cache with default 24-hour expiration
tables, tablenotes, filenotes = readFamaFrench("F-F_Research_Data_Factors")

# Bypass cache for a specific call (always download fresh)
tables, tablenotes, filenotes = readFamaFrench("F-F_Research_Data_Factors", use_cache=false)

# Use cache with custom expiration (e.g., 12 hours)
tables, tablenotes, filenotes = readFamaFrench("F-F_Research_Data_Factors", cache_max_age=12)

# Clear all cached data
clearFamaFrenchCache()
```

The cache is stored in a scratch space managed by Julia, which means it persists across Julia sessions and is automatically cleaned up when the package is removed.

## Additional Notes

 - Original files use `-99.99` or `-999` to encode missing values, I attempt to replace these with `missing`.
 - Original files have no column heading for column 1, I name this column `:Date`. It maintains the parsed type of `Int` because it can take several different forms: `20011231`,`200112`,`2001`.
 - I have not verified that all tables are parsed correctly.
 - Breakpoints files require the keyword argument `header=false`


## Disclaimer


I am not affiliated with the Ken French Data Library. This package does not "ship with" the data, just provides easier access to it. Other than the changes that I have explicitly stated, I do not alter the data; however, it is your responsibility to verify that the data is correct.


## API


```@docs
readFamaFrench
downloadFamaFrench
listFamaFrench
clearFamaFrenchCache
```