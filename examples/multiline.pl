#  IupMultiline Simple Example in IupLua;
#  Shows a multiline that ignores the treatment of the 'g' key, canceling its effect.;
use strict;
use warnings;

use IUP ':all';

my $ml = IUP::Text->new( MULTILINE=>"YES", EXPAND=>"YES", VALUE=>"I ignore the 'g' key!", BORDER=>"YES" );

sub cb_action {
  my ($self, $c, $after) = @_;
  if ( $c == IUP_K_g ) {
  #if ( $c == 666 ) {
     return IUP_IGNORE;
  }
  else {
    return IUP_DEFAULT;;
  }
}

$ml->ACTION(\&cb_action);

my $dlg = IUP::Dialog->new( child=>$ml, TITLE=>"IupMultiline", SIZE=>"QUARTERxQUARTER" );
$dlg->Show();

if (IUP->MainLoopLevel == 0) {
  IUP->MainLoop;
}
