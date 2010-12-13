use warnings;
use strict;

use Alien::IUP;

my $cf = Alien::IUP->config('INC');
my $lf = Alien::IUP->config('LIBS');

my $srcdir = $ARGV[0] || '.';

for (glob("$srcdir/*.cpp")) {
  (my $o = $_) =~ s/\.cpp$/.exe/;
  print STDERR "Compiling $_ => $o\n";
  system("gcc $_ -o $o $cf $lf -lstdc++");
}

for (glob("$srcdir/*.c")) {
  (my $o = $_) =~ s/\.c$/.exe/;
  print STDERR "Compiling $_ => $o\n";
  system("gcc $_ -o $o $cf $lf");
}
