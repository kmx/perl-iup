# IupTimer Example

use strict;
use warnings;

use IUP ':all';

my $timer1 = IUP::Timer->new(TIME=>100);
my $timer2 = IUP::Timer->new(TIME=>2000);

# xxx TODO.ASKIUP why iuptimer has ACTION_CB not ACTION

$timer1->ACTION_CB( sub {
  print("timer 1 called\n");
  return IUP_DEFAULT;
} );


$timer2->ACTION_CB( sub {
  print("timer 2 called\n");
  return IUP_CLOSE;
} );

# can only be set after the time is created;
$timer1->RUN("YES");
$timer2->RUN("YES");

my $dg = IUP::Dialog->new( child=>IUP::Label->new( TITLE=>"Wait..." ), TITLE=>"Timer example", SIZE=>"QUARTER" );
$dg->Show();

if (IUP->MainLoopLevel == 0) {
  IUP->MainLoop;
}
