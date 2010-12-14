use strict;
use warnings;
use Data::Dumper;
use Template;
use HTML::TreeBuilder;
use Pod::HTML2Pod;
use File::Path qw(make_path remove_tree);
use File::Slurp;
use Pod::Simple::HTMLBatch;

my $docroot = 'y:\IUP3.3\doc\iup';
my $rawroot = './pod.raw.v3.3';
my $podroot = './pod.tt';
my $htmlout = './pod.tt.html';

my $html_files = {
  'Attributes' => 'html/en/_all_attribs.html',
  'Attributes::00main' => 'html/en/attrib.html',
  'Attributes::ACTIVE' => 'html/en/attrib/iup_active.html',
  'Attributes::BGCOLOR' => 'html/en/attrib/iup_bgcolor.html',
  'Attributes::CLIENTSIZE' => 'html/en/attrib/iup_clientsize.html',
  'Attributes::CONTROL' => 'html/en/attrib/iup_control.html',
  'Attributes::CURSOR' => 'html/en/attrib/iup_cursor.html',
  'Attributes::DX' => 'html/en/attrib/iup_dx.html',
  'Attributes::DY' => 'html/en/attrib/iup_dy.html',
  'Attributes::EXPAND' => 'html/en/attrib/iup_expand.html',
  'Attributes::FGCOLOR' => 'html/en/attrib/iup_fgcolor.html',
  'Attributes::FLOATING' => 'html/en/attrib/iup_floating.html',
  'Attributes::FONT' => 'html/en/attrib/iup_font.html',
  'Attributes::FONT' => 'html/en/attrib/iup_font2.html',
  'Attributes::FONT' => 'html/en/attrib/iup_formatting.html',
  'Attributes::Global Attributes' => 'html/en/attrib/iup_globals.html',
  'Attributes::ICON' => 'html/en/attrib/iup_icon.html',
  'Attributes::KEY' => 'html/en/attrib/iup_key.html',
  'Attributes::iupMask' => 'html/en/attrib/iup_mask.html',
  'Attributes::MAXSIZE' => 'html/en/attrib/iup_maxsize.html',
  'Attributes::MAXSIZE' => 'html/en/attrib/iup_minsize.html',
  'Attributes::NAME' => 'html/en/attrib/iup_name.html',
  'Attributes::PARENTDIALOG' => 'html/en/attrib/iup_parentdialog.html',
  'Attributes::POSITION' => 'html/en/attrib/iup_position.html',
  'Attributes::POSX' => 'html/en/attrib/iup_posx.html',
  'Attributes::POSY' => 'html/en/attrib/iup_posy.html',
  'Attributes::RASTERSIZE' => 'html/en/attrib/iup_rastersize.html',
  'Attributes::SCROLLBAR' => 'html/en/attrib/iup_scrollbar.html',
  'Attributes::SHRINK' => 'html/en/attrib/iup_shrink.html',
  'Attributes::SIZE' => 'html/en/attrib/iup_size.html',
  'Attributes::TIP' => 'html/en/attrib/iup_tip.html',
  'Attributes::TITLE' => 'html/en/attrib/iup_title.html',
  'Attributes::VALUE' => 'html/en/attrib/iup_value.html',
  'Attributes::VISIBLE' => 'html/en/attrib/iup_visible.html',
  'Attributes::WID' => 'html/en/attrib/iup_wid.html',
  'Attributes::X' => 'html/en/attrib/iup_x.html',
  'Attributes::XMAX' => 'html/en/attrib/iup_xmax.html',
  'Attributes::XMIN' => 'html/en/attrib/iup_xmin.html',
  'Attributes::Y' => 'html/en/attrib/iup_y.html',
  'Attributes::YMAX' => 'html/en/attrib/iup_ymax.html',
  'Attributes::YMIN' => 'html/en/attrib/iup_ymin.html',
  'Attributes::ZORDER' => 'html/en/attrib/iup_zorder.html',
  'Attributes::Keyboard Codes' => 'html/en/attrib/key.html',
  'Manual::Attributes' => 'html/en/attrib_guide.html',
  'Manual::App_Basic' => 'html/en/basic/index.html',
  'Callbacks::00main' => 'html/en/call.html',
  'Callbacks::ACTION' => 'html/en/call/iup_action.html',
  'Callbacks::BUTTON_CB' => 'html/en/call/iup_button_cb.html',
  'Callbacks::CLOSE_CB' => 'html/en/call/iup_close_cb.html',
  'Callbacks::DEFAULT_ACTION' => 'html/en/call/iup_default_action.html',
  'Callbacks::DESTROY_CB' => 'html/en/call/iup_destroy_cb.html',
  'Callbacks::DROPFILES_CB' => 'html/en/call/iup_dropfiles_cb.html',
  'Callbacks::ENTERWINDOW_CB' => 'html/en/call/iup_enterwindow_cb.html',
  'Callbacks::GETFOCUS_CB' => 'html/en/call/iup_getfocus_cb.html',
  'Callbacks::HELP_CB' => 'html/en/call/iup_help_cb.html',
  'Callbacks::HIGHLIGHT_CB' => 'html/en/call/iup_highlight_cb.html',
  'Callbacks::IDLE_ACTION' => 'html/en/call/iup_idle_action.html',
  'Callbacks::K_ANY' => 'html/en/call/iup_k_any.html',
  'Callbacks::KEYPRESS_CB' => 'html/en/call/iup_keypress_cb.html',
  'Callbacks::KILLFOCUS_CB' => 'html/en/call/iup_killfocus_cb.html',
  'Callbacks::LEAVEWINDOW_CB' => 'html/en/call/iup_leavewindow_cb.html',
  'Callbacks::MAP_CB' => 'html/en/call/iup_map_cb.html',
  'Callbacks::MENUCLOSE_CB' => 'html/en/call/iup_menuclose_cb.html',
  'Callbacks::MOTION_CB' => 'html/en/call/iup_motion_cb.html',
  'Callbacks::OPEN_CB' => 'html/en/call/iup_open_cb.html',
  'Callbacks::RESIZE_CB' => 'html/en/call/iup_resize_cb.html',
  'Callbacks::SCROLL_CB' => 'html/en/call/iup_scroll_cb.html',
  'Callbacks::SHOW_CB' => 'html/en/call/iup_show_cb.html',
  'Callbacks::UNMAP_CB' => 'html/en/call/iup_unmap_cb.html',
  'Callbacks::WHEEL_CB' => 'html/en/call/iup_wheel_cb.html',
  'Callbacks::WOM_CB' => 'html/en/call/iup_wom_cb.html',
  'Callbacks::Events and Callbacks Guide' => 'html/en/call_guide.html',
  'Manual::Controls1' => 'html/en/controls.html',
  'Manual::Controls2' => 'html/en/cpi.html',
  'IUP::PPlot' => 'html/en/ctrl/iup_pplot.html',
  'IUP::Cells' => 'html/en/ctrl/iupcells.html',
  'IUP::ColorBar' => 'html/en/ctrl/iupcolorbar.html',
  'IUP::ColorBrowser' => 'html/en/ctrl/iupcolorbrowser.html',
  'IUP::Dial' => 'html/en/ctrl/iupdial.html',
  'IUP::Gauge' => 'html/en/ctrl/iupgauge.html',
  'IUP::GLCanvas' => 'html/en/ctrl/iupglcanvas.html',
  'IUP::Mask' => 'html/en/ctrl/iupmask.html',
  'IUP::Matrix_00main' => 'html/en/ctrl/iupmatrix.html',
  'IUP::Matrix_A' => 'html/en/ctrl/iupmatrix_attrib.html',
  'IUP::Matrix_C' => 'html/en/ctrl/iupmatrix_cb.html',
  'IUP::OleControl' => 'html/en/ctrl/iupole.html',
  'Manual::Dialogs' => 'html/en/dialogs.html',
  'IUP::Alarm' => 'html/en/dlg/iupalarm.html',
  'IUP::ColorDlg' => 'html/en/dlg/iupcolordlg.html',
  'IUP::Dialog' => 'html/en/dlg/iupdialog.html',
  'IUP::FileDlg' => 'html/en/dlg/iupfiledlg.html',
  'IUP::FontDlg' => 'html/en/dlg/iupfontdlg.html',
  'IUP::GetColor' => 'html/en/dlg/iupgetcolor.html',
  'IUP::GetFile' => 'html/en/dlg/iupgetfile.html',
  'IUP::GetParam' => 'html/en/dlg/iupgetparam.html',
  'IUP::GetText' => 'html/en/dlg/iupgettext.html',
  'IUP::ListDialog' => 'html/en/dlg/iuplistdialog.html',
  'IUP::Message' => 'html/en/dlg/iupmessage.html',
  'IUP::MessageDlg' => 'html/en/dlg/iupmessagedlg.html',
  'IUP::Scanf' => 'html/en/dlg/iupscanf.html',
  'Manual::IUPproject_Download1' => 'html/en/download.html',
  'Manual::IUPproject_Download2' => 'html/en/download_tips.html',
  'Manual::IUPproject_License' => 'html/en/copyright.html',
  'Manual::Driver_GTK' => 'html/en/drv/gtk.html',
  'Manual::Driver_Motif' => 'html/en/drv/motif.html',
  'Manual::Driver_Win32' => 'html/en/drv/win32.html',
  'IUP::Button' => 'html/en/elem/iupbutton.html',
  'IUP::Canvas' => 'html/en/elem/iupcanvas.html',
  'IUP::Cbox' => 'html/en/elem/iupcbox.html',
  'IUP::Clipboard' => 'html/en/elem/iupclipboard.html',
  'IUP::Fill' => 'html/en/elem/iupfill.html',
  'IUP::Frame' => 'html/en/elem/iupframe.html',
  'IUP::Hbox' => 'html/en/elem/iuphbox.html',
  'IUP::Image' => 'html/en/elem/iupimage.html',
  'IUP::Item' => 'html/en/elem/iupitem.html',
  'IUP::Label' => 'html/en/elem/iuplabel.html',
  'IUP::List' => 'html/en/elem/iuplist.html',
  'IUP::Menu' => 'html/en/elem/iupmenu.html',
  'IUP::MultiLine' => 'html/en/elem/iupmultiline.html',
  'IUP::Normalizer' => 'html/en/elem/iupnormalizer.html',
  'IUP::ProgressBar' => 'html/en/elem/iupprogressbar.html',
  'IUP::Radio' => 'html/en/elem/iupradio.html',
  'IUP::Sbox' => 'html/en/elem/iupsbox.html',
  'IUP::Separator' => 'html/en/elem/iupseparator.html',
  'IUP::Spin' => 'html/en/elem/iupspin.html',
  'IUP::Split' => 'html/en/elem/iupsplit.html',
  'IUP::Submenu' => 'html/en/elem/iupsubmenu.html',
  'IUP::Tabs' => 'html/en/elem/iuptabs.html',
  'IUP::Text' => 'html/en/elem/iuptext.html',
  'IUP::Timer' => 'html/en/elem/iuptimer.html',
  'IUP::Toggle' => 'html/en/elem/iuptoggle.html',
  'IUP::Tree_00main' => 'html/en/elem/iuptree.html',
  'IUP::Tree_A' => 'html/en/elem/iuptree_attrib.html',
  'IUP::Tree_C' => 'html/en/elem/iuptree_cb.html',
  'IUP::User' => 'html/en/elem/iupuser.html',
  'IUP::Val' => 'html/en/elem/iupval.html',
  'IUP::Vbox' => 'html/en/elem/iupvbox.html',
  'IUP::Zbox' => 'html/en/elem/iupzbox.html',
  'Func::Append' => 'html/en/func/iupappend.html',
  'Func::Close' => 'html/en/func/iupclose.html',
  'Func::ConvertXYToPos' => 'html/en/func/iupconvertxytopos.html',
  'Func::Create' => 'html/en/func/iupcreate.html',
  'Func::Destroy' => 'html/en/func/iupdestroy.html',
  'Func::Detach' => 'html/en/func/iupdetach.html',
  'Func::ExitLoop' => 'html/en/func/iupexitloop.html',
  'Func::Flush' => 'html/en/func/iupflush.html',
  'Func::GetActionName' => 'html/en/func/iupgetactionname.html',
  'Func::GetAllAttributes' => 'html/en/func/iupgetallattributes.html',
  'Func::GetAllDialogs' => 'html/en/func/iupgetalldialogs.html',
  'Func::GetAllNames' => 'html/en/func/iupgetallnames.html',
  'Func::GetAttribute' => 'html/en/func/iupgetattribute.html',
  'Func::GetAttributeHandle' => 'html/en/func/iupgetattributehandle.html',
  'Func::GetAttributes' => 'html/en/func/iupgetattributes.html',
  'Func::GetBrother' => 'html/en/func/iupgetbrother.html',
  'Func::GetCallback' => 'html/en/func/iupgetcallback.html',
  'Func::GetChild' => 'html/en/func/iupgetchild.html',
  'Func::GetChildCount' => 'html/en/func/iupgetchildcount.html',
  'Func::GetChildPos' => 'html/en/func/iupgetchildpos.html',
  'Func::GetClassAttributes' => 'html/en/func/iupgetclassattributes.html',
  'Func::GetClassName' => 'html/en/func/iupgetclassname.html',
  'Func::GetClassType' => 'html/en/func/iupgetclasstype.html',
  'Func::GetDialog' => 'html/en/func/iupgetdialog.html',
  'Func::GetDialogChild' => 'html/en/func/iupgetdialogchild.html',
  'Func::GetFloat' => 'html/en/func/iupgetfloat.html',
  'Func::GetFocus' => 'html/en/func/iupgetfocus.html',
  'Func::GetFunction' => 'html/en/func/iupgetfunction.html',
  'Func::GetGlobal' => 'html/en/func/iupgetglobal.html',
  'Func::GetHandle' => 'html/en/func/iupgethandle.html',
  'Func::GetInt' => 'html/en/func/iupgetint.html',
  'Func::GetLanguage' => 'html/en/func/iupgetlanguage.html',
  'Func::GetName' => 'html/en/func/iupgetname.html',
  'Func::GetNextChild' => 'html/en/func/iupgetnextchild.html',
  'Func::GetParent' => 'html/en/func/iupgetparent.html',
  'Func::Help' => 'html/en/func/iuphelp.html',
  'Func::Hide' => 'html/en/func/iuphide.html',
  'Func::Insert' => 'html/en/func/iupinsert.html',
  'Func::Load' => 'html/en/func/iupload.html',
  'Func::LoopStep' => 'html/en/func/iuploopstep.html',
  'xiupluaopen' => 'html/en/func/iuplua_open.html',
  'Func::MainLoop' => 'html/en/func/iupmainloop.html',
  'Func::MainLoopLevel' => 'html/en/func/iupmainlooplevel.html',
  'Func::Map' => 'html/en/func/iupmap.html',
  'Func::MapFont' => 'html/en/func/iupmapfont.html',
  'Func::NextField' => 'html/en/func/iupnextfield.html',
  'Func::Open' => 'html/en/func/iupopen.html',
  'Func::Popup' => 'html/en/func/iuppopup.html',
  'Func::PreviousField' => 'html/en/func/iuppreviousfield.html',
  'Func::Redraw' => 'html/en/func/iupredraw.html',
  'Func::Refresh' => 'html/en/func/iuprefresh.html',
  'Func::Append' => 'html/en/func/iupreparent.html',
  'Func::ResetAttribute' => 'html/en/func/iupresetattribute.html',
  'Func::SaveClassAttributes' => 'html/en/func/iupsaveclassattributes.html',
  'Func::SaveImageAsText' => 'html/en/func/iupsaveimageastext.html',
  'Func::SetAttributes' => 'html/en/func/iupsetatt.html',
  'Func::SetAttribute' => 'html/en/func/iupsetattribute.html',
  'Func::SetAttributeHandle' => 'html/en/func/iupsetattributehandle.html',
  'Func::SetAttributes' => 'html/en/func/iupsetattributes.html',
  'Func::SetCallback' => 'html/en/func/iupsetcallback.html',
  'Func::SetCallbacks' => 'html/en/func/iupsetcallbacks.html',
  'Func::SetClassDefaultAttribute' => 'html/en/func/iupsetclassdefaultattribute.html',
  'Func::SetfAttribute' => 'html/en/func/iupsetfattribute.html',
  'Func::SetFocus' => 'html/en/func/iupsetfocus.html',
  'Func::SetFunction' => 'html/en/func/iupsetfunction.html',
  'Func::SetGlobal' => 'html/en/func/iupsetglobal.html',
  'Func::SetHandle' => 'html/en/func/iupsethandle.html',
  'Func::SetLanguage' => 'html/en/func/iupsetlanguage.html',
  'Func::Show' => 'html/en/func/iupshow.html',
  'Func::ShowXY' => 'html/en/func/iupshowxy.html',
  'Func::StoreAttribute' => 'html/en/func/iupstoreattribute.html',
  'Func::StoreGlobal' => 'html/en/func/iupstoreglobal.html',
  'Func::Unmap' => 'html/en/func/iupunmap.html',
  'Func::UnMapFont' => 'html/en/func/iupunmapfont.html',
  'Func::Update' => 'html/en/func/iupupdate.html',
  'Func::Version' => 'html/en/func/iupversion.html',
  'Manual::Gallery_StandardControls' => 'html/en/gallery.html',
  'Manual::Gallery_AdditionalControls' => 'html/en/gallery_ctrl.html',
  'Manual::Gallery_PreDefinedDialogs' => 'html/en/gallery_dlg.html',
  'xGuide' => 'html/en/guide.html',
  'xIUP' => 'html/en/home.html',
  'xAdditionalControls' => 'html/en/iupcontrols.html',
  'IUP-IM' => 'html/en/iupim.html',
  'IUP::ImageLib' => 'html/en/iupimglib.html',
  'IUP::ImageLib' => 'html/en/iupimglib2.html',
  'xLuaAdvancedGuide1' => 'html/en/iuplua.html',
  'xLuaAdvancedGuide2' => 'html/en/iuplua_adv.html',
  'xKeyboard' => 'html/en/keyboard.html',
  'xLayoutComposition' => 'html/en/layout.html',
  'xLayoutGuide' => 'html/en/layout_guide.html',
  'xOverview' => 'html/en/prod.html',
  'xResources' => 'html/en/resources.html',
  'xOtherToolkits' => 'html/en/toolkits.html',
};

foreach my $n (keys %$html_files) {
  my $f = $docroot . '/' . $html_files->{$n};
  die "File $f not exists" unless -f $f;
  
  my $html = read_file($f);
  # HTML replacements here
  $html =~ s|href="|href="pod:|gi;  
  
  my $tree = HTML::TreeBuilder->new_from_content($html);

  my $t = $tree->find('title');
  (my $class = $t->as_text) =~ s/^Iup/IUP::/;
  my $b = $tree->find('body');
  
  ($t) = $tree->look_down( '_tag' => 'div', 'id' => 'navigation');
  $t->delete() if defined $t;
  
  my $pod = Pod::HTML2Pod::convert(
    'content' => $b->as_HTML,
    'a_href' => 1,  # try converting links
    'a_name' => 1,
  );  
  
  my $name = $n;
  $name =~ s|::|/|g;
  $name = "$podroot/$name.pod";
  $name =~ s|\\|/|g;
  my $dir = $name;
  $dir =~ s|[^/]*$||;
  make_path($dir);
  
  my $rawname = $n;
  $rawname =~ s|::|/|g;
  $rawname = "$rawroot/$rawname.pod.raw";
  $rawname =~ s|\\|/|g;  
  my $rawdir = $rawname;
  $rawdir =~ s|[^/]*$||;
  make_path($rawdir);

  my $rawpod = $pod;
  $rawpod =~ s/=cut.*/=cut/sg;
  write_file($rawname, $rawpod); #save original
  
  # POD replacements here
  $pod =~ s|X<SeeAlso>||g;
  $pod =~ s|=head1 [Ii]up(.*)|=head1 NAME_xxx\n\nIUP::$1 - xxx_short_info_xxx\n\n=head1 DESCRIPTION_xxx|g;
  $pod =~ s|=head2 Creation|=head1 USAGE\n\n=head2 Creation_xxx|g;
  $pod =~ s|=head2 Callbacks|=head2 Callbacks_xxx|g;
  $pod =~ s|=head2 Attributes|=head2 Attributes_xxx|g;
  $pod =~ s|=head2 Notes|=head2 Notes_xxx|g;
  $pod =~ s|=head2 Value|=head2 Value_xxx|g;
  $pod =~ s|=head2 Affects|=head2 Affects_xxx|g;  
  $pod =~ s|=head2 Examples|=head1 EXAMPLES_xxx|g;
  $pod =~ s|=head2 See Also|=head1 SEE ALSO_xxx|g;  
  $pod =~ s/L<Iup([a-zA-Z0-9]+)\|.*?>/L<IUP::$1|IUP::$1>/g;
  $pod =~ s/Iup([a-zA-Z0-9]+)/IUP::$1/g;
  $pod =~ s/B<(IUP::.*?)>/L<$1|$1>/g;
  $pod =~ s/L<([A-Z0-9]+)\|iup_([a-z0-9]+)\.html>/'L<'.$1.'|IUP::Manual::Attributes::'.uc($2).'>'/eg; #if in attrib dir
  $pod =~ s/L<([A-Z0-9]+)\|..\/attrib\/iup_([a-z0-9]+)\.html>/'L<'.$1.'|IUP::Manual::Attributes::'.uc($2).'>'/eg;
  $pod =~ s/\(since 3.0\)//g;
  if ($pod =~ /=head2 Attributes_xxx(.*?)=head/s ) {
    my $c = $1;
    $c =~ s|\n([LB]<[^ :]*) *:]*|\n=item * $1\n\n|g;
    #$c =~ s|): *([^\n])|):\n\n$1|g;
    $pod =~ s|=head2 Attributes_xxx(.*?)=head|=head2 Attributes_xxx\n\nAttr intro text_xxx\n\n=over$c=back\n\n=head|sg;    
    $pod =~ s|=over\n\n----\n\n=back|=back\n\nCommon attributes_xxx:\n\n=over|;
  }
  
  print STDERR "Writting '$name' ...\n";
  
  write_file($name, $pod);
  
}


my $batchconv = Pod::Simple::HTMLBatch->new;
#$batchconv->some_option( some_value );
#$batchconv->some_other_option( some_other_value );
$batchconv->batch_convert($podroot, $htmlout);

