#!/usr/bin/env perl

package IUP::Matrix;
use strict;
use warnings;
use base 'IUP::Internal::Element';
use IUP::Internal::LibraryIUP;

sub _create_element {
  my($self, $args) = @_;
  my $ih = IUP::Internal::LibraryIUP::_IupMatrix(undef); # xxx TODO fix '0'
  return $ih;
}

#in lua:
#elem["bgcolor"..l..":"..c] = v
#   or
#elem["bgcolor30:10"] = v

# xxx TODO

sub MatSetAttribute {
  #void  IupMatSetAttribute(Ihandle* ih, const char* name, int lin, int col, const char* value);
  #void  IupMatSetfAttribute(Ihandle* ih, const char* name, int lin, int col, const char* format, ...);
}

sub MatStoreAttribute {
  #void  IupMatStoreAttribute(Ihandle* ih, const char* name, int lin, int col, const char* value);
}

sub MatGetAttribute {
  #char* IupMatGetAttribute(Ihandle* ih, const char* name, int lin, int col);
}

sub MatGetInt {
  #int   IupMatGetInt(Ihandle* ih, const char* name, int lin, int col);
}

sub MatGetFloat {
  #float IupMatGetFloat(Ihandle* ih, const char* name, int lin, int col);
}

# xxx maybe
sub Cell { } # see lua: mat:setcell(3,0,"Energy")
sub CellBGCOLOR { }
sub CellFGCOLOR { }
sub CellFONT { }
sub CellFRAMEVERTCOLOR { }
sub CellFRAMEHORIZCOLOR { }
sub CellMARK { }
sub CellMASK { }

sub ColALIGNMENT { }
sub ColSORTSIGN { }
sub ColRASTERWIDTH { }
sub ColWIDTH { }

sub LinHEIGHT { }

1;
