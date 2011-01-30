# IupZbox Example
# An application of a zbox could be a program requesting several entries from the user
# according to a previous selection. In this example, a list of possible layouts,
# each one consisting of an element, is presented, and according to the selected
# option the dialog below the list is changed.

use strict;
use warnings;

use IUP ':all';

my $fill = IUP::Fill->new();
my $text = IUP::Text->new( VALUE=>"Enter your text here", EXPAND=>"YES" );
my $lbl  = IUP::Label->new( TITLE=>"This element is a label" );
my $btn  = IUP::Button->new( TITLE=>"This button does nothing" );
my $zbox = IUP::Zbox->new( child=>[$fill, $text, $lbl, $btn], ALIGNMENT=>"ACENTER", VALUE=>$text );

my $list = IUP::List->new( items=>["fill", "text", "lbl", "btn"], VALUE=>"2");
my $ilist = [ $fill, $text, $lbl, $btn ];

sub list_action {
  my ($self, $t, $o, $selected) = @_;
  if ( $selected == 1 ) {
    # Sets the value of the zbox to the selected element;
    $zbox->VALUE($ilist->[$o]);
  }

  return IUP_DEFAULT;
}

$list->ACTION(\&list_action);

my $frm = IUP::Frame->new( TITLE=>"Select an element", child=>
            IUP::Hbox->new( child=>[
              IUP::Fill->new(),
              $list,
              IUP::Fill->new(),
	    ] )
          );

my $dlg = IUP::Dialog->new( child=>IUP::Vbox->new( "MARGIN", "7x7", child=>[$frm, $zbox] ), SIZE=>"QUARTER", TITLE=>"IupZbox Example" );
$dlg->ShowXY (0, 0);

if (IUP->MainLoopLevel == 0) {
  IUP->MainLoop;
}
