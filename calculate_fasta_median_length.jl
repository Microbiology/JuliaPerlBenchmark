#!/usr/bin/env julia

open(ARGS[1], "r") do fasta_in
    length_array = Int[]
    for line in eachline(fasta_in)
        if !startswith(line,'>')
            push!(length_array, length(chomp(line)))
        end
    end
    println(median(length_array))
end
