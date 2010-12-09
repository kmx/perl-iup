use strict;
use warnings;
use Data::Dumper;
use Template;

my $srcroot = 'y:/IUP3.3';

sub proc_headers {
  my ($headers, $template, $outxs) = @_; 
  my $allinone = {};
  my @allfnc;

  for my $h (@$headers) {
    open DAT, "<", $h;
    while (<DAT>) {
      s/[\r\n]*$//;
      next if /^typedef/;
      
      if ( /^([a-zA-Z].*)((Iup|cd|im|wd)[^ \(]*) *\((.*?)\)/) {
      #die "1=$1 2=$2 3=$3 4=$4\n";
        my ($r, $f) = ($1, $2);
        my $o = $_;
        my @pars = split ',', $4;
        s/^ *// for @pars;
        s/ *$// for @pars;

        $o =~ s|/\*.*?\*/||g;
        $o =~ s/  */ /g;
        $r =~ s/^ *//;
        $r =~ s/ *$//;
        $r =~ s/ \*/\*/g;

        my $skip = 0;
        my @p;
        my @pn1;
        my @pn2;
        for (@pars) {
          if (/^(.*?)([a-zA-Z0-9_]*)$/) {
            my ($n, $t) = ($2, $1);
	    $t =~ s/^ *//;
            $t =~ s/ *$//;
            $t =~ s/ \*/\*/g;
            if ($t eq '') {
	      if ($n ne 'void') {
	        print STDERR "WARNING: error processing '$o'\n" if $n ne 'void';
	      }
	      else {
	        $t = '';
	        $n = '';
	      }
	    }
	
	    if($n eq '' && $t eq '...') {
	      $n = '...';
	      $t = '';
	    }
	  
            if ($t =~ /\*\*/) {
              print STDERR "WARNING: do not know how to handle '$o'\n";
	      $skip = 1;
	    }
	  
	    if ($n ne '' || $t ne '') {
	      push(@pn1, $n);
	
	      if ($t eq 'int*') {
	        print STDERR "WARNING: fixing 'int*' - '$o'\n";
  	        $t = 'int';
                $n = "&$n";
	      }
	
	      push(@pn2, $n) unless $n eq '...';
              push(@p, { orig => $_, name => $n, type => $t}) unless $n eq '...';
	      #print STDERR "DEBUG: >$n<\t\t>$t<\t\t$_\n";
	    }
          }
        }

        unless ($skip) {
          #print "DUMP:$f\n";
	  my $hh = '...'.substr($h, length($srcroot));
	  my $cdf = $f;
	  my @cdp = @p;
	  my @cdpn2 = @pn2;
	  if(defined $cdp[0] && $cdp[0]->{name} eq 'canvas' && $cdp[0]->{type} eq 'cdCanvas*') {
	    $cdp[0]->{type} = 'SV*';
	    $cdpn2[0] = 'ref2cnv('.$cdpn2[0].')';
	  }
          $cdf =~ s/cdfCanvas/cdf/;
          $cdf =~ s/cdCanvas/cd/;
          push(@allfnc, { orig => $o, header => $hh, rvtype => $r, fnc => $f, cdfnc => $cdf,
	                  params => \@p, cdparams => \@cdp, 
			  params_n1 => join(',',@pn1), 
			  params_n2 => join(',',@pn2),
			  cdparams_n2 => join(',',@cdpn2) } );
        }
      }
    }
  }
  
  foreach (@allfnc) {
    print STDERR "PROC_HEADER: processing '" . lc($_->{fnc}) . "'\n";
    $allinone->{lc($_->{fnc})}->{orig} = $_->{orig};
    $allinone->{lc($_->{fnc})}->{header} = $_->{header};
    $allinone->{lc($_->{fnc})}->{rvtype} = $_->{rvtype};
    $allinone->{lc($_->{fnc})}->{fnc} = $_->{fnc};
    $allinone->{lc($_->{cdfnc})}->{cdfnc} = $_->{cdfnc};
    $allinone->{lc($_->{fnc})}->{params} = $_->{params};
    $allinone->{lc($_->{fnc})}->{cdparams} = $_->{cdparams};
    $allinone->{lc($_->{fnc})}->{params_n1} = $_->{params_n1};
    $allinone->{lc($_->{fnc})}->{params_n2} = $_->{params_n2};
  }

  my $data = { allfnc => \@allfnc };
  my $tt = Template->new();
  $tt->process($template, $data, $outxs);
}

sub print_raw_data {
  my $allinone = shift;
  #Dump RawData
  foreach my $k (keys %{$allinone}) {
    print "###\t",
    $allinone->{$k}->{doc_html} || '?', "\t", 
    $allinone->{$k}->{doc_name} || '?', "\t", 
    $allinone->{$k}->{doc_file} || '?', "\t", 

    $allinone->{$k}->{nick} || '?', "\t", 
    $allinone->{$k}->{funcname} || '?', "\t", 
    $allinone->{$k}->{creation} || '?', "\t", 
    $allinone->{$k}->{parent} || '?', "\t", 
    $allinone->{$k}->{doctype} || '?', "\t", 
 
    $allinone->{$k}->{orig} || '?', "\t", 
    $allinone->{$k}->{header} || '?', "\t", 
    $allinone->{$k}->{rvtype} || '?', "\t", 
    $allinone->{$k}->{fnc} || '?', "\t", 
    $allinone->{$k}->{params} || '?', "\t", 
    $allinone->{$k}->{params_n1} || '?', "\t", 
    $allinone->{$k}->{params_n2} || '?', "\t", 
    "\n";
 }  
}

sub proc_lua {
  my $allinone = shift;
  my $doctype = {
    dialog => 'Primitives',
    label => 'Primitives',
    button => 'Primitives',
    text => 'Primitives',
    multiline => 'Primitives',
    list => 'Primitives',
    toggle => 'Primitives',
    canvas => 'Primitives',
    frame => 'Primitives',
    image => 'Primitives',
    
    hbox => 'Composition',
    vbox => 'Composition',
    zbox => 'Composition',
    fill =>'Composition',

    radio => 'Grouping',

    menu => 'Menu',
    submenu => 'Menu',
    item => 'Menu',
    separator => 'Menu',

    dial => 'Additional',
    gauge => 'Additional', 
    matrix => 'Additional',
    tabs => 'Additional',
    valuator => 'Additional',
    glcanvas => 'Additional',
    colorchooser => 'Additional',
    colorbrowser => 'Additional',
    fileselection => 'Dialogs',
    message => 'Dialogs',
    alarm => 'Dialogs',
    datainput => 'Dialogs',
    listselection => 'Dialogs',
  };

  my @lua_all = glob("$srcroot/srclua5/*.lua");

  for my $l (@lua_all) {
    open DAT, "<", $l;
    my ($nick, $funcname, $creation, $parent) = ('', '', '', '');
    #print STDERR "####################šLUA=$l\n";
    while (<DAT>) {
      s/[\r\n]*$//;
      
      if ( /creation *= *"(.*)"/ ) {
        $creation = $1;
        #print "creation=$1 '$_'\n";
      }
      
      if ( /nick *= *"(.*)"/ ) {
        $nick = $1;
        #print STDERR "nick=$1\n";
      }
      
      if ( /funcname *= *"(.*)"/ ) {
        $funcname = $1;
        #print STDERR "funcname=$1\n";
      }
      
      if ( /parent *= *iup\.([a-zA-Z0-9]*)/ ) {
        $parent = $1;
        #print STDERR "parent=$1\n";
      }    
    }

    print STDERR "PROC_LUA: processing '" . lc("iup$nick") . "'\n";
    $allinone->{lc("iup$nick")}->{nick} = $nick;
    $allinone->{lc("iup$nick")}->{funcname} = $funcname;
    $allinone->{lc("iup$nick")}->{creation} = $creation;
    $allinone->{lc("iup$nick")}->{parent} = $parent;
    $allinone->{lc("iup$nick")}->{doctype} = $doctype->{$nick};
  }
}

sub proc_doc {
  my $allinone = shift;
  #for my $l (qw/LIST_attrib.txt LIST_call.txt LIST_ctrl.txt LIST_dlg.txt LIST_elem.txt LIST_func.txt/) {
  for my $l (qw/LIST_ctrl.txt LIST_dlg.txt LIST_elem.txt/) {
    open DAT, "<", $l;
    while (<DAT>) {
      s/[\r\n]*$//;
      
      if ( /^(.*?\.html):(.*)$/ ) {
        print STDERR "PROC_DOC: processing '" . lc($2) . "'\n";
	$allinone->{lc($2)}->{doc_html} = $1;  
	$allinone->{lc($2)}->{doc_name} = $2;  
	$allinone->{lc($2)}->{doc_file} = $l;  
      }      
    }
  }
}

my $h = [
  "$srcroot/iup/include/iup.h",
  "$srcroot/iup/include/iupcontrols.h",
  "$srcroot/iup/include/iupole.h",
  "$srcroot/iup/include/iup_pplot.h",
  "$srcroot/iup/include/iupgl.h",
  "$srcroot/iup/include/iupim.h",
  "$srcroot/iup/include/iuptuio.h",
  "$srcroot/iup/include/iupweb.h",
  "$srcroot/cd/include/cd.h",
  "$srcroot/im/include/im.h",
];
proc_headers($h, 'Internal.tt', 'Internal.xs');

proc_headers( ["$srcroot/cd/include/cd.h"], 'Canvas.tt', 'Canvas.xs');
proc_headers( ["$srcroot/cd/include/wd.h"], 'Canvas.tt', 'WDCanvas.xs');

#cd
#cdContextRegisterCallback