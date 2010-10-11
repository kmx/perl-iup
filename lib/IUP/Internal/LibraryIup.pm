#!/usr/bin/env perl

package IUP::Internal::LibraryIup;

@ISA = qw/ DynaLoader /;
require DynaLoader;

bootstrap IUP::Internal::LibraryIup;

1;

__END__

=head1 NAME

IUP::Internal::LibraryIup - INTERNAL FUNCTIONS, do not use them from outside!

=cut