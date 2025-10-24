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

    @testset "Caching" begin
        # Clear cache before starting tests
        clearFamaFrenchCache()

        # Test that cache directory is created
        cache_dir = FamaFrenchData.get_cache_dir()
        @test isdir(cache_dir)

        # Test basic caching - first call should download
        test_dataset = "F-F_Momentum_Factor"
        tables1, notes1, filenotes1 = readFamaFrench(test_dataset)

        # Verify cached file was created
        cached_path = FamaFrenchData.get_cached_file_path(test_dataset)
        @test isfile(cached_path)
        @test FamaFrenchData.is_cache_valid(cached_path, 24)

        # Second call should use cache (verify by checking results are identical)
        tables2, notes2, filenotes2 = readFamaFrench(test_dataset)
        @test tables1[1] == tables2[1]
        @test notes1 == notes2

        # Test cache bypass with use_cache=false
        tables3, notes3, filenotes3 = readFamaFrench(test_dataset, use_cache=false)
        @test tables1[1] == tables3[1]  # Data should still be the same

        # Test custom cache_max_age (set to 0 to force re-download)
        # Wait a tiny bit to ensure file timestamp changes
        sleep(0.1)
        tables4, notes4, filenotes4 = readFamaFrench(test_dataset, cache_max_age=0)
        @test tables1[1] == tables4[1]  # Data should still be the same

        # Verify cache file was updated (modification time should be recent)
        @test FamaFrenchData.is_cache_valid(cached_path, 1)

        # Test clearFamaFrenchCache
        count_deleted = clearFamaFrenchCache()
        @test count_deleted >= 1
        @test !isfile(cached_path)

        # Test that is_cache_valid returns false for non-existent file
        @test !FamaFrenchData.is_cache_valid(cached_path, 24)

        # Test with a new dataset to ensure cache works for multiple datasets
        test_dataset2 = "F-F_Research_Data_Factors"
        tables5, notes5, filenotes5 = readFamaFrench(test_dataset2)
        cached_path2 = FamaFrenchData.get_cached_file_path(test_dataset2)
        @test isfile(cached_path2)

        # Clean up
        clearFamaFrenchCache()
    end
end