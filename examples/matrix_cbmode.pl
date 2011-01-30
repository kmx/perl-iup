use strict;
use warnings;

use IUP ':all';
use Data::Dumper;

my $matrix = IUP::Matrix->new(
    NUMLIN=>3,
    NUMCOL=>3,
    NUMCOL_VISIBLE=>3,
    NUMLIN_VISIBLE=>3,
    HEIGHT0=>10,
    WIDTHDEF=>30,
    SCROLLBAR=>"NO",
);

my $titles = [ "Col.A", "Col.B", "Col.C" ];

my $data = [
   [ 1.1, 1.2, 1.3 ],
   [ 2.1, 2.2, 2.3 ],
   [ 3.1, 3.2, 3.3 ],
 ];

# xxx TODO xxx how to define line titles
 
$matrix->VALUE_CB( sub {
  my ($self, $l, $c) = @_;
  warn "XXXX xxx cb1: $l, $c";
  if ($l>0 && $c>0) {
    return $data->[$l-1]->[$c-1];
  }
  elsif ($l==0 && $c>0) {
    # column title
    return $titles->[$c-1];
  }
  return;  
} );

$matrix->VALUE_EDIT_CB( sub {
  my ($self, $l, $c, $newvalue) = @_;
  warn "XXXX xxx cb2: $l, $c";
  $data->[$l-1]->[$c-1] = $newvalue;
} );

my $dlg = IUP::Dialog->new( child=>$matrix, TITLE=>"IupMatrix in Callback Mode" );
$dlg->Show();

if (IUP->MainLoopLevel == 0) {
  IUP->MainLoop;
}

# xxx TODO xxx - argument isnt numeric value - 
# xxx print STDERR Dumper($data);

