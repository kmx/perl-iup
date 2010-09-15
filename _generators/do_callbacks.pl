use strict;
use warnings;

use File::Slurp 'slurp';
use Template;
use Data::Dumper;

my $cb_csv = 'Callback.csv';

my $pfunc_default = '_execute_cb';
my $pfunc_table = {
  internal_cb_DRAW_CB_iiiiiiv => '_execute_cb_cnv7',
  internal_cb_POSTDRAW_CB_v   => '_execute_cb_cnv1',
  internal_cb_PREDRAW_CB_v    => '_execute_cb_cnv1',
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
    my @items = split(';', $_);
    for(my $i=2; $i < scalar(@cols); $i++) {
      $rv->{$items[0]}->{$items[1]}->{$cols[$i]} = $items[$i];
    }
  }
  return $rv;
}

sub generate1 {
  my $h = shift;
  for my $m (keys %$h) {
    for my $a (keys %{$h->{$m}}) {  
      my $if = "internal_cb_$a\_$h->{$m}->{$a}->{type}";      
      $h->{$m}->{$a}->{xs_internal_cb} = $if;
      $h->{$m}->{$a}->{xs_internal_cb_params} = "($h->{$m}->{$a}->{c_params})";
      $h->{$m}->{$a}->{xs_internal_cb_pfunc} = $pfunc_table->{$if} || $pfunc_default;
      
      my @l_rvname;
      my $c_retval = $h->{$m}->{$a}->{c_retval};
      if ($c_retval eq 'int') {
        $h->{$m}->{$a}->{xs_internal_cb_pop} = 'POPi';
	push @l_rvname, '$rv_num';
      }
      elsif ($c_retval eq 'char*') {
        $h->{$m}->{$a}->{xs_internal_cb_pop} = 'POPpx';
	push @l_rvname, '$rv_string';
      }
      else {
        die "this should not happen";
      }      

      my $pf = "_init_cb_$a\_$h->{$m}->{$a}->{type}";      

      my @l_name = ( '$self' );      
      
      my @l_xspush = ( "XPUSHs(sv_2mortal(newSVpvn(\"$a\", ".length($a).")));" );
      my @l_xspop = ();
      my @l_xslocvar = ();
      my $rv_count = 1;
      my @fp = split(',', $h->{$m}->{$a}->{c_params});
      die "invalid value '$fp[0]'" if $fp[0] ne 'Ihandle* ih';      
      my @tp = split('', $h->{$m}->{$a}->{type});
      die "[$m.$a] mismatch: '$h->{$m}->{$a}->{type}' vs. '$h->{$m}->{$a}->{c_params}'" unless scalar(@tp)+1==scalar(@fp);
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
	elsif ($tp[$i-1] =~ /^(n|v)$/) {
	  push @l_name, "\$$n";
	  push @l_xspush, "XPUSHs(sv_2mortal(newSViv(PTR2IV($n))));";
	}
	elsif ($tp[$i-1] =~ /^(I)$/) {
	  push @l_xspop, "*$n = POPi;"; # xxx TODO needs testing + pod update
	  $rv_count++;
	  push @l_rvname, "\$$n";
	}
	elsif ($tp[$i-1] =~ /^(F)$/) {
	  push @l_xspop, "*$n = POPn;"; # xxx TODO needs testing + pod update
	  $rv_count++;
	  push @l_rvname, "\$$n";
	}
	elsif ($tp[$i-1] =~ /^(A)$/) {  # xxx TODO needs testing + pod update
	  push @l_name, "\@$n\_list";
	  # xxx hack for MULTISELECTION_CB MULTIUNSELECTION_CB - do not use 'A' for anything else
	  push @l_xspush, "for(loc_i=0; loc_i++; loc_i<n) XPUSHs(sv_2mortal(newSViv(ids[loc_i])));";
	  push @l_xslocvar, "int loc_i;";
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
	else {
	  die "[$m.$a] error: '$h->{$m}->{$a}->{type}' vs. '$h->{$m}->{$a}->{c_params}'";
	}
      }
      
      #die Dumper(\@l);
      $h->{$m}->{$a}->{xs_init_cb} = $pf;
      $h->{$m}->{$a}->{xs_internal_cb_push} = \@l_xspush;
      $h->{$m}->{$a}->{xs_internal_cb_extrapop} = \@l_xspop;
      $h->{$m}->{$a}->{xs_internal_cb_locvar} = \@l_xslocvar;
      if($rv_count == 1) {
        $h->{$m}->{$a}->{xs_internal_cb_rvcheck} = "if (count != 1) croak(\"Error: _execute_cb($a) has not returned single scalar value!\\n\");";
      }
      else {
        $h->{$m}->{$a}->{xs_internal_cb_rvcheck} = "if (count != $rv_count) croak(\"Error: _execute_cb($a) has not returned $rv_count values!\\n\");";
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

sub hash2xsitems {
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

sub hash2pmitems {
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


my $h = file2hash($cb_csv);
generate1($h);
my $data1 = {
  xsitems => hash2xsitems($h),
  pmitems => hash2pmitems($h),
};

#die Dumper($data1);
my $tt = Template->new();
$tt->process('Callback_xs.tt', $data1, 'Callback.xs') || die $tt->error();
$tt->process('Callback_pm.tt', $data1, 'Callback.pm') || die $tt->error();
