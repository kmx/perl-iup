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
my $g_html    = "$FindBin::Bin/tmp.pod.cpan.html";
my $g_pod     = "$FindBin::Bin/tmp.pod";
# processing commandline options
my $getopt_rv = GetOptions(
  'help|?' => \$g_help,
  'pod=s' => \$g_pod,
  'html=s' => \$g_html,
);
pod2usage(-exitstatus=>0, -verbose=>2) if $g_help || !$getopt_rv;

my %html_all = map {$_=>1} My::Utils::find_file($g_html, qr/\.html$/);

sub procfile {
  my $pod = shift;
  my $rel = File::Spec->abs2rel($pod, $g_pod);
  my $html = File::Spec->rel2abs(File::Spec->catfile($g_html, $rel));    
  $html =~ s/\.pod$/\.html/;
  
  warn "[info] input='$pod'\n";
  my $html_orig = -f $html ? read_file($html) : 'EMPTY: random content='.rand(999);  
  my $html_new;  
  my $p = My::Pod::Simple::HTML->new();
  $p->output_string(\$html_new);
  $p->set_source($pod);  
  $p->run;
  $html_new = encode('utf-8', $html_new);
  $html_new =~ s|<style type="text/css">|</title><style type="text/css">|;
  if (sha1_hex($html_orig) ne sha1_hex($html_new)) {
    warn " -> orig=", sha1_hex($html_orig), "\n" unless $html_orig =~ /^EMPTY/;
    warn " -> new =", sha1_hex($html_new), "\n";
    warn " -> writting: '$pod'\n";
    My::Utils::make_path_for_file($html);
    write_file($html, $html_new);
  }
  delete $html_all{$html};
}

warn ">>>>[$0] Started!\n";
procfile($_) for (My::Utils::find_file($g_pod, qr/\.pod$/));
for (keys(%html_all)) {
  warn "[WARN] Unexpected extra html file: '$_' (GONNA DELETE!!!!)\n";
  unlink $_;
}
warn ">>>>[$0] Finished!\n";

__END__

=head1 USAGE

proc-pod2cpan.html.pl [options]

 Options:
   -help            help message
   -pod=<dir>       directory with *.pod files for conversion
   -html=<dir>      directory for storing output *.html files

=head1 DESCRIPTION

Converts *.pod files into HTML using CPAN's style sheet.
