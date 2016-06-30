#!/usr/bin/env julia

using DataFrames, Plots

f = open("time.log")
  timings = readtable(f, separator = '\t', header = false, names=[:realsysuser, :timing, :language, :number])
close(f)

sort!(timings, cols = [:number, :realsysuser])

perltimings = timings[timings[:language] .== "Perl", :][:timing]
juliatimings = timings[timings[:language] .== "Julia", :][:timing]

plot(
    [perltimings juliatimings],
    seriestype=:scatter,
    label=["Perl" "Julia"],

    xticks=(1:45, timings[:number][1:2:end]),
    xrotation = 90,

    yticks = 0:500:7000,

    markershape=[:circle :diamond],
    markeralpha=0.75,
    markersize = 4,

    xlabel = "number of sequences",
    ylabel = "time (milliseconds)",

    color = [:red :blue],

    legend = :left,

    linewidth = 4
    )

  savefig("julia-graph.png")
