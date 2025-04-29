library('STITCH')
getwd()
STITCH(tempdir = tempdir(), chr="ENA|OU383781|OU383781.1_RagTag",  bamlist="bamlistrg.txt", posfile="ENA|OU383781.txt", sampleNames_file="bamlist.txt", outputdir= paste0(getwd(), "/"), K=4, nGen=25, nCores=28, expRate=1)
