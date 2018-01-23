Data download according to the Supplemental Information of Helwak et al. (2013), Cell 153(3):654-665 (their best protocol is the "optimized" protocol E4, whose GEO accession number is GSM1219490).
There are two SRA runs for that GEO sample: [SRR959756](https://trace.ncbi.nlm.nih.gov/Traces/sra/?run=SRR959756 "SRA link for SRR959756") and [SRR959757](https://trace.ncbi.nlm.nih.gov/Traces/sra/?run=SRR959757 "SRA link for SRR959757").

Extraction of fastq files:
    fastq-dump SRR959756
Output:
Read 9195453 spots for SRR959756
Written 9195453 spots for SRR959756
    fastq-dump SRR959757
Output:
Read 30860297 spots for SRR959757
Written 30860297 spots for SRR959757

It turns out that SRR959756 contains 50-nt long reads while SRR959757 contains 100-nt long reads.

