#IupCanvas Example in IupLua;
use strict;
use warnings;

use IUP ':all';

#my $cv = IUP::Canvas->new( SIZE=>"300x100", XMIN=>0, XMAX=>99, POSX=>0, DX=>10 );
my $cv = IUP::Canvas->new( SCROLLBAR=>"YES", SIZE=>"300x300", DX=>10, POSX=>0, XMIN=>0, XMAX=>99);

$cv->ACTION( sub {
  my ($self, $sx, $sy) = @_;
  #print "redraw sx=$sx sy=$sy cnv=".$self->cnvhandle."\n";
} );

$cv->BUTTON_CB( sub {
  my ($self, $b, $s, $x, $y) = @_;
  warn "b=$b, s=$s, x=$x, y=$y\n";
  #if($b == IUP_BUTTON1 && $s) { # xxx TODO xxx IUP_BUTTON1 does not work
  printf STDERR ("1=%d 2=%d 3=%d\n", IUP_BUTTON1, IUP_BUTTON2, IUP_BUTTON3);
  if($b == 49 && $s)  {
    $self->cdActivate();
    $self->cdLine(10,10,500,500);   
    $self->cdMark($x,$self->cdUpdateYAxis($y));
  }
} );


$cv->MOTION_CB( sub {
  my ($self, $x, $y, $r) = @_;
  #print "mouse_x=$x mouse_y=$y mouse_button=$r\n";
} );

my $dg = IUP::Dialog->new( child=>IUP::Frame->new($cv), TITLE=>"IupCanvas" );
$dg->ShowXY(IUP_CENTER, IUP_CENTER);

if (IUP->MainLoopLevel == 0) {
  IUP->MainLoop;
}
