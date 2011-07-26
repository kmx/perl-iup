use strict;
use warnings;


use FindBin;
use File::Basename;
use File::Slurp;
use File::Glob 'bsd_glob';
use Data::Dump 'pp';
use Data::Dumper;

sub get_const_pod_section {
  my @t = (
    { tag=>'basic', width=>17, perline=>6, head=>"Export tag ':basic'", txt=>"" },
    { tag=>'cd', width=>23, perline=>5, head=>"Export tag ':cd'", txt=>"" },
    { tag=>'keys', width=>17, perline=>6, head=>"Export tag ':keys'", txt=>"" },
  );
  my $pm = "$FindBin::Bin/../lib/IUP/Constants.pm";
  my $retval = '';

  die "Fatal: file '$pm' does not exist!\n" unless $pm;
  require $pm;

  for (@t) {
    my $tag = $_->{tag};
    my $width = $_->{width};
    my $perline = $_->{perline};
    my $counter = 1;
    my $neednewline = 1;
    $retval .= "=head2 $_->{head}\n";
    
    my @data;
    my @src = @{$IUP::Constants::EXPORT_TAGS{$_->{tag}}};
    
    ###@src = qw/A B C D E F G H I J/;
    ###$perline = 3;

    my $count = scalar(@src);
    my $realcount;
    my $rows_realnum = $count/$perline - 0.001;
    my $rows = (1+int($rows_realnum));
    
    warn "count=$count rows=$rows perline=$perline\n";
    my ($i, $j);
    for $j (0..($rows-1)) {              
      for $i (0..($perline-1)) {
        my $next = $j+$i*$rows;
        push @data, ($src[$next] || '');
        $realcount++ if defined $src[$next];	
      }
    }
    warn "count=$count realcount=$realcount\n";
    die "FATAL" if $count != $realcount;        
    
    for my $l (@data) {
      my $spaces = 1 < $width-length($l) ? $width-length($l) : 1;
      $retval .= "\n " if $neednewline; 
      $retval .= $l.(' ' x $spaces);
      $neednewline = ($counter%$perline) == 0;
      $counter++;
    }
    $retval .= "\n\n";
  }
  return $retval;
}

print get_const_pod_section;




