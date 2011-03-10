# IUP::Tree example (attributes)

use strict;
use warnings;

IUP->Message("This example is slightly broken!"); #XXX-FIXME

use IUP ':all';

my $nodes = {
	branchname=>"root (0)",
	state=>"EXPANDED",
	child=>[{
		branchname=>"1.1 (1)",
		state=>"EXPANDED",
		child=>[{
			branchname=>"1.1.1 (2)",
			state=>"EXPANDED",
			child=>[{
				branchname=>"1.1.1.1 (3)",
				state=>"EXPANDED",
				child=>["1.1.1.1.1 (4)","1.1.1.1.2 (5)"],
			},
			{
				branchname=>"1.1.1.2 (6)",
				state=>"EXPANDED",
				child=>["1.1.1.2.1 (7)","1.1.1.2.2 (8)"],
			}], #xxx3
		},
		{
			branchname=>"1.1.2 (9)",
			state=>"EXPANDED",
			{
				branchname=>"1.1.2.1 (10)",
				state=>"EXPANDED",
				child=>["1.1.2.1.1 (11)","1.1.2.1.2 (12)"],
			},
			{
				branchname=>"1.1.2.2 (13)",
				state=>"EXPANDED",
				child=>["1.1.2.2.1 (14)","1.1.2.2.2 (15)"],
			},
		}], #xxx2
	},
	{
		branchname=>"1.2 (16)",
		state=>"EXPANDED",
		{
			branchname=>"1.2.1 (17)",
			state=>"EXPANDED",
			{
				branchname=>"1.2.1.1 (18)",
				state=>"EXPANDED",
				child=>["1.2.1.1.1 (19)","1.2.1.1.2 (20)"],
			},
			{
				branchname=>"1.2.1.2 (21)",
				state=>"EXPANDED",
				child=>["1.2.1.2.1 (22)","1.2.1.2.2 (23)"],
			},
		},
		{
			branchname=>"1.2.2 (24)",
			state=>"EXPANDED",
			{
				branchname=>"1.2.2.1 (25)",
				state=>"EXPANDED",
				child=>["1.2.2.1.1 (26)","1.2.2.1.2 (27)"],
			},
			{
				branchname=>"1.2.2.2 (28)",
				state=>"EXPANDED",
				child=>["1.2.2.2.1 (29)","1.2.2.2.2 (30)"],
			},
		},
	}], #xxx1
};

my $tree = IUP::Tree->new( MAP_CB=>sub { my $self=shift; $self->TreeAddNodes($nodes) } );

my $no = IUP::Text->new();

my $attrs = IUP::Text->new( VALUE=>"{ color = '255 0 0', }", SIZE=>"200x" );

my $dlg = IUP::Dialog->new( child=>IUP::Vbox->new( child=>[
		              $tree,
		              IUP::Hbox->new( child=>[
			        IUP::Fill->new(),
			        IUP::Label->new( TITLE=>"Node:" ),
			        $no,
			        IUP::Fill->new(),
			        IUP::Label->new( TITLE=>"Attributes:" ),
			        $attrs,
			        IUP::Fill->new()
			      ]),
			      IUP::Hbox->new( child=>[
			        IUP::Fill->new(),
			        IUP::Button->new(
				  TITLE=>"Ancestors",
				  ACTION=>sub { $tree->TreeSetAncestorsAttributes($no->VALUE, "return ".$attrs->VALUE) },
			        ),
			        IUP::Fill->new(),
			        IUP::Button->new(
				  TITLE=>"Descendents",
				  ACTION=>sub { $tree->TreeSetDescentsAttributes($no->VALUE, "return ".$attrs->VALUE) },
			        ),
			        IUP::Fill->new(),
			        IUP::Button->new(
				  TITLE=>"All",
				  ACTION=>sub {
                            		        for my $node (0..$tree->Count-1) { #XXX-FIXME
						  $tree->TreeSetNodeAttributes($node, "return ".$attrs->VALUE);
						}
					      },
			        ),
				IUP::Fill->new(),
			      ]),
			    ]),
			  );  

$dlg->Show();
$tree->VALUE(15);
$no->VALUE(15);

IUP->MainLoop();
