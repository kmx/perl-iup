package IUP::PPlot;
use strict;
use warnings;
use base 'IUP::Internal::Element';
use IUP::Internal::LibraryIup;

sub BEGIN {
  #warn "[DEBUG] IUP::PPlot::BEGIN() started\n";
  IUP::Internal::LibraryIup::_IupPPlotOpen();
}

sub _create_element {
  my ($self, $args, $firstonly) = @_;
  my $ih = IUP::Internal::LibraryIup::_IupPPlot();
  return $ih;
}

sub PPlotBegin {
  #void IupPPlotBegin(Ihandle* ih, int strXdata); [in C]
  #iup.PPlotBegin(ih: ihandle, strXdata: number) [in Lua]
  my ($self, $strXdata) = @_;
  return IUP::Internal::LibraryIup::_IupPPlotBegin($self->ihandle, $strXdata);
}

sub PPlotAdd {
  #void IupPPlotAdd(Ihandle* ih, float x, float y); [in C]
  #iup.PPlotAdd(ih: ihandle, x, y: number) [in Lua]
  #void IupPPlotAddStr(Ihandle* ih, const char* x, float y); [in C]
  #iup.PPlotAddStr(ih: ihandle, x: string, y: number) [in Lua]
  #NOTE: Add vs. AddStr autodetection based on $x type (float/string)  
  my ($self, $x, $y) = @_;
  return IUP::Internal::LibraryIup::_IupPPlotAdd($self->ihandle, $x, $y);
}

sub PPlotEnd {
  #int IupPPlotEnd(Ihandle* ih); [in C]
  #iup.PPlotEnd(ih: ihandle) -> (index: number) [in Lua]
  my $self = shift;
  return IUP::Internal::LibraryIup::_IupPPlotEnd($self->ihandle);
}

sub PPlotInsert {
  #void IupPPlotInsert(Ihandle *ih, int index, int sample_index, float x, float y); [in C]
  #iup.IupPPlotInsert(ih: ihandle, index, sample_index, x, y: number) [in Lua]
  my ($self, $index, $sample_index, $x, $y) = @_;
  return IUP::Internal::LibraryIup::_IupPPlotInsert($self->ihandle, $index, $sample_index, $x, $y);
}

sub PPlotInsertStr {
  #void IupPPlotInsertStr(Ihandle *ih, int index, int sample_index, const char* x, float y);
  #iup.IupPPlotInsertStr(ih: ihandle, index, sample_index, x, y: number)
  my ($self, $index, $sample_index, $x, $y) = @_;
  return IUP::Internal::LibraryIup::_IupPPlotInsertStr($self->ihandle, $index, $sample_index, $x, $y);
}

sub PPlotTransform {
  #void IupPPlotTransform(Ihandle* ih, float x, float y, int *ix, int *iy); [in C]
  #iup.PPlotTransform(ih: ihandle, x, y: number) -> (ix, iy: number) [in Lua]
  my ($self, $x, $y) = @_;
  my ($new_x, $new_y) = return IUP::Internal::LibraryIup::_IupPPlotTransform($self->ihandle, $x, $y);
  return ($new_x, $new_y);
}

sub PPlotPaintTo {
  #void IupPPlotPaintTo(Ihandle* ih, cdCanvas* cnv); [in C]
  #iup.PPlotPaintTo(ih: ihandle, cnv: cdCanvas) [in Lua]
  #NOTE: maybe not needed: Plots to the given CD canvas instead of the display canvas.
  my ($self, $cnv) = @_;
  return IUP::Internal::LibraryIup::_IupPPlotPaintTo($self->ihandle, $cnv->cnvhandle);
}

1;
