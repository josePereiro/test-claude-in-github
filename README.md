# BeaconFinder

A Julia package for searching file trees and finding files named `BEACON` that contain hash values.

## Installation

```julia
using Pkg
Pkg.activate(".")
Pkg.instantiate()
```

## Usage

```julia
using BeaconFinder

# Find all BEACON files in a directory tree
beacons = find_beacons("/path/to/search")

# Read the hash from a specific BEACON file
hash = read_beacon_hash("/path/to/BEACON")

# Find all BEACON files and read their hashes
results = find_and_read_beacons("/path/to/search")
```

## Example

The `examples` directory contains sample BEACON files. Try:

```julia
using BeaconFinder

# Search for BEACON files in the examples directory
beacons = find_beacons("examples")
println("Found BEACON files:")
for beacon in beacons
    println("  - ", beacon)
end

# Read all BEACON hashes
results = find_and_read_beacons("examples")
println("\nBEACON hashes:")
for (path, hash) in results
    println("  $path => $hash")
end
```

## Testing

Run the test suite with:

```julia
using Pkg
Pkg.test()
```

Or from the command line:

```bash
julia --project=. -e 'using Pkg; Pkg.test()'
```