#IupDial Example

use IUP;

my $lbl_h = IUP::Label->new( TITLE=>"0", ALIGNMENT=>"ACENTER", SIZE=>"100x10" );
my $lbl_v = IUP::Label->new( TITLE=>"0", ALIGNMENT=>"ACENTER", SIZE=>"100x10" );
my $lbl_c = IUP::Label->new( TITLE=>"0", ALIGNMENT=>"ACENTER", SIZE=>"100x10" );

my $dial_v = IUP::Dial->new( TYPE=>"VERTICAL", SIZE=>"100x100");
my $dial_h = IUP::Dial->new( TYPE=>"HORIZONTAL", DENSITY=>0.3);

sub v_mousemove_cb {
  my ($self, $a) = @_;
  $lbl_v->TITLE($a);
  return IUP_DEFAULT;
}

sub h_mousemove_cb {
  my ($self, $a) = @_;
  $lbl_h->TITLE($a);
  return IUP_DEFAULT;
}

$dial_v->MOUSEMOVE_CB(\&v_mousemove_cb);
$dial_h->MOUSEMOVE_CB(\&h_mousemove_cb);

my $dlg = IUP::Dialog->new( TITLE=>"IupDial", child=>
    IUP::Vbox->new( MARGIN=>"10x10", GAP=>"5", child=>[
        IUP::Vbox->new( child=>[ $dial_v, $lbl_v ] ),
        IUP::Vbox->new( child=>[ $dial_h, $lbl_h ] ),
    ] ) );

$dlg->ShowXY(IUP_CENTER,IUP_CENTER);

if (IUP->MainLoopLevel == 0) {
  IUP->MainLoop;
}
