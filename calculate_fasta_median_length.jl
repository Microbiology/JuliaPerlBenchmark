#!/usr/bin/env julia

function fasta_median()
    fasta_in = open(ARGS[1], "r")
    length_array = Float64[]

    for line::ASCIIString in eachline(fasta_in)
        if !ismatch(r"^\>", line)
            push!(length_array, length(chomp(line)))
        end
    end

    close(fasta_in)
    return median(length_array)
end

println(fasta_median())
