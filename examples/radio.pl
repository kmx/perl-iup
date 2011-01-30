# IupRadio Example
# Creates a dialog for the user to select his/her g}er.
# In this case, the radio element is essential to prevent the user from
# selecting both options.
use strict;
use warnings;

use IUP ':all';

my $male = IUP::Toggle->new( TITLE=>"Male" );
my $female = IUP::Toggle->new( TITLE=>"Female" );

# xxx TODO.ASKIUP xxx TIP attribute with iupradio does not work
my $exclusive = IUP::Radio->new( child=>IUP::Vbox->new( child=>[$male, $female] ),
                                 VALUE=>$female,
                                 TIP=>"Two state button - Exclusive - RADIO" );

my $frame = IUP::Frame->new( child=>$exclusive, TITLE=>"Gender" );

my $dialog = IUP::Dialog->new( child=>IUP::Hbox->new( child=>[ IUP::Fill->new(), $frame, IUP::Fill->new() ]),
                               TITLE=>"IupRadio",
                               SIZE=>140,
                               RESIZE=>"NO",
                               MINBOX=>"NO",
                               MAXBOX=>"NO"
);

$dialog->Show();

if (IUP->MainLoopLevel == 0) {
  IUP->MainLoop;
}
