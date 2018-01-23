#!/usr/bin/perl
$MIN_SIZE=15; # minimal size (in nt) of target fragment for reporting in output fastq file

if ($ARGV[0] eq '')
{
    print "Please enter script argument (fastq file of miRNA-matching reads; e.g., ./Module_stat_on_target_fragments.pl Hybrid_target_extraction_SRR959756.fastq).\n";
}
else
{
    open(OUT,">For_target_fragment_mapping_$ARGV[0]");
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
            if (length($seq)>=$MIN_SIZE)
            {
                print OUT "$ID\n$seq\n$re\n$qual\n";
            }
            ($miRNA,$position)=($ID,$ID);
            $miRNA=~s/.* match to //;
            $miRNA=~s/: nt .*//;
            $position=~s/.*\(//;
            $position=~s/ of target fragment\)$//;
            $l=length($seq);
            print "$miRNA $position $l\n";
        }
        ++$n;
    }
    close(FASTQ);
    close(OUT);
}
