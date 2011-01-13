use strict;
use warnings;

use FindBin;
use File::Path qw(make_path remove_tree);
use File::Slurp;
use File::Spec;
use File::Find;
use Template;
use Digest::SHA qw(sha1_hex);
use Getopt::Long;
use Pod::Usage;

require "$FindBin::Bin/utils.pm";
die "Cannot require utils.pm\n" if $@;

# global variables
my $g_help    = 0;
my $g_htmlinc = "$FindBin::Bin/pod.htmlinc";
my $g_podtt   = "$FindBin::Bin/tmp.pod.tt";
my $g_pod     = "$FindBin::Bin/tmp.pod";
#my $g_pod     = "$FindBin::Bin/../doc";
# processing commandline options
my $getopt_rv = GetOptions(
  'help|?' => \$g_help,
  'podtt=s' => \$g_podtt,
  'pod=s' => \$g_pod,
  'htmlinc=s' => \$g_htmlinc,
);
pod2usage(-exitstatus=>0, -verbose=>2) if $g_help || !$getopt_rv;

my $ttdata = {
  h => {
    name       => '=head1 NAME',
    synopsis   => '=head1 SYNOPSIS',
    desc       => '=head1 DESCRIPTION',
    usage      => '=head1 USAGE',
    notes      => '=head1 NOTES',
    see        => '=head1 SEE ALSO',
    examples   => '=head1 EXAMPLES',
    cb_func    => '=head1 xxxcbfunc',
    create     => '=head2 CREATION - new() method',
    at         => '=head2 ATTRIBUTES',
    cb         => '=head2 CALLBACKS',
    func       => '=head2 METHODS',
    at_value   => 'B<Value:>',
    at_notes   => 'B<Notes:>',
    at_affects => 'B<Affects:>',
    at_default => 'B<Default:>',
    at_handler => 'B<Callback handler prototype:>',
    at_see     => 'B<See Also:>',
    at_examples=> 'B<Examples:>',
    at_win     => 'B<Windows Related Notes:>',
    at_gtk     => 'B<GTK2+ Related Notes:>',
    at_mot     => 'B<Motif Related Notes:>',
#    at_value   => '=head3 Value',
#    at_notes   => '=head3 Notes',
#    at_affects => '=head3 Affects',
#    at_see     => '=head3 See Also',
#    at_examples=> '=head3 Examples',
#    at_win     => '=head3 Windows Subsystem',
#    at_gtk     => '=head3 GTK2+ Subsystem',
#    at_mot     => '=head3 Motif Subsystem',
  },
  n => {
    iup             =>               'IUP - Cross-platform GUI',
    iupbutton       =>       'IUP::Button - [GUI element] button decorated with a text and/or an image',
    iupcanvas       =>       'IUP::Canvas - [GUI element] 2D canvas with many drawing and text functions',
    iupcanvasgl     =>     'IUP::CanvasGL - [GUI element] 2D canvas based on OpenGL (co-operates with OpenGL module)',
    iupcbox         =>         'IUP::Cbox - [GUI element] container for position elements in absolute coordinates',
    iupcells        =>        'IUP::Cells - [GUI element] grid widget (set of cells) that enables chess-table-like drawings',
    iupclipboard    =>    'IUP::Clipboard - [special] allows access to the clipboard',
    iupcolorbar     =>     'IUP::ColorBar - [GUI element] color palette for color selection of 1 or 2 colors',
    iupcolorbrowser => 'IUP::ColorBrowser - [GUI element] color selector via cylindrical projection of the RGB cube',
    iupcolordlg     =>     'IUP::ColorDlg - [pre-defined dialog] selecting color',
    iupconstants    =>    'IUP::Constants - [special] IUP related constants',
    iupdial         =>         'IUP::Dial - [GUI element] dial for regulating a given angular variable',
    iupdialog       =>       'IUP::Dialog - [GUI element] the main GUI element; the main application window',
    iupfiledlg      =>      'IUP::FileDlg - [pre-defined dialog] selecting files or a directory',
    iupfill         =>         'IUP::Fill - [GUI element] dynamically occupies empty spaces always trying to expand itself',
    iupfontdlg      =>      'IUP::FontDlg - [pre-defined dialog] selecting a font',
    iupframe        =>        'IUP::Frame - [GUI element] frame with a title around an interface element',    
    iuphbox         =>         'IUP::Hbox - [GUI element] container for composing elements horizontally',
    iupimage        =>        'IUP::Image - [GUI element] image to be shown on a label, button, toggle, or as a cursor',
    iupitem         =>         'IUP::Item - [GUI element] item of the menu interface element',
    iuplabel        =>        'IUP::Label - [GUI element] displays a separator, a text or an image',
    iuplist         =>         'IUP::List - [GUI element] displays a list of items (listbox, combobox, dropdown)',
    iupmatrix       =>       'IUP::Matrix - [GUI element] matrix of alphanumeric fields',
    iupmenu         =>         'IUP::Menu - [GUI element] menu which can group 3 types of elements: item, submenu, separator',
    iupmessagedlg   =>   'IUP::MessageDlg - [pre-defined dialog] displaying a message',
    iupnormalizer   =>   'IUP::Normalizer - [GUI element] normalizes all controls from a list to be the biggest natural size',
    iupole          =>          'IUP::Ole - [GUI element] windows OLE control (aka ActiveX control) - WIN32 ONLY',
    iuppplot        =>        'IUP::PPlot - [GUI element] xxx creating plots that',
    iupprogressbar  =>  'IUP::ProgressBar - [GUI element] shows a percent value that can be updated to simulate a progression',
    iupradio        =>        'IUP::Radio - [GUI element] container for grouping mutual exclusive toggles (radiobutton)',
    iupsbox         =>         'IUP::Sbox - [GUI element] container for expanding/contracting the child size in one direction',
    iupseparator    =>    'IUP::Separator - [GUI element] shows a line between two menu items',
    iupspin         =>         'IUP::Spin - [GUI element] vertical box containing 2 buttons for incrementing/decrementing values',
    iupspinbox      =>      'IUP::Spinbox - [GUI element] horizontal container that already contains a IUP::Spin',
    iupsplit        =>        'IUP::Split - [GUI element] container that split its client area in two',
    iupsubmenu      =>      'IUP::Submenu - [GUI element] menu item that, when selected, opens another menu',
    iuptabs         =>         'IUP::Tabs - [GUI element] allows a single dialog to have several screens, grouping options',
    iuptext         =>         'IUP::Text - [GUI element] editable text field (single/multi-line, plain/rich-text)',
    iuptimer        =>        'IUP::Timer - [special] periodicaly invokes a callback when the time is up',
    iuptoggle       =>       'IUP::Toggle - [GUI element] two-state (on/off) button with a text and/or an image',
    iuptree         =>         'IUP::Tree - [GUI element] tree containing nodes of branches or leaves with associated text/image',
    iupuser         =>         'IUP::User - [special] user element which is not associated to any interface element',
    iupval          =>          'IUP::Val - [GUI element] selects a value in a limited interval (aka scale, trackbar)',
    iupvbox         =>         'IUP::Vbox - [GUI element] container for composing elements vertically',
    iupzbox         =>         'IUP::Zbox - [GUI element] container for composing elements in hidden layers with only one layer visible',
  },
  m => {
    intro    => 'IUP::Manual::01_BasicConcept',
    elem     => 'IUP::Manual::02_Elements',
    at       => 'IUP::Manual::03_Attributes',
    cb       => 'IUP::Manual::04_Callbacks',
    keys     => 'IUP::Manual::05_HandlingKeyboard',
    dlg      => 'IUP::Manual::06_DialogLayout',
    led      => 'IUP::Manual::06_UsingLED',
    examples => 'IUP::Manual::07_Examples',
    
    imglib   => 'IUP::Manual::06_BuiltInImageLibrary',
    predlg   => 'IUP::Manual::07_PredefinedDialogs',
    asimple  => 'IUP::Manual::09_SimpleApplication',
    acomplex => 'IUP::Manual::10_ComplexApplication',
    amdi     => 'IUP::Manual::11_MDIApplication',
    galery   => 'IUP::Manual::12_ScreenshotGalery',
  },
  txt => {
    new_attr  => "B<Note:> You can pass to C<new()> other C<ATTRIBUTE=E<gt>'value'> pairs relevant\n" .
                 "to this element - see L<[%m.elem%]|[%m.elem%]>.",
    at_intro  => "For more info about concept of attributes (setting/getting values etc.)\n" .
                 "see L<[%m.at%]|[%m.at%]>. Attributes specific to this element:",
    at_common => "The following L<common attributes|[%m.at%]/Common Attributes> are also accepted:",
    cb_intro  => "For more info about concept of callbacks (setting callback handlers etc.)\n" .
                 "see L<[%m.cb%]|[%m.cb%]>. Callbacks specific to this element:",
    cb_common => "The following L<common callbacks|[%m.cb%]/Common Callbacks> are also accepted:",
    cb_ih     => 'B<$self:> reference to the element that activated the event.',
  },
  url => {
    examples => 'https://github.com/kmx/perl-iup/tree/master/examples',
  },
  html => { }, #this is loaded via load_htmlinc()
};

my %pod_all = map {$_=>1} My::Utils::find_file($g_pod, qr/\.pod$/);

sub load_htmlinc {
  my $htmlinc = shift;
  die "non-existing dir '$htmlinc'\n" unless -d $htmlinc;
  for my $html (My::Utils::find_file($htmlinc, qr/\.html$/)) {
    my ($v, $d, $f) = File::Spec->splitpath($html);
    (my $n = $f) =~ s/\.html$//;
    my $content = read_file($html) or die "No content for '$html'\n";
    $content =~ s/^\s*(.*?)\s*$/$1/;
    $ttdata->{html}->{$n} = $content;
  }  
}

sub procfile {
  my $podtt = shift;
  my $rel = File::Spec->abs2rel($podtt, $g_podtt);
  my $pod = File::Spec->rel2abs(File::Spec->catfile($g_pod, $rel));    
  
  warn "[INFO] input='$podtt'\n";
  my $pod_orig = -f $pod ? read_file($pod) : 'EMPTY: random content='.rand(999);  
  my $pod_new;
  my $pod_tmp;
  my $tt = Template->new(ABSOLUTE=>1);  
  $tt->process($podtt, $ttdata, \$pod_tmp) || die $tt->error(), "\n";  
  $tt->process(\$pod_tmp, $ttdata, \$pod_new) || die $tt->error(), "\n";  
  $pod_new = encode('utf-8', $pod_new);
  if (sha1_hex($pod_orig) ne sha1_hex($pod_new)) {
    warn " -> orig=", sha1_hex($pod_orig), "\n" unless $pod_orig =~ /^EMPTY/;
    warn " -> new =", sha1_hex($pod_new), "\n";
    warn " -> writting: '$pod'\n";
    My::Utils::make_path_for_file($pod);
    write_file($pod, $pod_new);
  }
  delete $pod_all{$pod};
}

warn ">>>>[$0] Started!\n";

load_htmlinc($g_htmlinc);
procfile($_) for (My::Utils::find_file($g_podtt, qr/\.pod$/));
warn "[WARN] Unexpected extra pod file: '$_'\n" for keys(%pod_all);

warn ">>>>[$0] Finished!\n";

__END__

=head1 USAGE

proc-pod.tt2pod.pl [options]

 Options:
   -help            help message
   -podtt=<dir>     directory with *.pod files (in fact 'tt' templates)
   -pod=<dir>       directory for storing output *.pod files
   -htmlinc=<dir>   directory with *.html files (to be included into resulting *.pod)

=head1 DESCRIPTION

Converts *.pod files with TT marks (like '[% ... %]') into final *.pod files that
are gonna be published on CPAN.
