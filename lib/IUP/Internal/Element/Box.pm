#!/usr/bin/env perl

package IUP::Internal::Element::Box;
use strict;
use warnings;
use base 'IUP::Internal::Element';

sub import {
  my $p = shift;
  $p->SUPER::import(@_);
  #warn "### IUP::Internal::Element::Box->import($p) called";

  #xxx TODO xxx
  #my $at2eval = IUP::Internal::Attribute::_get_attr_eval_code('_box');
  #eval $at2eval;  
  #my $cb2eval = IUP::Internal::Callback::_get_cb_eval_code('_box');
  #eval $cb2eval;

}

1;

__END__

=head1 NAME

IUP::Internal::Element::Box - Perl extension for IUP xxx

=cut
