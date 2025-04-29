library('STITCH')
getwd()
STITCH(tempdir = tempdir(), chr="ENA|OU383800|OU383800.1_RagTag",  bamlist="bamlistrg.txt", posfile="ENA|OU383800.txt", sampleNames_file="bamlist.txt", outputdir= paste0(getwd(), "/"), K=4, nGen=25, nCores=28, expRate=10)
