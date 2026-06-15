#!perl

# Regression tests for the element lifecycle / ih_register bookkeeping around
# IUP's LDESTROY_CB handling. Covers:
#  - cascade cleanup of children (incl. Append()ed, untracked ones)
#  - double-Destroy safety (no IupDestroy(NULL) / double free)
#  - shared elements NOT auto-destroyed by IUP (images) are left intact
#  - the cdCanvas re-entrancy guard during teardown

BEGIN {
  if (!$ENV{DISPLAY} && $^O ne 'MSWin32' && $^O ne 'cygwin') {
    print "1..0 # skip: no display available for GUI tests\n";
    exit;
  }
}

use strict;
use warnings;
use Test::More;
use IUP ':all';

#-----------------------------------------------------------------------------
# 1) Cascade cleanup: an Append()ed child (never tracked in !int!child) and a
#    constructor child must both be cleaned when their parent tree is destroyed.
{
  my $btn  = IUP::Button->new(TITLE => "b");
  my $lbl  = IUP::Label->new(TITLE => "l");
  my $vbox = IUP::Vbox->new(child => [$lbl]);
  $vbox->Append($btn);              # NOT tracked in !int!child
  $btn->ACTION(sub { });            # circular keep-alive ref on $btn
  my $dlg  = IUP::Dialog->new(child => $vbox);

  my $btn_ih = $btn->ihandle;
  my $lbl_ih = $lbl->ihandle;
  ok(exists $IUP::Internal::LibraryIup::ih_register{$btn_ih}, 'appended button registered');
  ok(exists $IUP::Internal::LibraryIup::ih_register{$lbl_ih}, 'constructor child registered');

  $dlg->Destroy;

  ok(!exists $IUP::Internal::LibraryIup::ih_register{$btn_ih}, 'appended button unregistered after parent Destroy');
  ok(!exists $IUP::Internal::LibraryIup::ih_register{$lbl_ih}, 'constructor child unregistered after parent Destroy');
  is($btn->ihandle, undef, 'appended button wrapper handle neutralized');
  is($lbl->ihandle, undef, 'constructor child wrapper handle neutralized');
}

#-----------------------------------------------------------------------------
# 2) Double-Destroy must be a safe no-op (was: IupDestroy(NULL) / double free).
{
  my $dlg = IUP::Dialog->new(child => IUP::Button->new(TITLE => "x"));
  my $rv1 = eval { $dlg->Destroy; 1 };
  ok($rv1, 'first Destroy ok');
  is($dlg->ihandle, undef, 'handle cleared after Destroy');
  my $rv2 = eval { $dlg->Destroy; 1 };   # must not crash
  ok($rv2, 'second Destroy is a safe no-op');
}

#-----------------------------------------------------------------------------
# 3) Shared element NOT auto-destroyed by IUP (an image used by two dialogs):
#    destroying one owner must NOT neutralize the still-live shared wrapper.
{
  my $img = IUP::Image->new(WIDTH => 1, HEIGHT => 1, pixels => [0]);
  my $b1  = IUP::Button->new(IMAGE => $img);   # $img stored as a child of $b1
  my $b2  = IUP::Button->new(IMAGE => $img);   # ...and of $b2
  my $dlg1 = IUP::Dialog->new(child => $b1);
  my $dlg2 = IUP::Dialog->new(child => $b2);
  my $img_ih = $img->ihandle;

  $dlg1->Destroy;                              # IUP does NOT auto-destroy images

  ok(defined $img->ihandle, 'shared image wrapper NOT neutralized when one owner destroyed');
  ok(exists $IUP::Internal::LibraryIup::ih_register{$img_ih}, 'shared image still registered');

  $dlg2->Destroy;
  $img->Destroy;                               # now explicitly destroy the image
  is($img->ihandle, undef, 'image handle cleared after explicit Destroy');
}

#-----------------------------------------------------------------------------
# 4) cdCanvas re-entrancy guard: a wrapper stashed in a CHILD's
#    !int!cb!*!related (as canvas2SV does for DRAW_CB) is freed during the
#    cascade's _ldestroy_cleanup; that must happen with the guard flag SET, so a
#    real IUP::Internal::Canvas::DESTROY would skip the re-entrant cdKillCanvas.
{
  package CanvasProbe;
  our $flag_seen;
  sub new { bless {}, shift }
  sub DESTROY { $CanvasProbe::flag_seen = $IUP::Internal::Canvas::_in_ldestroy ? 1 : 0 }
  package main;

  my $child = IUP::Button->new(ACTION => sub { });   # has !int!cb!ACTION!related
  my $dlg   = IUP::Dialog->new(child => $child);
  # mimic canvas2SV storing a (canvas) wrapper strongly in the child's related hash
  $child->{'!int!cb!ACTION!related'}{'_probe'} = CanvasProbe->new;

  $CanvasProbe::flag_seen = undef;
  $dlg->Destroy;   # cascade -> LDESTROY(child) -> _ldestroy_cleanup frees the probe

  is($CanvasProbe::flag_seen, 1,
     'wrapper freed during LDESTROY cleanup sees re-entrancy guard set (cdKillCanvas would be skipped)');
}

#-----------------------------------------------------------------------------
# 5) Related-hash pruning (issue #1): a transient handle stashed by ihandle2SV in
#    an owner's !int!cb!*!related (with the back-ref) must remove itself from that
#    hash when it is destroyed, so the owner's related-hash can't grow unbounded.
{
  my $owner = IUP::Vbox->new;                  # long-lived "owner"
  my $param = IUP::Button->new(TITLE => "p");  # a transient related-handle
  my $cont  = IUP::Dialog->new(child => IUP::Vbox->new(child => [$param]));
  my $pih   = $param->ihandle;
  # simulate exactly what ihandle2SV() records for such a param:
  $owner->{'!int!cb!ACTION!related'}{$pih} = $param;  # strong stash in owner
  $param->{'!int!rel_owner'} = $owner;               # back-ref (weak in the C path)
  $param->{'!int!rel_key'}   = '!int!cb!ACTION!related';
  ok(exists $owner->{'!int!cb!ACTION!related'}{$pih}, 'related entry present before destruction');

  $cont->Destroy;   # cascade destroys $param -> LDESTROY -> _ldestroy_cleanup prunes it

  ok(!exists $owner->{'!int!cb!ACTION!related'}{$pih},
     'transient handle pruned from owner related-hash on its destruction (no unbounded growth)');
}

#-----------------------------------------------------------------------------
# 6) cdCanvas lifecycle (issue #3): cnvhandle(undef) clears, cdKillCanvas drops
#    the ch_register entry + neutralizes, and a second kill is a safe no-op.
{
  no warnings 'redefine';
  my $kill = 0;
  local *IUP::Internal::Canvas::_cdKillCanvas = sub { $kill++ };  # stub the native call
  my $fake = 0xABCDE;
  my $c = bless { '!int!cnvhandle' => $fake }, 'IUP::Internal::Canvas';
  $IUP::Internal::LibraryIup::ch_register{$fake} = $c;

  is($c->cnvhandle, $fake, 'cnvhandle getter returns the handle');
  $c->cdKillCanvas;
  is($kill, 1, 'cdKillCanvas calls the native kill exactly once');
  is($c->cnvhandle, undef, 'cnvhandle cleared after kill (no dangling canvas pointer)');
  ok(!exists $IUP::Internal::LibraryIup::ch_register{$fake}, 'canvas unregistered from %ch_register');
  $c->cdKillCanvas;
  is($kill, 1, 'second cdKillCanvas is a safe no-op (no double free)');
}

#-----------------------------------------------------------------------------
# 7) drag/drop callbacks are settable (issue #2 NULL/size guards compiled in).
#    The guards themselves only trigger on degenerate IUP-driven DnD events,
#    which can't be synthesized headless - validated by build + code review.
{
  my $t = IUP::Text->new;
  my $ok = eval {
    $t->DRAGDATA_CB(sub { return (IUP_DEFAULT, "") });
    $t->DROPDATA_CB(sub { return IUP_DEFAULT });
    1;
  };
  ok($ok, 'DRAGDATA_CB/DROPDATA_CB settable');
}

#-----------------------------------------------------------------------------
# 8) canvas ownership: a canvas handed to us by IUP (canvas2SV sets !int!cnv_noown,
#    e.g. the cdCanvas of a DRAW_CB) must NOT be cdKillCanvas'd - IUP owns it - but
#    must still be unregistered/neutralized; a canvas WE created still gets killed.
{
  no warnings 'redefine';
  my $kill = 0;
  local *IUP::Internal::Canvas::_cdKillCanvas = sub { $kill++ };

  my $own = bless { '!int!cnvhandle' => 0x111 }, 'IUP::Internal::Canvas';
  $own->cdKillCanvas;
  is($kill, 1, 'owning canvas: native cdKillCanvas IS called');

  $kill = 0;
  my $noown = bless { '!int!cnvhandle' => 0x222, '!int!cnv_noown' => 1 }, 'IUP::Internal::Canvas';
  $IUP::Internal::LibraryIup::ch_register{0x222} = $noown;
  $noown->cdKillCanvas;
  is($kill, 0, 'IUP-owned canvas: native cdKillCanvas is NOT called (no UAF/double-free)');
  is($noown->cnvhandle, undef, 'IUP-owned canvas wrapper still neutralized');
  ok(!exists $IUP::Internal::LibraryIup::ch_register{0x222}, 'IUP-owned canvas still unregistered from %ch_register');
}

#-----------------------------------------------------------------------------
# 9) Element-owned CD canvas (IUP::Canvas makes one in MAP_CB) is killed during
#    the element's LDESTROY so it doesn't leak (its DESTROY never runs - Element's
#    no-op DESTROY wins the @ISA). An IUP-owned (cnv_noown) one is NOT killed.
{
  no warnings 'redefine';
  my $killed = 0;
  local *IUP::Internal::Canvas::_cdKillCanvas = sub { $killed++ };

  my $child = IUP::Button->new(TITLE => "x");
  my $dlg   = IUP::Dialog->new(child => $child);
  $child->{'!int!cnvhandle'} = 0x4242;                  # simulate a binding-owned CD canvas
  $IUP::Internal::LibraryIup::ch_register{0x4242} = $child;
  $dlg->Destroy;                                        # cascade -> LDESTROY(child) -> kill it
  is($killed, 1, 'element-owned CD canvas killed during LDESTROY (no leak)');
  ok(!exists $child->{'!int!cnvhandle'}, 'element CD canvas handle cleared');
  ok(!exists $IUP::Internal::LibraryIup::ch_register{0x4242}, 'element CD canvas unregistered');

  $killed = 0;
  my $c2  = IUP::Button->new(TITLE => "y");
  my $dl2 = IUP::Dialog->new(child => $c2);
  $c2->{'!int!cnvhandle'} = 0x4343;
  $c2->{'!int!cnv_noown'} = 1;                          # IUP-owned -> must NOT be killed
  $dl2->Destroy;
  is($killed, 0, 'IUP-owned CD canvas NOT killed during LDESTROY');
}

#-----------------------------------------------------------------------------
# 10) Detach removes the child from the former parent's !int!child (no retention).
{
  my $btn = IUP::Button->new(TITLE => "x");
  my $box = IUP::Vbox->new(child => [$btn]);
  my $ih  = $btn->ihandle;
  ok(exists $box->{'!int!child'}{$ih}, 'child tracked by parent before Detach');
  $btn->Detach;
  ok(!exists $box->{'!int!child'}{$ih}, 'child removed from former parent after Detach');
  is($btn->ihandle, $ih, 'detached child still alive (not destroyed)');
  $btn->Destroy;
}

done_testing();
