#!/usr/bin/env julia

using DataFrames, Plots

f = open("time.log")
  timings = readtable(f, separator = '\t', header = false, names=[:realsysuser, :timing, :language, :number])
close(f)

sort!(timings, cols = [:number, :realsysuser])

perltimings = timings[timings[:language] .== "Perl", :][:timing]
juliatimings = timings[timings[:language] .== "Julia", :][:timing]
gotimings = timings[timings[:language] .== "Go", :][:timing]

plot(
    [perltimings juliatimings　gotimings],
    seriestype=:scatter,
    label=["Perl" "Julia" "Go"],

    xticks=(1:45, timings[:number][1:2:end]),
    xrotation = 90,

    yticks = 0:500:7000,

    markershape=[:circle :diamond :square],
    markeralpha=0.75,
    markersize = 4,

    xlabel = "number of sequences",
    ylabel = "time (milliseconds)",

    color = [:red :blue :green],

    legend = :left,

    linewidth = 4
    )

  savefig("julia-graph.png")
