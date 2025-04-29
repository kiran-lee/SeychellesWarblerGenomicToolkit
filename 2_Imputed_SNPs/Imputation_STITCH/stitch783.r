library('STITCH')
getwd()
STITCH(tempdir = tempdir(), chr="ENA|OU383783|OU383783.1_RagTag",  bamlist="bamlistrg.txt", posfile="ENA|OU383783.txt", sampleNames_file="bamlist.txt", outputdir= paste0(getwd(), "/"), K=4, nGen=25, nCores=28)
