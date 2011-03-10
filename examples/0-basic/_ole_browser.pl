# IUP::Canvas example
#
#xxx

use strict;
use warnings;

IUP->Message("This example is slightly broken!"); #XXX-FIXME

use IUP ':all';

# create the WebBrowser based on its ProgID
my $control = IUP::OleControl->new(progid=>"Shell.Explorer.2", DESIGNMODE=>"NO");

print "iu=",$control->GetAttribute('IUNKNOWN'),"\n";


#xxx-- connect it to LuaCOM
#control:CreateLuaCOM()

# Create a dialog containing the OLE control
my $addr = IUP::Text->new( EXPAND=>"HORIZONTAL", TIP=>"Type an URL here" );

my $bt = IUP::Button->new( TITLE=>"Load", TIP=>"Click to load the URL");
#xxx
#$bt->SetCallback('ACTION', control.com:Navigate(addr.value));

my $dlg = IUP::Dialog->new( TITLE=>"IupOle", SIZE=>"HALFxHALF",
                            child=>IUP::Vbox->new([IUP::Hbox->new([$addr, $bt]),$control]) );

# Show the dialog and run the main loop
$dlg->Show();
use Data::Dumper;
print "pi=",Dumper([$control->GetAttributes]),"\n";
IUP->MainLoop();
