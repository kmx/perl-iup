use strict;
use warnings;

use Test::More tests => 1;

use Test::More;
use FindBin;
use File::Slurp;
use File::Spec;
use File::Find;
use Data::Dumper;
use Data::Dump;

sub find_file {
  my ($dir, $re) = @_;
  my @files;
  $re ||= qr/.*/;
  {
    no warnings 'File::Find'; #hide warning "Can't opendir(...): Permission denied
    find({ wanted => sub { push @files, File::Spec->rel2abs($_) if /$re/ && -f $_ }, follow => 1, no_chdir => 1 , follow_skip => 2}, $dir);
  };
  return @files;
}

my $root = File::Spec->catdir($FindBin::Bin, '..');

my $all_code = '';
$all_code .= read_file($_) . "\n" for find_file ("$root/lib", qr/\.pm$/);
$all_code =~ s/(IUP::Internal::LibraryIup::[^\(\s,]+)/\n$1\n/sg;

my @pm_calls = grep(/^IUP::Internal::LibraryIup::/, (split "\n", $all_code));
@pm_calls = map { $1 if(/^IUP::Internal::LibraryIup::([^\(\s,]+)/) } @pm_calls;
@pm_calls = grep(!/^(_register_(ch|ih)|_translate_(ch|ih)|_unregister_(ch|ih))$/, @pm_calls);

my @xs_funcs = grep(/^_/, read_file("$root/lib/IUP/Internal/LibraryIup.xs"));
@xs_funcs = map { $1 if(/^(_[^\s\(]+)/) } @xs_funcs;

@xs_funcs = sort(@xs_funcs);
@pm_calls = sort(@pm_calls);

my ($data, $pm, $xs);
$data->{$_}++ for @xs_funcs;
$data->{$_}++ for @pm_calls;
$pm->{$_}++ for @pm_calls;
$xs->{$_}++ for @xs_funcs;

diag ">>>>> XS-FUNCS - cross-check";
my $result = 'OK';
for my $i (sort keys %{$data}) {
  next if $data->{$i} == 2;
  if (!$pm->{$i} && $i =~ /^_Iup(GetAttributeHandle|OleControl|OleControlOpen)$/) {
    diag "intentionally missing in pm: $i";
    next;
  }
  elsif ($pm->{$i} && $xs->{$i}) {
    next;
  }
  diag "missing in xs: $i" unless $xs->{$i};
  diag "missing in pm: $i" unless $pm->{$i}; 
  $result = 'FAIL';  
}

#diag ">>>>> XS-FUNCS - cross-check finished - $result";
#print Data::Dump::dump($data);

### do the actual test ###
isnt($result,'FAIL');