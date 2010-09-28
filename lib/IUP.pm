package IUP;

use strict;
use warnings;

use Carp;
use IUP::Internal::LibraryIUP;
use IUP::Internal::Callback;

# the following modules will be autoimported by calling 'use IUP;'
use IUP::Button;
use IUP::Canvas;
use IUP::Cbox;
use IUP::Cells;
use IUP::Clipboard;
use IUP::ColorBar;
use IUP::ColorBrowser;
use IUP::ColorDlg;
use IUP::Constants;
use IUP::Dial;
use IUP::Dialog;	# required by IUP.pm (GetParam)
use IUP::FileDlg;
use IUP::Fill;
use IUP::FontDlg;
use IUP::Frame;
use IUP::GLCanvas;
use IUP::Hbox;
use IUP::Image;
use IUP::ImageRGB;
use IUP::ImageRGBA;
use IUP::Item;
use IUP::Label;
use IUP::List;
use IUP::Matrix;
use IUP::Menu;
use IUP::MessageDlg;
use IUP::Normalizer;
use IUP::OleControl;
use IUP::PPlot;
use IUP::ProgressBar;
use IUP::Radio;
use IUP::Sbox;
use IUP::Separator;
use IUP::Spin;
use IUP::Spinbox;
use IUP::Split;
use IUP::Submenu;
use IUP::Tabs;
use IUP::Text;
use IUP::Timer;
use IUP::Toggle;
use IUP::Tree;
use IUP::User;
use IUP::Val;
use IUP::Vbox;
use IUP::Zbox;

sub import {
  IUP::Constants->import(caller); #kind of a hack - see IUP/Constants.pm  

  IUP::Button->import();
  IUP::Canvas->import();
  IUP::Cbox->import();
  IUP::Cells->import();
  IUP::Clipboard->import();
  IUP::ColorBar->import();
  IUP::ColorBrowser->import();
  IUP::ColorDlg->import();
  IUP::Dial->import();
  IUP::Dialog->import();
  IUP::FileDlg->import();
  IUP::Fill->import();
  IUP::FontDlg->import();
  IUP::Frame->import();
  IUP::GLCanvas->import();
  IUP::Hbox->import();
  IUP::Image->import();
  IUP::ImageRGB->import();
  IUP::ImageRGBA->import();
  IUP::Item->import();
  IUP::Label->import();
  IUP::List->import();
  IUP::Matrix->import();
  IUP::Menu->import();
  IUP::MessageDlg->import();
  IUP::Normalizer->import();
  IUP::OleControl->import();
  IUP::PPlot->import();
  IUP::ProgressBar->import();
  IUP::Radio->import();
  IUP::Sbox->import();
  IUP::Separator->import();
  IUP::Spin->import();
  IUP::Spinbox->import();
  IUP::Split->import();
  IUP::Submenu->import();
  IUP::Tabs->import();
  IUP::Text->import();
  IUP::Timer->import();
  IUP::Toggle->import();
  IUP::Tree->import();
  IUP::User->import();
  IUP::Val->import();
  IUP::Vbox->import();
  IUP::Zbox->import();
};

our $VERSION = 'v0.0.0_1';

use Data::Dumper;

### the main IUP control functions

sub MainLoop {
  #int IupMainLoop(void); [in C]
  #iup.MainLoop() -> ret: number [in Lua]
  return IUP::Internal::LibraryIUP::_IupMainLoop();
}

sub MainLoopLevel {
  #int IupMainLoopLevel(void); [in C]
  #iup.MainLoopLevel() -> ret: number [in Lua]
  return IUP::Internal::LibraryIUP::_IupMainLoopLevel();
}

sub LoopStep {
  #int IupLoopStep(void); [in C]
  #iup.LoopStep() -> ret: number [in Lua]
  return IUP::Internal::LibraryIUP::_IupLoopStep();
}

sub LoopStepWait {
  #int IupLoopStepWait(void); [in C]
  #iup.LoopStepWait() -> ret: number [in Lua]
  return IUP::Internal::LibraryIUP::_IupLoopStepWait();
}

sub ExitLoop {
  #void IupExitLoop(void); [in C]
  #iup.ExitLoop() [in Lua]
  IUP::Internal::LibraryIUP::_IupExitLoop();
}

sub Flush {
  #void IupFlush(void); [in C]
  #iup.Flush() [in Lua]
  IUP::Internal::LibraryIUP::_IupFlush();
}

### helper functions

sub Close {
  #void IupClose(void); [in C]
  #iup.Close() [in Lua]
  IUP::Internal::LibraryIUP::_IupClose();
}

sub GetAllDialogs {
  #int IupGetAllDialogs(char** names, int max_n); [in C]
  #iup.GetAllDialogs(max_n: number) -> (names: table, n: number) [in Lua]
  my ($pkg, $max_n) = @_;
  IUP::Internal::LibraryIUP::_IupGetAllDialogs($max_n);
}

sub GetAllNames {
  #int IupGetAllNames(char** names, int max_n); [in C]
  #iup.GetAllNames(max_n: number) -> (names: table, n: number) [in Lua]
  my ($pkg, $max_n) = @_;
  IUP::Internal::LibraryIUP::_IupGetAllNames($max_n);
}

sub GetFocus {
  #Ihandle* IupGetFocus(void); [in C]
  #iup.GetFocus() -> elem: ihandle [in Lua]
  my $ih = IUP::Internal::LibraryIUP::_IupGetFocus();
  return IUP->GetOrCreateByIhandle($ih);
}

sub GetClassName {
  #char* IupGetClassName(Ihandle* ih); [in C]
  #iup.GetClassName(ih: ihandle) -> (name: string) [in Lua]
  my ($pkg, $ih) = @_;
  return IUP::Internal::LibraryIUP::_IupGetClassName($ih);
}

sub GetByName {
  return GetHandle(@_);
}

sub GetHandle {
  #Ihandle *IupGetHandle(const char *name); [in C]
  #iup.GetHandle(name: string) -> ih: ihandle [in Lua]
  my ($pkg, $name) = @_;
  my $ih = IUP::Internal::LibraryIUP::_IupGetHandle($name);
  return IUP->GetOrCreateByIhandle($ih);
}

sub GetByIhandle {
  my ($pkg, $ih) = @_;
  return IUP::Internal::Callback::_translate_ih($ih) if defined $ih;
  return; #undef
}

sub GetOrCreateByIhandle {
  my ($pkg, $ih) = @_;
  my $mapping = {
    button => "IUP::Button",
    canvas => "IUP::Canvas",
    cbox => "IUP::Cbox",
    cells => "IUP::Cells",
    clipboard => "IUP::Clipboard",
    colorbar => "IUP::ColorBar",
    colorbrowser => "IUP::ColorBrowser",
    colordlg => "IUP::ColorDlg",
    constants => "IUP::Constants",
    dial => "IUP::Dial",
    dialog => "IUP::Dialog",
    filedlg => "IUP::FileDlg",
    fill => "IUP::Fill",
    fontdlg => "IUP::FontDlg",
    frame => "IUP::Frame",
    glcanvas => "IUP::GLCanvas",
    hbox => "IUP::Hbox",
    image => "IUP::Image",
    imagergb => "IUP::ImageRGB",
    imagergba => "IUP::ImageRGBA",
    item => "IUP::Item",
    label => "IUP::Label",
    list => "IUP::List",
    matrix => "IUP::Matrix",
    menu => "IUP::Menu",
    messagedlg => "IUP::MessageDlg",
#    multiline => "IUP::MultiLine", # xxx TODO xxx deprecated
    normalizer => "IUP::Normalizer",
    olecontrol => "IUP::OleControl",
    pplot => "IUP::PPlot",
    progressbar => "IUP::ProgressBar",
    radio => "IUP::Radio",
    sbox => "IUP::Sbox",
    separator => "IUP::Separator",
    spin => "IUP::Spin",
    spinbox => "IUP::Spinbox",
    split => "IUP::Split",
    submenu => "IUP::Submenu",
    tabs => "IUP::Tabs",
    text => "IUP::Text",
    timer => "IUP::Timer",
    toggle => "IUP::Toggle",
    tree => "IUP::Tree",
    user => "IUP::User",
    val => "IUP::Val",
    vbox => "IUP::Vbox",
    zbox => "IUP::Zbox",  
  };
  return unless $ih;
  my $e = IUP::Internal::Callback::_translate_ih($ih);
  return $e if defined $e;
  my $c = IUP->GetClassName($ih);
  return unless $c;
  my $p = $mapping->{$c};
  return unless $p;
  return $p->new_from_ihandle($ih);  
}

sub Help {
  #int IupHelp(const char* url); [in C]
  #iup.Help(url: string) [in Lua]
  my ($pkg, $url) = @_;
  return IUP::Internal::LibraryIUP::_IupHelp($url);
}

sub Load {
  #char *IupLoad(const char *filename); [in C]
  #iup.Load(filename: string) -> error: string [in Lua]
  my ($pkg, $filename) = @_;
  return IUP::Internal::LibraryIUP::_IupLoad($filename);
}

sub LoadBuffer {
  # xxx TODO maybe integrate into one Load() or accept also filehandle
  #char *IupLoadBuffer(const char *buffer); [in C] (since 3.0)
  #iup.LoadBuffer(buffer: string) -> error: string [in Lua]
  my ($pkg, $buffer) = @_;
  return IUP::Internal::LibraryIUP::_IupLoadBuffer($buffer);
}

sub GetClassAttributes {
  #int IupGetClassAttributes(const char* classname, char** names, int max_n); [in C]
  #iup.GetClassAttributes(classname: string, max_n: number) -> (names: table, n: number) [in Lua]
  my ($pkg, $classname, $max_n) = @_;
  return IUP::Internal::LibraryIUP::_IupGetClassAttributes($classname, $max_n);	
}

sub SetClassDefaultAttribute {
  #void IupSetClassDefaultAttribute(const char* classname, const char *name, const char *value); [in C]
  #iup.SetClassDefaultAttribute(classname, name, value: string) [in Lua]
  my ($pkg, $classname, $name, $value) = @_;
  IUP::Internal::LibraryIUP::_IupSetClassDefaultAttribute($classname, $name, $value);
}

sub GetGlobal {
  #char *IupGetGlobal(const char *name); [in C]
  #iup.GetGlobal(name: string) -> value: string [in Lua]
  my ($pkg, $name) = @_;
  return IUP::Internal::LibraryIUP::_IupGetGlobal($name);
}

sub SetGlobal {
  #void IupSetGlobal(const char *name, const char *value); [in C]
  #iup.SetGlobal(name: string, value: string) [in Lua] 
  my ($pkg, $name, $value) = @_;
  #IUP::Internal::LibraryIUP::_IupSetGlobal($name, $value); # xxx TODO SetGlobal vs. StoreGlobal xxx
  IUP::Internal::LibraryIUP::_IupStoreGlobal($name, $value);
}

sub StoreGlobal {
  #void IupStoreGlobal(const char *name, const char *value); [in C]
  #iup.StoreGlobal(name: string, value: string) [in Lua] 
  my ($pkg, $name, $value) = @_;
  IUP::Internal::LibraryIUP::_IupStoreGlobal($name, $value);
}

sub GetLanguage {
  #char* IupGetLanguage(void); [in C] 
  #iup.GetLanguage() -> (language: string) [in Lua] 
  return IUP::Internal::LibraryIUP::_IupGetLanguage();
}

sub SetLanguage {
  #void IupSetLanguage(const char *lng); [in C] 
  #iup.SetLanguage(lng: string) [in Lua]
  my ($pkg, $lng) = @_;
  IUP::Internal::LibraryIUP::_IupSetLanguage($lng);
}

sub MapFont {
  #char* IupMapFont(const char *iupfont); [in C]
  #iup.MapFont(iupfont : string) -> (driverfont : string) [in Lua]
  my ($pkg, $iupfont) = @_;
  return IUP::Internal::LibraryIUP::_IupMapFont($iupfont);
}

sub UnMapFont {
  #char* IupUnMapFont(const char *driverfont); [in C]
  #iup.UnMapFont(driverfont :string) -> (iupfont : string) [in Lua]
  my ($pkg, $driverfont) = @_;
  IUP::Internal::LibraryIUP::_IupUnMapFont($driverfont);
}

sub Version {
  #char* IupVersion(void); [in C]
  #iup.Version() -> (version: string) [in Lua]
  return IUP::Internal::LibraryIUP::_IupVersion();
}

sub VersionNumber {
  #int IupVersionNumber(void); [in C]
  #iup.VersionNumber() -> (version: number) [in Lua]
  return IUP::Internal::LibraryIUP::_IupVersionNumber();
}

### simple dialogues

sub GetColor {
  my ($pkg, $x, $y, $r, $g, $b) = @_;
  # returns array: ($retval, $new_r, $new_g, $new_b)
  return IUP::Internal::LibraryIUP::_IupGetColor($x, $y, $r, $g, $b);
}

sub GetFile {
  my ($pkg, $filename_filter) = @_;
  # returns array: ($retval, $filename)
  return IUP::Internal::LibraryIUP::_IupGetFile($filename_filter);
}

sub GetParam {
  #int IupGetParam(const char* title, Iparamcb action, void* user_data, const char* format,...); [in C]
  #iup.GetParam(title: string, action: function, format: string,...) -> (status: boolean, ...) [in Lua]
  my ($pkg, $title, $action, $format, @initial_values) = @_;
  my $dlg = IUP::Dialog->new_no_ihandle();
  # we do not have ihandle of the new dialog at this point
  # we are gonna set ihandle doring the first callback invocation (see XS code)
  my ($status, @output_values) = IUP::Internal::LibraryIUP::_IupGetParam($title, $action, $dlg, $format, @initial_values);
  return ($status, @output_values);
}

sub ListDialog {
  #int IupListDialog(int type, const char *title, int size, const char** list, int op, int max_col, int max_lin, int* marks); [in C]
  #iup.ListDialog(type: number, title: string, size: number, list: table of strings, op: number, max_col: number, max_lin: number, marks: table of numbers) -> status: number [in Lua]
  my ($pkg, $type, $title, $list, $op, $max_col, $max_lin, $marks) = @_;
  # perl function does not require 'size' param which is calculater from the size of 'list' array
  return IUP::Internal::LibraryIUP::_IupListDialog($type, $title, $list, $op, $max_col, $max_lin, $marks);
}

sub GetText {
  my $pkg = shift;
  if (scalar @_ == 1) {
    return IUP::Internal::LibraryIUP::_IupGetText('', $_[0]);
  }
  elsif (scalar @_ == 2) {
    return IUP::Internal::LibraryIUP::_IupGetText($_[0], $_[1]);
  }
  carp('Warning: wrong params - IUP->GetText($title, $msg)');
  return;
}

sub Alarm {
  my ($pkg, $t, $m, $b1, $b2, $b3) = @_;
  return IUP::Internal::LibraryIUP::_IupAlarm($t, $m, $b1, $b2, $b3);
}

sub Message {
  my $pkg = shift;
  if (scalar @_ == 1) {
    return IUP::Internal::LibraryIUP::_IupMessage('', $_[0]);
  }
  elsif (scalar @_ == 2) {
    return IUP::Internal::LibraryIUP::_IupMessage($_[0], $_[1]);
  }
  carp('Warning: wrong params - IUP->Message($title, $msg)');
  return;
}

sub SetIdle {
  my ($pkg, $func) = @_;
  return IUP::Internal::LibraryIUP::_SetIdle($func);
}

###

=head1 NAME

IUP - The great new IUP!

=head1 VERSION

Version 0.0.0_1

=head1 SYNOPSIS

Quick summary of what the module does.

Perhaps a little code snippet.

    use IUP;

    my $foo = IUP->new();
    ...

=head1 EXPORT

A list of functions that can be exported.  You can delete this section
if you don't export anything, such as for a purely object-oriented module.

=head1 SUBROUTINES/METHODS

=head2 function1

=head2 function2

=head1 AUTHOR

KMX, C<< <kmx at cpan.org> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-iup at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=IUP>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc IUP

You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=IUP>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/IUP>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/IUP>

=item * Search CPAN

L<http://search.cpan.org/dist/IUP/>

=back

=head1 ACKNOWLEDGEMENTS

xxx

=head1 LICENSE AND COPYRIGHT

Copyright 2010 KMX.

This program is distributed under the MIT (X11) License:
L<http://www.opensource.org/licenses/mit-license.php>

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.

=cut

1; # End of IUP
