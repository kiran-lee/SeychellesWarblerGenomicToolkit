#!/bin/bash

ls /fastdata/bop21kgl/RawData/LIMS*/Clean_aligned/[0-9]*rehead.bam > bamlist.txt
ls /fastdata/bop21kgl/RawData/LIMS*/Clean_aligned/rg*rehead.bam > bamlistrg.txt

#get downsampled bamlist.txt
grep -v "102_ACTTAGATCG-CGGAATTCTT_L002__all_mapped_rehead.bam" bamlist.txt > tmpfile && mv tmpfile bamlistdownsampled.txt
grep -v "18-11998DH0112L01_4567_CGCTCATTAT-GCCTCTATGT_L001__all_mapped_rehead.bam" bamlistdownsampled.txt > tmpfile && mv tmpfile bamlistdownsampled.txt
grep -v "19-11998DH0113L01_4568_CGCTCATTAT-AGGATAGGGT_L001__all_mapped_rehead.bam" bamlistdownsampled.txt > tmpfile && mv tmpfile bamlistdownsampled.txt
grep -v "21-11998DH0115L01_4576_CGCTCATTAT-CTTCGCCTGT_L001__all_mapped_rehead.bam" bamlistdownsampled.txt > tmpfile && mv tmpfile bamlistdownsampled.txt
grep -v "33-11998DH0033L01_3890_TACCGAGGAT-AGTTCAGGGT_L001__all_mapped_rehead.bam" bamlistdownsampled.txt > tmpfile && mv tmpfile bamlistdownsampled.txt
grep -v "34-11998DH0034L01_3903_CGTTAGAAAT-GACCTGAAGT_L001__all_mapped_rehead.bam" bamlistdownsampled.txt > tmpfile && mv tmpfile bamlistdownsampled.txt
grep -v "34-11998DH0128L01_4658_ATTCAGAAAT-GCCTCTATGT_L001__all_mapped_rehead.bam" bamlistdownsampled.txt > tmpfile && mv tmpfile bamlistdownsampled.txt
grep -v "37-11998DH0131L01_4680_ATTCAGAAAT-CTTCGCCTGT_L001__all_mapped_rehead.bam" bamlistdownsampled.txt > tmpfile && mv tmpfile bamlistdownsampled.txt
grep -v "42-11998DH0136L01_4717_GAATTCGTAT-GCCTCTATGT_L001__all_mapped_rehead.bam" bamlistdownsampled.txt > tmpfile && mv tmpfile bamlistdownsampled.txt
grep -v "46-11998DH0140L01_4835_GAATTCGTAT-TAAGATTAGT_L001__all_mapped_rehead.bam" bamlistdownsampled.txt > tmpfile && mv tmpfile bamlistdownsampled.txt
grep -v "50-11998DH0144L01_4853_CTGAAGCTAT-GCCTCTATGT_L001__all_mapped_rehead.bam" bamlistdownsampled.txt > tmpfile && mv tmpfile bamlistdownsampled.txt
grep -v "519_GACGTTCTCT-AGTAGAGCTA_L001__all_mapped_rehead.bam" bamlistdownsampled.txt > tmpfile && mv tmpfile bamlistdownsampled.txt
grep -v "53-11998DH0147L01_4879_CTGAAGCTAT-CTTCGCCTGT_L001__all_mapped_rehead.bam" bamlistdownsampled.txt > tmpfile && mv tmpfile bamlistdownsampled.txt
grep -v "54-11998DH0148L01_4881_CTGAAGCTAT-TAAGATTAGT_L001__all_mapped_rehead.bam" bamlistdownsampled.txt > tmpfile && mv tmpfile bamlistdownsampled.txt
grep -v "55-11998DH0149L01_4884_CTGAAGCTAT-ACGTCCTGGT_L001__all_mapped_rehead.bam" bamlistdownsampled.txt > tmpfile && mv tmpfile bamlistdownsampled.txt
grep -v "56-11998DH0150L01_4891_CTGAAGCTAT-GTCAGTACGT_L001__all_mapped_rehead.bam" bamlistdownsampled.txt > tmpfile && mv tmpfile bamlistdownsampled.txt
grep -v "58-11998DH0152L01_4897_TAATGCGCAT-GCCTCTATGT_L001__all_mapped_rehead.bam" bamlistdownsampled.txt > tmpfile && mv tmpfile bamlistdownsampled.txt
grep -v "586-6037_TTGCGCCAAG-CTCGGCTATC_L004__all_mapped_rehead.bam" bamlistdownsampled.txt > tmpfile && mv tmpfile bamlistdownsampled.txt
grep -v "621-6020_TCAGAACCTG-ACCGATCTAT_L004__all_mapped_rehead.bam" bamlistdownsampled.txt > tmpfile && mv tmpfile bamlistdownsampled.txt
grep -v "661-7321_ACCTCAGTAT-ACATTCACAG_L004__all_mapped_rehead.bam" bamlistdownsampled.txt > tmpfile && mv tmpfile bamlistdownsampled.txt
grep -v "70-11998DH0164L01_5012_CGGCTATGAT-TAAGATTAGT_L001__all_mapped_rehead.bam" bamlistdownsampled.txt > tmpfile && mv tmpfile bamlistdownsampled.txt
grep -v "96_CAACCATACA-ACCGGTTATA_L002__all_mapped_rehead.bam" bamlistdownsampled.txt > tmpfile && mv tmpfile bamlistdownsampled.txt
grep -v "97_GTAGGCCGTT-GCCACTGTCT_L002__all_mapped_rehead.bam" bamlistdownsampled.txt > tmpfile && mv tmpfile bamlistdownsampled.txt

cat QC/downsampled2.6 >> bamlistdownsampled.txt

#get downsampled bamlistrg.txt
grep -v "102_ACTTAGATCG-CGGAATTCTT_L002__all_mapped_rehead.bam" bamlistrg.txt > tmpfile && mv tmpfile bamlistrgdownsampled.txt
grep -v "18-11998DH0112L01_4567_CGCTCATTAT-GCCTCTATGT_L001__all_mapped_rehead.bam" bamlistrgdownsampled.txt > tmpfile && mv tmpfile bamlistrgdownsampled.txt
grep -v "19-11998DH0113L01_4568_CGCTCATTAT-AGGATAGGGT_L001__all_mapped_rehead.bam" bamlistrgdownsampled.txt > tmpfile && mv tmpfile bamlistrgdownsampled.txt
grep -v "21-11998DH0115L01_4576_CGCTCATTAT-CTTCGCCTGT_L001__all_mapped_rehead.bam" bamlistrgdownsampled.txt > tmpfile && mv tmpfile bamlistrgdownsampled.txt
grep -v "33-11998DH0033L01_3890_TACCGAGGAT-AGTTCAGGGT_L001__all_mapped_rehead.bam" bamlistrgdownsampled.txt > tmpfile && mv tmpfile bamlistrgdownsampled.txt
grep -v "34-11998DH0034L01_3903_CGTTAGAAAT-GACCTGAAGT_L001__all_mapped_rehead.bam" bamlistrgdownsampled.txt > tmpfile && mv tmpfile bamlistrgdownsampled.txt
grep -v "34-11998DH0128L01_4658_ATTCAGAAAT-GCCTCTATGT_L001__all_mapped_rehead.bam" bamlistrgdownsampled.txt > tmpfile && mv tmpfile bamlistrgdownsampled.txt
grep -v "37-11998DH0131L01_4680_ATTCAGAAAT-CTTCGCCTGT_L001__all_mapped_rehead.bam" bamlistrgdownsampled.txt > tmpfile && mv tmpfile bamlistrgdownsampled.txt
grep -v "42-11998DH0136L01_4717_GAATTCGTAT-GCCTCTATGT_L001__all_mapped_rehead.bam" bamlistrgdownsampled.txt > tmpfile && mv tmpfile bamlistrgdownsampled.txt
grep -v "46-11998DH0140L01_4835_GAATTCGTAT-TAAGATTAGT_L001__all_mapped_rehead.bam" bamlistrgdownsampled.txt > tmpfile && mv tmpfile bamlistrgdownsampled.txt
grep -v "50-11998DH0144L01_4853_CTGAAGCTAT-GCCTCTATGT_L001__all_mapped_rehead.bam" bamlistrgdownsampled.txt > tmpfile && mv tmpfile bamlistrgdownsampled.txt
grep -v "519_GACGTTCTCT-AGTAGAGCTA_L001__all_mapped_rehead.bam" bamlistrgdownsampled.txt > tmpfile && mv tmpfile bamlistrgdownsampled.txt
grep -v "53-11998DH0147L01_4879_CTGAAGCTAT-CTTCGCCTGT_L001__all_mapped_rehead.bam" bamlistrgdownsampled.txt > tmpfile && mv tmpfile bamlistrgdownsampled.txt
grep -v "54-11998DH0148L01_4881_CTGAAGCTAT-TAAGATTAGT_L001__all_mapped_rehead.bam" bamlistrgdownsampled.txt > tmpfile && mv tmpfile bamlistrgdownsampled.txt
grep -v "55-11998DH0149L01_4884_CTGAAGCTAT-ACGTCCTGGT_L001__all_mapped_rehead.bam" bamlistrgdownsampled.txt > tmpfile && mv tmpfile bamlistrgdownsampled.txt
grep -v "56-11998DH0150L01_4891_CTGAAGCTAT-GTCAGTACGT_L001__all_mapped_rehead.bam" bamlistrgdownsampled.txt > tmpfile && mv tmpfile bamlistrgdownsampled.txt
grep -v "58-11998DH0152L01_4897_TAATGCGCAT-GCCTCTATGT_L001__all_mapped_rehead.bam" bamlistrgdownsampled.txt > tmpfile && mv tmpfile bamlistrgdownsampled.txt
grep -v "586-6037_TTGCGCCAAG-CTCGGCTATC_L004__all_mapped_rehead.bam" bamlistrgdownsampled.txt > tmpfile && mv tmpfile bamlistrgdownsampled.txt
grep -v "621-6020_TCAGAACCTG-ACCGATCTAT_L004__all_mapped_rehead.bam" bamlistrgdownsampled.txt > tmpfile && mv tmpfile bamlistrgdownsampled.txt
grep -v "661-7321_ACCTCAGTAT-ACATTCACAG_L004__all_mapped_rehead.bam" bamlistrgdownsampled.txt > tmpfile && mv tmpfile bamlistrgdownsampled.txt
grep -v "70-11998DH0164L01_5012_CGGCTATGAT-TAAGATTAGT_L001__all_mapped_rehead.bam" bamlistrgdownsampled.txt > tmpfile && mv tmpfile bamlistrgdownsampled.txt
grep -v "96_CAACCATACA-ACCGGTTATA_L002__all_mapped_rehead.bam" bamlistrgdownsampled.txt > tmpfile && mv tmpfile bamlistrgdownsampled.txt
grep -v "97_GTAGGCCGTT-GCCACTGTCT_L002__all_mapped_rehead.bam" bamlistrgdownsampled.txt > tmpfile && mv tmpfile bamlistrgdownsampled.txt

ls /fastdata/bop21kgl/RawData/allplates/QC/rg*2.6x.bam >> bamlistrgdownsampled.txt