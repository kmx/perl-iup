#  IupMultiline Simple Example in IupLua;
#  Shows a multiline that ignores the treatment of the 'g' key, canceling its effect.;
use strict;
use warnings;

use IUP;

# xxx TODO xxx remove MultiLine
my $ml = IUP::Text->new( MULTILINE=>"YES", EXPAND=>"YES", VALUE=>"I ignore the 'g' key!", BORDER=>"YES" );

# xxx TODO xxx missing IUP_K_g

sub cb_action {
  my ($self, $c, $after) = @_;
  #if ( $c == IUP_K_g ) {
  if ( $c == 666 ) {
     return IUP_IGNORE;
  }
  else {
    return IUP_DEFAULT;;
  }
}

# xxx TODO xxx ACTION callback does not work
#$ml->ACTION(\&cb_action);
$ml->SetCallback("ACTION", \&cb_action);

my $dlg = IUP::Dialog->new( child=>$ml, TITLE=>"IupMultiline", SIZE=>"QUARTERxQUARTER" );
$dlg->Show();

if (IUP->MainLoopLevel == 0) {
  IUP->MainLoop;
}
