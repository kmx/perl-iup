 use IUP ':all';
 
 my $filedlg = IUP::FileDlg->new( DIALOGTYPE=>"SAVE", TITLE=>"File save",
                                  FILTER=>"*.bmp", FILTERINFO=>"Bitmap files",
                                  DIRECTORY=>'c:\windows' ); 
 $filedlg->Popup(IUP_CENTER, IUP_CENTER);
 
 my $status = $filedlg->STATUS; 
 IUP->Message("New file", $filedlg->VALUE)            if $status == "1";
 IUP->Message("File already exists", $filedlg->VALUE) if $status == "0";
 IUP->Message("IupFileDlg", "Operation canceled")     if $status == "-1";
