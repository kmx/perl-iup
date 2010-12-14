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

IUP::Internal::Element::Box - Perl extension for IUP

=cut
