using Test
using BeaconFinder

@testset "BeaconFinder Tests" begin
    # Create a temporary test directory structure
    test_dir = mktempdir()
    
    try
        # Create some BEACON files with hashes
        beacon1_dir = joinpath(test_dir, "dir1")
        beacon2_dir = joinpath(test_dir, "dir2", "subdir")
        beacon3_dir = test_dir
        
        mkpath(beacon1_dir)
        mkpath(beacon2_dir)
        
        # Write BEACON files with different hashes
        beacon1_path = joinpath(beacon1_dir, "BEACON")
        beacon2_path = joinpath(beacon2_dir, "BEACON")
        beacon3_path = joinpath(beacon3_dir, "BEACON")
        
        write(beacon1_path, "abc123\n")
        write(beacon2_path, "def456\n")
        write(beacon3_path, "789xyz\n")
        
        @testset "find_beacons" begin
            beacons = find_beacons(test_dir)
            @test length(beacons) == 3
            @test beacon1_path in beacons
            @test beacon2_path in beacons
            @test beacon3_path in beacons
        end
        
        @testset "read_beacon_hash" begin
            hash1 = read_beacon_hash(beacon1_path)
            @test hash1 == "abc123"
            
            hash2 = read_beacon_hash(beacon2_path)
            @test hash2 == "def456"
            
            hash3 = read_beacon_hash(beacon3_path)
            @test hash3 == "789xyz"
        end
        
        @testset "find_and_read_beacons" begin
            results = find_and_read_beacons(test_dir)
            @test length(results) == 3
            @test results[beacon1_path] == "abc123"
            @test results[beacon2_path] == "def456"
            @test results[beacon3_path] == "789xyz"
        end
        
        @testset "read_beacon_hash with nonexistent file" begin
            @test_throws ErrorException read_beacon_hash("/nonexistent/BEACON")
        end
        
    finally
        # Clean up
        rm(test_dir, recursive=true, force=true)
    end
end
