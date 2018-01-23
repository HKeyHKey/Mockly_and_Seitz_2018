# Origin of miRNA sequences:

Mature miRNA sequences (release 21 of miRBase, dated June 2014): downloaded from the miRBase website:  
`wget ftp://mirbase.org/pub/mirbase/21/mature.fa.gz;gunzip mature.fa.gz;mv mature.fa matureJun14.fa`

# miRNA sequence processing:

Selection of human miRNAs, conversion of sequences (U characters replaced by T's) and trimming of the last 3 nucleotides:

`grep -A 1 '^>hsa\-' matureJun14.fa | grep -v '\-\-' | sed -e '/^>/ !s|U|T|g' -e '/^>/ !s|...$||' > truncated_3_hsa_matureJun14.fa`

# Mapping reads on miRNAs:

Trimming 5´ barcode from reads, then mapping trimmed reads on mature, trimmed human miRNAs:

``for f in trimmed_SRR959756.fastq trimmed_SRR959757.fastq;do ./Module_extracts_barcode-matching_reads.pl $f CACAGC > barcode_$f;done;bowtie2-build truncated_3_hsa_matureJun14.fa truncated_3_hsa_matureJun14;for f in barcode_trimmed_SRR959756.fastq barcode_trimmed_SRR959757.fastq;do bowtie2 --local --norc --no-unal -x truncated_3_hsa_matureJun14 -U $f -S miRNA-matching_reads_in_`echo $f | sed 's|.fastq|.sam|'`;done``

# Output:

For SRR959756:

(many warnings for short reads)  
8688014 reads; of these:  
  8688014 (100.00%) were unpaired; of these:  
    8515672 (98.02%) aligned 0 times  
    171068 (1.97%) aligned exactly 1 time  
    1274 (0.01%) aligned >1 times  
1.98% overall alignment rate  

For SRR959757:

(many warnings for short reads)  
30848119 reads; of these:  
  30848119 (100.00%) were unpaired; of these:  
    30416759 (98.60%) aligned 0 times  
    426492 (1.38%) aligned exactly 1 time  
    4868 (0.02%) aligned >1 times  
1.40% overall alignment rate  
