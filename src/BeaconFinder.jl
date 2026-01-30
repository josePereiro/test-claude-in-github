module BeaconFinder

export find_beacons, read_beacon_hash, find_and_read_beacons

"""
    find_beacons(root_path::AbstractString) -> Vector{String}

Search recursively for files named "BEACON" starting from `root_path`.
Returns a vector of full paths to all BEACON files found.
"""
function find_beacons(root_path::AbstractString)
    beacon_files = String[]
    
    # Walk through the directory tree
    for (root, dirs, files) in walkdir(root_path)
        for file in files
            if file == "BEACON"
                push!(beacon_files, joinpath(root, file))
            end
        end
    end
    
    return beacon_files
end

"""
    read_beacon_hash(beacon_path::AbstractString) -> String

Read and return the hash value from a BEACON file.
The hash is expected to be on the first line of the file.
"""
function read_beacon_hash(beacon_path::AbstractString)
    if !isfile(beacon_path)
        error("BEACON file not found: $beacon_path")
    end
    
    # Read the first line which should contain the hash
    open(beacon_path, "r") do f
        line = readline(f)
        return strip(line)
    end
end

"""
    find_and_read_beacons(root_path::AbstractString) -> Dict{String, String}

Find all BEACON files and read their hashes.
Returns a dictionary mapping file paths to their hash values.
"""
function find_and_read_beacons(root_path::AbstractString)
    beacon_files = find_beacons(root_path)
    results = Dict{String, String}()
    
    for beacon_path in beacon_files
        try
            hash = read_beacon_hash(beacon_path)
            results[beacon_path] = hash
        catch e
            @warn "Failed to read beacon at $beacon_path: $e"
        end
    end
    
    return results
end

end # module
