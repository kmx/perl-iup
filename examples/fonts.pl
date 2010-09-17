use IUP;

my $l = IUP::List->new(DROPDOWN=>"YES");

$l->SetAttribute("1", "HELVETICA_NORMAL_8");
$l->SetAttribute("2", "COURIER_NORMAL_8");
$l->SetAttribute("3", "TIMES_NORMAL_8");
$l->SetAttribute("4", "HELVETICA_ITALIC_8");
$l->SetAttribute("5", "COURIER_ITALIC_8");
$l->SetAttribute("6", "TIMES_ITALIC_8");
$l->SetAttribute("7", "HELVETICA_BOLD_8");
$l->SetAttribute("8", "COURIER_BOLD_8");
$l->SetAttribute("9", "TIMES_BOLD_8");
$l->SetAttribute("10", "HELVETICA_NORMAL_10");
$l->SetAttribute("11", "COURIER_NORMAL_10");
$l->SetAttribute("12", "TIMES_NORMAL_10");
$l->SetAttribute("13", "HELVETICA_ITALIC_10");
$l->SetAttribute("14", "COURIER_ITALIC_10");
$l->SetAttribute("15", "TIMES_ITALIC_10");
$l->SetAttribute("16", "HELVETICA_BOLD_10");
$l->SetAttribute("17", "COURIER_BOLD_10");
$l->SetAttribute("18", "TIMES_BOLD_10");
$l->SetAttribute("19", "HELVETICA_NORMAL_12");
$l->SetAttribute("20", "COURIER_NORMAL_12");
$l->SetAttribute("21", "TIMES_NORMAL_12");
$l->SetAttribute("22", "HELVETICA_ITALIC_12");
$l->SetAttribute("23", "COURIER_ITALIC_12");
$l->SetAttribute("24", "TIMES_ITALIC_12");
$l->SetAttribute("25", "HELVETICA_BOLD_12");
$l->SetAttribute("26", "COURIER_BOLD_12");
$l->SetAttribute("27", "TIMES_BOLD_12");
$l->SetAttribute("28", "HELVETICA_NORMAL_14");
$l->SetAttribute("29", "COURIER_NORMAL_14");
$l->SetAttribute("30", "TIMES_NORMAL_14");
$l->SetAttribute("31", "HELVETICA_ITALIC_14");
$l->SetAttribute("32", "COURIER_ITALIC_14");
$l->SetAttribute("33", "TIMES_ITALIC_14");
$l->SetAttribute("34", "HELVETICA_BOLD_14");
$l->SetAttribute("35", "COURIER_BOLD_14");
$l->SetAttribute("36", "TIMES_BOLD_14");

my $dg = IUP::Dialog->new( child=>$l );
$dg->TITLE("title");

my $dg2;

$l->ACTION( sub {
  my ($self, $t, $i, $v) = @_;

  $dg2->Hide if ($dg2);

  if ($v == 1) {
    my $ml = IUP::MultiLine->new();
    #xxx TODO $ml->SIZE("200x200");
    #xxx TODO $ml->VALUE("1234\nmmmmm\niiiii");
    #xxx TODO $ml->FONT($t);
    $ml->SetAttribute("SIZE", "200x200");
    $ml->SetAttribute("VALUE", "200x200");
    $ml->SetAttribute("FONT", $t);
    $dg2 = IUP::Dialog->new( child=>$ml );
    $dg2->TITLE($t);
    $dg2->Show();
    $l->SetFocus();
  }
} );

$dg->Show();

if (IUP->MainLoopLevel == 0) {
  IUP->MainLoop;
}
