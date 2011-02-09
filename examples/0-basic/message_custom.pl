use strict;
use warnings;

use IUP ':all';

#xxx TODO xxx many unknown Dialog attributes

sub myMessage {
  my ($tit, $msg) = @_;
  my $dlg = IUP::Dialog->new( MARGIN=>"10x10", GAP=>"10", ALIGNMENT=>"ACENTER", TITLE=>$tit, 
                              child=>IUP::Vbox->new( [IUP::Label->new(TITLE=>$msg, EXPAND=>"Yes"), IUP::Button->new(TITLE=>"OK", PADDING=>"5x5", ACTION_CB=>sub{return IUP_CLOSE})] )
			      );
  $dlg->Popup(10, 10);
  $dlg->Destroy();
}

my $tit = "New Position";
my $msg = "Antonio's window";
myMessage($tit,$msg);
