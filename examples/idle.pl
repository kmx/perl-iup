use IUP;

my $l = IUP::Label->new( TITLE=>"1", SIZE=>"200x" );

sub idle_cb {
  my $v = int($l->TITLE) + 1;
  $l->TITLE = $v;
  if ( $v == 10000 ) {
    # xxx TODO xxx missing function
    # xxx IUP->SetIdle();
  }
  return IUP_DEFAULT;
}

my $dlg = IUP::Dialog->new( child=>$l, TITLE=>"Idle Test" );

$dlg->ShowXY(IUP_CENTER, IUP_CENTER);

# Registers idle callback;
# xxx TODO cannot set IDLE callback
IUP->SetIdle(\&idle_cb);

if (IUP->MainLoopLevel == 0) {
  IUP->MainLoop;
}