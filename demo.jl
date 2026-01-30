#!/usr/bin/env julia

# Demo script for BeaconFinder package
# Run with: julia --project=. demo.jl

using BeaconFinder

println("=== BeaconFinder Demo ===\n")

# Find all BEACON files in the examples directory
println("1. Finding all BEACON files in examples/:")
beacons = find_beacons("examples")
for beacon in beacons
    println("   ✓ Found: $beacon")
end

println("\n2. Reading hashes from BEACON files:")
results = find_and_read_beacons("examples")
for (path, hash) in sort(collect(results))
    println("   📁 $path")
    println("   🔑 Hash: $hash")
    println()
end

println("Demo completed successfully!")
