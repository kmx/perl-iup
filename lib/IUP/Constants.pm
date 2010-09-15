#!/usr/bin/env perl

package IUP::Constants;
use strict;
use warnings;

use base 'Exporter';
#use vars qw(@EXPORT @EXPORT_OK %EXPORT_TAGS);

our @EXPORT = qw(
  IUP_ERROR
  IUP_NOERROR
  IUP_OPENED
  IUP_INVALID

  IUP_IGNORE
  IUP_DEFAULT
  IUP_CLOSE
  IUP_CONTINUE

  IUP_CENTER
  IUP_LEFT
  IUP_RIGHT
  IUP_MOUSEPOS
  IUP_CURRENT
  IUP_CENTERPARENT
  IUP_TOP
  IUP_BOTTOM

  IUP_BUTTON1
  IUP_BUTTON2
  IUP_BUTTON3
  IUP_BUTTON4
  IUP_BUTTON5
);

use constant IUP_ERROR         => 1;
use constant IUP_NOERROR       => 0;
use constant IUP_OPENED        => -1;
use constant IUP_INVALID       => -1;

use constant IUP_IGNORE        => -1;
use constant IUP_DEFAULT       => -2;
use constant IUP_CLOSE         => -3;
use constant IUP_CONTINUE      => -4;

use constant IUP_CENTER        => 0xFFFF; # 65535
use constant IUP_LEFT          => 0xFFFE; # 65534
use constant IUP_RIGHT         => 0xFFFD; # 65533
use constant IUP_MOUSEPOS      => 0xFFFC; # 65532
use constant IUP_CURRENT       => 0xFFFB; # 65531
use constant IUP_CENTERPARENT  => 0xFFFA; # 65530
use constant IUP_TOP           => 0xFFFE; # = IUP_LEFT
use constant IUP_BOTTOM        => 0xFFFD; # = IUP_RIGHT

use constant IUP_BUTTON1       => 1;
use constant IUP_BUTTON2       => 2;
use constant IUP_BUTTON3       => 3;
use constant IUP_BUTTON4       => 4;
use constant IUP_BUTTON5       => 5;

sub import {
  # hack: import Constants into caller's namespace  
  my ($pkg, $callpkg) = @_;
  $callpkg ||= caller();
  #xxx warn "USING CALLER: $callpkg";
  no strict 'refs';
  *{"$callpkg\::$_"} = \&{"IUP::Constants::$_"} foreach @IUP::Constants::EXPORT;
}

1;
