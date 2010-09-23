#!/usr/bin/env perl

package IUP::PPlot;
use strict;
use warnings;
use base 'IUP::Internal::Element';
use IUP::Internal::LibraryIUP;

sub _create_element {
  my ($self, $args) = @_;
  my $ih = IUP::Internal::LibraryIUP::_IupPPlot();
  return $ih;
}

# xxx TODO decide whether to name methods: PPlotBegin or just Begin
# xxx TODO Add vs. AddStr

sub PPlotBegin {
  #void IupPPlotBegin(Ihandle* ih, int strXdata); [in C]
  #iup.PPlotBegin(ih: ihandle, strXdata: number) [in Lua]
  my ($self, $strXdata) = @_;
  return IUP::Internal::LibraryIUP::_IupPPlotBegin($self->ihandle, $strXdata);
}

sub PPlotAdd {
  #void IupPPlotAdd(Ihandle* ih, float x, float y); [in C]
  #iup.PPlotAdd(ih: ihandle, x, y: number) [in Lua]
  my ($self, $x, $y) = @_;
  return IUP::Internal::LibraryIUP::_IupPPlotAdd($self->ihandle, $x, $y);
}

# xxx TODO maybe autoselection PPlotAddStr vs. PPlotAdd
sub PPlotAddStr {
  #void IupPPlotAddStr(Ihandle* ih, const char* x, float y); [in C]
  #iup.PPlotAddStr(ih: ihandle, x: string, y: number) [in Lua]
  my ($self, $x, $y) = @_;
  return IUP::Internal::LibraryIUP::_IupPPlotAddStr($self->ihandle, $x, $y);
}

sub PPlotEnd {
  #int IupPPlotEnd(Ihandle* ih); [in C]
  #iup.PPlotEnd(ih: ihandle) -> (index: number) [in Lua]
  my $self = shift;
  return IUP::Internal::LibraryIUP::_IupPPlotEnd($self->ihandle);
}

sub PPlotInsert {
  #void IupPPlotInsert(Ihandle *ih, int index, int sample_index, float x, float y); [in C]
  #iup.IupPPlotInsert(ih: ihandle, index, sample_index, x, y: number) [in Lua]
  my ($self, $index, $sample_index, $x, $y) = @_;
  return IUP::Internal::LibraryIUP::_IupPPlotInsert($self->ihandle, $index, $sample_index, $x, $y);
}

sub PPlotInsertStr {
  #void IupPPlotInsertStr(Ihandle *ih, int index, int sample_index, const char* x, float y);
  #iup.IupPPlotInsertStr(ih: ihandle, index, sample_index, x, y: number)
  my ($self, $index, $sample_index, $x, $y) = @_;
  return IUP::Internal::LibraryIUP::_IupPPlotInsertStr($self->ihandle, $index, $sample_index, $x, $y);
}

sub PPlotTransform {
  #void IupPPlotTransform(Ihandle* ih, float x, float y, int *ix, int *iy); [in C]
  #iup.PPlotTransform(ih: ihandle, x, y: number) -> (ix, iy: number) [in Lua]
  my ($self, $x, $y) = @_;
  my ($new_x, $new_y) = return IUP::Internal::LibraryIUP::_IupPPlotTransform($self->ihandle, $x, $y);
  return ($new_x, $new_y);
}

sub PPlotPaintTo {
  # xxx TODO do we need this?
  #void IupPPlotPaintTo(Ihandle* ih, cdCanvas* cnv); [in C]
  #iup.PPlotPaintTo(ih: ihandle, cnv: cdCanvas) [in Lua]
  #Plots to the given CD canvas instead of the display canvas.
  my ($self, $cnv) = @_;
  return IUP::Internal::LibraryIUP::_IupPPlotPaintTo($self->ihandle, $cnv->cnvhandle);
}

1;
