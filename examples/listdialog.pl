# IupListDialog Example in IupLua;
# Shows a color-selection dialog.;
use strict;
use warnings;

use IUP ':all';

IUP->SetLanguage("ENGLISH");
my $marks = [0,0,0,0,1,1,0,0];
my $options = ["Blue", "Red", "Green", "Yellow", "Black", "White", "Gray", "Brown"];

my $error = IUP->ListDialog(2, "Color selection", $options, 0, 16, 5, $marks);

if ( $error == -1 ) {
  IUP->Message("IupListDialog", "Operation canceled");
}
else {
  my $selection = "";
  for(my $i=0; $i<scalar(@$marks); $i++) {    
    $selection .= $options->[$i] . "\n" if $marks->[$i] != 0;
  }
  if ( $selection eq '' ) {
    IUP->Message("IupListDialog", "No option selected");
  }
  else {
    IUP->Message("Selected options", $selection);
  }
}
