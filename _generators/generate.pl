use strict;
use warnings;

use File::Slurp 'slurp';
use Template;
use Data::Dumper;
use Getopt::Long;
use Pod::Usage;
use FindBin;

# processing commandline options
my $g_help    = 0;
my $g_dst     = '.';
my $getopt_rv = GetOptions(
  'help|?'   => \$g_help,
  'dst=s'    => \$g_dst,
);
pod2usage(-exitstatus=>0, -verbose=>2) if $g_help || !$getopt_rv;

my $cb_csv = $FindBin::Bin.'/Callback.csv';
my $ky_csv = $FindBin::Bin.'/Key.csv';

my $pfunc_default = '_execute_cb';
my $pfunc_table = {
  internal_cb_DROPSELECT_CB_iinsii => '_execute_cb_ih3',  #Ihandle* ih,int lin,int col,Ihandle* drop,char* t,int i,int v
  internal_cb_DROP_CB_nii          => '_execute_cb_ih1',  #Ihandle* ih,Ihandle* drop,int lin,int col
  internal_cb_TABCHANGE_CB_nn      => '_execute_cb_ih12', #Ihandle* ih,Ihandle* new_tab,Ihandle* old_tab
  internal_cb_DRAW_CB_iiiiiiv      => '_execute_cb_cnv7', #Ihandle* ih,int line,int column,int xmin,int xmax,int ymin,int ymax,cdCanvas* canvas
  internal_cb_POSTDRAW_CB_v        => '_execute_cb_cnv1', #Ihandle* ih,cdCanvas* cnv
  internal_cb_PREDRAW_CB_v         => '_execute_cb_cnv1', #Ihandle* ih,cdCanvas* cnv
};

sub file2hash {
  my $fname = shift;
  my $rv;
  
  die "File '$fname' does not exist!\n" unless -f $fname;
  my ($head, @lines) = slurp($fname);
  chomp ($head);
  chomp (@lines);  
  my @cols = split(';', $head);
  s/^#//g for (@cols);
  for (@lines) {
    next if /^#/;
    my @items = split(';', $_);
    $rv->{$items[0]}->{$items[1]}->{valid} = 1;
    for(my $i=2; $i < scalar(@cols); $i++) {
      $rv->{$items[0]}->{$items[1]}->{$cols[$i]} = $items[$i];
    }
  }
  return $rv;
}

my %type2params = (
  'ccc'  => 'char a,char b,char c',
  ''     => '',
);

sub cb_generate1 {
  my $h = shift;
  for my $m (keys %$h) {
    warn "[info] Processing '$m'\n";
    for my $a (keys %{$h->{$m}}) {  
      my $if = "internal_cb_$a\_$h->{$m}->{$a}->{type}";      
      $h->{$m}->{$a}->{xs_internal_cb} = $if;

      #avoid using variable names: count
      if ($h->{$m}->{$a}->{c_params} =~ /count/) {
        warn "[info] before: $h->{$m}->{$a}->{c_params}\n";
        $h->{$m}->{$a}->{c_params} =~ s/([\s,])count([\s,])/$1count_$2/;
        warn "[info] after : $h->{$m}->{$a}->{c_params}\n";
      }
      
      $h->{$m}->{$a}->{xs_internal_cb_params} = "($h->{$m}->{$a}->{c_params})";
      $h->{$m}->{$a}->{xs_internal_cb_pfunc} = $pfunc_table->{$if} || $pfunc_default;
      
      my @l_rvname;
      my $c_retval = $h->{$m}->{$a}->{c_retval};
      if ($c_retval eq 'int') {
        $h->{$m}->{$a}->{xs_declare_sv_rv} = 'SV * SV_rv';
        $h->{$m}->{$a}->{xs_internal_cb_pop} = 'POPi';
        $h->{$m}->{$a}->{xs_internal_default_rv} = 'IUP_DEFAULT';
        push @l_rvname, '$rv_num';
      }
      elsif ($c_retval eq 'char*') {
        $h->{$m}->{$a}->{xs_internal_cb_pop} = 'POPpx';
        $h->{$m}->{$a}->{xs_internal_default_rv} = 'NULL';
        push @l_rvname, '$rv_string';
      }
      else {
        warn "###WARNING### This should not happen m=$m a=$a c_retval=$c_retval (assuming retval='int')";
        $c_retval = 'int';
        $h->{$m}->{$a}->{xs_internal_cb_pop} = 'POPi';
        $h->{$m}->{$a}->{xs_internal_default_rv} = '0';
        push @l_rvname, '$rv_num';
      }      

      if ($h->{$m}->{$a}->{c_params} eq '#') {
        warn "###WARNING### This should not happen m=$m a=$a c_params=#";
        my $t = $h->{$m}->{$a}->{type};
        my $p = 'Ihandle* ih';
        if (defined $type2params{$t}) {
          $p .= ",$type2params{$t}";
        }
        else {
          warn "###WARNING### No hint in type2params for '$t'" unless $type2params{$t};          
        }
        $h->{$m}->{$a}->{c_params} = $p;
        warn "###WARNING### assuming params='$p'";        
      }
      
      my $pf = "_init_cb_$a\_$h->{$m}->{$a}->{type}";      
      my $pf_a = $a;

      my @l_name = ( '$self' );      
      
      $h->{$m}->{$a}->{xs_internal_action_push} = "XPUSHs(sv_2mortal(newSVpvn(\"$a\", ".length($a).")));";      
      $h->{$m}->{$a}->{xs_internal_action_key} = "!int!cb!$a!func";
      my @l_xspush = ();
      my @l_xspop = ();
      my @l_xslocvar = ();
      my $rv_count = 1;
      my @fp = split(',', $h->{$m}->{$a}->{c_params});
      die "###FATAL### invalid value '$fp[0]'" if $fp[0] ne 'Ihandle* ih';      
      my $tp_all_in_one = $h->{$m}->{$a}->{type};
      my @tp = split('', $tp_all_in_one);
      unless (scalar(@tp)+1==scalar(@fp)) {
        warn "###WARNING### [$m|$a] mismatch: '$h->{$m}->{$a}->{type}' vs. '$h->{$m}->{$a}->{c_params}'";
        warn "###WARNING### tp=", Dumper(\@tp);
        warn "###WARNING### fp=", Dumper(\@fp);
      }
      my $MULTITOUCH_CB_marker;
      for(my $i=1; $i<scalar(@fp); $i++) {
        my $n = 'xxx';
        if ($fp[$i] =~ /^.*?([^ ]*)$/) {
          $n = $1;          
        }
        else {
          die "this should not happen";
        }        
        if ($tp[$i-1] =~ /^(i|c)$/) {
          push @l_name, "\$$n";
          push @l_xspush, "XPUSHs(sv_2mortal(newSViv($n)));";
        }
        elsif ($tp[$i-1] =~ /^(n)$/) {
          push @l_name, "\$$n";
          push @l_xspush, "XPUSHs(ihandle2SV($n, element, \"!int!cb!$a!related\"));";
        }
        elsif ($tp[$i-1] =~ /^(v)$/) {
          push @l_name, "\$$n";
          push @l_xspush, "XPUSHs(canvas2SV($n, element, \"!int!cb!$a!related\"));";
        }
        elsif ($tp[$i-1] =~ /^(I)$/) {
          push @l_xspop, "*$n = POPi;"; # xxxTODO needs testing + pod update
          $rv_count++;
          push @l_rvname, "\$$n";
        }
        elsif ($tp[$i-1] =~ /^(F)$/) {
          push @l_xspop, "*$n = POPn;"; # xxxTODO needs testing + pod update
          $rv_count++;
          push @l_rvname, "\$$n";
        }
        elsif ($tp[$i-1] =~ /^(A)$/ && $tp_all_in_one eq 'Ai') {
          # hack for MULTISELECTION_CB MULTIUNSELECTION_CB
          push @l_name, "\@$n\_list";          
          push @l_xslocvar, "int loc_i;";
          push @l_xslocvar, "AV * r_$n;";
          push @l_xspush, "r_$n = newAV();";
          push @l_xspush, "for(loc_i=0; loc_i<n; loc_i++) av_push(r_$n, newSViv($n\[loc_i]));";
          push @l_xspush, "XPUSHs(sv_2mortal(newRV_noinc((SV *)r_$n)));"; #XXX-CHECKLATER-not-sure-about-this
        }
        elsif ($tp[$i-1] =~ /^(A)$/ && $tp_all_in_one eq 'iAAAA') {
          # hack for MULTITOUCH_CB
          push @l_name, "\@$n\_list";
          push @l_xslocvar, "int loc_i;" unless $MULTITOUCH_CB_marker;
          push @l_xslocvar, "AV * r_$n;";
          push @l_xspush, "r_$n = newAV();";
          push @l_xspush, "r_$n = (AV *)sv_2mortal((SV *)newAV());";
          push @l_xspush, "for(loc_i=0; loc_i<count_; loc_i++) av_push(r_$n, newSViv($n\[loc_i]));";
          push @l_xspush, "XPUSHs(sv_2mortal(newRV_noinc((SV *)r_$n)));"; #XXX-CHECKLATER-not-sure-about-this
          $MULTITOUCH_CB_marker = 1;
        }        
        elsif ($tp[$i-1] =~ /^(A)$/) {
          warn "###FATAL: do not know how to handle '$tp_all_in_one'\n";
        }
        elsif ($tp[$i-1] =~ /^(U)$/ && $tp_all_in_one eq 'U') {
          # hack for NODEREMOVED_CB
          $h->{$m}->{$a}->{xs_spec_NODEREMOVED_CB} = 1;
          last;
        }
        elsif ($tp[$i-1] =~ /^(f|d)$/) {
          push @l_name, "\$$n";
          push @l_xspush, "XPUSHs(sv_2mortal(newSVnv($n)));";
        }
        elsif ($tp[$i-1] =~ /^(s)$/) {
          push @l_name, "\$$n";
          push @l_xspush, "XPUSHs(sv_2mortal(newSVpv($n, 0)));";
        }
        elsif ($tp[$i-1] =~ /^(S)$/) {
          warn "###ERROR THIS-IS-BROKEN\n";
          push @l_xslocvar, "SV * SV_$n;";
          push @l_xspop, "*$n = (SvOK(SV_$n)) ? SvPV_nolen(SV_$n) : NULL; /* XXX-not-sure-about-NULL */;";
                push @l_xspop, "*SV_$n = POPs;";
          $rv_count++;
          push @l_rvname, "\$$n";
        }
        else {
          warn "###WARNING### [$m|$a] mismatch: '$h->{$m}->{$a}->{type}' vs. '$h->{$m}->{$a}->{c_params}'";
        }
      }
      
      #die Dumper(\@l);
      @l_xspop = reverse @l_xspop; # return params are on stack in reverse order
      $h->{$m}->{$a}->{xs_internal_cb_extrapop} = \@l_xspop;
      $h->{$m}->{$a}->{xs_internal_cb_push} = \@l_xspush;      
      $h->{$m}->{$a}->{xs_internal_cb_locvar} = \@l_xslocvar;
      $h->{$m}->{$a}->{xs_init_cb} = $pf;
      $h->{$m}->{$a}->{xs_init_cb_action} = $pf_a;
      if($rv_count == 1) {
        $h->{$m}->{$a}->{xs_internal_cb_rvcheck} = "if (count != 1) { /* no warning, use default retval */ }";
      }
      else {
        $h->{$m}->{$a}->{xs_internal_cb_rvcheck} = "if (count != $rv_count) { warn(\"Warning: callback $a has returned %d instead of $rv_count values!\\n\",count); }";
      }
            
      $h->{$m}->{$a}->{pod_sample_params} = '(' . join(', ', @l_name) . ')';
      if(scalar(@l_rvname)>2) {
        $h->{$m}->{$a}->{pod_sample_rv} = '(' . join(', ', @l_rvname) . ')';
      }
      else {
        $h->{$m}->{$a}->{pod_sample_rv} = $l_rvname[0];
      }
      
      #print "DONE: " . Dumper($h->{$m}->{$a});
    }
  }
}

sub cb_hash2xsitems {
  my $h = shift;
  my @rv;
  my %seen;
  
  foreach my $m (sort keys %$h) {
    for my $a (sort keys %{$h->{$m}}) {  
      push @rv, $h->{$m}->{$a} unless $seen{"$h->{$m}->{$a}->{xs_init_cb}"};
      $seen{"$h->{$m}->{$a}->{xs_init_cb}"} = 1;
    }
  }
  return \@rv;
}

sub cb_hash2pmitems {
  my $h = shift;
  my @rv;
  foreach my $m (sort keys %$h) {
    my @a;
    for my $a (sort keys %{$h->{$m}}) {  
      push @a, { action=>$a, xs_init_cb=>$h->{$m}->{$a}->{xs_init_cb} };
    }
#warn ">>>processing $m $a ".Dumper(\@a);
    push @rv, { module=>$m, actions=>\@a };
  }
  return \@rv;
}

warn ">>>>[$0] Started!\n";

my $tt = Template->new(ABSOLUTE=>1);
my $cb_h = file2hash($cb_csv);

# remove unsopported items
delete $cb_h->{'IUP::WebBrowser'};
delete $cb_h->{'IUP::TuioClient'};

#### CALLBACKS
cb_generate1($cb_h);
my $cb_data1 = {
  xsitems => cb_hash2xsitems($cb_h),
  pmitems => cb_hash2pmitems($cb_h),
};
#die Dumper($cb_data1);
$tt->process($FindBin::Bin.'/Callback_xs.tt', $cb_data1, $g_dst.'/Callback.xs') || die $tt->error();
$tt->process($FindBin::Bin.'/Callback_pm.tt', $cb_data1, $g_dst.'/Callback.pm') || die $tt->error();

warn ">>>>[$0] Finished!\n";

__END__

=head1 USAGE

generate.pl [options]

 Options:
   -help       help message
   -dst=<dir>  directory for storing generated filer (default: '.')

=head1 DESCRIPTION

 Creates: Callback.pm  from Callback_pm.tt
          Callback.xs  from Callback_xs.tt
