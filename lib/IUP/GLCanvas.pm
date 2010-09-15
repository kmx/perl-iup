#!/usr/bin/env perl

package IUP::GLCanvas;
use strict;
use warnings;
use base 'IUP::Internal::Element';
use IUP::Internal::LibraryIUP;

sub _create_element {
  my($self, $args) = @_;
  my $ih = IUP::Internal::LibraryIUP::_IupGLCanvas(0); #xxx TODO fix '0' + not in XS yet
  return $ih;
}

sub GLMakeCurrent {
  my $self = shift;
  return IUP::Internal::LibraryIUP::_IupGLMakeCurrent($self->ihandle);
}

sub GLIsCurrent {
  my $self = shift;
  return IUP::Internal::LibraryIUP::_IupGLIsCurrent($self->ihandle);
}

sub GLSwapBuffers {
  my $self = shift;
  return IUP::Internal::LibraryIUP::_IupGLSwapBuffers($self->ihandle);
}

sub GLPalette {
  my ($self, $index, $r, $g, $b) = @_;
  return IUP::Internal::LibraryIUP::_IupGLPalette($self->ihandle, $index, $r, $g, $b);
}

sub GLUseFont {
  my ($self, $first, $count, $list_base) = @_;
  return IUP::Internal::LibraryIUP::_IupGLUseFont($self->ihandle, $first, $count, $list_base);
}

sub GLWait {
  my ($self, $gl) = @_;
  return IUP::Internal::LibraryIUP::_IupGLWait($gl);
}

1;
