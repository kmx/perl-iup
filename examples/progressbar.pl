use strict;
use warnings;

use IUP;

my $progressbar = IUP::ProgressBar->new();
#$progressbar->SHOW_TEXT("YES");

sub idle_cb {
  my $value = $progressbar->VALUE;
  $value += 0.0001;
  $value = 0.0 if ( $value > 1.0 );
  $progressbar->VALUE($value);
  return IUP_DEFAULT;
}

my $dlg = IUP::Dialog->new( child=>$progressbar, TITLE=>"IupProgressBar");
#$dlg->SIZE("QUARTERxEIGHTH");

# xxx TODO SetIdle not implemented yet
# Registers idle callback;
IUP->SetIdle(\&idle_cb);

$dlg->ShowXY(IUP_CENTER, IUP_CENTER);

if (IUP->MainLoopLevel == 0) {
  IUP->MainLoop;
}
