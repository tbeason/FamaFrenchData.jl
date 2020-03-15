using FamaFrenchData,DataFrames
using Test


tcsv = abspath(joinpath(@__DIR__, "..", "test", "testcsv.csv"))

tables, tablenotes, filenotes = readFamaFrench(tcsv)

@test length(tables) == 2
@test length(tables) == length(tablenotes)

@test tables[1][1,2] == 1.0

@test tables[2][2,3] == 0.5


LFF = listFamaFrench()

@test LFF[1] == "F-F_Research_Data_Factors"

tdl = abspath(joinpath(@__DIR__, "..", "test", "testdownload.csv"))
downloadFamaFrench(tdl,LFF[1])

@test isfile(tdl) == true

rm(tdl)
