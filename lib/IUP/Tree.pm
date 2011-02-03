package IUP::Tree;
use strict;
use warnings;
use base 'IUP::Internal::Element';
use IUP::Internal::LibraryIup;

sub _create_element {
  #my ($self, $args, $firstonly) = @_;
  return IUP::Internal::LibraryIup::_IupTree();
}

sub TreeSetUserId {
  #int IupTreeSetUserId(Ihandle *ih, int id, void *userid); [in C]
  #iup.TreeSetUserId(ih: ihandle, id: number, userid: userdata/table) [in Lua]
  # xxx TODO xxx somehow handle pointer to user data
}

sub TreeGetUserId {
  #void* IupTreeGetUserId(Ihandle *ih, int id); [in C] 
  #iup.TreeGetUserId(ih: ihandle, id: number) -> (ret: userdata/table) [in Lua]
  # xxx TODO xxx somehow handle pointer to user data
}

sub TreeGetId {
  #int IupTreeGetId(Ihandle *ih, void *userid); [in C] 
  #iup.TreeGetId(ih: ihandle, userid: userdata/table) -> (ret: number) [in Lua]
  # xxx TODO xxx somehow handle pointer to user data
}

sub TreeSetAncestorsAttributes {
  my ($self, $ini, $attrs) = @_;
  #iup.TreeSetAncestorsAttributes(ih: ihandle, id: number, attrs: table) [in Lua]
  $ini = $self->GetAttribute("PARENT$ini");
  my @stack = ();  
  while (defined $ini) {
    push @stack, $ini;
    $ini = $self->GetAttribute("PARENT$ini");
  }
  $self->TreeSetNodeAttributes($_, $attrs) for (@stack);
}

sub TreeSetDescentsAttributes {
  my ($self, $ini, $attrs) = @_;
  #iup.TreeSetDescentsAttributes(ih: ihandle, id: number, attrs: table) [in Lua] 
  my $id = $ini;
  my $count = $self->GetAttribute("CHILDCOUNT$ini");
  for(my $i=0; $i<$count; $i++) {
    $id++;
    $self->TreeSetNodeAttributes($id, $attrs);
    if ($self->GetAttribute("KIND$id") eq "BRANCH") {
      $id = $self->TreeSetDescentsAttributes($id, $attrs);
    }
  }
  return $id;
}

sub TreeSetNodeAttributes {
  my ($self, $id, $attrs) = @_;
  #iup.TreeSetNodeAttributes(ih: ihandle, id: number, attrs: table) [in Lua]  
  while (my ($attr, $val) = each %$attrs) {
    $self->SetAttribute("$attr$id", $val);
  }
}

sub TreeAddNodes {
  #iup.TreeAddNodes(ih: ihandle, tree: table, [id: number]) [in Lua]
  my ($self, $t, $id) = @_;
  return unless defined $t;
  if (! defined $id) {
    $id = 0; # default is the root
    $self->SetAttribute("TITLE0", $t->{branchname}) if defined $t->{branchname};
    $self->TreeSetNodeAttrib($t, 0)
  }
  $self->TreeAddNodesRec($t, $id);
  $self->TreeSetState($t, 0) if $id == 0;
}

#xxxmaybe private
sub TreeSetState {
  my ($self, $tnode, $id) = @_;
  if ($tnode->{state}) {
    $self->SetAttribute("STATE$id", $tnode->{state})
  }
}

#xxxmaybe private
sub TreeSetNodeAttrib {  
  my ($self, $tnode, $id) = @_;
  $self->SetAttribute("COLOR$id", $tnode->{color})                           if $tnode->{color};
  $self->SetAttribute("TITLEFONT$id", $tnode->{titlefont})                   if $tnode->{titlefont};
  $self->SetAttribute("MARKED$id", $tnode->{marked})                         if $tnode->{marked};
  $self->TreeSetAttributeHandle("IMAGE$id", $tnode->{image})                 if $tnode->{image};
  $self->TreeSetAttributeHandle("IMAGEEXPANDED$id", $tnode->{imageexpanded}) if $tnode->{imageexpanded};
  $self->TreeSetUserId($id, $tnode->{userid})                                if $tnode->{userid};
}

#xxxmaybe private
sub TreeAddNodesRec {
  my ($self, $t, $id) = @_;
  return unless defined $t;
  foreach my $tt (@{$t->{child}}) {
    if (ref $tt) {
      if ($tt->{branchname}) {
        $self->SetAttribute("ADDBRANCH$id", $tt->{branchname});
        $self->TreeSetNodeAttrib($tt, $id+1);
        $self->TreeAddNodesRec($tt, $id+1);
        $self->TreeSetState($tt, $id+1);
      }
      elsif ($tt->{leafname}) {
        $self->SetAttribute("ADDLEAF$id", $tt->{leafname});
        $self->TreeSetNodeAttrib($tt, $id+1);
      }
    }
    else {
      $self->SetAttribute("ADDLEAF".$id, $tt);
    }
  }
}

1;
