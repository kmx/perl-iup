package IUP::Plot;
use strict;
use warnings;
use base 'IUP::Internal::Element';
use IUP::Internal::LibraryIup;
use Carp;

sub BEGIN {
  #warn "[DEBUG] IUP::Plot::BEGIN() started\n";
  IUP::Internal::LibraryIup::_IupPPlotOpen();
}

sub _create_element {
  my ($self, $args, $firstonly) = @_;
  my $ih = IUP::Internal::LibraryIup::_IupPPlot();
  return $ih;
}

sub PlotBegin {
  #void IupPlotBegin(Ihandle* ih, int strXdata); [in C]
  #iup.PlotBegin(ih: ihandle, strXdata: number) [in Lua]
  my ($self, $strXdata) = @_;
  $self->{'!int!last_begin_param'} = $strXdata;
  return IUP::Internal::LibraryIup::_IupPlotBegin($self->ihandle, $strXdata);
}

sub PlotEnd {
  #int IupPlotEnd(Ihandle* ih); [in C]
  #iup.PlotEnd(ih: ihandle) -> (index: number) [in Lua]
  my $self = shift;
  return IUP::Internal::LibraryIup::_IupPlotEnd($self->ihandle);
}

sub PlotAdd {
  # params: ($x, $y)
  my $self = shift;
  my $c = scalar @_;
  if ( $c>=2 && ($c%2)==0 ) {
    return IUP::Internal::LibraryIup::_IupPlotAdd($self->ihandle, $self->{'!int!last_begin_param'}, @_);
  }
  else {
    carp "Warning: wrong number of parameters";
  }
}

sub PlotAddPoints {
  # params: ($index, \@xylist)
  my $self = shift;
  return IUP::Internal::LibraryIup::_IupPlotAddPoints($self->ihandle, $self->{'!int!last_begin_param'}, @_);
}

sub PlotInsert {
  # params: ($index, $sample_index, $x, $y)
  my $self = shift;
  my $index = shift;
  my $sample_index = shift;
  my $c = scalar @_;
  if ( $c>=2 && ($c%2)==0 ) {
    return IUP::Internal::LibraryIup::_IupPlotInsert($self->ihandle, $self->{'!int!last_begin_param'},
                                                      $index, $sample_index, @_);
  }
  else {
    carp "Warning: wrong number of parameters";
  }  
}

sub PlotInsertPoints {
  # params: ($index, $sample_index, \@xylist)
  my $self = shift;
  return IUP::Internal::LibraryIup::_IupPlotInsertPoints($self->ihandle, $self->{'!int!last_begin_param'}, @_);
}

sub PlotTransform {
  #void IupPlotTransform(Ihandle* ih, float x, float y, int *ix, int *iy); [in C]
  #iup.PlotTransform(ih: ihandle, x, y: number) -> (ix, iy: number) [in Lua]
  my ($self, $x, $y) = @_;
  my ($new_x, $new_y) = return IUP::Internal::LibraryIup::_IupPlotTransform($self->ihandle, $x, $y);
  return ($new_x, $new_y);
}

sub PlotPaintTo {
  #void IupPlotPaintTo(Ihandle* ih, cdCanvas* cnv); [in C]
  #iup.PlotPaintTo(ih: ihandle, cnv: cdCanvas) [in Lua]
  my ($self, $cnv) = @_;
  return IUP::Internal::LibraryIup::_IupPlotPaintTo($self->ihandle, $cnv->cnvhandle);
}

1;
