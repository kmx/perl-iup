#!/usr/bin/env perl

package IUP::Internal::Element::Box;
use strict;
use warnings;
use base 'IUP::Internal::Element';

sub import {
  my $p = shift;
  $p->SUPER::import(@_);
}

1;

__END__

=head1 NAME

IUP::Internal::Element::Box - [internal only] DO NOT USE this unless you know what could happen!

=cut
