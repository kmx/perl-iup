#!/usr/bin/env perl

package IUP::Internal::Element::Image;
use strict;
use warnings;
use base 'IUP::Internal::Element';

sub import {
  my $p = shift;
  $p->SUPER::import(@_);
  #warn "### IUP::Internal::Element::Image->import($p) called";

  #xxx TODO xxx
  #my $at2eval = IUP::Internal::Attribute::_get_attr_eval_code('_dialog');
  #eval $at2eval;  
  #my $cb2eval = IUP::Internal::Callback::_get_cb_eval_code('_dialog');
  #eval $cb2eval;
}

sub SaveImage {
  #int IupSaveImage(Ihandle* ih, const char* file_name, const char* format); [in C]
  #iup.SaveImage(ih: ihandle, file_name, format: string) -> (ret: boolean) [in Lua]
  
  #xxx TODO xxx
  my ($self, $filename, $format) = @_;
  return IUP::Internal::LibraryIup::_IupSaveImage($self->ihandle, $filename, $format);
}

sub SaveImageAsText {
  #int IupSaveImageAsText(Ihandle* ih, const char* file_name, const char* format, const char* name); [in C]
  #iup.SaveImageAsText(ih: ihandle, file_name, format[, name]: string) -> (ret: boolean) [in Lua]

  #xxx TODO xxx
  my ($self, $filename, $format, $name) = @_;
  return IUP::Internal::LibraryIup::_IupSaveImageAsText($self->ihandle, $filename, $format, $name);
}

sub LoadImage {
  #Ihandle* IupLoadImage(const char* file_name); [in C]
  #iup.LoadImage(file_name: string) -> (elem: ihandle) [in Lua]
  
  #xxx TODO xxx - maybe not a method but rather a constructor
  my ($self, $filename) = @_;
  #return IUP::Internal::LibraryIup::_IupSaveImage($self->ihandle, $filename, $format);
}

sub GetNativeHandleImage {
  #imImage* IupGetNativeHandleImage(void* handle); [in C]
  #iup.GetNativeHandleImage(handle: userdata) -> (image: imImage) [in Lua]
  
  #xxx TODO xxx - maybe not a method but rather a constructor 
  # native2img
}

sub GetImageNativeHandle {
  #imImage* IupGetImageNativeHandle(imImage* image); [in C]
  #iup.GetImageNativeHandle(image: imImage) -> (handle: userdata) [in Lua]
  
  #xxx TODO xxx - beware returns imimage* not ihandle*
  # img2native
}

1;

__END__

=head1 NAME

IUP::Internal::Element::Image - Perl extension for IUP xxx

=cut
