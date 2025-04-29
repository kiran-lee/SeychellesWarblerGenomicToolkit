#!/bin/bash

PLATES=("LIMS24675" "LIMS25133" "LIMS26076p2" "LIMS26076p3" "LIMS26076p4" "LIMS26076p5" "LIMS26076p6" "LIMS26076p7" 
"LIMS26076raw" "LIMS26629" "LIMS26629p2" 
"LIMS26629p3" "LIMS26629p4" "LIMS26757" "LIMS26757p1" "LIMS26757p2" "LIMS26757p3" "LIMS26757p4")

for PLATE in "${PLATES[@]}"; do

	pushd /fastdata/bop21kgl/RawData/$PLATE/	

	#job1
	echo "starting fastqc"
	jid1=$(sbatch  /fastdata/bop21kgl/SNPsPipeline/fastqc.sh | awk '{print $4}')
	echo "$jid1"
	#job2
	echo "starting trim"
	jid2=$(sbatch  --dependency=afterok:$jid1 /fastdata/bop21kgl/SNPsPipeline/trimmomatic.sh | awk '{print $4}')
	echo "$jid2"
	#job3
	echo "starting bwa"
	jid3=$(sbatch  --dependency=afterok:$jid2 /fastdata/bop21kgl/SNPsPipeline/bwa.sh | awk '{print $4}')
	echo "$jid3"
	#job4
	echo "starting clean_bam"
	jid4=$(sbatch  --dependency=afterok:$jid3 /fastdata/bop21kgl/SNPsPipeline/clean_bam.sh | awk '{print $4}')
	echo "$jid4"
	#job5
	echo "starting snps"
	jid5=$(sbatch  --dependency=afterok:$jid4 /fastdata/bop21kgl/SNPsPipeline/snps.sh | awk '{print $4}')
	echo "$jid5"

	popd

done
