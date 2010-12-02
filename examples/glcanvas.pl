# Example IupGLCanvas
# Creates a OpenGL canvas and draws a line in it.
# This example uses gllua binding of OpenGL to Perl
use warnings;
use strict;

#xxx TODO: glcanvas.gl regularly hangs up (seen on Win32 native GUI, restart helps)

use IUP;
use OpenGL qw(:all);

my $cnv = IUP::GLCanvas->new( BUFFER=>"DOUBLE", RASTERSIZE=>"300x300" );

sub cb_cnv_action {
  my ($self, $x, $y) = @_;
  $self->GLMakeCurrent();
  glClearColor(1.0, 1.0, 1.0, 1.0);
  glClear(GL_COLOR_BUFFER_BIT);
  glClear(GL_DEPTH_BUFFER_BIT);
  glMatrixMode( GL_PROJECTION );
  glViewport(0, 0, 300, 300);
  glLoadIdentity();
  glBegin(GL_LINES);
  glColor3d(1.0, 0.0, 0.0);
  glVertex2d(0.0, 0.0);
  glVertex2d(100.0, 100.0);
  glEnd();
  $self->GLSwapBuffers();
}

sub cb_cnv_k_any {
  my ($self, $c) = @_;
  if ( $c == IUP_K_q or $c == IUP_K_ESC ) {
    return IUP_CLOSE;
  }
  else {
    return IUP_DEFAULT;
  }
}

$cnv->ACTION(\&cb_cnv_action);
$cnv->K_ANY(\&cb_cnv_k_any);

my $dlg = IUP::Dialog->new( child=>$cnv, TITLE=>"IupGLCanvas Example" );

$dlg->Show();

IUP->MainLoop if (IUP->MainLoopLevel == 0);
