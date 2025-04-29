#get all the samples and their coverages from each plate in different directories
cat /fastdata/bop21kgl/RawData/LIMS*/samplescoveragenew.txt > coverageall.txt

#make all decimal places
awk '{printf("%.7f\n", $2); }' coverageall.txt > coveragealldecimals.txt
awk 'NR==FNR{a[NR]=$0;next}{$2=a[FNR]}1' coveragealldecimals.txt coverageall.txt > coverageall2.txt

#sort based on coverage low to high
sort -k 2 -n coverageall2.txt > coverageallsorted.txt
