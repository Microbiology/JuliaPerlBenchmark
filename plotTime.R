# plotTime.R

library(ggplot2)

input <- read.delim("./time.log", sep="\t", header=F)

plot <- ggplot(input, aes(x=as.numeric(V4), y=as.numeric(V2), colour=V3)) +
	theme_bw() +
	geom_line(stat="identity") +
	facet_grid(V1~., scale="free") +
	xlab("Number of Sequences") +
	ylab("Time (msec)")

png("./BenchmarkingResults.png", width=5, height=4, units="in", res=800)
	plot
dev.off()
