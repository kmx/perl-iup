# Example IupGLCanvas
# Creates a OpenGL canvas and draws a line in it.
# This example uses gllua binding of OpenGL to Perl
use warnings;
use strict;

use IUP;
#use OpenGL qw(:glfunctions :glconstants);
use OpenGL qw(:all);

my $cnv = IUP::GLCanvas->new( BUFFER=>"DOUBLE", RASTERSIZE=>"300x300" );

# xxx TODO missing attribute
$cnv->SetAttribute("RASTERSIZE", "300x300");

sub cb_cnv_action {
  my ($self, $x, $y);
  $self->IUP_GLMakeCurrent();
  glClearColor(1.0, 1.0, 1.0, 1.0);
  glClear(GL_COLOR_BUFFER_BIT);
  glClear(GL_DEPTH_BUFFER_BIT);
  glMatrixMode( GL_PROJECTION );
  glViewport(0, 0, 300, 300);
  glLoadIdentity();
  glBegin(GL_LINES);
  glColor(1.0, 0.0, 0.0);
  glVertex(0.0, 0.0);
  glVertex(100.0, 100.0);
  glEnd();
  $self->GLSwapBuffers();
}

my $dlg = IUP::Dialog->new( child=>$cnv, TITLE=>"IupGLCanvas Example" );

sub cb_cnv_k_any {
  my ($self, $c);
# xxx TODO missing K_* constants
#  if ( $c == IUP_K_q or $c == IUP_K_Esc ) {
#    return IUP_CLOSE;
#  }
#  else {
#    return IUP_DEFAULT;
#  }
}

# xxx TODO callbacks
#$cnv->ACTION(\&cb_cnv_action);
#$cnv->K_ANY(\&cb_cnv_k_any);

$dlg->Show();

# xxx TODO not working

if (IUP->MainLoopLevel == 0) {
  IUP->MainLoop;
}