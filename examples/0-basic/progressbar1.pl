# IUP::Progressbar example

use strict;
use warnings;

use IUP ':all';

my $progressbar = IUP::ProgressBar->new();

sub idle_cb {
  my $value = $progressbar->VALUE;
  if ( $value == 1 ) {
   $value = 0.0001;
  }
  else {
   $value += 0.0001;
  }
  $progressbar->VALUE($value);
  return IUP_DEFAULT;
}

my $dlg = IUP::Dialog->new( child=>$progressbar, TITLE=>"IUP::ProgressBar");

# Registers idle callback;
IUP->SetIdle(\&idle_cb);

$dlg->ShowXY(IUP_CENTER, IUP_CENTER);

IUP->MainLoop;
