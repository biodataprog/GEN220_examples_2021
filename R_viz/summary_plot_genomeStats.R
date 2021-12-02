library(tidyverse)
library(vroom)
library(stringr)
intable <- vroom("assembly_stats.csv")
unique(intable["Sequencing_technology"])


#some columns in the table were mixed up
samples.mixedup.cols <- c("741139", "5116", "85974")

for (samp in samples.mixedup.cols) {
  i = intable$Sequencing_technology[intable$NCBI_TAXID == samp]
  intable$Sequencing_technology[intable$NCBI_TAXID == samp] <- intable$Genome_coverage[intable$NCBI_TAXID == samp]
  intable$Genome_coverage[intable$NCBI_TAXID == samp] <- i}

#separate seq technologies to deal with sepearately first to homogenize labels
#also seperate date into years for easier plotting
updatetbl <- intable %>% 
  separate(Date, into = c("year", "month", "day"), sep = "-", remove = FALSE) %>%
  mutate(Sequencing_technology = replace_na(Sequencing_technology, "Missing")) %>%
  separate(Sequencing_technology, into = c("first", "second", "third", "fourth"), sep = ";|,", remove = FALSE) %>%
  mutate(second = trimws(second), third = trimws(third), fourth=trimws(fourth) )

#grouping individual technologies
updatetbl2 <- updatetbl  %>% 
  mutate(first = if_else (str_detect(first, "^454|Roche"),"Roche 454",
                             if_else( str_detect(first, "^Illumina|Illunima|Miseq|MiSeq|HiSeq|NovaSeq|Solexa"),"Illumina",
                                      if_else( str_detect(first, "^ABI|Sanger"), "Sanger",
                                               if_else( str_detect(first, "^Pac|PacBio$|RSII$"), "PacBio",
                                                        if_else( str_detect(first, "^Oxford|Nanopore|PGM|MinION"), "Nanopore",
                                                                 if_else( str_detect(first, "^Ion"), "Ion Torrent",
                                                                        first)))))),
        second = if_else (str_detect(second, "^454|Roche"),"Roche 454",
                           if_else( str_detect(second, "^Illumina|Illunima|Miseq|MiSeq|HiSeq|NovaSeq|Solexa"),"Illumina",
                                    if_else( str_detect(second, "^ABI|Sanger"), "Sanger",
                                             if_else( str_detect(second, "^Pac|PacBio$|RSII$"), "PacBio",
                                                      if_else( str_detect(second, "^Oxford|Nanopore|PGM|MinION"), "Nanopore",
                                                               if_else( str_detect(second, "^Ion"), "Ion Torrent",
                                                                        second)))))),
        third = if_else (str_detect(third, "^454|Roche"),"Roche 454",
                            if_else( str_detect(third, "^Illumina|Illunima|Miseq|MiSeq|HiSeq|NovaSeq|Solexa"),"Illumina",
                                     if_else( str_detect(third, "^ABI|Sanger"), "Sanger",
                                              if_else( str_detect(third, "^Pac|PacBio$|RSII$"), "PacBio",
                                                       if_else( str_detect(third, "^Oxford|Nanopore|MinION"), "Nanopore",
                                                                if_else( str_detect(third, "^Ion|PGM"), "Ion Torrent",
                                                                         third)))))))

#unite columns again and first duplicates
#I wonder if could replace duplicates using regex here somehow, oh well
updatetbl3 <- updatetbl2 %>%
  unite(SeqTech, first, second, third, fourth, sep= "-", remove = FALSE, na.rm =TRUE) %>%
  mutate(SeqTech = if_else(SeqTech == "Sanger-lab finishing", "Sanger", 
         if_else(SeqTech == "SOLiD-Roche 454", "Roche 454-SOLiD",
            if_else(SeqTech == "Illumina-Illumina" | SeqTech == "Illumina-Illumina-Illumina", "Illumina",
                 if_else(SeqTech == "Illumina-Illumina-PacBio" | SeqTech == "PacBio-Illumina" |SeqTech ==  "Illumina-PacBio-Illumina" | SeqTech == "PacBio-Illumina-PacBio", "Illumina-PacBio",
                         if_else(SeqTech == "Illumina-Roche 454-PacBio" | SeqTech == "PacBio-Illumina-Roche 454" | SeqTech=="Roche 454-Illumina-PacBio", "Illumina-PacBio-Roche 454",
                                 if_else(SeqTech == "Nanopore-Illumina", "Illumina-Nanopore",
                                         if_else(SeqTech == "PacBio-Illumina-Nanopore" | SeqTech == "PacBio-Nanopore-Illumina", "Illumina-PacBio-Nanopore",
                                                 if_else(SeqTech == "Roche 454-Illumina", "Illumina-Roche 454",
                                                         if_else(SeqTech == "Roche 454-Illumina-Sanger" | SeqTech == "Sanger-Roche 454-Illumina" |SeqTech == "Roche 454-Sanger-Illumina", "Illumina-Roche 454-Sanger",
                                                                 if_else(SeqTech == "Sanger-Illumina", "Illumina-Sanger", 
                                                                         if_else(SeqTech == "Ion Torrent-Illumina", "Illumina-Ion Torrent", 
                                                                                 if_else(SeqTech == "Sanger-Roche 454", "Roche 454-Sanger", SeqTech)))))))))))))
                                             
unique(updatetbl3$SeqTech)

#update these to reflect what we define as 'short' vs 'long'
#for example, what is 'Complete Genomics'?
#And is Sanger 'long' or 'short'?
long_reads <- c("PacBio", "Nanopore", "10X", "Ion Torrent", "Sanger")
short_reads <- c("Illumina", "Roche 454")

updatetbl4 <- updatetbl3 %>%
  mutate(SeqTechBroad = if_else(SeqTech %in% short_reads, "Short", 
                               if_else( SeqTech %in% long_reads, "Long",
                                        if_else(str_detect(SeqTech, "-"), "Hybrid", SeqTech))))


#temporarily remove (?) problem taxa

to_remove <- c("1813822", "1603295", "2067060", "1117665", "1427494", "13349")

updatetbl5 <- subset(updatetbl4, !NCBI_TAXID %in% to_remove)


# graphing #


#gigabases vs. order
#note the "NA" order level will need to filter taxonomy and fix
ggplot(data = updatetbl5, aes(x = ORDER, y = (total_length/1000000000))) +
  geom_bar(stat='identity', fill = "#32648EFF") + 
  coord_flip() +
  xlab("") + 
  ylab("Gigabases") + 
  theme(text = element_text(size = 12)) + 
  theme(panel.background = element_blank()) + 
  scale_y_continuous(expand = c(0,0)) + 
  theme(axis.ticks.y = element_blank()) 



#contig n50 vs. assembly length
#fill colors will need to be updated 
ggplot(data = updatetbl5, aes(x = log10(total_length), y = log10(scaffold_N50))) +
  geom_point(aes(fill=SeqTechBroad), color = "black",shape=21, size = 3) + 
  xlab(expression(paste("Assembly length (lo", g[10], " bp)"))) +
  ylab(expression(paste("Contig N50 (lo", g[10], " bp)"))) + 
  theme(text = element_text(size = 12)) +
  scale_fill_manual(values = c("grey40", "#3F4788FF", "#DCE318FF", "grey50", "grey60", "#1F968BFF")) +
  guides(fill = guide_legend(title = "Sequencing Technology"))


#contig n50 vs. date
#fill colors will need to be updated 
ggplot(data = updatetbl5, aes(x = Date, y = log10(scaffold_N50))) +
  geom_point(aes(fill=SeqTechBroad), color = "black",shape=21, size = 3) + 
  xlab(expression(paste("Year"))) +
  ylab(expression(paste("Contig N50 (lo", g[10], " bp)"))) + 
  theme(text = element_text(size = 12)) +
  scale_fill_manual(values = c("grey40", "#3F4788FF", "#DCE318FF", "grey50", "grey60", "#1F968BFF")) +
  guides(fill = guide_legend(title = "Sequencing Technology"))
  


#contig n50 vs. order faceted by technology
#remove facet_grid to collapse
ggplot(data = updatetbl5, aes(x=PHYLUM, y = log10(scaffold_N50))) + 
  geom_boxplot()+ 
  xlab("") +
  ylab(expression(paste("Contig N50 (lo", g[10], " bp)"))) +
  scale_fill_manual(values = c("grey40", "#3F4788FF", "#DCE318FF", "grey50", "grey60", "#1F968BFF")) +
  guides(fill = guide_legend(title = "Sequencing Technology")) + 
  geom_point(mapping=aes(fill=SeqTechBroad), shape=21, size =2) + 
  theme(axis.text.x = element_text(angle = -90, hjust = 0, vjust = 0.5)) + 
  facet_grid(~SeqTechBroad)



#number of genomes
numgenomes <- updatetbl5 %>% count(PHYLUM)

ggplot(data = numgenomes, aes(x = PHYLUM, y = n)) +
  geom_bar(stat='identity', fill = "#32648EFF") + 
  coord_flip() +
  xlab("") + 
  ylab("Number of Genomes") + 
  theme(text = element_text(size = 12)) + 
  theme(panel.background = element_blank()) + 
  scale_y_continuous(expand = c(0,0)) + 
  theme(axis.ticks.y = element_blank()) 


