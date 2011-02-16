# IUP::PPlot example

use strict;
use warnings;

use IUP ':all';

my $plot = IUP::PPlot->new(
             TITLE        => "Sine and Cosine",
             MARGINBOTTOM => 40,
             MARGINLEFT   => 40,
             LEGENDSHOW   => "YES",
             AXS_XLABEL   => "X",
             AXS_YLABEL   => "Y",
             AXS_YMIN     => -1.1,
	     AXS_YAUTOMIN => "NO",
             AXS_YMAX     => 1.1,
	     AXS_YAUTOMAX => "NO",
);

$plot->PPlotBegin(0);
for (my $x=-2; $x<=2; $x+=0.01) {
  $plot->PPlotAdd($x, sin($x))
}
$plot->PPlotEnd();

$plot->PPlotBegin(0);
for (my $x=-2; $x<=2; $x+=0.01) {
  $plot->PPlotAdd($x, cos($x))
}
$plot->PPlotEnd();

$plot->DS_LINEWIDTH(3);
#$plot->REDRAW("YES");
$plot->PREDRAW_CB( sub { print("AXS_YMIN=", $plot->AXS_YMIN, "\n") } );

my $dlg = IUP::Dialog->new( child=>$plot, TITLE=>"Two Series", SIZE=>"QUARTERxQUARTER" );
$dlg->Show();

IUP->MainLoop();
