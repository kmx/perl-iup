# IUP::Plot example

use strict;
use warnings;

use IUP ':all';
use Scalar::Util 'looks_like_number';

#xxxTODO maybe add AxsBounds to IUP::Plot
sub AxsBounds {
  my ($self, $axs_xmin, $axs_xmax, $axs_ymin, $axs_ymax) = @_;
  if (defined $axs_xmin) {
    $self->AXS_XMIN($axs_xmin);
    $self->AXS_XAUTOMIN('NO');
  }
  if (defined $axs_xmax) {
    $self->AXS_XMAX($axs_xmax);
    $self->AXS_XAUTOMAX('NO');
  }
  if (defined $axs_ymin) {
    $self->AXS_YMIN($axs_ymin);
    $self->AXS_YAUTOMIN('NO');
  }
  if (defined $axs_ymax) {
    $self->AXS_YMAX($axs_ymax);
    $self->AXS_YAUTOMAX('NO');
  }
}

#xxxTODO maybe add AddSeries to IUP::Plot
sub AddSeries {
  my ($plot, @values) = @_;
  # are we given strings for the x values?
  $plot->PlotBegin(looks_like_number($values[0]->[0]) ? 0 : 1);
  $plot->PlotAdd($values[$_]->[0],$values[$_]->[1]) for (0..scalar(@values)-1);
  $plot->PlotEnd();
}


my $plot = IUP::Plot->new( TITLE=>"Simple Data", MARGINBOTTOM=>30, MARGINLEFT=>30 );
AxsBounds($plot, 0,100,0,100);
AddSeries($plot, [0,0],[10,10],[20,30],[30,45] );
AddSeries($plot, [40,40],[50,55],[60,60],[70,65] );

my $d = IUP::Dialog->new( TITLE=>"Easy Plotting", SIZE=>"QUARTERxQUARTER", child=>$plot );
$d->Show();

IUP->MainLoop();
