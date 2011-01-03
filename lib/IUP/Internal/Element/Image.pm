#!/usr/bin/env perl

package IUP::Internal::Element::Image;
use strict;
use warnings;
use base 'IUP::Internal::Element';

sub import {
  my $p = shift;
  $p->SUPER::import(@_);
}

sub SaveImage {
  #int IupSaveImage(Ihandle* ih, const char* file_name, const char* format); [in C]
  #iup.SaveImage(ih: ihandle, file_name, format: string) -> (ret: boolean) [in Lua]
  
  my ($self, $filename, $format) = @_;
  return IUP::Internal::LibraryIup::_IupSaveImage($self->ihandle, $filename, $format);
}

sub SaveImageAsText {
  #int IupSaveImageAsText(Ihandle* ih, const char* file_name, const char* format, const char* name); [in C]
  #iup.SaveImageAsText(ih: ihandle, file_name, format[, name]: string) -> (ret: boolean) [in Lua]

  my ($self, $filename, $format, $name) = @_;
  return IUP::Internal::LibraryIup::_IupSaveImageAsText($self->ihandle, $filename, $format, $name);
}

1;

__END__

=head1 NAME

IUP::Internal::Element::Image - [internal only] DO NOT USE this unless you know what could happen!

=cut
