use strict;
use warnings;

use IUP;

# Creates boxes;
my $vboxA = IUP::Vbox->new( child=>[
              IUP::Fill->new(),
              IUP::Label->new( TITLE=>"TABS AAA", EXPAND=>"HORIZONTAL" ),
	      IUP::Button->new( TITLE=>"AAA")
	    ] );  
my $vboxB = IUP::Vbox->new( child=>[
              IUP::Label->new( TITLE=>"TABS BBB" ),
              IUP::Button->new( TITLE=>"BBB" )
            ] );
# Sets titles of the vboxes;
# xxx TODO xxx TABTITLE does not work on vbox
#$vboxA->TABTITLE("AAAAAA");
#$vboxB->TABTITLE("BBBBBB");
$vboxA->SetAttribute("TABTITLE", "AAAAAA");
$vboxB->SetAttribute("TABTITLE", "BBBBBB");
# xxx TODO check available attributes, Vbox Vbox+Tab

# Creates tabs;
my $tabs = IUP::Tabs->new( child=>[$vboxA, $vboxB] );

# Creates dialog;
my $dlg = IUP::Dialog->new( child=>IUP::Vbox->new( child=>$tabs ), MARGIN=>"10x10", TITLE=>"Test IupTabs", SIZE=>"150x80");

$dlg->SetAttribute("MARGIN", "10x10");

# Shows dialog in the center of the screen;
$dlg->ShowXY(IUP_CENTER, IUP_CENTER);

if (IUP->MainLoopLevel == 0) {
  IUP->MainLoop;
}
