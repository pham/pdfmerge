#!perl -w

use strict;
use PDF::API3::Compat::API2;

printf "PDF: %s\n", &make_book2(@ARGV);

exit 0;

sub make_book2 {
    my $i       = [
        { files => [split ',', (shift//q{})], pages => 0, current => 0 },
        { files => [split ',', (shift//q{})], pages => 0, current => 0 }
    ];
    my $total   = 1;
    my $file    = sprintf "temp-%s.pdf", time;
    my $pdf     = PDF::API3::Compat::API2->new(-file => $file);

    ## title
    ## $pdf->cropbox(15,110,560,800);

    ## odd
    ## $pdf->cropbox(40,110,585,800);

    ## $pdf->cropbox(25,110,570,800);

    do {
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
                printf "%s: %d (%d)\n", $oe->{name}, ++$oe->{current}, $oe->{pages};
                $pdf->importpage($oe->{pdf}, $oe->{current});
                $total++;
            } elsif ($oe->{pdf}) {
                $oe->{current} = 0;
                $oe->{pdf}->end;
                undef $oe->{pdf};
            }
        }
    } while (
        scalar @{$i->[0]->{files}} ||
        scalar @{$i->[1]->{files}} ||
        $i->[0]->{pdf} ||
        $i->[1]->{pdf}
    );

    eval { $pdf->save };
    $@ and die "Cannot save $file: $!\n";

    print "Total pages $total\n";
    return $file;
}

1;

