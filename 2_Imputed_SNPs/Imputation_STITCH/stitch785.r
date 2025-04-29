library('STITCH')
getwd()
STITCH(tempdir = tempdir(), chr="ENA|OU383785|OU383785.1_RagTag",  bamlist="bamlistrg.txt", posfile="ENA|OU383785.txt", sampleNames_file="bamlist.txt", outputdir= paste0(getwd(), "/"), K=4, nGen=25, nCores=28, expRate=5)
