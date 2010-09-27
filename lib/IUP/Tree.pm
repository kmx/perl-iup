#!/usr/bin/env perl

package IUP::Tree;
use strict;
use warnings;
use base 'IUP::Internal::Element';
use IUP::Internal::LibraryIUP;

sub _create_element {
  my($self, $args) = @_;
  return IUP::Internal::LibraryIUP::_IupTree();
}

# xxx TODO xxx many unimplemented IUP::Tree methods

#int IupTreeSetUserId(Ihandle *ih, int id, void *userid); [in C]
#iup.TreeSetUserId(ih: ihandle, id: number, userid: userdata/table) [in Lua]

#void* IupTreeGetUserId(Ihandle *ih, int id); [in C] 
#iup.TreeGetUserId(ih: ihandle, id: number) -> (ret: userdata/table) [in Lua]

#int IupTreeGetId(Ihandle *ih, void *userid); [in C] 
#iup.TreeGetId(ih: ihandle, userid: userdata/table) -> (ret: number) [in Lua]

sub TreeSetState {
  my ($self, $tnode, $id) = @_;
  warn "xxx TODO xxx: TreeSetState not tested";
  if ($tnode->{state}) {
    $self->SetAttribute("STATE$id", $tnode->{state})
  }
}

sub TreeSetNodeAttrib {
  #iup.TreeSetNodeAttributes(ih: ihandle, id: number, attrs: table) [in Lua]
  my ($self, $tnode, $id) = @_;
  warn "xxx TODO xxx: TreeSetNodeAttrib not tested";
  $self->SetAttribute("COLOR$id", $tnode->{color})                           if $tnode->{color};
  $self->SetAttribute("TITLEFONT$id", $tnode->{titlefont})                   if $tnode->{titlefont};
  $self->SetAttribute("MARKED$id", $tnode->{marked})                         if $tnode->{marked};
  $self->TreeSetAttributeHandle("IMAGE$id", $tnode->{image})                 if $tnode->{image};
  $self->TreeSetAttributeHandle("IMAGEEXPANDED$id", $tnode->{imageexpanded}) if $tnode->{imageexpanded};
  $self->TreeSetUserId($id, $tnode->{userid})                                if $tnode->{userid};
}

sub TreeAddNodes {
  #iup.TreeAddNodes(ih: ihandle, tree: table, [id: number]) [in Lua]
  my ($self, $t, $id) = @_;
  warn "xxx TODO xxx: TreeAddNodes not tested $t->{branchname} $id";
  return unless defined $t;
  if (! defined $id) {
    $id = 0; # default is the root
    $self->SetAttribute("TITLE0", $t->{branchname}) if defined $t->{branchname};
    $self->TreeSetNodeAttrib($t, 0)
  }
  $self->TreeAddNodesRec($t, $id);
  $self->TreeSetState($t, 0) if $id == 0;
}

sub TreeAddNodesRec {
  my ($self, $t, $id) = @_;
  warn "xxx TODO xxx: TreeAddNodesRec not tested $t->{branchname} $id";
  return unless defined $t;
  foreach my $tt (@{$t->{child}}) {
    if (ref $tt) {
      if ($tt->{branchname}) {
warn "xxxxxxxxxxxxxxxxxxxxxxxxxxx ADDBRANCH$id, $tt->{branchname} ";
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

#iup.TreeSetAncestorsAttributes(ih: ihandle, id: number, attrs: table) [in Lua]

#iup.TreeSetDescentsAttributes(ih: ihandle, id: number, attrs: table) [in Lua]

#void  IupTreeSetAttribute (Ihandle *ih, const char* name, int id, const char* value);
#void  IupTreeSetfAttribute (Ihandle *ih, const char* name, int id, const char* format, ...);
#void  IupTreeStoreAttribute(Ihandle *ih, const char* name, int id, const char* value);

#char* IupTreeGetAttribute (Ihandle *ih, const char* name, int id);
#int   IupTreeGetInt (Ihandle *ih, const char* name, int id);
#float IupTreeGetFloat (Ihandle *ih, const char* name, int id);


1;
