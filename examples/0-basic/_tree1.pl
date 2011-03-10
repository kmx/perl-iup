# IUP::Tree example (animals) - using helper methods e.g. TreeAddNodes()
#
# Creates a tree with some branches and leaves. Uses a Lua Table to define the IUP::Tree structure.

use strict;
use warnings;

IUP->Message("This example is slightly broken!"); #XXX-FIXME

use IUP ':all';

#xxx TODO xxx decide about TreeAddNodes syntax
my $t = {
  branchname=>"Animals", child=>[
    { branchname => "Mammals",     child=>["Horse",  "Whale"] },
    { branchname => "Crustaceans", child=>["Shrimp", "Lobster"] },
  ]
};

my $tree = IUP::Tree->new();

my $dlg = IUP::Dialog->new( child=>$tree, TITLE=>"IUP::Tree Animals", SIZE=>"200x200" );

$dlg->ShowXY(IUP_CENTER,IUP_CENTER);

#NOTE: tree->TreeAddNodes(...) has to go after dialog->Show() xxx why?
$tree->TreeAddNodes($t);

IUP->MainLoop();
