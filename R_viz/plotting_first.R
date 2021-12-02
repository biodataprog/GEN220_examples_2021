# Start with base R loading of data

ecoliTable = read.csv("Ecoli_metadata.csv",sep=",",header=TRUE)
colnames(ecoliTable)
head(ecoliTable)
# if we wanted to change the column names we could use this
#colnames(ecoliTable) <- c( "A", "B", "C", "D", "E", "F", "G") 

# example of how to plot an x-y plot
x= c(1,2,3)
y= c(10,20,30)
plot(x,y )
# plot real data
plot(ecoliTable$generation, ecoliTable$genome_size)
# this is how we can write out a data file
write.csv(ecoliTable,file="Ecoli_metadata.new.csv")

# print a histogram
hist(ecoliTable$genome_size)

# print a histogram with 10 bins
hist(ecoliTable$genome_size, 10)

# read in a new file
fungalgenomes <- read.csv("assembly_stats.csv",header=TRUE,sep=",")
head(fungalgenomes)
# lets see the data for genome size 
summary(fungalgenomes$total_length)
# lets get rid of genomes < 1000 bp

filtered <- subset(fungalgenomes, fungalgenomes$total_length > 1000)
summary(filtered$total_length)
# log transform of the size of the genome, plot into 100 bins, add a plot title
hist(log(filtered$total_length)/log(10),100,main="Histogram of Genome size log_10")

# lets do this with tidyverse

library(readr)
library(dplyr)
library(ggplot2)
library(cowplot)
fungalgenomes <- read_csv("assembly_stats.csv")
head(fungalgenomes)
length(fungalgenomes$ASM_ACCESSION)
# using dplyr to get a subset of the data, can use this to cleanup or restrict the data to look at
filtered <- fungalgenomes %>% filter(total_length > 10000) %>% filter(gene_count > 0)
# make a ggplot
p <- ggplot(filtered, aes(total_length, gene_count, color=PHYLUM)) + geom_point() + coord_trans(x="log10") +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1)) + theme_bw() + scale_colour_brewer(palette = "Set2")
p
ggsave("genome_size_plot.pdf",p)
