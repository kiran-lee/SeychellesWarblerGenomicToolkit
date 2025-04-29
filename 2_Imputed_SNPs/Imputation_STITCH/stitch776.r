library('STITCH')
getwd()
STITCH(tempdir = tempdir(), chr="ENA|OU383776|OU383776.1_RagTag",  bamlist="bamlistrg.txt", posfile="ENA|OU383776.txt", sampleNames_file="bamlist.txt", outputdir= paste0(getwd(), "/"), K=4, nGen=25, nCores=28, expRate=1)
