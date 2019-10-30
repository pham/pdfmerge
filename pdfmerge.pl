#!perl -w

use strict;
use PDF::API3::Compat::API2;

use constant PRODUCT => 'pdfmerge';
use constant VERSION => 'v1.0';

&make_book(@ARGV);

exit 0;

sub make_book {
    my $i       = [
        { files => [split ',', (shift//q{})], pages => 0, current => 0 },
        { files => [split ',', (shift//q{})], pages => 0, current => 0 }
    ];
    my $total   = 0;
    my $pdf     = PDF::API3::Compat::API2->new;
    while ( scalar @{$i->[0]->{files}} || scalar @{$i->[1]->{files}} ||
            $i->[0]->{pdf} || $i->[1]->{pdf}) {
        foreach my $oe (@$i) {
            my $files = $oe->{files};
            if (!$oe->{pdf} && scalar @$files) {
                if (my $f = shift @$files) {
                    $oe->{pdf}      = PDF::API3::Compat::API2->open($f);
                    $oe->{pages}    = $oe->{pdf}->pages;
                    $oe->{name}     = $f;
                    printf "%s (%d)\n", $f, $oe->{pdf}->pages;
                }
            }
 
            if ($oe->{pages}-- > 0) {
                printf "%s: %d (%d)\n",
                    $oe->{name},
                    ++$oe->{current},
                    $oe->{pages};
                $pdf->importpage($oe->{pdf}, $oe->{current});
                $total++;
            } elsif ($oe->{pdf}) {
                $oe->{current} = 0;
                $oe->{pdf}->end;
                undef $oe->{pdf};
            }
        }
    }

    unless ($total) {
        die "$0 odd-1.pdf,odd-2.pdf even-1.pdf,even-2.pdf,even-3.pdf\n";
    }

    my $file    = sprintf "temp-%s.pdf", time;
    eval { $pdf->saveas($file) };
    if ($@) {
        unlink $file;
        die "Cannot save $file: $!\n";
    }

    print "$file has $total pages\n";
}

1;

