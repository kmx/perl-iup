#!/usr/bin/env perl

package IUP::Internal::LibraryIUP;

@ISA = qw/ DynaLoader /;
require DynaLoader;

bootstrap IUP::Internal::LibraryIUP;

1;

__END__

=head1 NAME

IUP::Internal::LibraryIUP - INTERNAL FUNCTIONS, do not use them from outside!

=cut