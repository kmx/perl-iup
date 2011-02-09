# IUP->SetIdle Example
#
# Basic usage of idle callback

use strict;
use warnings;

use IUP ':all';

my $l = IUP::Label->new( TITLE=>"1", SIZE=>"200x" );

sub idle_cb {
  my $v = int($l->TITLE) + 1;
  $l->TITLE($v);
  if ( $v >= 10000 ) {
    # done - unset idle callback
    IUP->SetIdle();
  }
  return IUP_DEFAULT;
}

my $dlg = IUP::Dialog->new( child=>$l, TITLE=>"Idle Test" );

$dlg->ShowXY(IUP_CENTER, IUP_CENTER);

# Registers idle callback;
IUP->SetIdle(\&idle_cb);

IUP->MainLoop;
