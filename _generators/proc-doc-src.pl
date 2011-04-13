#TODO
#find . -name "*.c" -o -name "*.cpp" | xargs grep -e "(IFidle)" -e "(IFn)" -e "(IFni)" -e "(IFnii)" -e "(IFniii)" -e "(IFniiii)" -e "(IFniiiiii)" -e "(IFnff)" -e "(IFniff)" -e "(IFnfiis)" -e "(IFnnii)" -e "(IFnnn)" -e "(IFnss)" -e "(IFns)" -e "(IFnsi)" -e "(IFnis)" -e "(IFnsii)" -e "(IFnsiii)" -e "(IFniis)" -e "(IFniiiis)" -e "(IFniiiiiis)" -e "(IFnIi)" -e "(IFnd)" -e "(IFniiIII)" -e "(IFniinsii)" -e "(IFnccc)" -e "(sIFnii)" -e "(sIFni)" | grep '"' | grep "(ih" | sed "s/  */ /" | sort | uniq | sed -e "s/\.c:/:/" -e "s/\.cpp:/:/" -e "s/:[^(]*(\([^)]*\))[^\"]*\"\([^\"]*\)\".*/:\1:\2/"

use strict;
use warnings;
use Data::Dumper;
use Template;
use HTML::TreeBuilder;
use FindBin;
use File::Spec;
use Getopt::Long;
use Pod::Usage;

require "$FindBin::Bin/utils.pm";
die "###FATAL### Cannot require utils.pm\n" if $@;

my $g_tag = "3.4";
my $g_longoutput = 0;
my $g_srcroot  = 'y:\IUP.Unpacked\iup-'.$g_tag;

my $curdir   = $FindBin::Bin;
my $distroot = File::Spec->catfile($curdir, '..');
my $docroot  = $g_srcroot;
die "###FATAL### Invalid dir '$distroot'" unless -d "$distroot/lib" && -f "$distroot/Build.PL";

my @all_src = My::Utils::find_file($g_srcroot, qr/\.(c|cpp)$/);
@all_src = grep /\Q$g_srcroot\E[\\\/](src|srcim|srcimglib|srcpplot|srcole|srccontrols|srccd|srcgl|srcweb|srctuio)[\\\/]/i, @all_src; #nasty hack - we need just files 
#die "###DEBUG### all_src=", Dumper(\@all_src);

my @all_doc = (
  glob("$docroot/html/en/elem/iup*.html"),
  glob("$docroot/html/en/dlg/iup*.html"),
  glob("$docroot/html/en/ctrl/iup*.html"),
);

my $cb_res = {};
my $at_res = {};
my %a_list;
my %c_list;

my %common_actions;
my %common_src;

$common_src{'IUP::Canvas'}->{ACTION} = 'ff';
$common_src{'IUP::Canvas'}->{RESIZE_CB} = 'ii';
$common_src{'IUP::Canvas'}->{SCROLL_CB} = 'iff';
$common_src{'IUP::Canvas'}->{WHEEL_CB} = 'fiis';
$common_src{'IUP::Cells'}->{DRAW_CB} = 'iiiiii';
$common_src{'IUP::Cells'}->{HEIGHT_CB} = 'i';
$common_src{'IUP::Cells'}->{HSPAN_CB} = 'ii';
$common_src{'IUP::Cells'}->{MOUSECLICK_CB} = 'iiiiiis';
$common_src{'IUP::Cells'}->{MOUSEMOTION_CB} = 'iiiis';
$common_src{'IUP::Cells'}->{SCROLLING_CB} = 'ii';
$common_src{'IUP::Cells'}->{VSPAN_CB} = 'ii';
$common_src{'IUP::Cells'}->{WIDTH_CB} = 'i';
$common_src{'IUP::Classbase'}->{VALUECHANGED_CB} = '';
$common_src{'IUP::ColorBrowser'}->{CHANGE_CB} = 'ccc';
$common_src{'IUP::ColorBrowser'}->{DRAG_CB} = 'ccc';
$common_src{'IUP::ColorBar'}->{CELL_CB} = 'i';
$common_src{'IUP::ColorBar'}->{EXTENDED_CB} = 'i';
$common_src{'IUP::ColorBar'}->{SELECT_CB} = 'ii';
$common_src{'IUP::ColorBar'}->{SWITCH_CB} = 'ii';
$common_src{'IUP::Common'}->{BUTTON_CB} = 'iiiis';
$common_src{'IUP::Common'}->{DROPFILES_CB} = 'siii';
$common_src{'IUP::Common'}->{MOTION_CB} = 'iis';
$common_src{'IUP::Common'}->{WOM_CB} = 'i';
$common_src{'IUP::Dial'}->{BUTTON_PRESS_CB} = 'd';
$common_src{'IUP::Dial'}->{BUTTON_RELEASE_CB} = 'd';
$common_src{'IUP::Dial'}->{MOUSEMOVE_CB} = 'd';
$common_src{'IUP::Dial'}->{VALUECHANGED_CB} = '';
$common_src{'IUP::Dialog'}->{COPYDATA_CB} = 'si';
$common_src{'IUP::Dialog'}->{MOVE_CB} = 'ii';
$common_src{'IUP::Dialog'}->{RESIZE_CB} = 'ii';
$common_src{'IUP::Dialog'}->{SHOW_CB} = 'i';
$common_src{'IUP::Dialog'}->{TRAYCLICK_CB} = 'iii';
$common_src{'IUP::FileDlg'}->{FILE_CB} = 'ss';
$common_src{'IUP::Focus'}->{FOCUS_CB} = 'i';
$common_src{'IUP::Key'}->{KEYPRESS_CB} = 'ii';
$common_src{'IUP::Key'}->{K_ANY} = 'i';
$common_src{'IUP::List'}->{ACTION} = 'sii';
$common_src{'IUP::List'}->{CARET_CB} = 'iii';
$common_src{'IUP::List'}->{DBLCLICK_CB} = 'is';
$common_src{'IUP::List'}->{DROPDOWN_CB} = 'i';
$common_src{'IUP::List'}->{EDIT_CB} = 'is';
$common_src{'IUP::List'}->{MULTISELECT_CB} = 's';
$common_src{'IUP::Matrix'}->{ACTION_CB} = 'iiiis';
$common_src{'IUP::Matrix'}->{BGCOLOR_CB} = 'iiIII';
$common_src{'IUP::Matrix'}->{CLICK_CB} = 'iis';
$common_src{'IUP::Matrix'}->{DROPCHECK_CB} = 'ii';
$common_src{'IUP::Matrix'}->{DROPSELECT_CB} = 'iinsii';
$common_src{'IUP::Matrix'}->{DROP_CB} = 'nii';
$common_src{'IUP::Matrix'}->{EDITION_CB} = 'iiii';
$common_src{'IUP::Matrix'}->{ENTERITEM_CB} = 'ii';
$common_src{'IUP::Matrix'}->{FGCOLOR_CB} = 'iiIII';
$common_src{'IUP::Matrix'}->{FONT_CB} = 'ii';
$common_src{'IUP::Matrix'}->{LEAVEITEM_CB} = 'ii';
$common_src{'IUP::Matrix'}->{MARKEDIT_CB} = 'iii';
$common_src{'IUP::Matrix'}->{MARK_CB} = 'ii';
$common_src{'IUP::Matrix'}->{MOUSEMOVE_CB} = 'ii';
$common_src{'IUP::Matrix'}->{RELEASE_CB} = 'iis';
$common_src{'IUP::Matrix'}->{SCROLLTOP_CB} = 'ii';
$common_src{'IUP::Matrix'}->{VALUE_CB} = 'ii';
$common_src{'IUP::Matrix'}->{VALUE_EDIT_CB} = 'iis';
$common_src{'IUP::Oldtabs'}->{TABCHANGE_CB} = 'nn';
$common_src{'IUP::Oldval'}->{BUTTON_PRESS_CB} = 'd';
$common_src{'IUP::Oldval'}->{BUTTON_RELEASE_CB} = 'd';
$common_src{'IUP::Oldval'}->{MOUSEMOVE_CB} = 'd';
$common_src{'IUP::Spin'}->{SPIN_CB} = 'i';
$common_src{'IUP::Tabs'}->{TABCHANGE_CB} = 'nn';
$common_src{'IUP::Text'}->{ACTION} = 'is';
$common_src{'IUP::Text'}->{CARET_CB} = 'iii';
$common_src{'IUP::Text'}->{SPIN_CB} = 'i';
$common_src{'IUP::Toggle'}->{ACTION} = 'i';
$common_src{'IUP::Tree'}->{BRANCHCLOSE_CB} = 'i';
$common_src{'IUP::Tree'}->{BRANCHOPEN_CB} = 'i';
$common_src{'IUP::Tree'}->{DRAGDROP_CB} = 'iiii';
$common_src{'IUP::Tree'}->{EXECUTELEAF_CB} = 'i';
$common_src{'IUP::Tree'}->{MULTISELECTION_CB} = 'Ai';   # patched
$common_src{'IUP::Tree'}->{MULTIUNSELECTION_CB} = 'Ai'; # patched
$common_src{'IUP::Tree'}->{NODEREMOVED_CB} = 's';
$common_src{'IUP::Tree'}->{RENAME_CB} = 'is';
$common_src{'IUP::Tree'}->{RIGHTCLICK_CB} = 'i';
$common_src{'IUP::Tree'}->{SELECTION_CB} = 'ii';
$common_src{'IUP::Tree'}->{SHOWRENAME_CB} = 'i';
$common_src{'IUP::Val'}->{BUTTON_PRESS_CB} = 'd';
$common_src{'IUP::Val'}->{BUTTON_RELEASE_CB} = 'd';
$common_src{'IUP::Val'}->{MOUSEMOVE_CB} = 'd';
$common_src{'IUP::Val'}->{VALUECHANGED_CB} = '';
sub myprint {
#  print @_;
};

my %type_patch = (
  'IUP::Tree' => { MULTISELECTION_CB => 'Ai', MULTIUNSELECTION_CB => 'Ai'},	
  'IUP::Matrix' => { DRAW_CB => 'iiiiiiv' },
  'IUP::PPlot' => { EDIT_CB => 'iiffFF' },
  'IUP::Dialog' => { COPYDATA_CB => 'si', MOVE_CB => 'ii' },
);

sub raw2pname {
  my $n = shift;
  my %trans = (
    'IUP::Filedlg' => 'IUP::FileDlg',
    'IUP::Pplot' => 'IUP::PPlot',
    'IUP::GLCanvas' => 'IUP::CanvasGL',
    'IUP::Glcanvas' => 'IUP::CanvasGL',
    'IUP::Glcanvas_x' => 'IUP::CanvasGL',
    'IUP::Glcanvas_win' => 'IUP::CanvasGL',
    'IUP::Progressbar' => 'IUP::ProgressBar',
    'IUP::Colorbrowser' => 'IUP::ColorBrowser',
    'IUP::Colorbar' => 'IUP::ColorBar',
    'IUP::Colordlg' => 'IUP::ColorDlg',
    'IUP::Common' => 'IUP::Classbase',
    'IUP::Fontdlg' => 'IUP::FontDlg',
    'IUP::Messagedlg' => 'IUP::MessageDlg',
    'IUP::Colorbrowserdlg' => 'IUP::ColorDlg',
    'IUP::ColorBrowserDlg' => 'IUP::ColorDlg',
    'IUP::Olecontrol' => 'IUP::OleControl',
    'IUP::Iupmatrix' => 'IUP::Matrix',
    'IUP::Webbrowser' => 'IUP::WebBrowser',
    'IUP::Tuio' => 'IUP::TuioClient',
    'IUP::Tuioclient' => 'IUP::TuioClient',
  );
  $n =~ s|^iup_||;
  $n =~ s|^iupwin_||i;
  $n =~ s|^iupgtk_||i;
  $n =~ s|^iupmot_||i;
  $n = "IUP::" . ucfirst($n) unless $n =~ /^IUP::/;  
  $n = $trans{$n} if defined $trans{$n};
  return $n;
}  

warn "###INFO### Going through all source codes (*.c *.cpp)\n";

foreach my $f (@all_src) {
  die "File $f not exists" unless -f $f;

  my $showdebug; 
  $showdebug = 1 if $f =~ /Tuio/i;
  
  warn "###DEBUG### Processing file $f\n" if $showdebug;
  (my $n = $f) =~ s/\.c(pp)?$//;
  $n =~ s|^.*?([^\\/]*)$|$1|;
  $n = raw2pname($n);
  open DAT, "<", $f;
  while (<DAT>) {
    s/[\r\n]*$//;
    s/^\s*//;
    if ( /iupClassRegisterCallback[^"]*"([^"]*)"[^"]*"([^"]*)"/) {
      my $a = $1;
      my $t = $2;
      warn "###DEBUG### Processing callback '$n|$a|$t' '$_'\n" if $showdebug;
      $t =~ s/=s//;
      $c_list{$n}->{$a}->{comment1} = 'src=yes';      
      $c_list{$n}->{$a}->{type} = $type_patch{$n}->{$a} || $t; # type patching
    }
    else {
      (my $shortname = $f) =~ s/^.*?([^\\\/]+)$/$1/;
      warn "###INFO### MISSING CB [$shortname]:$_\n" if ( /iupClassRegisterCallback/ );
    }
    
    if ( /iupClassRegisterAttribute[^"]*"([^"]*)".*?([^,")]*)\)/) {
      my ($o, $x) = ($1, $2);
      $x =~ s/ //g;
      $x =~ s/IUPAF_//g;
      #print "XXX_ATT_XXX $n '$o' '$x'\n";
      $a_list{$n}->{$o} = { type=> $x, comment1 => 'src=yes' };
    }
    else {
      (my $shortname = $f) =~ s/^.*?([^\\\/]+)$/$1/;
      warn "###INFO### MISSING AT [$shortname]:$_\n" if ( /iupClassRegisterAttribute/ );
    }
    
    if ( /ic->name *= *"([^"]*)"/) {
      $n = raw2pname($1);
      #warn ">>>>[$f] $n";
    }
    
    if ( /iupBaseRegisterCommonCallbacks/ ) {
      warn "###INFO### [$n] iupBaseRegisterCommonCallbacks !!!\n";
      $c_list{$n}->{MAP_CB} = { type => '', comment1 => 'src=common' };
      $c_list{$n}->{UNMAP_CB} = { type => '', comment1 => 'src=common' };
      $c_list{$n}->{GETFOCUS_CB} = { type => '', comment1 => 'src=common' };
      $c_list{$n}->{KILLFOCUS_CB} = { type => '', comment1 => 'src=common' };
      $c_list{$n}->{ENTERWINDOW_CB} = { type => '', comment1 => 'src=common' };
      $c_list{$n}->{LEAVEWINDOW_CB} = { type => '', comment1 => 'src=common' };
      $c_list{$n}->{HELP_CB} = { type => '', comment1 => 'src=common' };
      $c_list{$n}->{K_ANY} = { type => 'i', comment1 => 'src=common' };
    }
  }
  close(DAT);
  if ($n eq 'IUP::Dialog') {
    $c_list{$n}->{MDIACTIVATE_CB} = { type => '', comment1 => 'src=win+gtk only' };
    $c_list{$n}->{TRAYCLICK_CB} = { type => 'iii', comment1 => 'src=win+gtk only' };
  }
}

warn "###INFO### Going through callback related HTML files\n";

foreach my $f (glob("$docroot/html/en/call/*.html")) {
  die "File $f not exists" unless -f $f;
  my $tree = HTML::TreeBuilder->new_from_file($f);
  my $a = $tree->find('title')->as_text;
  my $b = $tree->find('body');
  foreach my $c ($b->content_list) {
    next unless ref($c) eq 'HTML::Element';
    next unless $c ne ' ';
    my $tx = $c->as_text;    
    if ($tx =~ /([a-zA-Z0-9\*]+)  *function *\(([^\)]*)\)/) {
      my $rv = $1;
      my $par = $2;
      $par =~ s/, */,/g;
      $par =~ s/  */ /g;
      $rv =~ s/  */ /g;
      $common_actions{$a}->{par} = $par;
      $common_actions{$a}->{rv} = $rv;
      #warn "COMMON '$a' = $par";
    }    
  }
}

warn "###INFO### Going through iuptree_attrib.html iuptree_cb.html\n";

$common_actions{HELP_CB}->{rv}='int'; #ad hoc patching

my @spec_cb = ( qw(html/en/elem/iuptree_cb.html html/en/ctrl/iupmatrix_cb.html) );
foreach (@spec_cb) {
  my $f = "$docroot/$_";
  my $fn = $1 if( $f =~ /([^\/]*)\.html$/);
  die "File $f not exists" unless -f $f;
  my $tree = HTML::TreeBuilder->new_from_file($f);
  my $t = $tree->find('title');
  my $class = $t->as_text;
  $class =~ s/^Iup/IUP::/;
  $class =~ s/ .*$//;
  $class = raw2pname($class);  
  my ($cpar, $cnam, $crv);
  $cnam = 'IUP::None';
  my $b = $tree->find('body');
  foreach my $c ($b->content_list) {
    next unless ref($c) eq 'HTML::Element';
    next unless $c ne ' ';
    my $tg = $c->tag;
    my $tx = $c->as_text;    
    
    if ($tx =~ /([a-zA-Z0-9\*]+) +(funct*ion|change|drag) *\(([^\)]*)\)/) {
      $cpar = $3;
      $crv = $1;
      $cpar =~ s/, */,/g;
      $cpar =~ s/  */ /g;      
      $crv =~ s/  */ /g;
      if (defined($cnam)) {
        #warn "##### $class $cnam $crv $cpar";
        $c_list{$class}->{$cnam}->{par} = $cpar;
	$c_list{$class}->{$cnam}->{rv} = $crv;
      }
      else {
        warn "Unknown CB: '$class' '$cpar' '$fn.html'";
      }
    }
    if ($tg eq 'p') {
      $tx =~ s/  */ /g;
      if ($tx =~ /^[ "]*((([A-Z0-9_]+), )+([A-Z0-9_]+))[^,]/) {
        my $t = $1;	
	$t =~ s/ //g;
	foreach (split(',',$t)) {
	  $c_list{$class}->{$_}->{comment2} = "doc=spec.common";
	  $c_list{$class}->{$_}->{par} ||= $common_actions{$_}->{par};
	  $c_list{$class}->{$_}->{rv} ||= $common_actions{$_}->{rv};
	}
      }
      elsif ($tx =~ /^[ "]*([A-Z0-9_]+)[^a-z]/) {
        $cnam = $1;
	$c_list{$class}->{$1}->{comment2} = "doc=spec.ok";
	$c_list{$class}->{$1}->{par} ||= $common_actions{$1}->{par};
	$c_list{$class}->{$1}->{rv} ||= $common_actions{$1}->{rv};
      }
    }  
  }
}

# xxxTODO xxx the same for attr/*.html

warn "###INFO### Going through all_doc HTML files\n";
foreach my $f (@all_doc) {
  my $fn = $f;
  $fn = $1 if( $f =~ /([^\/]*)\.html$/);  
  die "File $f not exists" unless -f $f;
  my $tree = HTML::TreeBuilder->new_from_file($f);
  my $t = $tree->find('title');
  (my $class = $t->as_text) =~ s/^Iup/IUP::/;
  $class = raw2pname($class);
  my $b = $tree->find('body');
  my $active_a = 0;
  my $active_c = 0;
  my ($cpar, $cnam, $crv);  
  my %seen;
  foreach my $c ($b->content_list) {
    next unless ref($c) eq 'HTML::Element';
    next unless $c ne ' ';
    my $tg = $c->tag;
    my $tx = $c->as_text;    
    if ($tg eq 'h3') {
      $active_a = 0;
      $active_c = 0;
    }
    if ($tg eq 'h3' && $tx eq 'Attributes') {
      $active_a = 1;
    }
    elsif ($tg eq 'h3' && $tx eq 'Callbacks') {
      $active_c = 1;
      $cnam = '';
    }
    
    if ($active_a && $tg eq 'p') {
      $tx =~ s/  */ /g;
      $tx =~ s/"//g;
      if ($tx =~ /^[ "]*((([A-Z0-9_]+)(,| and) )+([A-Z0-9_]+))[^,]/) {
        my $t = $1;
	$t =~ s/ //g;
	foreach (split(',',$t)) {
          foreach (split('and',$_)) {
	    myprint "$fn\t$class\tATTR\t$_\tTX=xxx\n";
	    $a_list{$class}->{$_}->{comment2} = 'doc=yes';
	  }
	}
      }
      elsif ($tx =~ /^[ "]*([A-Z0-9_]+)[^a-z]/) {
        myprint "$fn\t$class\tATTR\t$1\tTEXT=".$c->as_text."\tHTML=".$c->as_HTML."\n";
	$a_list{$class}->{$1}->{comment2} = 'doc=yes';
      }
    }

    if ($active_c && $tx =~ /([a-zA-Z0-9_\*]+) +(funct*ion|change|drag) *\(([^\)]*)\)/) {
      $cpar = $3;
      $crv = $1;
      $cpar =~ s/, */,/g;
      $cpar =~ s/  */ /g;      
      $crv =~ s/  */ /g;
      if (defined($cnam)) {
        $c_list{$class}->{$cnam}->{par} = $cpar unless $seen{$class}->{$cnam};
	$c_list{$class}->{$cnam}->{rv} = $crv unless $seen{$class}->{$cnam};
	$seen{$class}->{$cnam} = 1;
      }
      else {
        warn "Unknown CB: '$class' '$cpar' '$fn.html'";
      }
    }
    if ($active_c && $tg eq 'p') {
      $tx =~ s/  */ /g;
      if ($tx =~ /^[ "]*((([A-Z0-9_]+), )+([A-Z0-9_]+))[^,]/) {
        my $t = $1;	
	$t =~ s/ //g;
	foreach (split(',',$t)) {
          myprint "$fn\t$class\tCLBK\t$_\tMULTI\n";
	  $c_list{$class}->{$_}->{comment2} = "doc=multi";
	  $c_list{$class}->{$_}->{par} ||= $common_actions{$_}->{par};
	  $c_list{$class}->{$_}->{rv} ||= $common_actions{$_}->{rv};
	}
      }
      elsif ($tx =~ /^[ "]*([A-Z0-9_]+)[^a-z]/) {
        $cnam = $1;
        myprint "$fn\t$class\tCLBK\t$1\n";
	$c_list{$class}->{$1}->{comment2} = "doc=single";
	$c_list{$class}->{$1}->{par} ||= $common_actions{$1}->{par};
	$c_list{$class}->{$1}->{rv} ||= $common_actions{$1}->{rv};
      }

    }    
  }
}

#print Dumper(\%a_list);
#print Dumper(\%c_list);

#ad hoc patching - attributes
$a_list{'IUP::Classbase'}->{CX}->{type}='unknown';
$a_list{'IUP::Classbase'}->{CY}->{type}='unknown';

#ad hoc patching - callbacks
$c_list{'IUP::WebBrowser'}->{COMPLETED_CB}->{type}= 's';
$c_list{'IUP::WebBrowser'}->{COMPLETED_CB}->{par} = 'Ihandle* ih,char* url';

$c_list{'IUP::ColorBrowser'}->{DRAG_CB}->{par} = 'Ihandle *ih,unsigned char r,unsigned char g,unsigned char b';
$c_list{'IUP::ColorBrowser'}->{DRAG_CB}->{rv} = 'int';

$c_list{'IUP::ColorBrowser'}->{VALUECHANGED_CB}->{par} = 'Ihandle *ih';
$c_list{'IUP::ColorBrowser'}->{VALUECHANGED_CB}->{rv} = 'int';

$c_list{'IUP::ColorBrowser'}->{CHANGE_CB}->{par} = 'Ihandle *ih,unsigned char r,unsigned char g,unsigned char b';
$c_list{'IUP::ColorBrowser'}->{CHANGE_CB}->{rv} = 'int';

$c_list{'IUP::TuioClient'}->{MULTITOUCH_CB}->{par} = 'Ihandle *ih, int count, int* pid, int* px, int* py, int* pstate';
$c_list{'IUP::TuioClient'}->{MULTITOUCH_CB}->{rv} = 'int';
$c_list{'IUP::TuioClient'}->{MULTITOUCH_CB}->{type} = 'iIIII';

$c_list{'IUP::TuioClient'}->{TOUCH_CB}->{par} = 'Ihandle* ih, int id, int x, int y, char* state';
$c_list{'IUP::TuioClient'}->{TOUCH_CB}->{rv} = 'int';
$c_list{'IUP::TuioClient'}->{TOUCH_CB}->{type} = 'iiis';

$c_list{'IUP::Canvas'}->{MULTITOUCH_CB}->{type} = 'iIIII';

$c_list{'IUP::Matrix'}->{EDITION_CB}->{type}='iiii';
$c_list{'IUP::CanvasGL'}->{RESIZE_CB}->{type}='ii';

$c_list{'IUP::PPlot'}->{DELETEBEGIN_CB}->{par} = 'Ihandle *ih';
$c_list{'IUP::PPlot'}->{DELETEBEGIN_CB}->{rv} = 'int';

$c_list{'IUP::PPlot'}->{DELETEEND_CB}->{par} = 'Ihandle *ih';
$c_list{'IUP::PPlot'}->{DELETEEND_CB}->{rv} = 'int';

$c_list{'IUP::PPlot'}->{EDITBEGIN_CB}->{par} = 'Ihandle *ih';
$c_list{'IUP::PPlot'}->{EDITBEGIN_CB}->{rv} = 'int';

$c_list{'IUP::PPlot'}->{EDITEND_CB}->{par} = 'Ihandle *ih';
$c_list{'IUP::PPlot'}->{EDITEND_CB}->{rv} = 'int';

$c_list{'IUP::PPlot'}->{POSTDRAW_CB}->{par} = 'Ihandle *ih,cdCanvas* cnv';
$c_list{'IUP::PPlot'}->{POSTDRAW_CB}->{rv} = 'int';

$c_list{'IUP::PPlot'}->{PREDRAW_CB}->{par} = 'Ihandle *ih,cdCanvas* cnv';
$c_list{'IUP::PPlot'}->{PREDRAW_CB}->{rv} = 'int';

$c_list{'IUP::PPlot'}->{SELECTBEGIN_CB}->{par} = 'Ihandle *ih';
$c_list{'IUP::PPlot'}->{SELECTBEGIN_CB}->{rv} = 'int';

$c_list{'IUP::PPlot'}->{SELECTEND_CB}->{par} = 'Ihandle *ih';
$c_list{'IUP::PPlot'}->{SELECTEND_CB}->{rv} = 'int';

$c_list{'IUP::Spinbox'}->{SPIN_CB}->{par} = 'Ihandle *ih,int inc';
$c_list{'IUP::Spinbox'}->{SPIN_CB}->{rv} = 'int';

#$c_list{'IUP::Val'}->{BUTTON_PRESS_CB}->{par} = 0;
#$c_list{'IUP::Val'}->{BUTTON_RELEASE_CB}->{par} = 0;
#$c_list{'IUP::Val'}->{MOUSEMOVE_CB}->{par} = 0;

my %uniq;

sub print_c1 {  
  my %base = %{$c_list{'IUP::Classbase'}};
  my %box = %{$c_list{'IUP::Box'}} if $c_list{'IUP::Box'}; # maybe leave out completely xxxTODO xxx
  my %menu = %{$c_list{'IUP::Menu'}};
  my %dialog = %{$c_list{'IUP::Dialog'}};
  my $file = shift;
  my @output;
  for my $class (sort keys %c_list) {
    next unless $class;
    next if $class =~ /^(IUP::GetParam|IUP::MultiLine|IUP::Gauge)/; #legacy
    
    my %t = %{$c_list{$class}};
    for my $cb (sort keys %t) {
      next if $class eq 'IUP::Matrix' && $cb eq 'IMPORTANT'; #not a CB
      next if $class eq 'IUP::Val' && $cb eq 'BUTTON_PRESS_CB'; #legacy
      next if $class eq 'IUP::Val' && $cb eq 'BUTTON_RELEASE_CB'; #legacy
      next if $class eq 'IUP::Val' && $cb eq 'MOUSEMOVE_CB'; #legacy

      unless (defined $t{$cb}->{par}) {
        warn "NONEXISTING.par '$class\::$cb'";
        if (defined($common_actions{$cb}->{par})) {
          $t{$cb}->{par} = $common_actions{$cb}->{par};
	  $t{$cb}->{rv} = $common_actions{$cb}->{rv};
	  $t{$cb}->{comment3} = "default.common.cb";
        }
        else {
          warn "NONEXISTING.common '$class\::$cb'";        
        }
      }
      my $classbase = $c_list{'IUP::Classbase'}->{$cb};

      if(!defined $t{$cb}->{type}) {
        if(defined($c_list{'IUP::Classbase'}->{$cb})) {
          $t{$cb}->{type} = $c_list{'IUP::Classbase'}->{$cb}->{type};
          $t{$cb}->{comment3} = "default.classbase";
        }
        elsif (defined($common_src{$class}->{$cb})) {
          $t{$cb}->{type} = $common_src{$class}->{$cb};
	  $t{$cb}->{comment3} = "default.src_common1";
        }
        elsif (defined($common_src{'IUP::Common'}->{$cb})) {
	  $t{$cb}->{type} = $common_src{'IUP::Common'}->{$cb};
	  $t{$cb}->{comment3} = "default.src_common2";
        }
        else {
	  $t{$cb}->{type} = $type_patch{$class}->{$cb} || '#undef#'; # type patching
	  warn "###WARN### class=$class cb=$cb type=$t{$cb}->{type}";
        }
      }
      $t{$cb}->{par} =~ s/ \*/* /g if defined $t{$cb}->{par};
      $common_src{$class}->{$cb} ||= '';
      
      #xxxTODO xxx not tested yet
      my $class2 = $class;
      $class2 = '_base' if $class2 eq 'IUP::Classbase';
      $class2 = '_box' if $class2 eq 'IUP::Box';
      $class2 = '_dialog' if $class2 eq 'IUP::Dialog';
      $class2 = '_canvas' if $class2 eq 'IUP::Canvas';
      #$class2 = '_menu' if $class2 eq 'IUP::Menu';
      next if $class2 !~ /^_base/ && $base{$cb};
      next if $class2 !~ /^_box/ && $box{$cb} && $class2 =~ /^IUP::[CHVZ]box$/;
      next if $class2 !~ /^_dialog/ && $dialog{$cb} && $class2 =~ /^IUP::(Color|File|Font|Message)Dlg$/;
      #next if $class2 !~ /^_menu/ && $menu{$cb} && $class2 =~ /^IUP::(Submenu|Item)$/;

      push @output, [ $class2,                      
                      $cb,
                      $t{$cb}->{type},
                      ($t{$cb}->{rv} || '#'),
                      ($t{$cb}->{par} || '#'),
                      ($t{$cb}->{comment1} || '#'),
                      ($t{$cb}->{comment2} || '#'),
                      ($t{$cb}->{comment3} || '#'),
                      ($common_src{$class}->{$cb} || '?'),
                      (((!defined $common_src{$class}->{$cb}) || ($common_src{$class}->{$cb} eq '') || ($t{$cb}->{type} eq $common_src{$class}->{$cb})) ? '' : 'BEWARE'),
		    ];
      $uniq{"cb_$cb\_$t{$cb}->{type}"} = 1;    
    }
  }
  @output = sort { $a->[0].';'.$a->[1].';' cmp $b->[0].';'.$b->[1].';' } @output; # ASCII-betical sort 
  open (F, ">", $file) || die "cannot open file $file";  
  if ($g_longoutput) {
    print F '#module;#action;#type;#c_retval;#c_params;#c1;#c2;#c3;#c4;#c5', "\n";
  }
  else {
    print F '#module;#action;#type;#c_retval;#c_params', "\n";
  }
  for (@output) {
    if ($g_longoutput) {
      print F join(';', @$_), "\n";
    }
    else {
      print F $_->[0], ';', $_->[1], ';', $_->[2], ';', $_->[3], ';', $_->[4], "\n";
    }
  }
  close(F);  

}

sub print_a1_xxx {
  my %seen;  
  for my $class (sort keys %a_list) {
    next unless $class;
    my %t = %{$a_list{$class}};
    for my $at (sort keys %t) { $seen{$at} = 1 };
  }
  for( my $i=0; $i<256; $i++) { delete $seen{$i} };
  my @tmp = sort keys %seen;  
  #for( my $i=0; $i<256; $i++) { push @tmp, $i };
  print "ATTR DUMP:\n";
  my $count = 0;
  print 'my @attrib_all = (qw/';
  for (@tmp) {
    print "\n  " unless ($count++ % 6);
    print $_, ' ', ' ' x (22-length($_));
  };
  print "\n/);";
  
}

sub print_a1 {
  my $file = shift || die "undefined filename";
  my $invalid = {
    'IUP::Cbox'	    => { 'CX' => 1, 'CY' => 1 },
    'IUP::Cells'    => { 'LIMITSL' => 1 },
    'IUP::ColorBar' => { 'CEL' => 1 },
    'IUP::List'	    => { 'INSERTITE' => 1 },
    'IUP::Tabs'	    => { 'TABIMAG' => 1, 'TABTITL' => 1 },
    'IUP::Tree'	    => { 'VALU' => 1 },
    'IUP::Zbox'	    => { 
      'ACENTER' => 1,
      'EAST' => 1,
      'NE' => 1,
      'NORTH' => 1,
      'NW' => 1,
      'SE' => 1,
      'SOUTH' => 1,
      'SW' => 1,
      'WEST' => 1,
    },
    '_dialog'	=> { 'IMPORTANT' => 1 },
    'IUP::Image'=> { '0' => 1 },
    'IUP::List'	=> { '1' => 1 },
    'IUP::Toggle' => { '3STATE' => 1 },
  };

  my %seen;  
  my %base = %{$a_list{'IUP::Classbase'}};
  my %box = %{$a_list{'IUP::Box'}};
  my %menu = %{$a_list{'IUP::Menu'}};
  my %dialog = %{$a_list{'IUP::Dialog'}};
  my @output;
  for my $class (sort keys %a_list) {
    next unless $class;
    my %t = %{$a_list{$class}};    
    for my $at (sort keys %t) {
      $seen{$at} = 1;
      $class = '_base' if $class eq 'IUP::Classbase';
      $class = '_box' if $class eq 'IUP::Box';
      $class = '_dialog' if $class eq 'IUP::Dialog';
      #$class = '_menu' if $class eq 'IUP::Menu';
      next if $class !~ /^_base/ && $base{$at};
      next if $class !~ /^_box/ && $box{$at} && $class =~ /^IUP::[CHVZ]box$/;
      next if $class !~ /^_dialog/ && $dialog{$at} && $class =~ /^IUP::(Color|File|Font|Message)Dlg$/;
      #next if $class !~ /^_menu/ && $menu{$at} && $class =~ /^IUP::(Submenu|Item)$/;
      push @output, [ $class,
                      $at,
                      ($t{$at}->{type}     || 'unknown'),
                      ($t{$at}->{comment1} || 'src=no'),
                      ($t{$at}->{comment2} || 'doc=no'),
                      ($invalid->{$class}->{$at} ? '0' : '1'),
		     ];
    };
  }
  @output = sort { $a->[0].';'.$a->[1].';' cmp $b->[0].';'.$b->[1].';' } @output; # ASCII-betical sort 
  open (F, ">", $file) || die "cannot open file $file";  
  if ($g_longoutput) {
    print F '#module;#attribute;#flags;#c1;#c2;#valid', "\n";
  }
  else {
    print F '#module;#attribute', "\n";
  }
  for (@output) {
    if ($g_longoutput) {
      print F join(';', @$_), "\n";
    }
    else {
      print F $_->[0], ';', $_->[1], "\n";
    }
  }
  close(F);  
}

#warn "###DEBUG### c_list=", Dumper(\%c_list);
warn "###INFO### Gonna create Callback_$g_tag.csv\n";
print_c1("Callback_$g_tag.csv");

#warn "###DEBUG### a_list=", Dumper(\%a_list);
#print "$_\n" for (keys %uniq);
warn "###INFO### Gonna create Attribute_$g_tag.csv\n";
print_a1("Attribute_$g_tag.csv");
