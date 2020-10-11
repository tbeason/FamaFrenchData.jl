using FamaFrenchData,DataFrames
using Test
@testset "FamaFrenchData" begin

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

        @test tablesff[1].Date[1] == 192607

        @test tablesff[2].Date[1] == 1927

        tablesff, tablenotesff, filenotesff = readFamaFrench("F-F_Momentum_Factor")
        @test length(tablesff) == 2

        @test ncol(tablesff[1]) == 2

        tablesff, tablenotesff, filenotesff = readFamaFrench("25_Portfolios_5x5")
        @test length(tablesff) == 10

        @test ncol(tablesff[1]) == 26

        @test tablesff[1].Date[1] == 192607


        tablesff, tablenotesff, filenotesff = readFamaFrench("ME_Breakpoints",header=false)
        @test length(tablesff) == 1

        @test ncol(tablesff[1]) == 22

        @test tablesff[1].Date[1] == 192512
    end

    @testset "Download" begin
        tdl = abspath(joinpath(@__DIR__, "..", "test", "testdownload.csv"))
        downloadFamaFrench(tdl,"F-F_Research_Data_Factors")

        @test isfile(tdl) == true

        rm(tdl)
    end

    @testset "Unexported" begin
        @test FamaFrenchData.strip_rn("abc 123\r\n") == "abc 123 "

        @test FamaFrenchData.contiguousblocks([1,2,3,1,1,1,2,2,2,2,1,2,2,2,2,2]) == [7:10, 12:16]

        @test FamaFrenchData.lastornothing([1;2]) == 2

        @test FamaFrenchData.pathtoFamaFrench("F-F_Research_Data_Factors") == "http://mba.tuck.dartmouth.edu/pages/faculty/ken.french/ftp/F-F_Research_Data_Factors_CSV.zip"
    end
end