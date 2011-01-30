# IupFrame Example in IupLua;
# Draws a frame around a button. Note that FGCOLOR is added to the frame but;
# it is inherited by the button.;

use IUP ':all';

# Creates frame with a label;
my $frame = IUP::Frame->new( IUP::Hbox->new( MARGIN=>"20x20", child=>[
              IUP::Fill->new(),
              IUP::Label->new( TITLE=>"IupFrame Test" ),
              IUP::Fill->new(),
            ] ) );
	    
# Sets label's attributes;
$frame->FGCOLOR("255 0 0");
$frame->SIZE   ("EIGHTHxEIGHTH");
$frame->TITLE  ("This is the frame");

# xxx TODO fix attribute
# xxx $frame->MARGIN ("10x10");
# xxx ask if IupFrame has MARGIN attribute
# xxx nechodi: $frame->SetAttribute("MARGIN", "10x10");

# Creates dialog;
# xxx my $dialog = IUP::Dialog->new( child=>$frame );
my $dialog = IUP::Dialog->new( child=>IUP::Hbox->new( MARGIN=>"20x20", child=>$frame ) );

# Sets dialog's title;
$dialog->TITLE("IupFrame");

$dialog->ShowXY(IUP_CENTER,IUP_CENTER); # Shows dialog in the center of the screen

if (IUP->MainLoopLevel == 0) {
  IUP->MainLoop;
}
