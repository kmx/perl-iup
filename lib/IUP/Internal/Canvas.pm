package IUP::Internal::Canvas;

@ISA = qw/ DynaLoader /;
require DynaLoader;

bootstrap IUP::Internal::Canvas;

# accessor
sub cnvhandle {
  if ($_[1]) {
    IUP::Internal::LibraryIup::_register_ch($_[1], $_[0]);    
    return $_[0]->{'!int!cnvhandle'} = $_[1]    
  }
  else {
    return $_[0]->{'!int!cnvhandle'};
  }
}

sub new_from_cnvhandle {
  my ($class, $ch) = @_;
  my $self = { class => $class };
  bless($self, $class);
  $self->cnvhandle($ch);
  return $self;
}

sub DESTROY {
  #xxxFIXME handle canvas destruction
  #warn "***DEBUG*** DESTROY(): " . ref($_[0]) . " [" . $_[0]->ihandle . "]\n";  
}

#Note: all canvas related methods implemented directly in XS

1;

__END__

=head1 NAME

IUP::Internal::Canvas - [internal only] DO NOT USE this unless you know what could happen!

=cut