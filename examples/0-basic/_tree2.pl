# IUP::Tree example (figures) - using attribute only interface
#
# Creates a tree with some branches and leaves.
# Two callbacks are registered: one deletes marked nodes when the Del key
# is pressed, and the other, called when the right mouse button is pressed,
# opens a menu with options.

use strict;
use warnings;

IUP->Message("This example is slightly broken!"); #XXX-FIXME

use IUP ':all';

my $tree = IUP::Tree->new();

$tree->RIGHTCLICK_CB( sub { print STDERR "RIGHTCLICK_CB\n" } );

$tree->RENAME_CB( sub { print STDERR "RENAME_CB\n" } );

$tree->K_ANY( sub {
  my ($self, $c) = @_;
  $tree->SetAttribute("DELNODE", "MARKED") if ( $c == K_DEL );
} );

#xxx TODO check tree.c example + tree1.wlua

sub init_tree_nodes {
  $tree->SetAttribute( "TITLE", "Figures" ); 
  $tree->SetAttribute( "ADDBRANCH0", "3D" );
  $tree->SetAttribute( "ADDBRANCH0", "2D" );
  $tree->SetAttribute( "ADDBRANCH1", "parallelogram" );
  $tree->SetAttribute( "ADDLEAF2", "diamond" );
  $tree->SetAttribute( "ADDLEAF2", "square" );
  $tree->SetAttribute( "ADDBRANCH1", "triangle" );
  $tree->SetAttribute( "ADDLEAF2", "scalenus" );
  $tree->SetAttribute( "ADDLEAF2", "isoceles" );
  $tree->SetAttribute( "ADDLEAF2", "equilateral" );
  $tree->SetAttribute( "ADDLEAF2", "other" );
  $tree->SetAttribute( "VALUE", "6" ); 
}

my $dlg = IUP::Dialog->new( child=>$tree, TITLE=>"IUP::Tree Figures", SIZE=>"QUARTERxTHIRD" );
$tree->SetAttribute( MARKMODE=>"MULTIPLE", ADDEXPANDED=>"NO", SHOWRENAME=>"YES" );
$dlg->ShowXY(IUP_CENTER,IUP_CENTER);

#NOTE: all tree->SetAttribute(...) has to go after dialog->Show() xxx why?
init_tree_nodes();

IUP->MainLoop;
