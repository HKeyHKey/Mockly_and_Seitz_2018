#!/usr/bin/perl

if ($ARGV[1] eq '')
{
    print "Please enter script arguments (fastq file and miRNA fasta file; e.g., ./Module_extracts_hybrid_targets.pl miRNA-matching_reads_in_SRR959756.fastq /mnt/data/home/herve.seitz/Blaise/miRNA_absence_verification_by_Herve/matureJun14.fa).\n";
}
else
{
    open(MIRNA,$ARGV[1]);
    while (<MIRNA>)
    {
        chomp;
        if (/^>/)
        {
            s/^>//;
            s/ .*//;
            $name=$_;
        }
        else
        {
            if ($name=~/^hsa\-/)
            {
                s/U/T/g;
                $full_seq{$name}=$_;
                s/.$//;
                $trimmed1_seq{$name}=$_;
                s/.$//;
                $trimmed2_seq{$name}=$_;
                s/.$//;
                $trimmed3_seq{$name}=$_;
#                print "name=$name\n    full_seq=$full_seq{$name}\ntrimmed1_seq=$trimmed1_seq{$name}\ntrimmed2_seq=$trimmed2_seq{$name}\ntrimmed3_seq=$trimmed3_seq{$name}\n";
            }
        }
    }
    close(MIRNA);

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

                $read_length=length($seq);
                $match=0;
                foreach $name (keys %full_seq)
                {
                    if ($seq=~/$full_seq{$name}/)
                    {
                        $match=1;
                        &display($name,'full');
                    }
                }
                if ($match==0)
                {
                    foreach $name (keys %full_seq)
                    {
                        if (($seq=~/$trimmed1_seq{$name}/) && ($match==0))
                        {
                            $match=1;
                            &display($name,'trimmed1');
                        }
                    }
                }
                if ($match==0)
                {
                    foreach $name (keys %full_seq)
                    {
                        if (($seq=~/$trimmed2_seq{$name}/) && ($match==0))
                        {
                            $match=1;
                            &display($name,'trimmed2');
                        }
                    }
                }
                if ($match==0)
                {
                    foreach $name (keys %full_seq)
                    {
                        if (($seq=~/$trimmed3_seq{$name}/) && ($match==0))
                        {
                            $match=1;
                            &display($name,'trimmed3');
                        }
                    }
                }
        }
        ++$n;
    }
    close(FASTQ);
}

sub display
{
    $i=index $seq,$full_seq{$_[0]};
    $l=length($full_seq{$_[0]});
    $start=$i+1;
    $end=$i+$l;
    $a=$i+$l/2;
    $b=$read_length/2;
    if ($i+$l/2 > $read_length/2)
    {
        $flag='down';
        $target=substr $seq,0,$i+1;
        $quality=substr $qual,0,$i+1;
    }
    else
    {
        $flag='up';
        $target=substr $seq,$l;
        $quality=substr $qual,$l;
    }
    print "$ID match to $_[1] $_[0]: nt $start to $end (".$flag."stream of target fragment)\n$target\n$re match to $_[1] $_[0]: nt $start to $end (".$flag."stream of target fragment)\n$quality\n";
}
