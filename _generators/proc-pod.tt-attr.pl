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
use Data::Dumper;

require "$FindBin::Bin/utils.pm";
die "Cannot require utils.pm\n" if $@;

# global variables
my $g_help    = 0;
my $g_podtt   = "$FindBin::Bin/pod.tt/IUP_Manual_Attributes.pod";
# processing commandline options
my $getopt_rv = GetOptions(
  'help|?' => \$g_help,
  'podtt=s' => \$g_podtt,
);
pod2usage(-exitstatus=>0, -verbose=>2) if $g_help || !$getopt_rv;

my $common_cat = [
  { name => 'Common Attributes', members => [ qw/ACTIVE BGCOLOR FGCOLOR FONT FONTSTYLE FONTSIZE FONTFACE CHARSIZE FOUNDRY VISIBLE CLIENTSIZE CLIENTOFFSET EXPAND MAXSIZE MINSIZE RASTERSIZE SIZE FLOATING POSITION X Y NAME TIP TIPBALLON TIPBALLONTITLE TIPBALLONTITLEICON TIPBGCOLOR TIPDELAY TIPFGCOLOR TIPFONT TIPICON TIPMARKUP TIPRECT TIPVISIBLE TITLE VALUE WID ZORDER/ ], },
  { name => 'Frequently used Attributes', members => [ qw/CONTROL CURSOR DX DY ICON MASK MASKCASEI MASKINT MASKFLOAT PARENTDIALOG POSX POSY SCROLLBAR SHRINK XMAX XMIN YMAX YMIN/ ], },
];

my $global_cat = [
  { name => 'Global Attributes - General', members => [ qw/LANGUAGE VERSION COPYRIGHT DRIVER/ ], },
  { name => 'Global Attributes - System Control', members => [ qw/LOCKLOOP CURSORPOS MOUSEBUTTON SHIFTKEY CONTROLKEY MODKEYSTATE KEYPRESS KEYRELEASE KEY AUTOREPEAT UTF8AUTOCONVERT SINGLEINSTANCE/ ], },
  { name => 'Global Attributes - System Information', members => [ qw/SYSTEMLANGUAGE SYSTEM SYSTEMVERSION GTKVERSION GTKDEVVERSION MOTIFVERSION MOTIFNUMBER COMPUTERNAME USERNAME XSERVERVENDOR XVENDORRELEASE/ ], },
  { name => 'Global Attributes - Screen Information', members => [ qw/FULLSIZE SCREENSIZE SCREENDEPTH TRUECOLORCANVAS VIRTUALSCREEN MONITORSINFO/ ], },
  { name => 'Global Attributes - System Data', members => [ qw/HINSTANCE DLL_HINSTANCE APPSHELL XDISPLAY XSCREEN/ ], },
  { name => 'Global Attributes - Default Attributes', members => [ qw/DLGBGCOLOR DLGFGCOLOR MENUBGCOLOR MENUFGCOLOR TXTBGCOLOR TXTFGCOLOR DEFAULTFONT DEFAULTFONTSIZE/ ], },
];

my $data = {};
my $unprocessed = {};

sub procfile {
  my $podtt = shift;
  die "Non-existing file '$podtt'\n" unless -f $podtt;

  my $orig = read_file($podtt, {binmode=>1});
  die "Empty or wrong file '$podtt'\n" unless $orig;
  
  my $attribs = $orig;
  $attribs =~ s/^.*?=item B</=item B</s;
  $attribs =~ s/(\s*=back)?(\s*=cut)?\s*$/\n/s;
  $attribs =~ s/\s*=back\s*=head[12] [^\n]+\s*=over\s*/\n\n/sg;
  $attribs =~ s/\s*=back\s*=head[12] [^\n]+\s*=head[12] [^\n]+\s*=over\s*/\n\n/sg;

  my @a = split "\n=item B<", $attribs;
  for (@a) { $_ = "=item B<$_" unless /^=item B</ }
  for (@a) {
    if (/^=item B<(.*?)>/) {
      $data->{$1} = $_;
      $unprocessed->{$1} = 1;
    }
    else {
      die "Wrong item: '$_'\n";
    }
  }
  my @kg;
  my @kc;

  my $out_cdetail = "=head1 COMMON ATTRIBUTES\n\n";
  my $out_common = "=over\n\n";
  for my $c (@$common_cat) {
    my @kc = sort @{$c->{members}};
    $out_cdetail .= "=head2 $c->{name}\n\n=over\n";
    for my $m (@kc) {
      $out_cdetail .= "\n" . $data->{$m};
      delete $unprocessed->{$m};
      warn ">>$c->{name}>>$m\n";
    }
    $out_cdetail .= "\n=back\n\n";
    my @l = map { "L<$_|/\"$_\">" } @kc; 
    $out_common .= "=item * B<L<$c->{name}|/\"$c->{name}\">>\n\n";
    my $alist = join ", ", @l;
    $out_common .= "$alist\n\n";
  }
  $out_common .= "=back";
  
  my $out_gdetail = "=head1 GLOBAL ATTRIBUTES\n\n";
  my $out_global = "=over\n\n";
  for my $c (@$global_cat) {
    my @kg = sort @{$c->{members}};
    $out_gdetail .= "=head2 $c->{name}\n\n=over\n";
    for my $m (@kg) {
      $out_gdetail .= "\n" . $data->{$m};
      delete $unprocessed->{$m};
      warn ">>$c->{name}>>$m\n";
    }
    $out_gdetail .= "\n=back\n\n";
    my @l = map { "L<$_|/\"$_\">" } @kg; 
    $out_global .= "=item * B<L<$c->{name}|/\"$c->{name}\">>\n\n";
    my $alist = join ", ", @l;
    $out_global .= "$alist\n\n";
  }
  $out_global .= "=back"; 

  my $new = $orig;
  die "Cannot find marker '=for comment c_at_marker'\n" unless $new =~ /=for comment c_at_marker/;
  die "Cannot find marker '=for comment g_at_marker'\n" unless $new =~ /=for comment g_at_marker/;
  die "Cannot find marker '=for comment at_details'\n"  unless $new =~ /=for comment at_details/;
  
  $new =~ s|=for comment at_details.*$|=for comment at_details\n\n$out_cdetail$out_gdetail|s;  
  $new =~ s!=for comment c_at_marker.*?=(head|for)!=for comment c_at_marker\n\n$out_common\n\n=$1!s;
  $new =~ s!=for comment g_at_marker.*?=(head|for)!=for comment g_at_marker\n\n$out_global\n\n=$1!s;
  write_file("$podtt.autobak", {binmode=>1}, $orig);  
  write_file("$podtt", {binmode=>1}, $new);  
  
  die "Unprocessed attributes\n\n" . Dumper($unprocessed) if scalar(keys %$unprocessed)>0;
  return 1;
}

warn ">>>>[$0] Started!\n";
procfile($g_podtt) || warn "FAILURE during processing!\n";
warn ">>>>[$0] Finished!\n";

__END__

=head1 USAGE

proc-pod.tt2pod.pl [options]

 Options:
   -help            help message
   -podtt=<file>    path to IUP_Manual_Attributes.pod file (in fact 'tt' template)

=head1 DESCRIPTION

Recreates summary chapters in IUP_Manual_Attributes.pod according categories configured in this script.
