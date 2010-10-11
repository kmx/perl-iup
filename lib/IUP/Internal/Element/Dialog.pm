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

1;

__END__

=head1 NAME

IUP::Internal::Element::Dialog - Perl extension for IUP xxx

=cut
