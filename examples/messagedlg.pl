use strict;
use warnings;

use IUP ':all';

my $dlg = IUP::MessageDlg->new( DIALOGTYPE=>"ERROR", TITLE=>"Error!", VALUE=>"This is an error message" );

$dlg->Popup();
$dlg->Destroy();
