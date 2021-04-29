# Mockly_and_Seitz_2018
Instructions, scripts and intermediary data for the generation of Table 1 in [Mockly and Seitz (Methods in Molecular Biology, 2018)](https://pubmed.ncbi.nlm.nih.gov/30963499/).

# Instruction files:

Files 'Step1.md', 'Step2.md', 'Step3.md', 'Step4.md', 'Step5.md', 'Step6.md' (in that order) describe the successive analytical steps for the preparation of Table 1.
* 'Step1.md': data download from SRA, pre-processing;
* 'Step2.md': verification of the 5´ barcode;
* 'Step3.md': 3´ adapter trimming;
* 'Step4.md': mapping reads on 3´-trimmed human miRNAs;
* 'Step5.md': selection of miRNA-containing reads, extraction of target fragments from chimeric reads, computation of statistics regarding chimeric reads;
* 'Step6.md': annotation of extracted target fragments.

# Scripts:

* 'Module_extract_from_fastq.pl': extracts reads from a fastq file (inputs: fastq file containing a larger dataset, list of read ID's to be extracted);
* 'Module_extracts_barcode-matching_reads.pl': from a fastq file, extracts reads matching a 5´ barcode;
* 'Module_extracts_hybrid_targets.pl': selects reads containing miRNA sequences, and extracts their ligated target fragments;
* 'Module_stat_on_target_fragments.pl': computes simple statistics regarding chimeric reads.

# Intermediary data files:

* 'For_target_fragment_mapping_Hybrid_target_extraction_*.fastq': fastq files containing target fragments extracted from chimeric reads;
* 'human_ncRNA_database.fa': manually assembled sequences of abundant human non-coding RNAs;
* 'matureJun14.fa': mature miRNAs in miRBase's release 21 (dated June 2014);
* 'refseq_sense_mappers_*.txt': list of ID's of reads matching RefSeq mRNAs;
* 'stat_*.dat': simple statistics regarding chimeric reads;
* 'truncated_3_hsa_matureJun14.fa': human miRNA sequences from file 'matureJun14.fa', after trimming of their last 3 nucleotides, and after converting their "U" characters into "T" characters.
