# IupGetFile Example in IupLua;
# Shows a typical file-selection dialog.;

use IUP;

IUP->SetLanguage("ENGLISH");
my ($err, $f) = IUP->GetFile("*.txt");  # xxx TODO different retval order comparing to LUA

if ( $err == 1 ) {
  IUP->Message("New file", $f);
}
elsif ( $err == 0 ) {
  IUP->Message("File already exists", $f);
}
elsif ( $err == -1 ) {
  IUP->Message("IupFileDlg", "Operation canceled");
}
elsif ( $err == -2 ) {
  IUP->Message("IupFileDlg", "Allocation errr");
}
elsif ( $err == -3 ) {
  IUP->Message("IupFileDlg", "Invalid parameter");
}
