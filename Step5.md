# Selection of miRNA-containing reads:

Selecting reads that match trimmed miRNA sequences (but potentially not covering the whole trimmed miRNA):

`for lib in SRR959756 SRR959757;do sed '1,/^@PG\t/ d' miRNA-matching_reads_in_barcode_trimmed_$lib'.sam' | awk '{print $1}' > miRNA-matching_reads_in_$lib'.txt';done`

Generating fastq files for those:

`for lib in SRR959756 SRR959757;do ./Module_extract_from_fastq.pl barcode_trimmed_$lib'.fastq' miRNA-matching_reads_in_$lib'.txt' > miRNA-matching_reads_in_$lib'.fastq';done`

# Extraction of potential target fragments:

(note: that step also selects for reads that contain the whole 3´-trimmed miRNAs, thus eliminating a few reads from the previous step)

`for lib in SRR959756 SRR959757;do ./Module_extracts_hybrid_targets.pl miRNA-matching_reads_in_$lib'.fastq' matureJun14.fa > Hybrid_target_extraction_$lib'.fastq';done`

# Extraction of statistics:

Statistics regarding the relative position of the miRNA and the target fragment, the necessity for miRNA 3´ trimming, and the length of the target fragment:

`for lib in SRR959756 SRR959757;do ./Module_stat_on_target_fragments.pl Hybrid_target_extraction_$lib'.fastq' > stat_$lib'.dat';done`

In these 'stat_*' files, the first column indicates the 3´ trimming that was necessary for the miRNA to be matched by the read:
* "full" did not require any trimming
* "trimmed1" required trimming of 1 nt on the 3´ end
* "trimmed2" required trimming of 2 nt on the 3´ end
* "trimmed3" required trimming of 3 nt on the 3´ end

The second column identifies the miRNA.

The third column indicates the position of the miRNA relatively to the target fragment ("upstream" or "downstream").

The fourth column gives the length of the target fragment (in nt).
