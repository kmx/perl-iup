#IupCanvas Example in IupLua;

use IUP;

# xxx TODO fix attributes
#my $cv = IUP::Canvas->new( SIZE=>"300x100", XMIN=>0, XMAX=>99, POSX=>0, DX=>10 );
my $cv = IUP::Canvas->new( SCROLLBAR=>"YES", SIZE=>"300x300", DX=>10 );
$cv->SetAttribute("XMIN", 0);
$cv->SetAttribute("XMAX", 99);
$cv->SetAttribute("POSX", 0);
 
my $dg = IUP::Dialog->new( child=>IUP::Frame->new($cv), TITLE=>"IupCanvas" );

$cv->MOTION_CB( sub {
  my ($self, $x, $y, $r) = @_;
  print "mouse_x=$x mouse_y=$y mouse_button=$r\n";
} );

$dg->ShowXY(IUP_CENTER, IUP_CENTER);

if (IUP->MainLoopLevel == 0) {
  IUP->MainLoop;
}
