# IUP::Item Example
#
#xxx

use strict;
use warnings;

use IUP ':all';

# create the main application windows (dialog)

my $text = IUP::Text->new( VALUE=>"This is an initial text", MULTILINE=>"YES", VISIBLECOLUMNS=>15, VISIBLELINES=>15 );

my $item_save     = IUP::Item->new( TITLE=>"Save\tCtrl+S", KEY=>"K_cS", ACTIVE=>"NO" );
my $item_autosave = IUP::Item->new( TITLE=>"Auto Save", KEY=>"K_a", VALUE=>"ON" );
my $item_exit     = IUP::Item->new( TITLE=>"Exit\tAlt+X", KEY=>"K_x" );

#xxxTODO KEY=>... does not work

my $menu_file = IUP::Menu->new( child=>[$item_save, $item_autosave, $item_exit] );

my $submenu_file = IUP::Submenu->new( TITLE=>"File", child=>$menu_file );

my $menu = IUP::Menu->new( child=>$submenu_file );

my $dlg = IUP::Dialog->new( child=>$text, TITLE=>"IupItem", MENU=>$menu );

$dlg->ShowXY(IUP_CENTER, IUP_CENTER);

# setup callbacks

$item_exit->ACTION( sub { $dlg->Hide() } );

sub autosave_cb {
  if ( $item_autosave->VALUE eq "ON" ) {
    IUP->Message("Auto Save", "OFF");
    $item_autosave->VALUE("OFF");
  }
  else {
    IUP->Message("Auto Save", "ON");
    $item_autosave->VALUE("ON");
  }
  return IUP_DEFAULT;
}
$item_autosave->ACTION(\&autosave_cb);

# start the main loop

IUP->MainLoop;
