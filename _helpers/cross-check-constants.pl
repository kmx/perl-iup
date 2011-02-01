use strict;
use warnings;

use FindBin;
use File::Slurp;
use File::Spec;
use Data::Dumper;
use Data::Dump;

my $root = File::Spec->catdir($FindBin::Bin, '..');

my @defined = grep(/^use\s+constant/, read_file("$root/lib/IUP/Constants.pm"));
@defined = map { $1 if(/^use\s+constant\s+([^\s=]+)/) } @defined;

my @exported = grep(/^\s*(IUP_|K_|CD_)/, read_file("$root/lib/IUP/Constants.pm"));
@exported = map { $1 if(/^\s*([^\s=]+)/) } @exported;

my ($data, $def, $exp);
$data->{$_}++ for @defined;
$data->{$_}++ for @exported;
$def->{$_}++ for @defined;
$exp->{$_}++ for @exported;

printf STDERR ">>>>> CONSTANTS - cross-check:\n";
my $result = 'OK';
for my $i (sort keys %{$data}) {
  next if $data->{$i} == 2;
  print STDERR "missing definition: $i\n" unless $def->{$i};
  print STDERR "missing export    : $i\n" unless $exp->{$i};
  $result = 'FAIL';  
}

printf STDERR ">>>>> CONSTANTS - cross-check finished\n$result\n";

#print Data::Dump::dump($data);