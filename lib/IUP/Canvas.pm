#!/usr/bin/env perl

package IUP::Canvas;
use strict;
use warnings;
use base 'IUP::Internal::Element';
use IUP::Internal::LibraryIUP;
#use IUP::Internal::LibraryCD;

sub _create_element {
  my($self, $args) = @_;
  my $ih = IUP::Internal::LibraryIUP::_IupCanvas(0); #xxx TODO fix '0'
  #my $cnvh = IUP::Internal::LibraryIUP::_cdCreateCanvas(CD_IUP, $ih);
  return $ih;
}

sub Box {
  my($self, $x1, $y1, $x2, $y2) = @_;
  #return IUP::Internal::LibraryCD::_cdCanvasBox($self->cvnhandle, $x1, $x2, $y1, $y2);
}

#cdCanvasBegin(canvas, CD_PATH);
#cdCanvasPathSet(canvas, CD_PATH_MOVETO);
#cdCanvasVertex(canvas, x1, y1);
#cdCanvasEnd(canvas);

#void cdCanvasText(cdCanvas* canvas, int x, int y, const char* text); [in C]
#void cdCanvasFont(cdCanvas* canvas, const char* typeface, int style, int size); [in C]

#void cdCanvasLine(cdCanvas* canvas, int x1, int y1, int x2, int y2); [in C]
#void cdCanvasRect(cdCanvas* canvas, int xmin, int xmax, int ymin, int ymax); [in C]
#void cdCanvasArc(cdCanvas* canvas, int xc, int yc, int w, int h, double angle1, double angle2); [in C]
#int cdCanvasLineStyle(cdCanvas* canvas, int style); [in C]
#void cdCanvasLineStyleDashes(cdCanvas* canvas, const int* dashes, int count); [in C]
#int cdCanvasLineWidth(cdCanvas* canvas, int width); [in C]
#int cdCanvasLineJoin(cdCanvas* canvas, int style); [in C]
#int cdCanvasLineCap(cdCanvas* canvas, int style); [in C]

1;
