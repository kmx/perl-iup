use strict;
use warnings;

use IUP ':all';

my $bt = IUP::Button->new( TITLE=>"Test", EXPAND=>"YES" );

my $box = IUP::Sbox->new( child=>$bt, DIRECTION=>"SOUTH", COLOR=>"0 255 0" );

my $ml = IUP::Text->new( MULTILINE=>"YES", EXPAND=>"YES" );

my $vbox = IUP::Vbox->new( child=>[$box, $ml] );

my $lb = IUP::Label->new( TITLE=>"Label", EXPAND=>"YES" );

my $dg = IUP::Dialog->new( child=>IUP::Hbox->new( child=>[$vbox, $lb] ), SIZE=>"QUARTERxQUARTER" );
$dg->Show();

if (IUP->MainLoopLevel == 0) {
  IUP->MainLoop;
}
