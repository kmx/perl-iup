use strict;
use warnings;

use Data::Dumper;
use Template;
use HTML::TreeBuilder;
use Pod::HTML2Pod;
use File::Path qw(make_path remove_tree);
use File::Slurp;
use File::Spec;
use File::Find;
use Pod::Simple::HTMLBatch;
use Encode;
use FindBin;
use Getopt::Long;

require "$FindBin::Bin/utils.pm";
die "Cannot require utils.pm\n" if $@;

# global variables
my $g_help    = 0;
my $g_iupdoc  = 'y:\IUP.Unpacked\cd-5.4.1';
my $g_podraw  = "$FindBin::Bin/xxpod.raw.cd5.4.1";
my $g_podtt   = "$FindBin::Bin/xxtmp.pod.cd.tt";
# processing commandline options
my $getopt_rv = GetOptions(
  'help|?' => \$g_help,
  'iupdoc=s' => \$g_iupdoc,
  'podraw=s' => \$g_podraw,
  'podtt=s' => \$g_podtt,
);
pod2usage(-exitstatus=>0, -verbose=>2) if $g_help || !$getopt_rv;

my %html_files;
	
sub procfile {
  my $f = shift;
  my ($vol,$directory,$file) = File::Spec->splitpath($f);
  my @d = grep {/^.+$/} File::Spec->splitdir($directory);
  my $dir = pop @d;
  my $name = $file;
  $name =~ s/^iup_/iup/;
  $name =~ s/^key\.html$/iupkey.html/;
  $name =~ s/^iup(.*?)\.html/'IUP::'.ucfirst($1)/e;
  $name =~ s/bar$/Bar/;
  $name =~ s/dlg$/Dlg/;
  $name =~ s/browser$/Browser/;
  $name =~ s/Glcanvas$/GLCanvas/;
  #$name =~ s/Ole$/OleControl/;
  $name =~ s/Pplot$/PPlot/;
  $name =~ s/^IUP::/IUP::Func::/ if $dir eq 'func';
  $name =~ s/^IUP::(.*)/'IUP::AT::'.uc($1)/e if $dir eq 'attrib';
  $name =~ s/^IUP::(.*)/'IUP::CB::'.uc($1)/e if $dir eq 'call';

  #warn "Found: $name - $dir - $file\n";
  $html_files{$name} = { file=>$f, dir=>$dir, html=>$f };

  die "Non-existing file '$f'" unless -f $f;
  my ($html_v, $html_d, $html_f) = File::Spec->splitpath($f);
  
  my $html = decode('utf-8',read_file($f));
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
   
  $name =~ s|::|_|g;
  $name = File::Spec->rel2abs("$g_podtt/$name.pod");
  my ($name_v, $name_d, $name_f) = File::Spec->splitpath($name);
  
  my $rawname = $f;
  $rawname = File::Spec->rel2abs($rawname);
  $rawname = File::Spec->abs2rel($rawname, "$g_iupdoc/html/en");
  $rawname = File::Spec->rel2abs("$g_podraw/$rawname");
  $rawname =~ s/\.html$/.pod/;
  my ($rawname_v, $rawname_d, $rawname_f) = File::Spec->splitpath($rawname);
  
  printf STDERR "[INFO] html:'% 33s' pod.tt:'% 33s'\n", $html_f, $name_f;

  # common replacements
  $pod =~ s/=cut.*$/=cut/sg;
  $pod =~ s/^=pod[\r\n\s]*E<iuml>E<rchevron>E<iquest>[\r\n\s]*=head/=head/sg;
  $pod =~ s/^B<([A-Z0-9]+) +> */B<$1> /g;
  $pod =~ s/ *B< > */ /g;
  $pod =~ s/[LBC]<:>/:/g;
  $pod =~ s/, L<\n/,\nL</sg;
  
  #warn " -> writting POD.RAW '$rawname' ...\n";  
  My::Utils::make_path_for_file($rawname);
  write_file($rawname, {binmode=>1}, encode('utf-8',$pod)); #save original
  
  # POD replacements here
  $pod =~ s|X<SeeAlso>||g;
  $pod =~ s|=head1 [Ii]up([a-zA-Z0-9_]*)|"[% h.name %]\n\n[% n.iup".lc($1)." %]\n\n[% h.desc %]"|eg;
  $pod =~ s|=head2 Creation|[% h.usage %]\n\n[% h.create %]|g;
  $pod =~ s|=head2 Callbacks|[% h.cb %]|g;
  $pod =~ s|=head2 Attributes|[% h.at %]|g;
  $pod =~ s|=head2 Notes|[% h.notes %]|g;
  $pod =~ s|=head2 Value|[% h.at_value %]xxx|g;
  $pod =~ s|=head2 Affects|[% h.at_affects %]|g;  
  $pod =~ s|=head2 Examples|[% h.examples %]|g;
  $pod =~ s|=head2 See Also|[% h.see %]|g;
  
  $pod =~ s/L<Iup([a-zA-Z0-9]+)\|.*?>/L<IUP§§$1|IUP§§$1>/g;
  $pod =~ s/Iup([a-zA-Z0-9]+)/IUP§§$1/g;
  $pod =~ s/B<(IUP§§.*?)>/L<$1|$1>/g;
  $pod =~ s/L<([A-Z0-9]+)\|iup_([a-z0-9]+)\.html>/'L<'.$1.'|[%m.at%]\/'.uc($2).'>'/eg; #if in attrib dir
  $pod =~ s/L<([A-Z0-9]+)\|..\/attrib\/iup_([a-z0-9]+)\.html>/'L<'.$1.'|[%m.at%]\/'.uc($2).'>'/eg;
  $pod =~ s/L<([A-Z0-9]+)\|..\/call\/iup_([a-z0-9]+)\.html>/'L<'.$1.'|[%m.cb%]\/'.uc($2).'>'/eg;
  $pod =~ s/\(since 3.0\)//g;
  if ($pod =~ /\[% h\.at %\](.*?)\[% h/s ) {
    my $c = $1;
    $c =~ s|\n([LB]<[^>]*>[^:]*):\s*|\n=item * $1\n\n|g;
    $pod =~ s|\[% h\.at %\](.*?)\[% h|[% h.at %]\n\n[%txt.at_intro%]\n\n=over$c=back\n\n[% h|sg;    
    $pod =~ s|=over\n\n----\n\n=back|=back\n\n[%txt.at_common%]\n\n=over|;
  }
  if ($pod =~ /\[% h\.cb %\](.*?)\[% h/s ) {
    my $c = $1;
    #die $c;
    $c =~ s|\n([LB]<[A-Z][^>]*>[^:]*):\s*|\n=back\n\n=item * $1\n\n|g;
    $c =~ s|^\n*=back\n||;
    $c =~ s|(\n( .*?\n)+)|$1\n=over\n|g;
    $c =~ s|\n([LB]<[^>]*>[^:]*):\s*|\n=item * $1 - |g;
    $pod =~ s|\[% h\.cb %\](.*?)\[% h|[% h.cb %]\n\n[%txt.cb_intro%]\n\n=over\n$c=back\n\n[% h|sg;    
    $pod =~ s|=over\n\n----\n\n=back\n\n=back|=back\n\n[%txt.cb_common%]\n\n=over|;
  }
  $pod =~ s/§§/::/g;
  
  #warn " -> writting POD.TT '$name_f'\n";
  My::Utils::make_path_for_file($name);
  write_file($name, {binmode=>1}, encode('utf-8',$pod));  
}

sub proc_at {
  my $file = shift;
  my $pod = read_file($file, {binmode=>1} );
  
  #xxxTODO
  $pod =~ s/=head1/=head3/g;
  $pod =~ s/=head2/=head4/g;
  $pod .= "\n\n";
  
  write_file("$g_podtt/IUP_AT.pod", {binmode=>1, append=>1}, $pod);
}

sub proc_cb {
  my $file = shift;
  my $pod = read_file($file, {binmode=>1} );
  
  #xxxTODO
  $pod =~ s/=head1/=head3/g;
  $pod =~ s/=head2/=head4/g;
  $pod .= "\n\n";
  
  write_file("$g_podtt/IUP_CB.pod", {binmode=>1, append=>1}, $pod);
}

sub proc_func {
  my $file = shift;  
  my $pod = read_file($file, {binmode=>1} );
  
  #xxxTODO
  $pod =~ s/=head1/=head3/g;
  $pod =~ s/=head2/=head4/g;
  $pod .= "\n\n";
  
  write_file("$g_podtt/IUP_Func.pod", {binmode=>1, append=>1}, $pod);
}

warn ">>>>[$0] Started!\n";

die "Non-existing iupdoc dir '$g_iupdoc'\n" unless -d $g_iupdoc;
die "Invalid iupdoc dir '$g_iupdoc'\n" unless -d "$g_iupdoc/html/en";

remove_tree($g_podraw) if -d $g_podraw;
remove_tree($g_podtt) if -d $g_podtt; 
make_path($g_podraw);
make_path($g_podtt);

die "Output dir error '$g_podtt'" unless -d $g_podtt;
die "Output dir error '$g_podraw'" unless -d $g_podraw;

warn ">>>>[$0] Processing HTML\n";
procfile($_)  for (My::Utils::find_file("$g_iupdoc/html/en", qr/\.html$/));
warn ">>>>[$0] Processing IUP_AT_*.pod\n";
proc_at($_)   for (My::Utils::find_file("$g_podtt", qr/IUP_AT_.*?\.pod$/));
warn ">>>>[$0] Processing IUP_CB_*.pod\n";
proc_cb($_)   for (My::Utils::find_file("$g_podtt", qr/IUP_CB_.*?\.pod$/));
warn ">>>>[$0] Processing IUP_Func_*.pod\n";
proc_func($_) for (My::Utils::find_file("$g_podtt", qr/IUP_Func_.*?\.pod$/));

warn ">>>>[$0] Finished!\n";

__END__

=head1 USAGE

proc-html2pod.tt.pl [options]

 Options:
   -help            help message
   -podtt=<dir>     directory for storing *.pod files (in fact 'tt' templates)
   -podraw=<dir>    directory for storing raw html2pod conversion outputs
   -iupdoc=<dir>    directory with IUP documentation (should conain 'html/en' subdir)

=head1 DESCRIPTION

Converts the original IUP documentation into *.pod files with TT marks (like '[% ... %]').
