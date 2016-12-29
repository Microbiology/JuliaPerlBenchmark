#!/bin/bash
# Some quick benchmarking to test out Julia while
# and comparing to Perl.

for itr in 100 1000 10000 50000 100000 250000 500000 1000000 1500000 5000000 10000000 15000000 20000000 25000000 40000000; do
	head -n ${itr} largeseqtest.fa > ./tmpseq.fa
	cat ./tmpseq.fa > /dev/null
	{ time perl calculate_fasta_median_length.pl ./tmpseq.fa; } 2> ./tmpPerlTime${itr}.log
	grep [a-zA-Z0-9] ./tmpPerlTime${itr}.log | awk -v var=$itr '{ print $0"\tPerl\t"var }' | sed 's/.m\(.\)./\1/' | sed 's/\([0-9]\)s/\1/' > ./tmpPerlTime${itr}form.log
	{ time julia calculate_fasta_median_length.jl ./tmpseq.fa; } 2>> ./tmpJuliaTime${itr}.log
	grep [a-zA-Z0-9] ./tmpJuliaTime${itr}.log | awk -v var=$itr '{ print $0"\tJulia\t"var }' | sed 's/.m\(.\)./\1/' | sed 's/\([0-9]\)s/\1/' > ./tmpJuliaTime${itr}form.log
        { time ./calculate_fasta_median_length ./tmpseq.fa; } 2>> ./tmpGoTime${itr}.log
	grep [a-zA-Z0-9] ./tmpGoTime${itr}.log | awk -v var=$itr '{ print $0"\tGo\t"var }' | sed 's/.m\(.\)./\1/' | sed 's/\([0-9]\)s/\1/' > ./tmpGoTime${itr}form.log
done

cat ./tmp*form.log > ./time.log
rm ./tmp*

Rscript plotTime.R
