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
    create     => '=head2 CREATION - new() method',
    at         => '=head2 ATTRIBUTES',
    cb         => '=head2 CALLBACKS',
    func       => '=head2 METHODS',
    cb_func    => '=head1 xxxcbfunc',
    at_value   => '=head3 Value',
    at_notes   => '=head3 Notes',
    at_affects => '=head3 Affects',
    at_also    => '=head3 See Also',
    at_examples=> '=head3 Examples',
    at_win     => '=head3 Windows Subsystem',
    at_gtk     => '=head3 GTK2+ Subsystem',
    at_mot     => '=head3 Motif Subsystem',
  },
  n => {
    iupbutton => 'IUP::Button - [UI element] xxx',
    iuplabel  => 'IUP::Label - [UI element] xxx',
  },
  m => {
    man_intro => 'IUP::Manual::01_Introduction',
    man_at    => 'IUP::Manual::01_Attributes',
    man_cb    => 'IUP::Manual::01_Callbacks',    
  },
  txt => {
    at_intro => '',
    at_common => '',
    cb_intro => '',
    cb_common => '',
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
    $ttdata->{htmlinc}->{$n} = $content;
  }  
}

sub procfile {
  my $podtt = shift;
  my $rel = File::Spec->abs2rel($podtt, $g_podtt);
  my $pod = File::Spec->rel2abs(File::Spec->catfile($g_pod, $rel));    
  
  warn "[INFO] input='$podtt'\n";
  my $pod_orig = -f $pod ? read_file($pod) : 'EMPTY: random content='.rand(999);  
  my $pod_new;  
  my $tt = Template->new(ABSOLUTE=>1);  
  $tt->process($podtt, $ttdata, \$pod_new) || die $tt->error(), "\n";  
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
