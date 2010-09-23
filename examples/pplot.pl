use strict;
use warnings;

use IUP;

my $plot = IUP::PPlot->new(
  TITLE=>"Simple Line",
  MARGINBOTTOM=>"65",
  MARGINLEFT=>"65",
  AXS_XLABEL=>"X",
  AXS_YLABEL=>"Y",
  LEGENDSHOW=>"YES",
  LEGENDPOS=>"TOPLEFT",  
);

$plot->PPlotBegin(0);
$plot->PPlotAdd(0, 0);
$plot->PPlotAdd(1, 0.4);
$plot->PPlotAdd(2, 2);
$plot->PPlotEnd();

# xxx TODO xxx DS_ attributes unknown
# xxx TODO xxx note in doc that DS_ has to be set after ->End()
$plot->SetAttribute("DS_LINEWIDTH", 2);
$plot->SetAttribute("DS_LEGEND", "test line");

my $d = IUP::Dialog->new( child=>$plot, SIZE=>"300x200", TITLE=>"PPlot" );
$d->Show();

if (IUP->MainLoopLevel == 0) {
  IUP->MainLoop;
}
