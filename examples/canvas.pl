#IupCanvas Example in IupLua;

use IUP;

#my $cv = IUP::Canvas->new( SIZE=>"300x100", XMIN=>0, XMAX=>99, POSX=>0, DX=>10 );
my $cv = IUP::Canvas->new( SCROLLBAR=>"YES", SIZE=>"300x300", DX=>10, POSX=>0, XMIN=>0, XMAX=>99);

$cv->ACTION( sub {
  my ($self, $sx, $sy) = @_;
  print "redraw sx=$sx sy=$sy cnv=".$self->cnvhandle."\n";
  $self->cdCanvasLine(10,10,500,500);
} );

$cv->MOTION_CB( sub {
  my ($self, $x, $y, $r) = @_;
  print "mouse_x=$x mouse_y=$y mouse_button=$r\n";
} );

my $dg = IUP::Dialog->new( child=>IUP::Frame->new($cv), TITLE=>"IupCanvas" );
$dg->ShowXY(IUP_CENTER, IUP_CENTER);

if (IUP->MainLoopLevel == 0) {
  IUP->MainLoop;
}
