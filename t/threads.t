#!perl

# Regression: objects wrapping a native CD/IUP resource (IUP::Canvas::Bitmap, ...)
# free it in DESTROY. Under ithreads they used to be cloned into spawned threads
# sharing the same native pointer, so the clone's DESTROY double-freed it
# -> "free(): invalid pointer". Fixed via CLONE_SKIP (see IUP::Internal::LibraryIup).

use strict;
use warnings;
use Config;

BEGIN {
  unless ($Config{useithreads}) { print "1..0 # skip: perl built without ithreads\n"; exit; }
  if (!$ENV{DISPLAY} && $^O ne 'MSWin32' && $^O ne 'cygwin') {
    print "1..0 # skip: no display available\n"; exit;
  }
}

use threads;
use Test::More;
use IUP ':all';

my $bmp = IUP::Canvas::Bitmap->new(CD_RGB, 100, 100);
is($bmp->Width, 100, 'bitmap Width before any threads');

threads->create(sub { 1 })->join;   # used to abort with: free(): invalid pointer

is($bmp->Width, 100, 'bitmap still usable after thread spawn+join (no double-free)');

# a few spawns to be sure
threads->create(sub { 1 })->join for 1 .. 3;
is($bmp->Width, 100, 'bitmap survives repeated thread spawns');

ok(IUP::Canvas::Bitmap->can('CLONE_SKIP'),   'IUP::Canvas::Bitmap has CLONE_SKIP');
ok(IUP::Internal::Canvas->can('CLONE_SKIP'), 'IUP::Internal::Canvas has CLONE_SKIP');

done_testing();
