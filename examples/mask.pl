# Creates an IupText that accepts only numbers.;
use strict;
use warnings;

use IUP ':all';

my $txt = IUP::Text->new( MASK=>'/d*');

my $dg = IUP::Dialog->new( child=>$txt, TITLE=>"MASK Example" );
$dg->Show();

if (IUP->MainLoopLevel == 0) {
  IUP->MainLoop;
}
