# IupText Example
# Allows the user to execute a Lua command
use strict;
use warnings;

use IUP;

my $text = IUP::Text->new( VALUE=>"Write a text, press Ctrl-Q to exit", EXPAND=>"HORIZONTAL" );

sub cb_text_k_any {
  my ($self, $c) = @_;
  # xxx TODO K_xxx missing
  #if ( c == IUP_K_cQ ) {
  #  return IUP_CLOSE;
  #}
  return IUP_DEFAULT;
}

my $dlg = IUP::Dialog->new( child=>$text, TITLE=>"IupText", SIZE=>"QUARTERxQUARTER" );

$dlg->ShowXY(IUP_CENTER, IUP_CENTER);
$text->SetFocus();

if (IUP->MainLoopLevel == 0) {
  IUP->MainLoop;
}

#xxx TODO xxx consider IUP->SetFocus($text)