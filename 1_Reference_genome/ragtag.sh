# I concatenated all 31 chromosomes from here: https://www.ebi.ac.uk/ena/browser/view/GCA_910950805?dataType=&show=chromosomes 
#by using cat function:
cat chr*.fasta > rw_chromosomes.fasta

#Then I used ragtag with following parameteres to take SW contigs and map to RW genome:
ragtag.py scaffold rw_chromosomes.fasta Pilontrial4thround2.fasta -r -C -g100 -m 100000 -f 200 -u --mm2-params '-x asm5'

