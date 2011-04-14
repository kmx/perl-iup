use strict;
use warnings;

use Test::More tests => 1;

use FindBin;
use File::Slurp;
use File::Spec;
use Data::Dumper;
use Data::Dump;

my $root = File::Spec->catdir($FindBin::Bin, '..');

my $data = {};

my @global_pod = grep(/^=head\d *.*?\(\)\s*$/, read_file("$root/_generators/pod.tt/IUP.pod"));
@global_pod = map { $1 if(/^=head\d *(.*?\(\))/) } @global_pod;

my @elemall_pod = grep(/^=head\d *.*?\(\)\s*$/, read_file("$root/_generators/pod.tt/IUP_Manual_Elements.pod"));
@elemall_pod = map { $1 if(/^=head\d *(.*?\(\))/) } @elemall_pod;

my @global_pm = grep(/^sub\s+([^\s]+)/, read_file("$root/lib/IUP.pm"));
@global_pm = map { "$1()" if(/^sub\s+([^\s]+)/) } @global_pm;

my @elemall_pm = grep(/^sub\s+([A-Z].*|new)/, read_file("$root/lib/IUP/Internal/Element.pm"));
@elemall_pm = map { "$1()" if(/^sub\s+([^\s]+)/) } @elemall_pm;

$data->{$_}->{g0doc}  = 1 for (@global_pod);
$data->{$_}->{g0mod}  = 1 for (@global_pm);
$data->{$_}->{e0doc}  = 1 for (@elemall_pod);
$data->{$_}->{e0mod}  = 1 for (@elemall_pm);

delete $data->{$_} for (qw/BEGIN() DESTROY() END() import()/);

printf STDERR ">>>>> METHODS - cross-check:\n";
my $result = 'OK';
for my $i (sort keys %{$data}) {
  next if  $data->{$i}->{g0doc} &&  $data->{$i}->{g0mod} && !$data->{$i}->{e0doc} && !$data->{$i}->{e0mod};
  next if !$data->{$i}->{g0doc} && !$data->{$i}->{g0mod} &&  $data->{$i}->{e0doc} &&  $data->{$i}->{e0mod};
  printf STDERR "% 30s %s\n", $i, Data::Dump::dump($data->{$i});
  $result = 'FAIL';  
}

printf STDERR ">>>>> METHODS - cross-check finished\n$result\n";
#print Data::Dump::dump($data);

### do the actual test ###
isnt($result,'FAIL');
