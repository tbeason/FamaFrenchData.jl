using FamaFrenchData,DataFrames
using Test

@testset "Local read and list" begin
    tcsv = abspath(joinpath(@__DIR__, "..", "test", "testcsv.csv"))

    tables, tablenotes, filenotes = readFamaFrench(tcsv)

    @test length(tables) == 2
    @test length(tables) == length(tablenotes)

    @test tables[1][1,2] == 1.0

    @test tables[2][2,3] == 0.5


    LFF = listFamaFrench()

    @test LFF[1] == "F-F_Research_Data_Factors"
end

@testset "Web stream" begin
    tablesff, tablenotesff, filenotesff = readFamaFrench("F-F_Research_Data_Factors")
    @test length(tablesff) == 2

    @test ncol(tablesff[1]) == 5
end

@testset "Download" begin
    tdl = abspath(joinpath(@__DIR__, "..", "test", "testdownload.csv"))
    downloadFamaFrench(tdl,"F-F_Research_Data_Factors")

    @test isfile(tdl) == true

    rm(tdl)
end

@testset "Unexported" begin
    @test FamaFrenchData.lastornothing([1;2]) == 2

    @test FamaFrenchData.pathtoFamaFrench("F-F_Research_Data_Factors") == "http://mba.tuck.dartmouth.edu/pages/faculty/ken.french/ftp/F-F_Research_Data_Factors_CSV.zip"
end
