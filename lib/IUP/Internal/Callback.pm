# BEWARE: this is a generated file, DO NOT EDIT THIS FILE MANUALLY!!!

package IUP::Internal::Callback;

use strict;
use warnings;

use IUP::Internal::LibraryIup; #loads also XS part

my $cb_table = {
  'IUP::Button' => {
    ACTION => \&_init_cb_ACTION_,
    BUTTON_CB => \&_init_cb_BUTTON_CB_iiiis,
  },
  'IUP::CanvasGL' => {
    RESIZE_CB => \&_init_cb_RESIZE_CB_ii,
  },
  'IUP::Cells' => {
    DRAW_CB => \&_init_cb_DRAW_CB_iiiiiiv,
    HEIGHT_CB => \&_init_cb_HEIGHT_CB_i,
    HSPAN_CB => \&_init_cb_HSPAN_CB_ii,
    MOUSECLICK_CB => \&_init_cb_MOUSECLICK_CB_iiiiiis,
    MOUSEMOTION_CB => \&_init_cb_MOUSEMOTION_CB_iiiis,
    NCOLS_CB => \&_init_cb_NCOLS_CB_,
    NLINES_CB => \&_init_cb_NLINES_CB_,
    SCROLLING_CB => \&_init_cb_SCROLLING_CB_ii,
    VSPAN_CB => \&_init_cb_VSPAN_CB_ii,
    WIDTH_CB => \&_init_cb_WIDTH_CB_i,
  },
  'IUP::ColorBar' => {
    CELL_CB => \&_init_cb_CELL_CB_i,
    EXTENDED_CB => \&_init_cb_EXTENDED_CB_i,
    SELECT_CB => \&_init_cb_SELECT_CB_ii,
    SWITCH_CB => \&_init_cb_SWITCH_CB_ii,
  },
  'IUP::ColorBrowser' => {
    CHANGE_CB => \&_init_cb_CHANGE_CB_ccc,
    DRAG_CB => \&_init_cb_DRAG_CB_ccc,
    VALUECHANGED_CB => \&_init_cb_VALUECHANGED_CB_,
  },
  'IUP::Dial' => {
    BUTTON_PRESS_CB => \&_init_cb_BUTTON_PRESS_CB_d,
    BUTTON_RELEASE_CB => \&_init_cb_BUTTON_RELEASE_CB_d,
    MOUSEMOVE_CB => \&_init_cb_MOUSEMOVE_CB_d,
    VALUECHANGED_CB => \&_init_cb_VALUECHANGED_CB_,
  },
  'IUP::FileDlg' => {
    FILE_CB => \&_init_cb_FILE_CB_ss,
  },
  'IUP::Item' => {
    ACTION => \&_init_cb_ACTION_,
    HIGHLIGHT_CB => \&_init_cb_HIGHLIGHT_CB_,
  },
  'IUP::Label' => {
    BUTTON_CB => \&_init_cb_BUTTON_CB_iiiis,
    DROPFILES_CB => \&_init_cb_DROPFILES_CB_siii,
  },
  'IUP::List' => {
    ACTION => \&_init_cb_ACTION_sii,
    BUTTON_CB => \&_init_cb_BUTTON_CB_iiiis,
    CARET_CB => \&_init_cb_CARET_CB_iii,
    DBLCLICK_CB => \&_init_cb_DBLCLICK_CB_is,
    DROPDOWN_CB => \&_init_cb_DROPDOWN_CB_i,
    DROPFILES_CB => \&_init_cb_DROPFILES_CB_siii,
    EDIT_CB => \&_init_cb_EDIT_CB_is,
    MOTION_CB => \&_init_cb_MOTION_CB_iis,
    MULTISELECT_CB => \&_init_cb_MULTISELECT_CB_s,
    VALUECHANGED_CB => \&_init_cb_VALUECHANGED_CB_,
  },
  'IUP::Matrix' => {
    ACTION_CB => \&_init_cb_ACTION_CB_iiiis,
    BGCOLOR_CB => \&_init_cb_BGCOLOR_CB_iiIII,
    CLICK_CB => \&_init_cb_CLICK_CB_iis,
    DRAW_CB => \&_init_cb_DRAW_CB_iiiiiiv,
    DROPCHECK_CB => \&_init_cb_DROPCHECK_CB_ii,
    DROPSELECT_CB => \&_init_cb_DROPSELECT_CB_iinsii,
    DROP_CB => \&_init_cb_DROP_CB_nii,
    EDITION_CB => \&_init_cb_EDITION_CB_iiii,
    ENTERITEM_CB => \&_init_cb_ENTERITEM_CB_ii,
    FGCOLOR_CB => \&_init_cb_FGCOLOR_CB_iiIII,
    FONT_CB => \&_init_cb_FONT_CB_ii,
    LEAVEITEM_CB => \&_init_cb_LEAVEITEM_CB_ii,
    MARKEDIT_CB => \&_init_cb_MARKEDIT_CB_iii,
    MARK_CB => \&_init_cb_MARK_CB_ii,
    MOUSEMOVE_CB => \&_init_cb_MOUSEMOVE_CB_ii,
    RELEASE_CB => \&_init_cb_RELEASE_CB_iis,
    SCROLLTOP_CB => \&_init_cb_SCROLLTOP_CB_ii,
    VALUE_CB => \&_init_cb_VALUE_CB_ii,
    VALUE_EDIT_CB => \&_init_cb_VALUE_EDIT_CB_iis,
  },
  'IUP::Menu' => {
    MENUCLOSE_CB => \&_init_cb_MENUCLOSE_CB_,
    OPEN_CB => \&_init_cb_OPEN_CB_,
  },
  'IUP::PPlot' => {
    DELETEBEGIN_CB => \&_init_cb_DELETEBEGIN_CB_,
    DELETEEND_CB => \&_init_cb_DELETEEND_CB_,
    DELETE_CB => \&_init_cb_DELETE_CB_iiff,
    EDITBEGIN_CB => \&_init_cb_EDITBEGIN_CB_,
    EDITEND_CB => \&_init_cb_EDITEND_CB_,
    EDIT_CB => \&_init_cb_EDIT_CB_iiffFF,
    POSTDRAW_CB => \&_init_cb_POSTDRAW_CB_v,
    PREDRAW_CB => \&_init_cb_PREDRAW_CB_v,
    SELECTBEGIN_CB => \&_init_cb_SELECTBEGIN_CB_,
    SELECTEND_CB => \&_init_cb_SELECTEND_CB_,
    SELECT_CB => \&_init_cb_SELECT_CB_iiffi,
  },
  'IUP::Spin' => {
    SPIN_CB => \&_init_cb_SPIN_CB_i,
  },
  'IUP::SpinBox' => {
    SPIN_CB => \&_init_cb_SPIN_CB_i,
  },
  'IUP::Submenu' => {
    HIGHLIGHT_CB => \&_init_cb_HIGHLIGHT_CB_,
  },
  'IUP::Tabs' => {
    TABCHANGEPOS_CB => \&_init_cb_TABCHANGEPOS_CB_ii,
    TABCHANGE_CB => \&_init_cb_TABCHANGE_CB_nn,
  },
  'IUP::Text' => {
    ACTION => \&_init_cb_ACTION_is,
    BUTTON_CB => \&_init_cb_BUTTON_CB_iiiis,
    CARET_CB => \&_init_cb_CARET_CB_iii,
    DROPFILES_CB => \&_init_cb_DROPFILES_CB_siii,
    MOTION_CB => \&_init_cb_MOTION_CB_iis,
    SPIN_CB => \&_init_cb_SPIN_CB_i,
    VALUECHANGED_CB => \&_init_cb_VALUECHANGED_CB_,
  },
  'IUP::Timer' => {
    ACTION_CB => \&_init_cb_ACTION_CB_,
  },
  'IUP::Toggle' => {
    ACTION => \&_init_cb_ACTION_i,
    VALUECHANGED_CB => \&_init_cb_VALUECHANGED_CB_,
  },
  'IUP::Tree' => {
    BRANCHCLOSE_CB => \&_init_cb_BRANCHCLOSE_CB_i,
    BRANCHOPEN_CB => \&_init_cb_BRANCHOPEN_CB_i,
    BUTTON_CB => \&_init_cb_BUTTON_CB_iiiis,
    DRAGDROP_CB => \&_init_cb_DRAGDROP_CB_iiii,
    DROPFILES_CB => \&_init_cb_DROPFILES_CB_siii,
    EXECUTELEAF_CB => \&_init_cb_EXECUTELEAF_CB_i,
    MOTION_CB => \&_init_cb_MOTION_CB_iis,
    MULTISELECTION_CB => \&_init_cb_MULTISELECTION_CB_Ai,
    MULTIUNSELECTION_CB => \&_init_cb_MULTIUNSELECTION_CB_Ai,
    NODEREMOVED_CB => \&_init_cb_NODEREMOVED_CB_U,
    RENAME_CB => \&_init_cb_RENAME_CB_is,
    RIGHTCLICK_CB => \&_init_cb_RIGHTCLICK_CB_i,
    SELECTION_CB => \&_init_cb_SELECTION_CB_ii,
    SHOWRENAME_CB => \&_init_cb_SHOWRENAME_CB_i,
  },
  'IUP::Val' => {
    VALUECHANGED_CB => \&_init_cb_VALUECHANGED_CB_,
  },
  '_base' => {
    ENTERWINDOW_CB => \&_init_cb_ENTERWINDOW_CB_,
    GETFOCUS_CB => \&_init_cb_GETFOCUS_CB_,
    HELP_CB => \&_init_cb_HELP_CB_,
    KILLFOCUS_CB => \&_init_cb_KILLFOCUS_CB_,
    K_ANY => \&_init_cb_K_ANY_i,
    LEAVEWINDOW_CB => \&_init_cb_LEAVEWINDOW_CB_,
    MAP_CB => \&_init_cb_MAP_CB_,
    UNMAP_CB => \&_init_cb_UNMAP_CB_,
  },
  '_canvas' => {
    ACTION => \&_init_cb_ACTION_ff,
    BUTTON_CB => \&_init_cb_BUTTON_CB_iiiis,
    DROPFILES_CB => \&_init_cb_DROPFILES_CB_siii,
    FOCUS_CB => \&_init_cb_FOCUS_CB_i,
    KEYPRESS_CB => \&_init_cb_KEYPRESS_CB_ii,
    MOTION_CB => \&_init_cb_MOTION_CB_iis,
    MULTITOUCH_CB => \&_init_cb_MULTITOUCH_CB_iAAAA,
    RESIZE_CB => \&_init_cb_RESIZE_CB_ii,
    SCROLL_CB => \&_init_cb_SCROLL_CB_iff,
    TOUCH_CB => \&_init_cb_TOUCH_CB_iiis,
    WHEEL_CB => \&_init_cb_WHEEL_CB_fiis,
    WOM_CB => \&_init_cb_WOM_CB_i,
  },
  '_dialog' => {
    CLOSE_CB => \&_init_cb_CLOSE_CB_,
    COPYDATA_CB => \&_init_cb_COPYDATA_CB_si,
    DROPFILES_CB => \&_init_cb_DROPFILES_CB_siii,
    MDIACTIVATE_CB => \&_init_cb_MDIACTIVATE_CB_,
    MOVE_CB => \&_init_cb_MOVE_CB_ii,
    RESIZE_CB => \&_init_cb_RESIZE_CB_ii,
    SHOW_CB => \&_init_cb_SHOW_CB_i,
    TRAYCLICK_CB => \&_init_cb_TRAYCLICK_CB_iii,
  },
};

sub _get_cb_init_function {
  my ($pkg, $action) = @_;  
  my $p = $cb_table->{$pkg};
  my $f = $p->{$action} if $p;
  $f ||= $cb_table->{_dialog}->{$action} if $pkg =~ /^IUP::(Dialog|ColorDlg|FileDlg|FontDlg|MessageDlg)$/;
  $f ||= $cb_table->{_canvas}->{$action} if $pkg =~ /^IUP::(Canvas|CanvasGL)$/;
  $f ||= $cb_table->{_base}->{$action};  
  return $f;
}

sub _is_cb_valid {
  my ($pkg, $action) = @_;
  return (_get_cb_init_function($pkg, $action)) ? 1 : 0;
}

sub _get_cb_list {
  my $pkg = shift;
  my @list;
  push @list, keys(%{$cb_table->{$pkg}});
  push @list, keys(%{$cb_table->{_dialog}}) if $pkg =~ /^IUP::(Dialog|ColorDlg|FileDlg|FontDlg|MessageDlg)$/;
  push @list, keys(%{$cb_table->{_canvas}}) if $pkg =~ /^IUP::(Canvas|CanvasGL)$/;
  push @list, keys(%{$cb_table->{_base}});
  return keys %{{ map { $_ => 1 } @list }}; #return just uniq items
}

sub _get_cb_eval_code {
  my $pkg = shift;
  my $rv;
  for (_get_cb_list($pkg)) {
    next if defined  *{"$pkg\::$_"};
    $rv .= "*$pkg\::$_ = sub { return \$_[1] ? \$_[0]->SetCallback('$_', \$_[1]) : \$_[0]->{$_} };\n";
  }
  return $rv;
}

1;

__END__

=head1 NAME

IUP::Internal::Callback - [internal only] DO NOT USE this unless you know what could happen!

=cut
