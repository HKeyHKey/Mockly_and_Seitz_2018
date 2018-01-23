# Origin of annotation files:

The 'human_ncRNA_database.fa' file contains manually assembled sequences of abundant human non-coding RNAs (rRNAs, tRNAs, snRNAs, snoRNAs, ...).

The 'refMrna.fa' file (containing RefSeq mRNA sequences) was donwloaded from the UCSC Genome Browser on January 19, 2018:

`wget http://hgdownload.soe.ucsc.edu/goldenPath/hg38/bigZips/refMrna.fa.gz;gunzip refMrna.fa.gz`

# Index building:

`hisat2-build -f human_ncRNA_database.fa human_ncRNA_database;hisat2-build -f refMrna.fa refMrna`

# Mapping on abundant ncRNAs:

`for lib in SRR959756 SRR959757;do hisat2 --no-unal -x human_ncRNA_database -U For_target_fragment_mapping_Hybrid_target_extraction_$lib'.fastq' -S Human_ncRNA_database_mapping_$lib'.sam';done`

# Output:

33364 reads; of these:  
  33364 (100.00%) were unpaired; of these:  
    27397 (82.12%) aligned 0 times  
    5962 (17.87%) aligned exactly 1 time  
    5 (0.01%) aligned >1 times  
17.88% overall alignment rate  
105831 reads; of these:  
  105831 (100.00%) were unpaired; of these:  
    75909 (71.73%) aligned 0 times  
    29866 (28.22%) aligned exactly 1 time  
    56 (0.05%) aligned >1 times  
28.27% overall alignment rate  

# ncRNA annotation:

Many fragments matching nuclear rRNAs, and trace amounts matching tRNAs, mitochondrial rRNAs or tRNAs, snRNAs or snoRNAs:

``for f in `ls Human_ncRNA*.sam`;do sed '1,/^@PG\t/ d' $f;done | awk '$2==0 || $2==256 {print $3}' | sort | uniq -c | sort -g``

Counting by category:

``for lib in SRR959756 SRR959757;do sed '1,/^@PG\t/ d' Human_ncRNA_database_mapping_$lib'.sam' | awk '$2==0 || $2==256 {print $3}' | sort | uniq -c > count_$lib'.txt';done``

``for f in `ls Human_ncRNA*.sam`;do sed '1,/^@PG\t/ d' $f;done | awk '$2==0 || $2==256 {print $3}' | sort | uniq -c | sort -g | grep -v 'hg38_tRNAs_' | awk '{print $2}' > non_tRNAs``

``for lib in SRR959756 SRR959757;do echo "";echo $lib":";category='snoRNA_scaRNA';n=`egrep -w 'U17a|ACA22|U109|ACA34|HBI-61|ACA36' count_$lib'.txt' | awk '{s+=$1} END {print s}'`;echo $category $n;category='snRNA';n=`egrep -w 'NR_002716\.3|NR_029422\.1' count_$lib'.txt' | awk '{s+=$1} END {print s}'`;echo $category $n;category='tRNA';n=`egrep 'mito_tRNA|hg38_tRNAs_' count_$lib'.txt' | awk '{s+=$1} END {print s}'`;echo $category $n;category='7SL_7SK';n=`egrep -w 'NR_145670\.1|NR_001445\.2' count_$lib'.txt' | awk '{s+=$1} END {print s}'`;echo $category $n;category='rRNA';n=`egrep -w 'mito_rRNA_16S|NR_023363\.1|mito_rRNA_12S|U13369\.1' count_$lib'.txt' | awk '{s+=$1} END {print s}'`;echo $category $n;done``

# Mapping on RefSeq mRNAs:

`for lib in SRR959756 SRR959757;do hisat2 --no-unal -x refMrna -U For_target_fragment_mapping_Hybrid_target_extraction_$lib'.fastq' -S Human_RefSeq_mRNA_mapping_$lib'.sam';done`

# Output:

33364 reads; of these:  
  33364 (100.00%) were unpaired; of these:  
    15274 (45.78%) aligned 0 times  
    14036 (42.07%) aligned exactly 1 time  
    4054 (12.15%) aligned >1 times  
54.22% overall alignment rate  
105831 reads; of these:  
  105831 (100.00%) were unpaired; of these:  
    58952 (55.70%) aligned 0 times  
    30790 (29.09%) aligned exactly 1 time  
    16089 (15.20%) aligned >1 times  
44.30% overall alignment rate  

# mRNA-matching reads that don't match rRNAs or tRNAs:

Counting reads that match RefSeq mRNAs in the sense orientation without matching rRNAs or tRNAs in the sense orientation:

``for lib in SRR959756 SRR959757;do sed '1,/@PG\t/ d' Human_RefSeq_mRNA_mapping_$lib'.sam' | awk '$2==0 || $2==256 {print $1}' | sort | uniq > refseq_sense_mappers_$lib'.txt';done;for lib in SRR959756 SRR959757;do sed '1,/@PG\t/ d' Human_ncRNA_database_mapping_$lib'.sam' | awk '$2==0 || $2==256 {print $1,$3}' | egrep 'mito_tRNA|hg38_tRNAs_|mito_rRNA_16S|NR_023363\.1|mito_rRNA_12S|U13369\.1' | awk '{print $1}' | sort | uniq > rRNA_tRNA_sense_mappers_$lib'.txt';done;for lib in SRR959756 SRR959757;do cat refseq_sense_mappers_$lib'.txt' rRNA_tRNA_sense_mappers_$lib'.txt' rRNA_tRNA_sense_mappers_$lib'.txt' | sort | uniq -c | grep -c '^ *1 ';done``
