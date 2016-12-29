#!/usr/bin/env julia

open(ARGS[1], "r") do fasta_in
    length_array = Int[]
    seq_length = -1
    for line in eachline(fasta_in)
        if startswith(line,'>')
            if seq_length != -1
                push!(length_array, seq_length)
            end
            seq_length = 0
        else
            seq_length += length(chomp(line))
        end
    end
    if seq_length != -1
        push!(length_array, seq_length)
    end
    println(median(length_array))
end
