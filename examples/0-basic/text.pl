# IupText Example
# Allows the user to execute a Lua command
use strict;
use warnings;

use IUP ':all';

sub cb_text_k_any {
  my ($self, $c) = @_;
  return IUP_CLOSE if $c == K_cQ;
  return IUP_DEFAULT;
}

my $text = IUP::Text->new( VALUE=>"Write a text, press Ctrl-Q to exit",
                           EXPAND=>"HORIZONTAL",
                           K_ANY=>\&cb_text_k_any );

my $dlg = IUP::Dialog->new( child=>$text, TITLE=>"IupText", SIZE=>"QUARTERxQUARTER" );

$dlg->ShowXY(IUP_CENTER, IUP_CENTER);
#xxx TODO xxx consider adding IUP->SetFocus($text)
$text->SetFocus();

if (IUP->MainLoopLevel == 0) {
  IUP->MainLoop;
}
