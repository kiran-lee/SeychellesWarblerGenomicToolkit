#!/bin/bash

#copy samples for STITCH
cp ../../bamlistrgdownsampledcorrect.txt .
cp ../../bamlistdownsampledcorrect.txt .

#copy script for STITCH
cp ../../stitch773first.r stitch773firstdownsampled.r
cp ../../stitch774first.r stitch774firstdownsampled.r
cp ../../stitch775first.r stitch775firstdownsampled.r
cp ../../stitch776.r stitch776downsampled.r
cp ../../stitch777.r stitch777downsampled.r
cp ../../stitch778.r stitch778downsampled.r
cp ../../stitch779.r stitch779downsampled.r
cp ../../stitch780.r stitch780downsampled.r
cp ../../stitch781.r stitch781downsampled.r
cp ../../stitch782.r stitch782downsampled.r
cp ../../stitch783.r stitch783downsampled.r
cp ../../stitch784.r stitch784downsampled.r
cp ../../stitch785.r stitch785downsampled.r
cp ../../stitch786.r stitch786downsampled.r
cp ../../stitch787.r stitch787downsampled.r
cp ../../stitch788.r stitch788downsampled.r
cp ../../stitch789.r stitch789downsampled.r
cp ../../stitch790.r stitch790downsampled.r
cp ../../stitch791.r stitch791downsampled.r
cp ../../stitch792.r stitch792downsampled.r
cp ../../stitch793.r stitch793downsampled.r
cp ../../stitch794.r stitch794downsampled.r
cp ../../stitch795.r stitch795downsampled.r
cp ../../stitch796.r stitch796downsampled.r
cp ../../stitch797.r stitch797downsampled.r
cp ../../stitch798.r stitch798downsampled.r
cp ../../stitch799.r stitch799downsampled.r
cp ../../stitch800.r stitch800downsampled.r
cp ../../stitch801.r stitch801downsampled.r
cp ../../stitch802.r stitch802downsampled.r
cp ../../stitch803.r stitch803downsampled.r

#Change to downsampled samples for STITCH and change to nGen=25
sed -i 's/bamlistrg.txt/bamlistrgdownsampledcorrect.txt/g' *.r
sed -i 's/bamlist.txt/bamlistdownsampledcorrect.txt/g' *.r
sed -i 's/nGen=100/nGen=25/g' *.r

#Change to expected recombination rates as recommended by Daniel Hooper studying black-throated finches
sed -i 's/nCores=1/nCores=8, expRate=1/g' stitch{773..775}firstdownsampled.r
sed -i 's/nCores=1/nCores=8, expRate=1/g' stitch{776..781}downsampled.r
sed -i 's/nCores=1/nCores=8, expRate=5/g' stitch{782..791}downsampled.r
sed -i 's/nCores=1/nCores=8, expRate=10/g' stitch{792..803}downsampled.r



