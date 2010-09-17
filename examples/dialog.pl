#IupDialog Example - Creates a simple dialog

use IUP;

my $vbox = IUP::Vbox->new( child=>[ IUP::Label->new(TITLE=>"Label"), IUP::Button->new(TITLE=>"Test") ] );
my $dlg = IUP::Dialog->new( child=>$vbox, TITLE=>"Dialog", SIZE=>"100x100");
$dlg->Show();

if (IUP->MainLoopLevel == 0) {
  IUP->MainLoop;
}