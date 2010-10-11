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

# note: DS_nnn attributes have to be set after PPlotEnd()
$plot->DS_LEGEND("test line");
$plot->DS_LINEWIDTH(2);

my $d = IUP::Dialog->new( child=>$plot, SIZE=>"300x200", TITLE=>"PPlot" );
$d->Show();

if (IUP->MainLoopLevel == 0) {
  IUP->MainLoop;
}
