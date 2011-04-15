use strict;
use warnings;

use Test::More tests => 1;

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

diag ">>>>> CONSTANTS - cross-check";
my $result = 'OK';
for my $i (sort keys %{$data}) {
  next if $data->{$i} == 2;
  diag "missing definition: $i" unless $def->{$i};
  diag "missing export    : $i" unless $exp->{$i};
  $result = 'FAIL';  
}

#diag ">>>>> CONSTANTS - cross-check finished - $result";
#print Data::Dump::dump($data);

### do the actual test ###
isnt($result,'FAIL');