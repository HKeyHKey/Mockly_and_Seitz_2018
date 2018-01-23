#!/usr/bin/perl

if ($ARGV[1] eq '')
{
    print "Please enter script arguments (fastq file and barcode sequence; e.g., ./Module_extracts_barcode-matching_reads.pl trimmed_SRR959756.fastq CACAGC).\n";
}
else
{
    $barcode=$ARGV[1];

    $n=0;
    open(FASTQ,$ARGV[0]);
    while (<FASTQ>)
    {
        chomp;
        if ($n==0)
        {
            $ID=$_;
        }
        if ($n==1)
        {
            $seq=$_;
        }
        if ($n==2)
        {
            $re=$_;
        }
        if ($n==3)
        {
            $qual=$_;
            $n=-1;
            if ($seq=~/^$barcode/)
            {
                $seq=~s/^$barcode//;
                $qual=substr $qual,length($barcode);
                print "$ID\n$seq\n$re\n$qual\n";
            }
        }
        ++$n;
    }
    close(FASTQ);
}
