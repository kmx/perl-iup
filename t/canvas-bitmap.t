#!perl

# Regression test: IUP::Canvas::Bitmap->Pixel() used to SEGFAULT because the XS
# PREINIT block did "int width = self->w;" - but perlxs expands PREINIT BEFORE the
# typemap assigns 'self' from ST(0), so 'self' was an uninitialised pointer there.
# (Fixed by reading self->w/h in PPCODE.) See lib/IUP/Internal/Canvas_Bitmap.xs.inc.

BEGIN {
  if (!$ENV{DISPLAY} && $^O ne 'MSWin32' && $^O ne 'cygwin') {
    print "1..0 # skip: no display available\n";
    exit;
  }
}

use strict;
use warnings;
use Test::More;
use IUP ':all';

my $bmp = IUP::Canvas::Bitmap->new(CD_RGB, 100, 100);
isnt($bmp, undef, 'IUP::Canvas::Bitmap->new(CD_RGB, 100, 100)');

# reading a pixel is exactly what used to segfault
my @rgb = $bmp->Pixel(50, 50);
is(scalar(@rgb), 3, 'Pixel(x,y) returns 3 components for a CD_RGB bitmap (no segfault)');

# write a pixel, then read it back
$bmp->Pixel(10, 20, 11, 22, 33);
is_deeply([$bmp->Pixel(10, 20)], [11, 22, 33], 'Pixel write then read round-trips');

# the original one-liner from the bug report
my @p = IUP::Canvas::Bitmap->new(CD_RGB, 100, 100)->Pixel(50, 50);
ok(@p == 3, 'chained new(...)->Pixel(...) works');

done_testing();
