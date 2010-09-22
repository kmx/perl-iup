# IupGetColor Example
# Creates a predefined color selection dialog which returns the
# selected color in the RGB format.

use IUP;

my ($r, $g, $b) = IUP->GetColor(100, 100, 255, 255, 255);

print("r=$r g=$g b=$b") if ($r);
