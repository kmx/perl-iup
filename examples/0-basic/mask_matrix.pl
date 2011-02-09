use strict;
use warnings;

use IUP ':all';

my $mat = IUP::Matrix->new( NUMLIN=>3, NUMCOL=>3 );
$mat->MatCell(1, 1, "Only numbers");

# xxx TODO xxx MASK does not work well
#$mat->SetAttribute("MASK", "/d+"); # xxx TODO this does not work
$mat->SetAttribute("MASK1:1", "/d+"); # xxx TODO this somehow does work
#$mat->SetAttribute("MASKINT", "0:99");

my $dg = IUP::Dialog->new( child=>$mat );

$dg->Show();

if (IUP->MainLoopLevel == 0) {
  IUP->MainLoop;
}