#IupTree Example
#Creates a tree with some branches and leaves. Uses a Lua Table to define the IupTree structure.
use strict;
use warnings;

use IUP;

my $tree = IUP::Tree->new();
my $dlg = IUP::Dialog->new( child=>$tree, TITLE=>"TableTree result", SIZE=>"200x200" );
$dlg->ShowXY(IUP_CENTER,IUP_CENTER);

#xxx TODO xxx decide about TreeAddNodes syntax

my $t = {
  branchname=>"Animals", child=>[
    { branchname => "Mammals",     child=>["Horse",  "Whale"] },
    { branchname => "Crustaceans", child=>["Shrimp", "Lobster"] },
  ]
};

$tree->TreeAddNodes($t);

if (IUP->MainLoopLevel == 0) {
  IUP->MainLoop;
}
