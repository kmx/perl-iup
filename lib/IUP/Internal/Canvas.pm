package IUP::Internal::Canvas;

use strict;
use warnings;

use IUP::Internal::LibraryIup; #loads also XS part

# Set (via local) by IUP::Internal::Element::_ldestroy_cleanup while IUP is
# tearing an element down. While true, DESTROY must not call cdKillCanvas(),
# because that would re-enter the native library from inside IupDestroy().
our $_in_ldestroy = 0;

# accessor
sub cnvhandle {
  if ($_[1]) {
    IUP::Internal::LibraryIup::_register_ch($_[1], $_[0]);
    return $_[0]->{'!int!cnvhandle'} = $_[1]
  }
  elsif (scalar(@_) > 1) {
    # cnvhandle(undef) => explicit clear (used by cdKillCanvas to drop a dead canvas)
    return delete $_[0]->{'!int!cnvhandle'};
  }
  else {
    return $_[0]->{'!int!cnvhandle'};
  }
}

sub new_from_cnvhandle {
  my ($class, $ch) = @_;
  my $self = { class => $class };
  #warn "XXX-DEBUG: IUP::Internal::Canvas::new_from_cnvhandle(): class=$class [" . ref($self) . "]\n";
  return undef unless($ch); #XXX-CHECKLATER
  bless($self, $class);
  $self->cnvhandle($ch);
  return $self;
}

sub cdKillCanvas {
  my $self = shift;
  #warn "XXX-DEBUG: IUP::Internal::Canvas::cdKillCanvas(): " . ref($self) . " [" . $self->cnvhandle . "]\n";
  my $ch = $self->cnvhandle;
  return unless $ch; #no canvas / already killed - avoid a double cdKillCanvas (double free)
  #only destroy canvases WE created; a canvas handed to us by IUP (DRAW_CB, PRE/POSTDRAW_CB,
  #LISTDRAW_CB - see canvas2SV) is owned and freed by IUP, so cdKillCanvas() on it would be
  #a use-after-free / double-free
  $self->_cdKillCanvas() unless $self->{'!int!cnv_noown'};
  IUP::Internal::LibraryIup::_unregister_ch($ch); #keep %ch_register in sync (LDESTROY symmetry for canvases)
  $self->cnvhandle(undef); #neutralize the now-dangling handle
  #warn "XXX-DEBUG: IUP::Internal::Canvas::cdKillCanvas(): done\n";
}

sub DESTROY {
  my $self = shift;
  #XXX-CHECKLATER not sure if we handle correctly canvas destruction
  #warn "XXX-DEBUG: IUP::Internal::Canvas::DESTROY(): " . ref($self) . " [" . $self->cnvhandle . "]\n";
  #do not cdKillCanvas() while IUP is destroying the owning element (re-entrancy);
  #such canvases are owned/torn down by IUP itself
  return if $_in_ldestroy;
  $self->cdKillCanvas;
  #warn "XXX-DEBUG: IUP::Internal::Canvas::DESTROY(): done\n";
}

#Note: all canvas related methods implemented directly in XS

1;

__END__

=head1 NAME

IUP::Internal::Canvas - [internal only] DO NOT USE this unless you know what could happen!

=cut