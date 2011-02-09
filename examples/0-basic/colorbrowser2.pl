#example used for screenshot - IUP.pod

use IUP ':all';
 
 my $dlg = IUP::ColorDlg->new( VALUE=>"128 0 255", ALPHA=>"142",
                               SHOWHEX=>"YES", SHOWCOLORTABLE=>"YES",
                               TITLE=>"IUP::ColorDlg Test" );

 $dlg->Popup(IUP_CENTER, IUP_CENTER); 
 IUP->Message("Chosen color", "Color:\t" . $dlg->VALUE) if $dlg->STATUS;
