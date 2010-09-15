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

sub Begin {
  #void IupPPlotBegin(Ihandle* ih, int strXdata); [in C]
  #iup.PPlotBegin(ih: ihandle, strXdata: number) [in Lua]
  my ($self, $strXdata);
  #return IUP::Internal::LibraryIUP::_IupPPlotBegin($self->ihandle, $strXdata);
}

sub Add {
  #void IupPPlotAdd(Ihandle* ih, float x, float y); [in C]
  #iup.PPlotAdd(ih: ihandle, x, y: number) [in Lua]
  my ($self, $x, $y);
  #return IUP::Internal::LibraryIUP::_IupPPlotAdd($self->ihandle, $x, $y);
}

sub AddStr {
  #void IupPPlotAddStr(Ihandle* ih, const char* x, float y); [in C]
  #iup.PPlotAddStr(ih: ihandle, x: string, y: number) [in Lua]
  my ($self, $x, $y);
  #return IUP::Internal::LibraryIUP::_IupPPlotAddStr($self->ihandle, $x, $y);
}

sub End {
  #int IupPPlotEnd(Ihandle* ih); [in C]
  #iup.PPlotEnd(ih: ihandle) -> (index: number) [in Lua]
  my $self = shift;
  #return IUP::Internal::LibraryIUP::_IupPPlotEnd($self->ihandle);
}

sub Insert {
  #void IupPPlotInsert(Ihandle *ih, int index, int sample_index, float x, float y); [in C]
  #iup.IupPPlotInsert(ih: ihandle, index, sample_index, x, y: number) [in Lua]
  my ($self, $index, $sample_index, $x, $y);
  #return IUP::Internal::LibraryIUP::_IupPPlotInsert($self->ihandle, $index, $sample_index, $x, $y);
}

sub InsertStr {
  #void IupPPlotInsertStr(Ihandle *ih, int index, int sample_index, const char* x, float y);
  #iup.IupPPlotInsertStr(ih: ihandle, index, sample_index, x, y: number)
  my ($self, $index, $sample_index, $x, $y);
  #return IUP::Internal::LibraryIUP::_IupPPlotInsertStr($self->ihandle, $index, $sample_index, $x, $y);
}

sub Transform {
  #void IupPPlotTransform(Ihandle* ih, float x, float y, int *ix, int *iy); [in C]
  #iup.PPlotTransform(ih: ihandle, x, y: number) -> (ix, iy: number) [in Lua]
  my ($self, $x, $y);
  #my ($new_x, $new_y) = return IUP::Internal::LibraryIUP::_IupPPlotTransform($self->ihandle, $x, $y);
  #return ($new_x, $new_y);
}

sub PaintTo {
  # xxx TODO do we need this?
  #void IupPPlotPaintTo(Ihandle* ih, cdCanvas* cnv); [in C]
  #iup.PPlotPaintTo(ih: ihandle, cnv: cdCanvas) [in Lua]
  #Plots to the given CD canvas instead of the display canvas.
  my ($self, $cnv);
  #return IUP::Internal::LibraryIUP::_IupPPlotInsert($self->ihandle, $cnv->cnvhandle);
}

1;
