var documenterSearchIndex = {"docs":
[{"location":"#FamaFrenchData.jl","page":"Home","title":"FamaFrenchData.jl","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"FamaFrenchData.jl is a Julia package providing access to the Fama-French data available on the Ken French Data Library. Working with the data is sometimes tedious because the downloadable files come (1) compressed in zip archives and (2) having non-standard csv layouts. This package handles both of those hurdles, allowing users to get to the data faster.","category":"page"},{"location":"#Usage","page":"Home","title":"Usage","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"To add the package, type ] add FamaFrenchData at the Julia REPL.","category":"page"},{"location":"","page":"Home","title":"Home","text":"Once added, type using FamaFrenchData to import the package.","category":"page"},{"location":"","page":"Home","title":"Home","text":"The package exports 3 functions: readFamaFrench, downloadFamaFrench, and listFamaFrench.","category":"page"},{"location":"","page":"Home","title":"Home","text":"For help with any of these functions, use ? at the REPL (eg. ?readFamaFrench).","category":"page"},{"location":"#Example","page":"Home","title":"Example","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"The Fama-French 3 factor model is a commonly used empirical asset pricing model. This example retrieves the full time series of FF3 monthly and annual returns.","category":"page"},{"location":"","page":"Home","title":"Home","text":"using FamaFrenchData, DataFrames\n\ntables, tablenotes, filenotes = readFamaFrench(\"F-F_Research_Data_Factors\")\n\nFF3_monthly = tables[1]\nFF3_annual = tables[2]","category":"page"},{"location":"","page":"Home","title":"Home","text":"If you would rather store the file locally (perhaps so your code is reproducible later on), use downloadFamaFrench.","category":"page"},{"location":"","page":"Home","title":"Home","text":"using FamaFrenchData, DataFrames\n\nsavename = \"path/to/my/file.csv\"\ndownloadFamaFrench(savename,\"F-F_Research_Data_Factors\")\ntables, tablenotes, filenotes = readFamaFrench(savename) # also reads local files","category":"page"},{"location":"","page":"Home","title":"Home","text":"To get a list of all of the available table names, use listFamaFrench.","category":"page"},{"location":"","page":"Home","title":"Home","text":"using FamaFrenchData\nFFnames = listFamaFrench()","category":"page"},{"location":"#Additional-Notes","page":"Home","title":"Additional Notes","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"Original files use -99.99 or -999 to encode missing values, I attempt to replace these with missing.\nOriginal files have no column heading for column 1, I name this column :Date. It maintains the parsed type of Int because it can take several different forms: 20011231,200112,2001.\nI have not verified that all tables are parsed correctly.\nBreakpoints files require the keyword argument header=false","category":"page"},{"location":"#Disclaimer","page":"Home","title":"Disclaimer","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"I am not affiliated with the Ken French Data Library. This package does not \"ship with\" the data, just provides easier access to it. Other than the changes that I have explicitly stated, I do not alter the data; however, it is your responsibility to verify that the data is correct.","category":"page"},{"location":"#API","page":"Home","title":"API","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"readFamaFrench\ndownloadFamaFrench\nlistFamaFrench","category":"page"},{"location":"#FamaFrenchData.readFamaFrench","page":"Home","title":"FamaFrenchData.readFamaFrench","text":"readFamaFrench(ffn;kwargs...)\n\nffn can be the table name (in which case it is retreived from the web) or a path to the local file. kwargs are passed to CSV.File. Missing values (-99.99 or -999) are replaced with missing.\n\nReturns three pieces:\n\n- `tables::Vector{DataFrame}` - the extracted tables\n\n- `tablenotes::Vector{String}` - any notes to the tables\n\n- `filenotes::String` - notes at the top of the file\n\nExample Usage:\n\nusing DataFrames, FamaFrenchData\n\n# read the Fama-French 3 factors (monthly and annual)\ntables, tablenotes, filenotes = readFamaFrench(\"F-F_Research_Data_Factors\")\n\n# read the Fama-French 3 factors (daily)\ntablesd, tablenotesd, filenotesd = readFamaFrench(\"F-F_Research_Data_Factors_Daily\")\n\n# read the 25 Size-B/M portfolios (monthly and annual)\ntables25, tablenotes25, filenotes25 = readFamaFrench(\"25_Portfolios_5x5\")\n\n\n\n\n\n","category":"function"},{"location":"#FamaFrenchData.downloadFamaFrench","page":"Home","title":"FamaFrenchData.downloadFamaFrench","text":"downloadFamaFrench(savename,ffn)\n\nSaves the extracted CSV file from ffn to local file savename.\n\n\n\n\n\n","category":"function"},{"location":"#FamaFrenchData.listFamaFrench","page":"Home","title":"FamaFrenchData.listFamaFrench","text":"listFamaFrench(;refresh=false)\n\nReturns a vector of possible table names. Reads from listFamaFrench.txt. When refresh = true, first crawls the website to find current list of tables, then overwrites listFamaFrench.txt with this list. The selection of tables is rarely changed, so the provided list is likely sufficient.\n\n\n\n\n\n","category":"function"}]
}
