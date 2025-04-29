library(readr)
library(tidyverse)
library(dplyr)
library(readxl)
library(ggplot2)
library("data.table") 
setwd("~/Documents/GitHub/SNPsSeychellesWarbler/3_Imputation_accuracy/")

#Obtain coverage
CoverageSamples <- read.delim("reference_coverage.txt",sep=" ",header=F)
names(CoverageSamples)[names(CoverageSamples) == 'V1'] <- 'SeqID'
names(CoverageSamples)[names(CoverageSamples) == 'V2'] <- 'Coverage'

#Testing STITCH accuracy
ReferencePanel<-subset(CoverageSamples, CoverageSamples$Coverage>8)

##Create necessary multiplier to achieve each test coverage level column
ReferencePanel$Multipler2.65X<-2.65/ReferencePanel$Coverage
ReferencePanel$Multipler1X<-1/ReferencePanel$Coverage
ReferencePanel$Multipler0.1X<-0.1/ReferencePanel$Coverage
ReferencePanel<-ReferencePanel %>%
  ungroup() %>%
  select(SeqID, Multipler2.65X, Multipler1X, Multipler0.1X)

##Create bam file list 
ReferencePanel <- merge(ReferencePanel,BAMfilesSexReorderedDeduplicatedVCF,by="BirdID", all = FALSE)
ReferencePanel$BirdID<-ReferencePanel$vcfID
ReferencePanel<-ReferencePanel %>%
  ungroup() %>%
  select(BirdID, Multipler3X, Multipler1X, Multipler0.5X, Multipler0.1X)

##write multiplier table
write.table(ReferencePanel, file = "~/Documents/GitHub/SNPsSeychellesWarbler/3_Imputation_accuracy/downsamplescalingnew", sep = "\t",
            col.names = F, row.names = F, quote = FALSE)
