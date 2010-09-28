# IupMenu Example in IupLua;
# Creates a dialog with a menu with two submenus.;
use strict;
use warnings;

use IUP;

# Creates a text, sets its value and turns on text readonly mode;
my $text = IUP::Text->new( READONLY=>"YES", VALUE=>"Selecting show or hide will affect this text", SIZE=>300 );

# Creates items, sets its shortcut keys and deactivates edit item;
my $item_show = IUP::Item->new( TITLE=>"Show", KEY=>IUP_K_S );
my $item_hide = IUP::Item->new( TITLE=>"Hide\tCtrl+H" );
my $item_edit = IUP::Item->new( TITLE=>"Edit", KEY=>"K_E", ACTIVE=>"NO" );
my $item_exit = IUP::Item->new( TITLE=>"Exit", KEY=>"K_x" );

# xxx TODO xxx KEY=>... does not work

$item_show->ACTION( 
  sub {
    $text->VISIBLE("YES");
    return IUP_DEFAULT;
  } 
);

$item_hide->ACTION(
  sub {
    $text->VISIBLE("NO");
    return IUP_DEFAULT;
  }
);

$item_exit->ACTION( sub { return IUP_CLOSE } );

# Creates two menus;
my $menu_file = IUP::Menu->new( child=>[$item_exit] );
my $menu_text = IUP::Menu->new( child=>[$item_show, $item_hide, $item_edit] );

# Creates two submenus;
my $submenu_file = IUP::Submenu->new( menu=>$menu_file, TITLE=>"File" );
my $submenu_text = IUP::Submenu->new( menu=>$menu_text, TITLE=>"Text" );

# Creates main menu with two submenus;
my $menu = IUP::Menu->new( child=>[$submenu_file, $submenu_text] );

# Creates dialog with a text, sets its title and associates a menu to it;
my $dlg = IUP::Dialog->new( child=>$text, TITLE=>"IupMenu Example", MENU=>$menu);

# Shows dialog in the center of the screen;
$dlg->ShowXY( IUP_CENTER,IUP_CENTER );

if (IUP->MainLoopLevel == 0) {
  IUP->MainLoop;
}
