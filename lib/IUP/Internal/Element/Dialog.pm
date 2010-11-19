#!/usr/bin/env perl

package IUP::Internal::Element::Dialog;
use strict;
use warnings;
use base 'IUP::Internal::Element';

sub import {
  my $p = shift;
  $p->SUPER::import(@_);
  #warn "### IUP::Internal::Element::Dialog->import($p) called";

  #xxx TODO xxx
  #my $at2eval = IUP::Internal::Attribute::_get_attr_eval_code('_dialog');
  #eval $at2eval;  
  #my $cb2eval = IUP::Internal::Callback::_get_cb_eval_code('_dialog');
  #eval $cb2eval;
}

sub Popup {
  # xxx Dialog
  #int IupPopup(Ihandle *ih, int x, int y); [in C]
  #iup.Popup(ih: ihandle[, x, y: number]) -> (ret: number) [in Lua]
  #or ih:popup([x, y: number]) -> (ret: number) [in Lua]
  my ($self, $x, $y) = @_;
  #$x ||= 0; # xxx TOTO some reasonable defaults
  #$y ||= 0; # xxx TOTO some reasonable defaults
  return IUP::Internal::LibraryIup::_IupPopup($self->ihandle, $x, $y);  
}

sub Show {
  # xxx Dialog
  #int IupShow(Ihandle *ih); [in C]
  #iup.Show(ih: ihandle) -> (ret: number) [in Lua]
  #or ih:show() -> (ret: number) [in IupLua]
  my $self = shift;
  return IUP::Internal::LibraryIup::_IupShow($self->ihandle);
}

sub ShowXY {
  # xxx Dialog
  #int IupShowXY(Ihandle *ih, int x, int y); [in C]
  #iup.ShowXY(ih: ihandle[, x, y: number]) -> (ret: number) [in Lua]
  #or ih:showxy([x, y: number]) -> (ret: number) [in Lua]
  my ($self, $x, $y) = @_;
  return IUP::Internal::LibraryIup::_IupShowXY($self->ihandle, $x, $y);  
}

sub Hide {
  #int IupHide(Ihandle *ih); [in C]
  #iup.Hide(ih: ihandle) -> (ret: number) [in Lua]
  my $self = shift;
  return IUP::Internal::LibraryIup::_IupHide($self->ihandle);  
}

1;

__END__

=head1 NAME

IUP::Internal::Element::Dialog - Perl extension for IUP xxx

=cut
