use strict;
use warnings;
use FindBin;

require "$FindBin::Bin/utils.pm";

my $f = shift;
die "Non-existing file '$f'\n" unless -f $f;

my $p = My::Pod::Simple::HTML->new();
$p->parse_from_file($f);
