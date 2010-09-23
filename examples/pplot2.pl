use strict;
use warnings;

use IUP;

my $tgg2;

sub delete_cb [
  my ($self, $index, $sample_index, $x, $y) = @_;
  printf("DELETE_CB(%d, %d, %g, %g)\n", $index, $sample_index, $x, $y);
  return IUP_DEFAULT;
}

sub select_cb {
my ($self, $index, $sample_index, $x, $y, $select) = @_;
  printf("SELECT_CB(%d, %d, %g, %g, %d)\n", $index, $sample_index, $x, $y, $select);
  return IUP_DEFAULT;
}

sub edit_cb {
  #(Ihandle* ih, int index, int sample_index, float x, float y, float *new_x, float *new_y)
  # xxx TODO references
  my ($self, $index, $sample_index, $x, $y, $new_x, $new_y) = @_;
  printf("EDIT_CB(%d, %d, %g, %g, %g, %g)\n", $index, $sample_index, $x, $y, $new_x, $new_y);
  return IUP_DEFAULT;
}

sub postdraw_cb {
  #(Ihandle* ih, cdCanvas* cnv)
  my ($self, $cnv) = @_;
  my ($ix, $iy) = $self->Transform(0.003, 0.02);
  $cnv->cdCanvasFont(NULL, CD_BOLD, 10);
  $cnv->cdCanvasTextAlignment(CD_SOUTH);
  $cnv->cdCanvasText($ix, $iy, "My Inline Legend");
  printf("POSTDRAW_CB()\n");
  return IUP_DEFAULT;
}

sub predraw_cb {
  #(Ihandle* ih, cdCanvas* cnv)
  my ($self, $cnv) = @_;
  printf("PREDRAW_CB()\n");
  return IUP_DEFAULT;
}

my @plot = ();

sub InitPlots {
  my $theFac;

  # PLOT 0 - MakeExamplePlot1
  $plot[0]->SetAttribute("TITLE", "AutoScale");
  $plot[0]->SetAttribute("MARGINTOP", "40");
  $plot[0]->SetAttribute("MARGINLEFT", "40");
  $plot[0]->SetAttribute("MARGINBOTTOM", "50");
  $plot[0]->SetAttribute("TITLEFONTSIZE", "16");
  $plot[0]->SetAttribute("AXS_XLABEL", "gnu (Foo)");
  $plot[0]->SetAttribute("AXS_YLABEL", "Space (m^3)");
  $plot[0]->SetAttribute("AXS_YFONTSIZE", "7");
  $plot[0]->SetAttribute("AXS_YTICKFONTSIZE", "7");
  $plot[0]->SetAttribute("LEGENDSHOW", "YES");
  $plot[0]->SetAttribute("AXS_XFONTSIZE", "10");
  $plot[0]->SetAttribute("AXS_YFONTSIZE", "10");
  $plot[0]->SetAttribute("AXS_XLABELCENTERED", "NO");
  $plot[0]->SetAttribute("AXS_YLABELCENTERED", "NO");
  
#  IupSetAttribute(plot[0], "USE_IMAGERGB", "YES");
#  IupSetAttribute(plot[0], "USE_GDI+", "YES");

  $theFac = 1.0/(100*100*100);
  $plot[0]->PPlotBegin(0);
  for (my $theI=-100; $theI<=100; $theI++) {
    my $x = $theI+50;
    my $y = $theFac*$theI*$theI*$theI;
    $plot[0]->PPlotAdd($x, $y);
  }
  $plot[0]->IupPPlotEnd();
  $plot[0]->IupSetAttribute("DS_LINEWIDTH", "3");
  $plot[0]->IupSetAttribute("DS_LEGEND", "Line");

  $theFac = 2.0/100;
  $plot[0]->PPlotBegin(0);
  for (my $theI=-100; $theI<=100; $theI++) {
    my $x = $theI;
    my $y = -$theFac*$theI;
    $plot[0]->PPlotAdd($x, $y);
  }
  $plot[0]->PPlotEnd();
  $plot[0]->SetAttribute("DS_LEGEND", "Curve 1");

  $plot[0]->PPlotBegin(0);
  for (my $theI=-100; $theI<=100; $theI++)  {
    $x = (0.01*$theI*$theI-30);
    $y = 0.01*$theI;
    $plot[0]->PPlotAdd($x, $y);
  }
  $plot[0]->PPlotEnd();
  $plot[0]->IupSetAttribute("DS_LEGEND", "Curve 2");

  # PLOT 1 - MakeExamplePlot2
  $plot[1]->SetAttribute("TITLE", "No Autoscale+No CrossOrigin");
  $plot[1]->SetAttribute("TITLEFONTSIZE", "16");
  $plot[1]->SetAttribute("MARGINTOP", "40");
  $plot[1]->SetAttribute("MARGINLEFT", "55");
  $plot[1]->SetAttribute("MARGINBOTTOM", "50");
  $plot[1]->SetAttribute("BGCOLOR", "0 192 192");
  $plot[1]->SetAttribute("AXS_XLABEL", "Tg (X)");
  $plot[1]->SetAttribute("AXS_YLABEL", "Tg (Y)");
  $plot[1]->SetAttribute("AXS_XAUTOMIN", "NO");
  $plot[1]->SetAttribute("AXS_XAUTOMAX", "NO");
  $plot[1]->SetAttribute("AXS_YAUTOMIN", "NO");
  $plot[1]->SetAttribute("AXS_YAUTOMAX", "NO");
  $plot[1]->SetAttribute("AXS_XMIN", "10");
  $plot[1]->SetAttribute("AXS_XMAX", "60");
  $plot[1]->SetAttribute("AXS_YMIN", "-0.5");
  $plot[1]->SetAttribute("AXS_YMAX", "0.5");
  $plot[1]->SetAttribute("AXS_XCROSSORIGIN", "NO");
  $plot[1]->SetAttribute("AXS_YCROSSORIGIN", "NO");
  $plot[1]->SetAttribute("AXS_XFONTSTYLE", "BOLD");
  $plot[1]->SetAttribute("AXS_YFONTSTYLE", "BOLD");
  $plot[1]->SetAttribute("AXS_XREVERSE", "YES");
  $plot[1]->SetAttribute("GRIDCOLOR", "128 255 128");
  $plot[1]->SetAttribute("GRIDLINESTYLE", "DOTTED");
  $plot[1]->SetAttribute("GRID", "YES");
  $plot[1]->SetAttribute("LEGENDSHOW", "YES");

  $theFac = 1.0/(100*100*100);
  $plot[1]->PPlotBegin(0);
  for (my $theI=0; $theI<=100; $theI++) {
    my $x = $theI;
    my $y = $theFac*$theI*$theI*$theI;
    $plot[1]->PPlotAdd($x, $y);
  }
  $plot[1]->PPlotEnd();

  $theFac = 2.0/100;
  $plot[1]->PPlotBegin(0);
  for (my $theI=0; $theI<=100; $theI++) {
    my $x = $theI;
    my $y = -$theFac*$theI;
    $plot[1]->PPlotAdd($x, $y);
  }
  $plot[1]->PPlotEnd();

  # PLOT 2 - MakeExamplePlot4
  $plot[2]->SetAttribute("TITLE", "Log Scale");
  $plot[2]->SetAttribute("TITLEFONTSIZE", "16");
  $plot[2]->SetAttribute("MARGINTOP", "40");
  $plot[2]->SetAttribute("MARGINLEFT", "70");
  $plot[2]->SetAttribute("MARGINBOTTOM", "50");
  $plot[2]->SetAttribute("GRID", "YES");
  $plot[2]->SetAttribute("AXS_XSCALE", "LOG10");
  $plot[2]->SetAttribute("AXS_YSCALE", "LOG2");
  $plot[2]->SetAttribute("AXS_XLABEL", "Tg (X)");
  $plot[2]->SetAttribute("AXS_YLABEL", "Tg (Y)");
  $plot[2]->SetAttribute("AXS_XFONTSTYLE", "BOLD");
  $plot[2]->SetAttribute("AXS_YFONTSTYLE", "BOLD");

  $theFac = 100.0/(100*100*100);
  $plot[2]->PPlotBegin(0);
  for (my $theI=0; $theI<=100; $theI++) {
    my $x = (0.0001+$theI*0.001);
    my $y = (0.01+$theFac*$theI*$theI*$theI);
    $plot[2]->PPlotAdd($x, $y);
  }
  $plot[2]->PPlotEnd(plot[2]);
  $plot[2]->SetAttribute("DS_COLOR", "100 100 200");

  # PLOT 3 - MakeExamplePlot5
  $plot[3]->SetAttribute("TITLE", "Bar Mode");
  $plot[3]->SetAttribute("TITLEFONTSIZE", "16");
  $plot[3]->SetAttribute("MARGINTOP", "40");
  $plot[3]->SetAttribute("MARGINLEFT", "30");
  $plot[3]->SetAttribute("MARGINBOTTOM", "30");
  my $kLables = ("jan", "feb", "mar", "apr", "may", "jun", "jul", "aug", "sep", "oct", "nov", "dec");
  my $kData = (1,2,3,4,5,6,7,8,9,0,1,2);

  $plot[3]->PPlotBegin(1);
  for (my $theI=0; $theI<12; $theI++) { 
    $plot[3]->PPlotAddStr($kLables[$theI], $kData[$theI]);
  }
  $plot[3]->PPlotEnd();
  $plot[3]->SetAttribute("DS_COLOR", "100 100 200");
  $plot[3]->SetAttribute("DS_MODE", "BAR");

  # PLOT 4 - MakeExamplePlot6
  $plot[4]->SetAttribute("TITLE", "Marks Mode");
  $plot[4]->SetAttribute("TITLEFONTSIZE", "16");
  $plot[4]->SetAttribute("MARGINTOP", "40");
  $plot[4]->SetAttribute("MARGINLEFT", "45");
  $plot[4]->SetAttribute("MARGINBOTTOM", "40");
  $plot[4]->SetAttribute("AXS_XAUTOMIN", "NO");
  $plot[4]->SetAttribute("AXS_XAUTOMAX", "NO");
  $plot[4]->SetAttribute("AXS_YAUTOMIN", "NO");
  $plot[4]->SetAttribute("AXS_YAUTOMAX", "NO");
  $plot[4]->SetAttribute("AXS_XMIN", "0");
  $plot[4]->SetAttribute("AXS_XMAX", "0.011");
  $plot[4]->SetAttribute("AXS_YMIN", "0");
  $plot[4]->SetAttribute("AXS_YMAX", "0.22");
  $plot[4]->SetAttribute("AXS_XCROSSORIGIN", "NO");
  $plot[4]->SetAttribute("AXS_YCROSSORIGIN", "NO");
  $plot[4]->SetAttribute("AXS_XTICKFORMAT", "%1.3f");
  $plot[4]->SetAttribute("LEGENDSHOW", "YES");
  $plot[4]->SetAttribute("LEGENDPOS", "BOTTOMRIGHT");

  $theFac = 100.0/(100*100*100);
  $plot[4]->PPlotBegin(0);
  for (my $theI=0; $theI<=10; $theI++) {
    my $x = (0.0001+$theI*0.001);
    my $y = (0.01+$theFac*$theI*$theI);
    $plot[4]->PPlotAdd($x, $y);
  }
  $plot[4]->PPlotEnd();
  $plot[4]->SetAttribute("DS_MODE", "MARKLINE");
  $plot[4]->SetAttribute("DS_SHOWVALUES", "YES");

  $plot[4]->PPlotBegin(0);
  for (my $theI=0; $theI<=10; $theI++) {
    my $x = (0.0001+$theI*0.001);
    my $y = (0.2-$theFac*$theI*$theI);
    $plot[4]->PPlotAdd($x, $y);
  }
  $plot[4]->PPlotEnd();
  $plot[4]->SetAttribute("DS_MODE", "MARK");
  $plot[4]->SetAttribute("DS_MARKSTYLE", "HOLLOW_CIRCLE");
  
  # PLOT 5 - MakeExamplePlot8
  $plot[5]->SetAttribute("TITLE", "Data Selection and Editing");
  $plot[5]->SetAttribute("TITLEFONTSIZE", "16");
  $plot[5]->SetAttribute("MARGINTOP", "40");

  $theFac = 100.0/(100*100*100);
  $plot[5]->PPlotBegin(0);
  for (my $theI=-10; $theI<=10; $theI++) {
    my $x = (0.001*$theI);
    my $y = (0.01+$theFac*$theI*$theI*$theI);
    $plot[5]->PPlotAdd($x, $y);
  }
  $plot[5]->PPlotEnd();
  $plot[5]->SetAttribute("DS_COLOR", "100 100 200");
  $plot[5]->SetAttribute("DS_EDIT", "YES");
  $plot[5]->SetCallback("DELETE_CB", (Icallback)delete_cb);
  $plot[5]->SetCallback("SELECT_CB", (Icallback)select_cb);
  $plot[5]->SetCallback("POSTDRAW_CB", (Icallback)postdraw_cb);
  $plot[5]->SetCallback("PREDRAW_CB", (Icallback)predraw_cb);
  $plot[5]->SetCallback("EDIT_CB", (Icallback)edit_cb);
}

sub tabs_get_index {
  my $curr_tab = IUP->GetByName($tabs->IupGetAttribute("VALUE"));
  my $ss = $curr_tab->GetAttribute("TABTITLE");
  $ss = substr($ss, 5); # Skip "Plot "
  return int($ss);
}

# Some processing required by current tab change: the controls at left
# will be updated according to current plot props
sub tabs_tabchange_cb {
  #(Ihandle* self, Ihandle* new_tab)
  my ($self, $new_tab) = @_;
  my $ii = 0;

  my $ss = $new_tab->GetAttribute("TABTITLE");
  $ss = substr($ss, 5); # Skip "Plot "
  $ii = int($ss);

  # autoscaling
  # X axis
  if ($plot[$ii]->GetInt("AXS_XAUTOMIN") && $plot[$ii]->GetInt("AXS_XAUTOMAX")) {
    $tgg2->VALUE("ON");
    $dial2->ACTIVE("NO");
  }
  else {
    $tgg2->VALUE("OFF");
    $dial2->ACTIVE("YES");
  }
  # Y axis
  if ($plot[$ii]->GetInt("AXS_YAUTOMIN") && $plot[$ii]->GetInt("AXS_YAUTOMAX")) {
    $tgg1->VALUE("ON");
    $dial1->ACTIVE("NO");
  }
  else {
    $tgg1->VALUE("OFF");
    $dial1->ACTIVE("YES");
  }

  # grid
  if ($plot[$ii]->GetInt("GRID"))
  {
    $tgg3->VALUE("ON");
    $tgg4->VALUE("ON");
  }
  else
  {
    # X axis
    if ($plot[$ii]->GetAttribute("GRID") eq 'V')
      $tgg3->VALUE("ON");
    else
      $tgg3->VALUE("OFF");
    # Y axis
    if ($plot[$ii]->GetAttribute("GRID") eq 'H')
      $tgg4->VALUE("ON");
    else
      $tgg4->VALUE("OFF");
  }

  # legend
  if ($plot[$ii]->GetInt("LEGENDSHOW"))
    $tgg5->VALUE("ON");
  else
    $tgg5->VALUE("OFF");

  return IUP_DEFAULT;
}
# xxx continue from here xxx

# show/hide V grid
int tgg3_cb(Ihandle *self, int v)
{
  int ii = tabs_get_index();

  if (v)
  {
    if (IupGetInt(tgg4, "VALUE"))
      IupSetAttribute(plot[ii], "GRID", "YES");
    else
      IupSetAttribute(plot[ii], "GRID", "VERTICAL");
  }
  else
  {
    if (!IupGetInt(tgg4, "VALUE"))
      IupSetAttribute(plot[ii], "GRID", "NO");
    else
      IupSetAttribute(plot[ii], "GRID", "HORIZONTAL");
  }

  IupSetAttribute(plot[ii], "REDRAW", NULL);

  return IUP_DEFAULT;
}


# show/hide H grid
int tgg4_cb(Ihandle *self, int v)
{
  int ii = tabs_get_index();

  if (v)
  {
    if (IupGetInt(tgg3, "VALUE"))
      IupSetAttribute(plot[ii], "GRID", "YES");
    else
      IupSetAttribute(plot[ii], "GRID", "HORIZONTAL");
  }
  else
  {
    if (!IupGetInt(tgg3, "VALUE"))
      IupSetAttribute(plot[ii], "GRID", "NO");
    else
      IupSetAttribute(plot[ii], "GRID", "VERTICAL");
  }

  IupSetAttribute(plot[ii], "REDRAW", NULL);

  return IUP_DEFAULT;
}


# show/hide legend
int tgg5_cb(Ihandle *self, int v)
{
  int ii = tabs_get_index();

  if (v)
    IupSetAttribute(plot[ii], "LEGENDSHOW", "YES");
  else
    IupSetAttribute(plot[ii], "LEGENDSHOW", "NO");

  IupSetAttribute(plot[ii], "REDRAW", NULL);

  return IUP_DEFAULT;
}


# autoscale Y
int tgg1_cb(Ihandle *self, int v)
{
  int ii = tabs_get_index();

  if (v) {
    IupSetAttribute(dial1, "ACTIVE", "NO");
    IupSetAttribute(plot[ii], "AXS_YAUTOMIN", "YES");
    IupSetAttribute(plot[ii], "AXS_YAUTOMAX", "YES");
  }
  else {
    IupSetAttribute(dial1, "ACTIVE", "YES");
    IupSetAttribute(plot[ii], "AXS_YAUTOMIN", "NO");
    IupSetAttribute(plot[ii], "AXS_YAUTOMAX", "NO");
  }

  IupSetAttribute(plot[ii], "REDRAW", NULL);

  return IUP_DEFAULT;
}


# autoscale X
int tgg2_cb(Ihandle *self, int v)
{
  int ii = tabs_get_index();

  if (v) {
    IupSetAttribute(dial2, "ACTIVE", "NO");
    IupSetAttribute(plot[ii], "AXS_XAUTOMIN", "YES");
    IupSetAttribute(plot[ii], "AXS_XAUTOMAX", "YES");
  }
  else {
    IupSetAttribute(dial2, "ACTIVE", "YES");
    IupSetAttribute(plot[ii], "AXS_XAUTOMIN", "NO");
    IupSetAttribute(plot[ii], "AXS_XAUTOMAX", "NO");
  }

  IupSetAttribute(plot[ii], "REDRAW", NULL);

  return IUP_DEFAULT;
}


# Y zoom
int dial1_btndown_cb(Ihandle *self, double angle)
{
  int ii = tabs_get_index();

  IupStoreAttribute(plot[ii], "OLD_YMIN", IupGetAttribute(plot[ii], "AXS_YMIN"));
  IupStoreAttribute(plot[ii], "OLD_YMAX", IupGetAttribute(plot[ii], "AXS_YMAX"));

  return IUP_DEFAULT;
}

int dial1_btnup_cb(Ihandle *self, double angle)
{
  int ii = tabs_get_index();
  double x1, x2, xm;
  char *ss;

  x1 = IupGetFloat(plot[ii], "OLD_YMIN");
  x2 = IupGetFloat(plot[ii], "OLD_YMAX");

  ss = IupGetAttribute(plot[ii], "AXS_YMODE");
  if ( ss && ss[3]=='2' ) {
    // LOG2:  one circle will zoom 2 times
    xm = 4.0 * fabs(angle) / 3.141592;
    if (angle>0.0) { x2 /= xm; x1 *= xm; }
    else { x2 *= xm; x1 /= xm; }
  }
  if ( ss && ss[3]=='1' ) {
    // LOG10:  one circle will zoom 10 times
    xm = 10.0 * fabs(angle) / 3.141592;
    if (angle>0.0) { x2 /= xm; x1 *= xm; }
    else { x2 *= xm; x1 /= xm; }
  }
  else {
    // LIN: one circle will zoom 2 times
    xm = (x1 + x2) / 2.0;
    x1 = xm - (xm - x1)*(1.0-angle*1.0/3.141592);
    x2 = xm + (x2 - xm)*(1.0-angle*1.0/3.141592);
  }

  if (x1<x2)
  {
    IupSetfAttribute(plot[ii], "AXS_YMIN", "%f", x1);
    IupSetfAttribute(plot[ii], "AXS_YMAX", "%f", x2);
  }

  IupSetAttribute(plot[ii], "REDRAW", NULL);

  return IUP_DEFAULT;
}


// X zoom
int dial2_btndown_cb(Ihandle *self, double angle)
{
  int ii = tabs_get_index();

  IupStoreAttribute(plot[ii], "OLD_XMIN", IupGetAttribute(plot[ii], "AXS_XMIN"));
  IupStoreAttribute(plot[ii], "OLD_XMAX", IupGetAttribute(plot[ii], "AXS_XMAX"));

  return IUP_DEFAULT;
}

int dial2_btnup_cb(Ihandle *self, double angle)
{
  int ii = tabs_get_index();
  double x1, x2, xm;

  x1 = IupGetFloat(plot[ii], "OLD_XMIN");
  x2 = IupGetFloat(plot[ii], "OLD_XMAX");

  xm = (x1 + x2) / 2.0;

  x1 = xm - (xm - x1)*(1.0-angle*1.0/3.141592); // one circle will zoom 2 times
  x2 = xm + (x2 - xm)*(1.0-angle*1.0/3.141592);

  IupSetfAttribute(plot[ii], "AXS_XMIN", "%f", x1);
  IupSetfAttribute(plot[ii], "AXS_XMAX", "%f", x2);

  IupSetAttribute(plot[ii], "REDRAW", NULL);

  return IUP_DEFAULT;
}

int bt1_cb(Ihandle *self)
{
  //int ii = tabs_get_index();
  //cdCanvas* cnv = cdCreateCanvas(CD_PDF, "pplot.pdf -o");
  //IupPPlotPaintTo(plot[ii], cnv);
  //cdKillCanvas(cnv);
  return IUP_DEFAULT;
}


### main ###

int main(int argc, char **argv)
{
  Ihandle *vboxr[MAXPLOT+1];       /* tabs containing the plots */
  Ihandle *dlg, *vboxl, *hbox, *lbl1, *lbl2, *lbl3, *bt1,
          *boxinfo, *boxdial1, *boxdial2, *f1, *f2;
  int ii;

  IupOpen(&argc, &argv);          // init IUP
  IupControlsOpen();  // init the addicional controls library (we use IupTabs)
  IupPPlotOpen();     // init IupPPlot library

//  cdInitGdiPlus();

  // create plots
  for (ii=0; ii<MAXPLOT; ii++)
    plot[ii] = IupPPlot();

  // left panel: plot control
  // Y zooming
  dial1 = IupDial("VERTICAL");
  lbl1 = IupLabel("+");
  lbl2 = IupLabel("-");
  boxinfo = IupVbox(lbl1, IupFill(), lbl2, NULL);
  boxdial1 = IupHbox(boxinfo, dial1, NULL);

  IupSetAttribute(boxdial1, "ALIGNMENT", "ACENTER");
  IupSetAttribute(boxinfo, "ALIGNMENT", "ACENTER");
  IupSetAttribute(boxinfo, "SIZE", "20x52");
  IupSetAttribute(boxinfo, "GAP", "2");
  IupSetAttribute(boxinfo, "MARGIN", "4");
  IupSetAttribute(boxinfo, "EXPAND", "YES");
  IupSetAttribute(lbl1, "EXPAND", "NO");
  IupSetAttribute(lbl2, "EXPAND", "NO");

  IupSetAttribute(dial1, "ACTIVE", "NO");
  IupSetAttribute(dial1, "SIZE", "20x52");
  IupSetCallback(dial1, "BUTTON_PRESS_CB", (Icallback)dial1_btndown_cb);
  IupSetCallback(dial1, "MOUSEMOVE_CB", (Icallback)dial1_btnup_cb);
  IupSetCallback(dial1, "BUTTON_RELEASE_CB", (Icallback)dial1_btnup_cb);

  tgg1 = IupToggle("Y Autoscale", NULL);
  IupSetCallback(tgg1, "ACTION", (Icallback)tgg1_cb);
  IupSetAttribute(tgg1, "VALUE", "ON");

  f1 = IupFrame( IupVbox(boxdial1, tgg1, NULL) );
  IupSetAttribute(f1, "TITLE", "Y Zoom");

  // X zooming
  dial2 = IupDial("HORIZONTAL");
  lbl1 = IupLabel("-");
  lbl2 = IupLabel("+");
  boxinfo = IupHbox(lbl1, IupFill(), lbl2, NULL);
  boxdial2 = IupVbox(dial2, boxinfo, NULL);

  IupSetAttribute(boxdial2, "ALIGNMENT", "ACENTER");
  IupSetAttribute(boxinfo, "ALIGNMENT", "ACENTER");
  IupSetAttribute(boxinfo, "SIZE", "64x16");
  IupSetAttribute(boxinfo, "GAP", "2");
  IupSetAttribute(boxinfo, "MARGIN", "4");
  IupSetAttribute(boxinfo, "EXPAND", "HORIZONTAL");

  IupSetAttribute(lbl1, "EXPAND", "NO");
  IupSetAttribute(lbl2, "EXPAND", "NO");

  IupSetAttribute(dial2, "ACTIVE", "NO");
  IupSetAttribute(dial2, "SIZE", "64x16");
  IupSetCallback(dial2, "BUTTON_PRESS_CB", (Icallback)dial2_btndown_cb);
  IupSetCallback(dial2, "MOUSEMOVE_CB", (Icallback)dial2_btnup_cb);
  IupSetCallback(dial2, "BUTTON_RELEASE_CB", (Icallback)dial2_btnup_cb);

  tgg2 = IupToggle("X Autoscale", NULL);
  IupSetCallback(tgg2, "ACTION", (Icallback)tgg2_cb);

  f2 = IupFrame( IupVbox(boxdial2, tgg2, NULL) );
  IupSetAttribute(f2, "TITLE", "X Zoom");

  lbl1 = IupLabel("");
  IupSetAttribute(lbl1, "SEPARATOR", "HORIZONTAL");

  tgg3 = IupToggle("Vertical Grid", NULL);
  IupSetCallback(tgg3, "ACTION", (Icallback)tgg3_cb);
  tgg4 = IupToggle("Horizontal Grid", NULL);
  IupSetCallback(tgg4, "ACTION", (Icallback)tgg4_cb);

  lbl2 = IupLabel("");
  IupSetAttribute(lbl2, "SEPARATOR", "HORIZONTAL");

  tgg5 = IupToggle("Legend", NULL);
  IupSetCallback(tgg5, "ACTION", (Icallback)tgg5_cb);

  lbl3 = IupLabel("");
  IupSetAttribute(lbl3, "SEPARATOR", "HORIZONTAL");

  bt1 = IupButton("Export PDF", NULL);
  IupSetCallback(bt1, "ACTION", (Icallback)bt1_cb);

  vboxl = IupVbox(f1, f2, lbl1, tgg3, tgg4, lbl2, tgg5, lbl3, bt1, NULL);
  IupSetAttribute(vboxl, "GAP", "4");
  IupSetAttribute(vboxl, "EXPAND", "NO");

  // right panel: tabs with plots
  for (ii=0; ii<MAXPLOT; ii++) {
    vboxr[ii] = IupVbox(plot[ii], NULL); // each plot a tab
    IupSetfAttribute(vboxr[ii], "TABTITLE", "Plot %d", ii); // name each tab
  }
  vboxr[MAXPLOT] = NULL; // mark end of vector

  tabs = IupTabsv(vboxr); // create tabs
  IupSetCallback(tabs, "TABCHANGE_CB", (Icallback)tabs_tabchange_cb);

  // dialog
  hbox = IupHbox(vboxl, tabs, NULL);
  IupSetAttribute(hbox, "MARGIN", "4x4");
  IupSetAttribute(hbox, "GAP", "10");
  
  dlg = IupDialog(hbox);
  IupSetAttributes(dlg, "SIZE=500x240" );
  IupSetAttribute(dlg, "TITLE", "IupPPlot Example");

  InitPlots(); // It must be able to be done independent of dialog Mapping

  tabs_tabchange_cb(tabs, vboxr[0]);

  IupShowXY(dlg, IUP_CENTER, IUP_CENTER);
  IupSetAttribute(dlg, "SIZE", NULL);

if (IUP->MainLoopLevel == 0) {
  IUP->MainLoop;
}
