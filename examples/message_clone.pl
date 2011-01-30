use strict;
use warnings;

use IUP ':all';

#xxx TODO xxx many unknown Dialog attributes

sub myMessage {
  my ($tit, $msg) = @_;
  my $dlg = IUP::Dialog->new( TITLE=>$msg, EXPAND=>"Yes", TITLE=>"OK", PADDING=>"5x5", MARGIN=>"10x10", GAP=>"10", ALIGNMENT=>"ACENTER", TITLE=>$tit, SIZE=>"200x200" );
  $dlg->Popup(10, 10);
  $dlg->Destroy();
}

my $tit = "New Position";
my $msg = "Antonio's window";
myMessage($tit,$msg);
