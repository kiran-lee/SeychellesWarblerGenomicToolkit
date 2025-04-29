# This script takes the higher coverage repeat samples and merges them with the previously sequenced samples, that have been verified as duplicates using script as in 10checkaccuracy.sh to output a set of commmands used in 12mergereference.sh

R.Version()
library(readr)
library(tidyverse)
library(dplyr)
library(readxl)
library(openxlsx)
library(ggplot2)
library("data.table") 
setwd("~/Documents/GitHub/InProgressGenomicsInbreedingSeychellesWarblers/Data")

#Create the dataframe for the analysis
## We want to create dataframe of sample filenames (.bam files), their BirdID,and Coverage.
CoverageExtraSamples <- read.delim("coveragefilenameallsortedextrasamples.txt",sep=" ",header=F)
names(CoverageExtraSamples)[names(CoverageExtraSamples) == 'V1'] <- 'SeqID'
names(CoverageExtraSamples)[names(CoverageExtraSamples) == 'V2'] <- 'Coverage'
CoverageExtraSamples$Filepath<-CoverageExtraSamples$SeqID
CoverageExtraSamples$Filepath <- gsub("^.{0,4}", "", CoverageExtraSamples$Filepath)
CoverageExtraSamples$SeqID<-sub('.', '', CoverageExtraSamples$SeqID)
CoverageExtraSamples<-CoverageExtraSamples %>% separate(SeqID, c('Filepath1', 'Filepath2', 'Filepath3', 'Filepath4','Plate','Filepath5','SeqID'), sep = '/', convert = TRUE)
CoverageExtraSamples = subset(CoverageExtraSamples, select = c(Plate, SeqID, Coverage, Filepath))
CoverageExtraSamples$ID<-CoverageExtraSamples$SeqID

##Files to match BirdIDs
Identifiers<-read_excel("SheffieldSubmissions.xlsx")
Identifiers26076<-read_excel("ID 26076_Sample information table.xlsx")
PilotIdentifiers<-read_excel("SamplesForPilotTargetCapture_290119_sortBTN_Qubit.xlsx")
LIMS26629renamed<-read.table("lims26629renamed.txt",sep=" ",header=F)
LIMS26757p1raw4<-read.csv("Samples for Sequencing 25072023.csv",colClasses=c("NULL",NA,NA,NA,NA,NA))
MissingLIMS26757p1raw4 <- data.frame(BirdID=c(6572,6145,6373,5904,6144,6651), 
                                    FieldRing=c(NA,NA,NA,NA,NA,NA),
                                    BTO=c(NA,NA,NA,NA,NA,NA), 
                                    BloodID=c(8178, 5883,6287,5620,5880,7239), 
                                    BloodTubeNumber=c(NA,NA,NA,NA,NA,NA), 
                                    stringsAsFactors=FALSE)
LIMS26757p1raw4<-rbind(LIMS26757p1raw4,MissingLIMS26757p1raw4)
BloodID<-read.csv("BloodID.csv")

##Clean ID numbers
LIMS26629renamed<-LIMS26629renamed %>% arrange(V1)
LIMS26629renamed$SeqID<-CoverageExtraSamples$SeqID[CoverageExtraSamples$Plate=='LIMS26629']
LIMS26629renamed<-LIMS26629renamed %>%
  mutate(SeqID=sort(SeqID))
LIMS26629renamed$V1<-sub(".*\\-", "", LIMS26629renamed$V1)
colnames(LIMS26629renamed)[colnames(LIMS26629renamed) == 'V1'] <- 'ID'

#Fix 6 samples that were mislabeled, as identified by Rowan
LIMS26629renamed$ID[which(LIMS26629renamed$SeqID == "100_ACAAGAACCT-CGATACTGAA_L002__all_mapped_rehead.bam")] <- 2544
LIMS26629renamed$ID[which(LIMS26629renamed$SeqID == "101_AGAGTATGTG-AGATGGCTTC_L002__all_mapped_rehead.bam")] <- 3227
LIMS26629renamed$ID[which(LIMS26629renamed$SeqID == "96_CAACCATACA-ACCGGTTATA_L002__all_mapped_rehead.bam")] <- 764
LIMS26629renamed$ID[which(LIMS26629renamed$SeqID == "97_GTAGGCCGTT-GCCACTGTCT_L002__all_mapped_rehead.bam")] <- 2688
LIMS26629renamed$ID[which(LIMS26629renamed$SeqID == "98_CGGATTGATC-AGTCACAACA_L002__all_mapped_rehead.bam")] <- 2493
LIMS26629renamed$ID[which(LIMS26629renamed$SeqID == "99_ACTGGCAAGA-TGTTGTCCAT_L002__all_mapped_rehead.bam")] <- 2522

CoverageExtraSamples$ID[CoverageExtraSamples$Plate=="LIMS26629"]<-NA
CoverageExtraSamples <- merge(CoverageExtraSamples,LIMS26629renamed,by="SeqID", all = TRUE) %>%
  mutate(ID = coalesce(ID.x, ID.y)) %>%
  select (-c(ID.x, ID.y))



PilotSequences<-subset(CoverageExtraSamples, CoverageExtraSamples$Plate=="LIMS24675"|CoverageExtraSamples$Plate=="LIMS25133")
PilotSequences$ID<-trimws(sapply(strsplit(PilotSequences$ID, "_"), `[[`, 2))
MissingBloodIDSequences<-subset(CoverageExtraSamples, CoverageExtraSamples$Plate == "LIMS26076p4"|CoverageExtraSamples$Plate == "LIMS26076raw")
MissingBloodIDSequences$ID<-as.numeric(sapply(strsplit(MissingBloodIDSequences$ID, "_"), "[[", 1))
BloodIDSequences<-subset(CoverageExtraSamples, CoverageExtraSamples$Plate!="LIMS24675"& CoverageExtraSamples$Plate!="LIMS25133"&CoverageExtraSamples$Plate != "LIMS26076p4"&CoverageExtraSamples$Plate != "LIMS26076raw" )
BloodIDSequences$ID <- sub('_repeat','',BloodIDSequences$ID)
BloodIDSequences$ID <- sub('-repeat','',BloodIDSequences$ID)
BloodIDSequences$ID<-trimws(sapply(strsplit(BloodIDSequences$ID, "_"), `[[`, 1))
BloodIDSequences$ID<-sub('.+-(.+)', '\\1', BloodIDSequences$ID)

##Pilot sequences use Blood Tube Number, the rest use BloodID
PilotSequences$Identifier<-paste("BloodTubeNumber")
MissingBloodIDSequences$Identifier<-paste("BloodID")
BloodIDSequences$Identifier<-paste("BloodID")

##Make IDs numeric
PilotSequences$ID<-as.numeric(PilotSequences$ID)
BloodIDSequences$ID<-as.numeric(BloodIDSequences$ID)
MissingBloodIDSequences$ID<-as.numeric(MissingBloodIDSequences$ID)
Identifiers26076$Sample_number<-as.numeric(Identifiers26076$`Sample number`)
Identifiers26076$BloodID<-as.numeric(Identifiers26076$`Sample name`)

#Join BirdIDs
PilotSequences <- PilotSequences %>% 
  left_join(select(PilotIdentifiers, BirdID, BloodTubeNumber), by = c("ID" = "BloodTubeNumber"))

BloodIDSequences$BloodID<-BloodIDSequences$ID
BloodIDSequences <- BloodIDSequences %>% 
  left_join(select(Identifiers, BirdID, BloodID), by = c("ID" = "BloodID"))
names(BloodIDSequences)[names(BloodIDSequences) == 'BirdID.x'] <- 'BirdID'
BloodIDSequences<-BloodIDSequences[!duplicated(BloodIDSequences), ]

MissingBloodIDSequences <- MissingBloodIDSequences %>% 
  left_join(select(Identifiers26076, Sample_number, BloodID), by = c("ID" = "Sample_number"))
MissingBloodIDSequences <- MissingBloodIDSequences %>% 
  left_join(select(Identifiers, BirdID, BloodID), by = c("BloodID" = "BloodID"))

##Concatenate into one file (2018 individuals including duplicates)
MissingBloodIDSequencesFormatted= subset(MissingBloodIDSequences, select = c(Plate, SeqID, Coverage, Filepath, BloodID, Identifier, BirdID))
colnames(MissingBloodIDSequencesFormatted)[colnames(MissingBloodIDSequencesFormatted) == 'BloodID'] <- 'ID'
BloodIDSequencesFormatted= subset(BloodIDSequences, select = c(Plate, SeqID, Coverage, Filepath, ID, Identifier, BirdID))
SequencedIndividualsBirdIDs=rbind(PilotSequences,MissingBloodIDSequencesFormatted,BloodIDSequencesFormatted)

##Add in missing BirdIDs from LIMS26757p1raw4
SequencedIndividualsBirdIDsExtra<- SequencedIndividualsBirdIDs %>% 
  left_join(select(LIMS26757p1raw4, BirdID, BloodID), by = c("ID" = "BloodID")) %>%
  mutate(BirdID = coalesce(BirdID.x, BirdID.y)) %>%
  select (-c(BirdID.x, BirdID.y))

SequencedIndividualsBirdIDsExtraDeduplicated<- SequencedIndividualsBirdIDsExtra %>% 
  group_by(BirdID) %>%
  top_n(1, abs(Coverage))

##Merge reference panel

ReferencePanel<- read.delim("duplicatereferencepairs0.3na1.kin0",sep=" ",header=T,col.names=c("","Resequence","","SeqID","","","",""),row.names=NULL)
ReferencePanel<- subset(ReferencePanel, select = -c(X,X.1,X.2,X.3,X.4,X.5) )
ReferencePanel[] <- lapply(ReferencePanel, gsub, pattern='./Clean_aligned/', replacement='')

#Add in filepaths
ReferencePanel<-merge(ReferencePanel, SequencedIndividualsBirdIDsExtraDeduplicated , by="SeqID") %>%
                        select(Resequence,Filepath) #SequencedIndividualsBirdIDsExtraDeduplicated can be found here https://github.com/kiran-lee/InbreedingDepressionSeychellesWarbler/blob/main/DataandResults/Seychelles_warbler_traits.txt
ReferencePanel$Merged_output<-ReferencePanel$Filepath
ReferencePanel$Resequence <- sub("^", "/fastdata/bop21kgl/RawData/LIMS202103/Clean_aligned/", ReferencePanel$Resequence )
ReferencePanel$Merged_output<-gsub(".*/","",ReferencePanel$Merged_output)
ReferencePanel$Merged_output <- sub("^", "/fastdata/bop21kgl/RawData/LIMSMERGED/Clean_aligned/", ReferencePanel$Merged_output )
ReferencePanel$Command= "samtools merge"
ReferencePanel<-ReferencePanel[,c(4,3,1,2)]

#Write out commands for samtools to merge files
write.table(ReferencePanel, file = "ReferencePanel.txt", sep = " ",
            col.names = F, row.names = F, quote = FALSE)