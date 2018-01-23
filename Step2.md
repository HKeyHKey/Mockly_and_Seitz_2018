# Commands:

According to Helwak et al.'s Suppl. Table S6, the 5´ barcode for protocol E4 is CACAGC. Verification:

``for i in `seq 1 10000`;do j=`echo "("$i"-1)*4+2" | bc`;head -$j SRR959756.fastq | tail -1;done > first_10000;grep -c '^CACAGC' first_10000 # result: 9442 (looks OK)``


``for i in `seq 1 10000`;do j=`echo "("$i"-1)*4+2" | bc`;head -$j SRR959757.fastq | tail -1;done > first_10000_SRR959757;grep -c '^CACAGC' first_10000_SRR959757 # result: 10000 (looks OK)``

# Conclusion:

A large majority of reads indeed start with the expected 5´ barcode.
