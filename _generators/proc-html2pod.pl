use strict;
use warnings;
use Data::Dumper;
use Template;
use HTML::TreeBuilder;
use Pod::HTML2Pod;
use File::Path qw(make_path remove_tree);
use File::Slurp;
use File::Spec;
use Pod::Simple::HTMLBatch;
use Encode;

#my $docroot = 'y:\IUP3.3\doc\iup';
my $docroot = '/home/user/doc/iup';
my $rawroot = './pod.raw.v3.3';
my $podroot = './pod.tt';
my $htmlout = './pod.tt.html';

my $html_files;

my @l = ( glob("$docroot/html/en/dlg/*.html"),
          glob("$docroot/html/en/ctrl/*.html"),
	      glob("$docroot/html/en/elem/*.html"),
		  glob("$docroot/html/en/func/*.html"),
		  glob("$docroot/html/en/call/*.html"),
		  glob("$docroot/html/en/attrib/*.html"),
        );
for my $html (@l) {
  my ($vol,$dir,$file) = File::Spec->splitpath($html);
  my @d = grep {/^.+$/} File::Spec->splitdir($dir);
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
  warn "Found: $name - $dir - $file\n";
  $html_files->{$name} = { file=>$html, dir=>$dir, html=>$html };
}
		
#die "exitus\n";

foreach my $n (keys %$html_files) {
  my $f = $html_files->{$n}->{file};
  die "File $f not exists" unless -f $f;
  warn "Processing: $f\n";
  
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
  
  my $name = $n;
  $name =~ s|::|_|g;
  $name = "$podroot/$name.pod";
  $name =~ s|\\|/|g;
  my $dir = $name;
  $dir =~ s|[^/]*$||;
  make_path($dir);
  
  my $rawname = $n;
  $rawname =~ s|::|_|g;
  $rawname = "$rawroot/$rawname.pod.raw";
  $rawname =~ s|\\|/|g;  
  my $rawdir = $rawname;
  $rawdir =~ s|[^/]*$||;
  make_path($rawdir);

  my $rawpod = $pod;
  $rawpod =~ s/=cut.*/=cut/sg;
  write_file($rawname, encode('utf-8',$rawpod)); #save original
  
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
  
  write_file($name, encode('utf-8',$pod));
  
}


my $batchconv = Pod::Simple::HTMLBatch->new;
#$batchconv->some_option( some_value );
#$batchconv->some_other_option( some_other_value );
$batchconv->batch_convert($podroot, $htmlout);

