use strict;
use warnings;

use IUP;

my $mat = IUP::Matrix->new( NUMCOL=>5, NUMLIN=>3, NUMCOL_VISIBLE=>5, NUMLIN_VISIBLE=>3, WIDTHDEF=>34 );
#$mat->RESIZEMATRIX = "YES";
$mat->SetAttribute("RESIZEMATRIX", "YES");

# xxx TODO xxx idea: $o->Attribute("TITLE") vs. $o->Attribute("TITLE", "value");

$mat->Cell(0,0,"Inflation");
$mat->Cell(1,0,"Medicine");
$mat->Cell(2,0,"Food");
$mat->Cell(3,0,"Energy");
$mat->Cell(0,1,"January 2000");
$mat->Cell(0,2,"February 2000");
$mat->Cell(1,1,"5.6");
$mat->Cell(2,1,"2.2");
$mat->Cell(3,1,"7.2");
$mat->Cell(1,2,"4.6");
$mat->Cell(2,2,"1.3");
$mat->Cell(3,2,"1.4");

my $dlg = IUP::Dialog->new( child=>IUP::Vbox->new( child=>$mat, MARGIN=>"10x10") );
$dlg->ShowXY(IUP_CENTER, IUP_CENTER);

if (IUP->MainLoopLevel == 0) {
  IUP->MainLoop;
}
