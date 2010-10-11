#!/usr/bin/env perl

package IUP::Constants;
use strict;
use warnings;

use base 'Exporter';
#use vars qw(@EXPORT @EXPORT_OK %EXPORT_TAGS);

our @EXPORT = qw(
  IUP_ERROR
  IUP_NOERROR
  IUP_OPENED
  IUP_INVALID

  IUP_CENTER
  IUP_LEFT
  IUP_RIGHT
  IUP_MOUSEPOS
  IUP_CURRENT
  IUP_CENTERPARENT
  IUP_TOP
  IUP_BOTTOM

  IUP_BUTTON1
  IUP_BUTTON2
  IUP_BUTTON3
  IUP_BUTTON4
  IUP_BUTTON5

  IUP_IGNORE
  IUP_DEFAULT
  IUP_CLOSE
  IUP_CONTINUE

  IUP_SBUP
  IUP_SBDN
  IUP_SBPGUP
  IUP_SBPGDN
  IUP_SBPOSV
  IUP_SBDRAGV
  IUP_SBLEFT
  IUP_SBRIGHT
  IUP_SBPGLEFT
  IUP_SBPGRIGHT
  IUP_SBPOSH
  IUP_SBDRAGH

  IUP_SHOW
  IUP_RESTORE
  IUP_MINIMIZE
  IUP_MAXIMIZE
  IUP_HIDE

  IUP_MASK_FLOAT
  IUP_MASK_UFLOAT
  IUP_MASK_EFLOAT
  IUP_MASK_INT
  IUP_MASK_UINT

  IUP_RED
  IUP_GREEN
  IUP_BLUE
  IUP_BLACK
  IUP_WHITE
  IUP_YELLOW
  
  IUP_K_SP
  IUP_K_exclam
  IUP_K_quotedbl
  IUP_K_numbersign
  IUP_K_dollar
  IUP_K_percent
  IUP_K_ampersand
  IUP_K_apostrophe
  IUP_K_parentleft
  IUP_K_parentright
  IUP_K_asterisk
  IUP_K_plus
  IUP_K_comma
  IUP_K_minus
  IUP_K_period
  IUP_K_slash
  IUP_K_0
  IUP_K_1
  IUP_K_2
  IUP_K_3
  IUP_K_4
  IUP_K_5
  IUP_K_6
  IUP_K_7
  IUP_K_8
  IUP_K_9
  IUP_K_colon
  IUP_K_semicolon
  IUP_K_less
  IUP_K_equal
  IUP_K_greater
  IUP_K_question
  IUP_K_at
  IUP_K_A
  IUP_K_B
  IUP_K_C
  IUP_K_D
  IUP_K_E
  IUP_K_F
  IUP_K_G
  IUP_K_H
  IUP_K_I
  IUP_K_J
  IUP_K_K
  IUP_K_L
  IUP_K_M
  IUP_K_N
  IUP_K_O
  IUP_K_P
  IUP_K_Q
  IUP_K_R
  IUP_K_S
  IUP_K_T
  IUP_K_U
  IUP_K_V
  IUP_K_W
  IUP_K_X
  IUP_K_Y
  IUP_K_Z
  IUP_K_bracketleft
  IUP_K_backslash
  IUP_K_bracketright
  IUP_K_circum
  IUP_K_underscore
  IUP_K_grave
  IUP_K_a
  IUP_K_b
  IUP_K_c
  IUP_K_d
  IUP_K_e
  IUP_K_f
  IUP_K_g
  IUP_K_h
  IUP_K_i
  IUP_K_j
  IUP_K_k
  IUP_K_l
  IUP_K_m
  IUP_K_n
  IUP_K_o
  IUP_K_p
  IUP_K_q
  IUP_K_r
  IUP_K_s
  IUP_K_t
  IUP_K_u
  IUP_K_v
  IUP_K_w
  IUP_K_x
  IUP_K_y
  IUP_K_z
  IUP_K_braceleft
  IUP_K_bar
  IUP_K_braceright
  IUP_K_tilde

  IUP_K_BS
  IUP_K_TAB
  IUP_K_LF
  IUP_K_CR

  IUP_isprint
  IUP_isXkey
  IUP_isShiftXkey
  IUP_isCtrlXkey
  IUP_isAltXkey
  IUP_isSysXkey
  IUP_IUP_NUMMAXCODES

  IUP_K_HOME
  IUP_K_UP
  IUP_K_PGUP
  IUP_K_LEFT
  IUP_K_MIDDLE
  IUP_K_RIGHT
  IUP_K_END
  IUP_K_DOWN
  IUP_K_PGDN
  IUP_K_INS
  IUP_K_DEL
  IUP_K_PAUSE
  IUP_K_ESC
  IUP_K_ccedilla
  IUP_K_F1
  IUP_K_F2
  IUP_K_F3
  IUP_K_F4
  IUP_K_F5
  IUP_K_F6
  IUP_K_F7
  IUP_K_F8
  IUP_K_F9
  IUP_K_F10
  IUP_K_F11
  IUP_K_F12
  IUP_K_Print
  IUP_K_Menu

  IUP_K_acute

  IUP_K_sHOME
  IUP_K_sUP
  IUP_K_sPGUP
  IUP_K_sLEFT
  IUP_K_sMIDDLE
  IUP_K_sRIGHT
  IUP_K_sEND
  IUP_K_sDOWN
  IUP_K_sPGDN
  IUP_K_sINS
  IUP_K_sDEL
  IUP_K_sSP
  IUP_K_sTAB
  IUP_K_sCR
  IUP_K_sBS
  IUP_K_sPAUSE
  IUP_K_sESC
  IUP_K_Ccedilla
  IUP_K_sF1
  IUP_K_sF2
  IUP_K_sF3
  IUP_K_sF4
  IUP_K_sF5
  IUP_K_sF6
  IUP_K_sF7
  IUP_K_sF8
  IUP_K_sF9
  IUP_K_sF10
  IUP_K_sF11
  IUP_K_sF12
  IUP_K_sPrint
  IUP_K_sMenu

  IUP_K_cHOME
  IUP_K_cUP
  IUP_K_cPGUP
  IUP_K_cLEFT
  IUP_K_cMIDDLE
  IUP_K_cRIGHT
  IUP_K_cEND
  IUP_K_cDOWN
  IUP_K_cPGDN
  IUP_K_cINS
  IUP_K_cDEL
  IUP_K_cSP
  IUP_K_cTAB
  IUP_K_cCR
  IUP_K_cBS
  IUP_K_cPAUSE
  IUP_K_cESC
  IUP_K_cCcedilla
  IUP_K_cF1
  IUP_K_cF2
  IUP_K_cF3
  IUP_K_cF4
  IUP_K_cF5
  IUP_K_cF6
  IUP_K_cF7
  IUP_K_cF8
  IUP_K_cF9
  IUP_K_cF10
  IUP_K_cF11
  IUP_K_cF12
  IUP_K_cPrint
  IUP_K_cMenu

  IUP_K_mHOME
  IUP_K_mUP
  IUP_K_mPGUP
  IUP_K_mLEFT
  IUP_K_mMIDDLE
  IUP_K_mRIGHT
  IUP_K_mEND
  IUP_K_mDOWN
  IUP_K_mPGDN
  IUP_K_mINS
  IUP_K_mDEL
  IUP_K_mSP
  IUP_K_mTAB
  IUP_K_mCR
  IUP_K_mBS
  IUP_K_mPAUSE
  IUP_K_mESC
  IUP_K_mCcedilla
  IUP_K_mF1
  IUP_K_mF2
  IUP_K_mF3
  IUP_K_mF4
  IUP_K_mF5
  IUP_K_mF6
  IUP_K_mF7
  IUP_K_mF8
  IUP_K_mF9
  IUP_K_mF10
  IUP_K_mF11
  IUP_K_mF12
  IUP_K_mPrint
  IUP_K_mMenu

  IUP_K_yHOME
  IUP_K_yUP
  IUP_K_yPGUP
  IUP_K_yLEFT
  IUP_K_yMIDDLE
  IUP_K_yRIGHT
  IUP_K_yEND
  IUP_K_yDOWN
  IUP_K_yPGDN
  IUP_K_yINS
  IUP_K_yDEL
  IUP_K_ySP
  IUP_K_yTAB
  IUP_K_yCR
  IUP_K_yBS
  IUP_K_yPAUSE
  IUP_K_yESC
  IUP_K_yCcedilla
  IUP_K_yF1
  IUP_K_yF2
  IUP_K_yF3
  IUP_K_yF4
  IUP_K_yF5
  IUP_K_yF6
  IUP_K_yF7
  IUP_K_yF8
  IUP_K_yF9
  IUP_K_yF10
  IUP_K_yF11
  IUP_K_yF12
  IUP_K_yPrint
  IUP_K_yMenu

  IUP_K_sPlus
  IUP_K_sComma
  IUP_K_sMinus
  IUP_K_sPeriod
  IUP_K_sSlash

  IUP_K_cA
  IUP_K_cB
  IUP_K_cC
  IUP_K_cD
  IUP_K_cE
  IUP_K_cF
  IUP_K_cG
  IUP_K_cH
  IUP_K_cI
  IUP_K_cJ
  IUP_K_cK
  IUP_K_cL
  IUP_K_cM
  IUP_K_cN
  IUP_K_cO
  IUP_K_cP
  IUP_K_cQ
  IUP_K_cR
  IUP_K_cS
  IUP_K_cT
  IUP_K_cU
  IUP_K_cV
  IUP_K_cW
  IUP_K_cX
  IUP_K_cY
  IUP_K_cZ
  IUP_K_c1
  IUP_K_c2
  IUP_K_c3
  IUP_K_c4
  IUP_K_c5
  IUP_K_c6
  IUP_K_c7
  IUP_K_c8
  IUP_K_c9
  IUP_K_c0
  IUP_K_cPlus
  IUP_K_cComma
  IUP_K_cMinus
  IUP_K_cPeriod
  IUP_K_cSlash
  IUP_K_cSemicolon
  IUP_K_cEqual
  IUP_K_cBracketleft
  IUP_K_cBracketright
  IUP_K_cBackslash
  IUP_K_cAsterisk

  IUP_K_mA
  IUP_K_mB
  IUP_K_mC
  IUP_K_mD
  IUP_K_mE
  IUP_K_mF
  IUP_K_mG
  IUP_K_mH
  IUP_K_mI
  IUP_K_mJ
  IUP_K_mK
  IUP_K_mL
  IUP_K_mM
  IUP_K_mN
  IUP_K_mO
  IUP_K_mP
  IUP_K_mQ
  IUP_K_mR
  IUP_K_mS
  IUP_K_mT
  IUP_K_mU
  IUP_K_mV
  IUP_K_mW
  IUP_K_mX
  IUP_K_mY
  IUP_K_mZ
  IUP_K_m1
  IUP_K_m2
  IUP_K_m3
  IUP_K_m4
  IUP_K_m5
  IUP_K_m6
  IUP_K_m7
  IUP_K_m8
  IUP_K_m9
  IUP_K_m0
  IUP_K_mPlus
  IUP_K_mComma
  IUP_K_mMinus
  IUP_K_mPeriod
  IUP_K_mSlash
  IUP_K_mSemicolon
  IUP_K_mEqual
  IUP_K_mBracketleft
  IUP_K_mBracketright
  IUP_K_mBackslash
  IUP_K_mAsterisk

  IUP_K_yA
  IUP_K_yB
  IUP_K_yC
  IUP_K_yD
  IUP_K_yE
  IUP_K_yF
  IUP_K_yG
  IUP_K_yH
  IUP_K_yI
  IUP_K_yJ
  IUP_K_yK
  IUP_K_yL
  IUP_K_yM
  IUP_K_yN
  IUP_K_yO
  IUP_K_yP
  IUP_K_yQ
  IUP_K_yR
  IUP_K_yS
  IUP_K_yT
  IUP_K_yU
  IUP_K_yV
  IUP_K_yW
  IUP_K_yX
  IUP_K_yY
  IUP_K_yZ
  IUP_K_y1
  IUP_K_y2
  IUP_K_y3
  IUP_K_y4
  IUP_K_y5
  IUP_K_y6
  IUP_K_y7
  IUP_K_y8
  IUP_K_y9
  IUP_K_y0
  IUP_K_yPlus
  IUP_K_yComma
  IUP_K_yMinus
  IUP_K_yPeriod
  IUP_K_ySlash
  IUP_K_ySemicolon
  IUP_K_yEqual
  IUP_K_yBracketleft
  IUP_K_yBracketright
  IUP_K_yBackslash
  IUP_K_yAsterisk

);

# Common return values
use constant IUP_ERROR         => 1;
use constant IUP_NOERROR       => 0;
use constant IUP_OPENED        => -1;
use constant IUP_INVALID       => -1;

# IupPopup e IupShowXY  
use constant IUP_CENTER        => 0xFFFF; # 65535
use constant IUP_LEFT          => 0xFFFE; # 65534
use constant IUP_RIGHT         => 0xFFFD; # 65533
use constant IUP_MOUSEPOS      => 0xFFFC; # 65532
use constant IUP_CURRENT       => 0xFFFB; # 65531
use constant IUP_CENTERPARENT  => 0xFFFA; # 65530
use constant IUP_TOP           => 0xFFFE; # = IUP_LEFT
use constant IUP_BOTTOM        => 0xFFFD; # = IUP_RIGHT

# BUTTON_CB
use constant IUP_BUTTON1       => 1;
use constant IUP_BUTTON2       => 2;
use constant IUP_BUTTON3       => 3;
use constant IUP_BUTTON4       => 4;
use constant IUP_BUTTON5       => 5;

# Callback return values
use constant IUP_IGNORE        => -1;
use constant IUP_DEFAULT       => -2;
use constant IUP_CLOSE         => -3;
use constant IUP_CONTINUE      => -4;

# Scrollbar
use constant IUP_SBUP          => 0;
use constant IUP_SBDN          => 1;
use constant IUP_SBPGUP        => 2;
use constant IUP_SBPGDN        => 3;
use constant IUP_SBPOSV        => 4;
use constant IUP_SBDRAGV       => 5;
use constant IUP_SBLEFT        => 6;
use constant IUP_SBRIGHT       => 7;
use constant IUP_SBPGLEFT      => 8;
use constant IUP_SBPGRIGHT     => 9;
use constant IUP_SBPOSH        => 10;
use constant IUP_SBDRAGH       => 11;

# SHOW_CB
use constant IUP_SHOW          => 0;
use constant IUP_RESTORE       => 1;
use constant IUP_MINIMIZE      => 2;
use constant IUP_MAXIMIZE      => 3;
use constant IUP_HIDE          => 4;

# Pre-Defined Masks        
use constant IUP_MASK_FLOAT    => "[+/-]?(/d+/.?/d*|/./d+)";
use constant IUP_MASK_UFLOAT   => "(/d+/.?/d*|/./d+)";
use constant IUP_MASK_EFLOAT   => "[+/-]?(/d+/.?/d*|/./d+)([eE][+/-]?/d+)?";
use constant IUP_MASK_INT      => "[+/-]?/d+";
use constant IUP_MASK_UINT     => "/d+";

# Pre-Defined Colors
use constant IUP_RED           => "255 0 0";
use constant IUP_GREEN         => "0 255 0";
use constant IUP_BLUE          => "0 0 255";
use constant IUP_BLACK         => "0 0 0";
use constant IUP_WHITE         => "1 1 1";
use constant IUP_YELLOW        => "1 1 0";

### keys ###

# from 32 to 126, all character sets are equal, the key code is the same as the character code.

use constant IUP_K_SP          => 32; # ' ' (0x20)
use constant IUP_K_exclam      => 33; # '!'
use constant IUP_K_quotedbl    => 34; # '\"'
use constant IUP_K_numbersign  => 35; # '#'
use constant IUP_K_dollar      => 36; # '$'
use constant IUP_K_percent     => 37; # '%'
use constant IUP_K_ampersand   => 38; # '&'
use constant IUP_K_apostrophe  => 39; # '\''
use constant IUP_K_parentleft  => 40; # '('
use constant IUP_K_parentright => 41; # ')'
use constant IUP_K_asterisk    => 42; # '*'
use constant IUP_K_plus        => 43; # '+'
use constant IUP_K_comma       => 44; # ','
use constant IUP_K_minus       => 45; # '-'
use constant IUP_K_period      => 46; # '.'
use constant IUP_K_slash       => 47; # '/'
use constant IUP_K_0           => 48; # '0' (0x30)
use constant IUP_K_1           => 49; # '1'
use constant IUP_K_2           => 50; # '2'
use constant IUP_K_3           => 51; # '3'
use constant IUP_K_4           => 52; # '4'
use constant IUP_K_5           => 53; # '5'
use constant IUP_K_6           => 54; # '6'
use constant IUP_K_7           => 55; # '7'
use constant IUP_K_8           => 56; # '8'
use constant IUP_K_9           => 57; # '9'
use constant IUP_K_colon       => 58; # ':'
use constant IUP_K_semicolon   => 59; # ';'
use constant IUP_K_less        => 60; # '<'
use constant IUP_K_equal       => 61; # '='
use constant IUP_K_greater     => 62; # '>'
use constant IUP_K_question    => 63; # '?'
use constant IUP_K_at          => 64; # '@'
use constant IUP_K_A           => 65; # 'A' (0x41)
use constant IUP_K_B           => 66; # 'B'
use constant IUP_K_C           => 67; # 'C'
use constant IUP_K_D           => 68; # 'D'
use constant IUP_K_E           => 69; # 'E'
use constant IUP_K_F           => 70; # 'F'
use constant IUP_K_G           => 71; # 'G'
use constant IUP_K_H           => 72; # 'H'
use constant IUP_K_I           => 73; # 'I'
use constant IUP_K_J           => 74; # 'J'
use constant IUP_K_K           => 75; # 'K'
use constant IUP_K_L           => 76; # 'L'
use constant IUP_K_M           => 77; # 'M'
use constant IUP_K_N           => 78; # 'N'
use constant IUP_K_O           => 79; # 'O'
use constant IUP_K_P           => 80; # 'P'
use constant IUP_K_Q           => 81; # 'Q'
use constant IUP_K_R           => 82; # 'R'
use constant IUP_K_S           => 83; # 'S'
use constant IUP_K_T           => 84; # 'T'
use constant IUP_K_U           => 85; # 'U'
use constant IUP_K_V           => 86; # 'V'
use constant IUP_K_W           => 87; # 'W'
use constant IUP_K_X           => 88; # 'X'
use constant IUP_K_Y           => 89; # 'Y'
use constant IUP_K_Z           => 90; # 'Z'
use constant IUP_K_bracketleft => 91; # ''['
use constant IUP_K_backslash   => 92; # '\\'
use constant IUP_K_bracketright=> 93; # '']'
use constant IUP_K_circum      => 94; # '^'
use constant IUP_K_underscore  => 95; # ''_'
use constant IUP_K_grave       => 96; # '`'
use constant IUP_K_a           => 97; # 'a' (0x61)
use constant IUP_K_b           => 98; # 'b'
use constant IUP_K_c           => 99; # 'c'
use constant IUP_K_d           => 100; # 'd'
use constant IUP_K_e           => 101; # 'e'
use constant IUP_K_f           => 102; # 'f'
use constant IUP_K_g           => 103; # 'g'
use constant IUP_K_h           => 104; # 'h'
use constant IUP_K_i           => 105; # 'i'
use constant IUP_K_j           => 106; # 'j'
use constant IUP_K_k           => 107; # 'k'
use constant IUP_K_l           => 108; # 'l'
use constant IUP_K_m           => 109; # 'm'
use constant IUP_K_n           => 110; # 'n'
use constant IUP_K_o           => 111; # 'o'
use constant IUP_K_p           => 112; # 'p'
use constant IUP_K_q           => 113; # 'q'
use constant IUP_K_r           => 114; # 'r'
use constant IUP_K_s           => 115; # 's'
use constant IUP_K_t           => 116; # 't'
use constant IUP_K_u           => 117; # 'u'
use constant IUP_K_v           => 118; # 'v'
use constant IUP_K_w           => 119; # 'w'
use constant IUP_K_x           => 120; # 'x'
use constant IUP_K_y           => 121; # 'y'
use constant IUP_K_z           => 122; # 'z'
use constant IUP_K_braceleft   => 123; # '{'
use constant IUP_K_bar         => 124; # '|'
use constant IUP_K_braceright  => 125; # ''}'
use constant IUP_K_tilde       => 126; # '~'

# also define the escape sequences that have keys associated

use constant IUP_K_BS     => 8; # '\b'
use constant IUP_K_TAB    => 9; # '\t'
use constant IUP_K_LF     => 10; # '\n' (0x0A) not a real key, is a combination of CR with a modifier, just to document
use constant IUP_K_CR     => 13; # '\r' (0x0D)

# IUP Extended Key Codes, range start at 128
# Modifiers use 256 interval
# These key code definitions are specific to IUP

sub IUP_isXkey      { return ($_[0] > 128) };
sub IUP_isShiftXkey { return ($_[0] > 256  && $_[0] < 512) };
sub IUP_isCtrlXkey  { return ($_[0] > 512  && $_[0] < 768) };
sub IUP_isAltXkey   { return ($_[0] > 768  && $_[0] < 1024) };
sub IUP_isSysXkey   { return ($_[0] > 1024 && $_[0] < 1280) };

# xxx TODO xxx case not fixed, check what is 'isprint'
sub IUP_isprint     { return ($_[0] > 31 && $_[0] < 127) };

# xxx TODO xxx case not fixed
sub IUP_isSshift     { return ($_[0] eq 'S') };
sub IUP_isControl   { return ($_[0] eq 'C') };
sub IUP_isAlt       { return ($_[0] eq 'A') };
sub IUP_isSys       { return ($_[0] eq 'Y') };
sub IUP_isButton1   { return ($_[0] eq '1') };
sub IUP_isButton2   { return ($_[0] eq '2') };
sub IUP_isButton3   { return ($_[0] eq '3') };
sub IUP_isButton4   { return ($_[0] eq '4') };
sub IUP_isButton5   { return ($_[0] eq '5') };
sub IUP_isDouble    { return ($_[0] eq 'D') };

# N + 128  - Normal (must be above 128)
# N + 256  - Shift (must have range to include the standard keys and the normal extended keys, so must be above 256
# N + 512  - Ctrl
# N + 768  - Alt
# N + 1024 - Sys (Win or Apple)

use constant IUP_IUP_NUMMAXCODES => 1280; # 5*256=1280  Normal+Shift+Ctrl+Alt+Sys

use constant IUP_K_HOME     => 128 + 1;
use constant IUP_K_UP       => 128 + 2;
use constant IUP_K_PGUP     => 128 + 3;
use constant IUP_K_LEFT     => 128 + 4;
use constant IUP_K_MIDDLE   => 128 + 5;
use constant IUP_K_RIGHT    => 128 + 6;
use constant IUP_K_END      => 128 + 7;
use constant IUP_K_DOWN     => 128 + 8;
use constant IUP_K_PGDN     => 128 + 9;
use constant IUP_K_INS      => 128 + 10;
use constant IUP_K_DEL      => 128 + 11;
use constant IUP_K_PAUSE    => 128 + 12;
use constant IUP_K_ESC      => 128 + 13;
use constant IUP_K_ccedilla => 128 + 14; # xxx TODO IUP_K_ccedilla vs. IUP_K_Ccedilla
use constant IUP_K_F1       => 128 + 15;
use constant IUP_K_F2       => 128 + 16;
use constant IUP_K_F3       => 128 + 17;
use constant IUP_K_F4       => 128 + 18;
use constant IUP_K_F5       => 128 + 19;
use constant IUP_K_F6       => 128 + 20;
use constant IUP_K_F7       => 128 + 21;
use constant IUP_K_F8       => 128 + 22;
use constant IUP_K_F9       => 128 + 23;
use constant IUP_K_F10      => 128 + 24;
use constant IUP_K_F11      => 128 + 25;
use constant IUP_K_F12      => 128 + 26;
use constant IUP_K_Print    => 128 + 27;
use constant IUP_K_Menu     => 128 + 28;

use constant IUP_K_acute    => 128 + 29; # no Shift/Ctrl/Alt

use constant IUP_K_sHOME    => 256 + IUP_K_HOME;
use constant IUP_K_sUP      => 256 + IUP_K_UP;
use constant IUP_K_sPGUP    => 256 + IUP_K_PGUP;
use constant IUP_K_sLEFT    => 256 + IUP_K_LEFT;
use constant IUP_K_sMIDDLE  => 256 + IUP_K_MIDDLE;
use constant IUP_K_sRIGHT   => 256 + IUP_K_RIGHT;
use constant IUP_K_sEND     => 256 + IUP_K_END;
use constant IUP_K_sDOWN    => 256 + IUP_K_DOWN;
use constant IUP_K_sPGDN    => 256 + IUP_K_PGDN;
use constant IUP_K_sINS     => 256 + IUP_K_INS;
use constant IUP_K_sDEL     => 256 + IUP_K_DEL;
use constant IUP_K_sSP      => 256 + IUP_K_SP;
use constant IUP_K_sTAB     => 256 + IUP_K_TAB;
use constant IUP_K_sCR      => 256 + IUP_K_CR;
use constant IUP_K_sBS      => 256 + IUP_K_BS;
use constant IUP_K_sPAUSE   => 256 + IUP_K_PAUSE;
use constant IUP_K_sESC     => 256 + IUP_K_ESC;
use constant IUP_K_Ccedilla => 256 + IUP_K_ccedilla; # xxx TODO xxx IUP_K_ccedilla vs. IUP_K_Ccedilla
use constant IUP_K_sF1      => 256 + IUP_K_F1;
use constant IUP_K_sF2      => 256 + IUP_K_F2;
use constant IUP_K_sF3      => 256 + IUP_K_F3;
use constant IUP_K_sF4      => 256 + IUP_K_F4;
use constant IUP_K_sF5      => 256 + IUP_K_F5;
use constant IUP_K_sF6      => 256 + IUP_K_F6;
use constant IUP_K_sF7      => 256 + IUP_K_F7;
use constant IUP_K_sF8      => 256 + IUP_K_F8;
use constant IUP_K_sF9      => 256 + IUP_K_F9;
use constant IUP_K_sF10     => 256 + IUP_K_F10;
use constant IUP_K_sF11     => 256 + IUP_K_F11;
use constant IUP_K_sF12     => 256 + IUP_K_F12;
use constant IUP_K_sPrint   => 256 + IUP_K_Print;
use constant IUP_K_sMenu    => 256 + IUP_K_Menu;

use constant IUP_K_cHOME     => 512 + IUP_K_HOME;
use constant IUP_K_cUP       => 512 + IUP_K_UP;
use constant IUP_K_cPGUP     => 512 + IUP_K_PGUP;
use constant IUP_K_cLEFT     => 512 + IUP_K_LEFT;
use constant IUP_K_cMIDDLE   => 512 + IUP_K_MIDDLE;
use constant IUP_K_cRIGHT    => 512 + IUP_K_RIGHT;
use constant IUP_K_cEND      => 512 + IUP_K_END;
use constant IUP_K_cDOWN     => 512 + IUP_K_DOWN;
use constant IUP_K_cPGDN     => 512 + IUP_K_PGDN;
use constant IUP_K_cINS      => 512 + IUP_K_INS;
use constant IUP_K_cDEL      => 512 + IUP_K_DEL;
use constant IUP_K_cSP       => 512 + IUP_K_SP;
use constant IUP_K_cTAB      => 512 + IUP_K_TAB;
use constant IUP_K_cCR       => 512 + IUP_K_CR;
use constant IUP_K_cBS       => 512 + IUP_K_BS;
use constant IUP_K_cPAUSE    => 512 + IUP_K_PAUSE;
use constant IUP_K_cESC      => 512 + IUP_K_ESC;
use constant IUP_K_cCcedilla => 512 + IUP_K_ccedilla;
use constant IUP_K_cF1       => 512 + IUP_K_F1;
use constant IUP_K_cF2       => 512 + IUP_K_F2;
use constant IUP_K_cF3       => 512 + IUP_K_F3;
use constant IUP_K_cF4       => 512 + IUP_K_F4;
use constant IUP_K_cF5       => 512 + IUP_K_F5;
use constant IUP_K_cF6       => 512 + IUP_K_F6;
use constant IUP_K_cF7       => 512 + IUP_K_F7;
use constant IUP_K_cF8       => 512 + IUP_K_F8;
use constant IUP_K_cF9       => 512 + IUP_K_F9;
use constant IUP_K_cF10      => 512 + IUP_K_F10;
use constant IUP_K_cF11      => 512 + IUP_K_F11;
use constant IUP_K_cF12      => 512 + IUP_K_F12;
use constant IUP_K_cPrint    => 512 + IUP_K_Print;
use constant IUP_K_cMenu     => 512 + IUP_K_Menu;

use constant IUP_K_mHOME     => 768 + IUP_K_HOME;
use constant IUP_K_mUP       => 768 + IUP_K_UP;
use constant IUP_K_mPGUP     => 768 + IUP_K_PGUP;
use constant IUP_K_mLEFT     => 768 + IUP_K_LEFT;
use constant IUP_K_mMIDDLE   => 768 + IUP_K_MIDDLE;
use constant IUP_K_mRIGHT    => 768 + IUP_K_RIGHT;
use constant IUP_K_mEND      => 768 + IUP_K_END;
use constant IUP_K_mDOWN     => 768 + IUP_K_DOWN;
use constant IUP_K_mPGDN     => 768 + IUP_K_PGDN;
use constant IUP_K_mINS      => 768 + IUP_K_INS;
use constant IUP_K_mDEL      => 768 + IUP_K_DEL;
use constant IUP_K_mSP       => 768 + IUP_K_SP;
use constant IUP_K_mTAB      => 768 + IUP_K_TAB;
use constant IUP_K_mCR       => 768 + IUP_K_CR;
use constant IUP_K_mBS       => 768 + IUP_K_BS;
use constant IUP_K_mPAUSE    => 768 + IUP_K_PAUSE;
use constant IUP_K_mESC      => 768 + IUP_K_ESC;
use constant IUP_K_mCcedilla => 768 + IUP_K_ccedilla;
use constant IUP_K_mF1       => 768 + IUP_K_F1;
use constant IUP_K_mF2       => 768 + IUP_K_F2;
use constant IUP_K_mF3       => 768 + IUP_K_F3;
use constant IUP_K_mF4       => 768 + IUP_K_F4;
use constant IUP_K_mF5       => 768 + IUP_K_F5;
use constant IUP_K_mF6       => 768 + IUP_K_F6;
use constant IUP_K_mF7       => 768 + IUP_K_F7;
use constant IUP_K_mF8       => 768 + IUP_K_F8;
use constant IUP_K_mF9       => 768 + IUP_K_F9;
use constant IUP_K_mF10      => 768 + IUP_K_F10;
use constant IUP_K_mF11      => 768 + IUP_K_F11;
use constant IUP_K_mF12      => 768 + IUP_K_F12;
use constant IUP_K_mPrint    => 768 + IUP_K_Print;
use constant IUP_K_mMenu     => 768 + IUP_K_Menu;

use constant IUP_K_yHOME     => 1024 + IUP_K_HOME;
use constant IUP_K_yUP       => 1024 + IUP_K_UP;
use constant IUP_K_yPGUP     => 1024 + IUP_K_PGUP;
use constant IUP_K_yLEFT     => 1024 + IUP_K_LEFT;
use constant IUP_K_yMIDDLE   => 1024 + IUP_K_MIDDLE;
use constant IUP_K_yRIGHT    => 1024 + IUP_K_RIGHT;
use constant IUP_K_yEND      => 1024 + IUP_K_END;
use constant IUP_K_yDOWN     => 1024 + IUP_K_DOWN;
use constant IUP_K_yPGDN     => 1024 + IUP_K_PGDN;
use constant IUP_K_yINS      => 1024 + IUP_K_INS;
use constant IUP_K_yDEL      => 1024 + IUP_K_DEL;
use constant IUP_K_ySP       => 1024 + IUP_K_SP;
use constant IUP_K_yTAB      => 1024 + IUP_K_TAB;
use constant IUP_K_yCR       => 1024 + IUP_K_CR;
use constant IUP_K_yBS       => 1024 + IUP_K_BS;
use constant IUP_K_yPAUSE    => 1024 + IUP_K_PAUSE;
use constant IUP_K_yESC      => 1024 + IUP_K_ESC;
use constant IUP_K_yCcedilla => 1024 + IUP_K_ccedilla;
use constant IUP_K_yF1       => 1024 + IUP_K_F1;
use constant IUP_K_yF2       => 1024 + IUP_K_F2;
use constant IUP_K_yF3       => 1024 + IUP_K_F3;
use constant IUP_K_yF4       => 1024 + IUP_K_F4;
use constant IUP_K_yF5       => 1024 + IUP_K_F5;
use constant IUP_K_yF6       => 1024 + IUP_K_F6;
use constant IUP_K_yF7       => 1024 + IUP_K_F7;
use constant IUP_K_yF8       => 1024 + IUP_K_F8;
use constant IUP_K_yF9       => 1024 + IUP_K_F9;
use constant IUP_K_yF10      => 1024 + IUP_K_F10;
use constant IUP_K_yF11      => 1024 + IUP_K_F11;
use constant IUP_K_yF12      => 1024 + IUP_K_F12;
use constant IUP_K_yPrint    => 1024 + IUP_K_Print;
use constant IUP_K_yMenu     => 1024 + IUP_K_Menu;

use constant IUP_K_sPlus         => 256 + IUP_K_plus;
use constant IUP_K_sComma        => 256 + IUP_K_comma;
use constant IUP_K_sMinus        => 256 + IUP_K_minus;
use constant IUP_K_sPeriod       => 256 + IUP_K_period;
use constant IUP_K_sSlash        => 256 + IUP_K_slash;
# xxx TODO xxx use constant IUP_K_sAsterisk     => 256 + IUP_K;

use constant IUP_K_cA     => 512 + IUP_K_A;
use constant IUP_K_cB     => 512 + IUP_K_B;
use constant IUP_K_cC     => 512 + IUP_K_C;
use constant IUP_K_cD     => 512 + IUP_K_D;
use constant IUP_K_cE     => 512 + IUP_K_E;
use constant IUP_K_cF     => 512 + IUP_K_F;
use constant IUP_K_cG     => 512 + IUP_K_G;
use constant IUP_K_cH     => 512 + IUP_K_H;
use constant IUP_K_cI     => 512 + IUP_K_I;
use constant IUP_K_cJ     => 512 + IUP_K_J;
use constant IUP_K_cK     => 512 + IUP_K_K;
use constant IUP_K_cL     => 512 + IUP_K_L;
use constant IUP_K_cM     => 512 + IUP_K_M;
use constant IUP_K_cN     => 512 + IUP_K_N;
use constant IUP_K_cO     => 512 + IUP_K_O;
use constant IUP_K_cP     => 512 + IUP_K_P;
use constant IUP_K_cQ     => 512 + IUP_K_Q;
use constant IUP_K_cR     => 512 + IUP_K_R;
use constant IUP_K_cS     => 512 + IUP_K_S;
use constant IUP_K_cT     => 512 + IUP_K_T;
use constant IUP_K_cU     => 512 + IUP_K_U;
use constant IUP_K_cV     => 512 + IUP_K_V;
use constant IUP_K_cW     => 512 + IUP_K_W;
use constant IUP_K_cX     => 512 + IUP_K_X;
use constant IUP_K_cY     => 512 + IUP_K_Y;
use constant IUP_K_cZ     => 512 + IUP_K_Z;
use constant IUP_K_c1     => 512 + IUP_K_1;
use constant IUP_K_c2     => 512 + IUP_K_2;
use constant IUP_K_c3     => 512 + IUP_K_3;
use constant IUP_K_c4     => 512 + IUP_K_4;
use constant IUP_K_c5     => 512 + IUP_K_5;
use constant IUP_K_c6     => 512 + IUP_K_6;
use constant IUP_K_c7     => 512 + IUP_K_7;
use constant IUP_K_c8     => 512 + IUP_K_8;
use constant IUP_K_c9     => 512 + IUP_K_9;
use constant IUP_K_c0     => 512 + IUP_K_0;
use constant IUP_K_cPlus         => 512 + IUP_K_plus;
use constant IUP_K_cComma        => 512 + IUP_K_comma;
use constant IUP_K_cMinus        => 512 + IUP_K_minus;
use constant IUP_K_cPeriod       => 512 + IUP_K_period;
use constant IUP_K_cSlash        => 512 + IUP_K_slash;
use constant IUP_K_cSemicolon    => 512 + IUP_K_semicolon;
use constant IUP_K_cEqual        => 512 + IUP_K_equal;
use constant IUP_K_cBracketleft  => 512 + IUP_K_bracketleft;
use constant IUP_K_cBracketright => 512 + IUP_K_bracketright;
use constant IUP_K_cBackslash    => 512 + IUP_K_backslash;
use constant IUP_K_cAsterisk     => 512 + IUP_K_asterisk;

use constant IUP_K_mA     => 768 + IUP_K_A;
use constant IUP_K_mB     => 768 + IUP_K_B;
use constant IUP_K_mC     => 768 + IUP_K_C;
use constant IUP_K_mD     => 768 + IUP_K_D;
use constant IUP_K_mE     => 768 + IUP_K_E;
use constant IUP_K_mF     => 768 + IUP_K_F;
use constant IUP_K_mG     => 768 + IUP_K_G;
use constant IUP_K_mH     => 768 + IUP_K_H;
use constant IUP_K_mI     => 768 + IUP_K_I;
use constant IUP_K_mJ     => 768 + IUP_K_J;
use constant IUP_K_mK     => 768 + IUP_K_K;
use constant IUP_K_mL     => 768 + IUP_K_L;
use constant IUP_K_mM     => 768 + IUP_K_M;
use constant IUP_K_mN     => 768 + IUP_K_N;
use constant IUP_K_mO     => 768 + IUP_K_O;
use constant IUP_K_mP     => 768 + IUP_K_P;
use constant IUP_K_mQ     => 768 + IUP_K_Q;
use constant IUP_K_mR     => 768 + IUP_K_R;
use constant IUP_K_mS     => 768 + IUP_K_S;
use constant IUP_K_mT     => 768 + IUP_K_T;
use constant IUP_K_mU     => 768 + IUP_K_U;
use constant IUP_K_mV     => 768 + IUP_K_V;
use constant IUP_K_mW     => 768 + IUP_K_W;
use constant IUP_K_mX     => 768 + IUP_K_X;
use constant IUP_K_mY     => 768 + IUP_K_Y;
use constant IUP_K_mZ     => 768 + IUP_K_Z;
use constant IUP_K_m1     => 768 + IUP_K_1;
use constant IUP_K_m2     => 768 + IUP_K_2;
use constant IUP_K_m3     => 768 + IUP_K_3;
use constant IUP_K_m4     => 768 + IUP_K_4;
use constant IUP_K_m5     => 768 + IUP_K_5;
use constant IUP_K_m6     => 768 + IUP_K_6;
use constant IUP_K_m7     => 768 + IUP_K_7;
use constant IUP_K_m8     => 768 + IUP_K_8;
use constant IUP_K_m9     => 768 + IUP_K_9;
use constant IUP_K_m0     => 768 + IUP_K_0;
use constant IUP_K_mPlus         => 768 + IUP_K_plus;
use constant IUP_K_mComma        => 768 + IUP_K_comma;
use constant IUP_K_mMinus        => 768 + IUP_K_minus;
use constant IUP_K_mPeriod       => 768 + IUP_K_period;
use constant IUP_K_mSlash        => 768 + IUP_K_slash;
use constant IUP_K_mSemicolon    => 768 + IUP_K_semicolon;
use constant IUP_K_mEqual        => 768 + IUP_K_equal;
use constant IUP_K_mBracketleft  => 768 + IUP_K_bracketleft;
use constant IUP_K_mBracketright => 768 + IUP_K_bracketright;
use constant IUP_K_mBackslash    => 768 + IUP_K_backslash;
use constant IUP_K_mAsterisk     => 768 + IUP_K_asterisk;

use constant IUP_K_yA     => 1024 + IUP_K_A;
use constant IUP_K_yB     => 1024 + IUP_K_B;
use constant IUP_K_yC     => 1024 + IUP_K_C;
use constant IUP_K_yD     => 1024 + IUP_K_D;
use constant IUP_K_yE     => 1024 + IUP_K_E;
use constant IUP_K_yF     => 1024 + IUP_K_F;
use constant IUP_K_yG     => 1024 + IUP_K_G;
use constant IUP_K_yH     => 1024 + IUP_K_H;
use constant IUP_K_yI     => 1024 + IUP_K_I;
use constant IUP_K_yJ     => 1024 + IUP_K_J;
use constant IUP_K_yK     => 1024 + IUP_K_K;
use constant IUP_K_yL     => 1024 + IUP_K_L;
use constant IUP_K_yM     => 1024 + IUP_K_M;
use constant IUP_K_yN     => 1024 + IUP_K_N;
use constant IUP_K_yO     => 1024 + IUP_K_O;
use constant IUP_K_yP     => 1024 + IUP_K_P;
use constant IUP_K_yQ     => 1024 + IUP_K_Q;
use constant IUP_K_yR     => 1024 + IUP_K_R;
use constant IUP_K_yS     => 1024 + IUP_K_S;
use constant IUP_K_yT     => 1024 + IUP_K_T;
use constant IUP_K_yU     => 1024 + IUP_K_U;
use constant IUP_K_yV     => 1024 + IUP_K_V;
use constant IUP_K_yW     => 1024 + IUP_K_W;
use constant IUP_K_yX     => 1024 + IUP_K_X;
use constant IUP_K_yY     => 1024 + IUP_K_Y;
use constant IUP_K_yZ     => 1024 + IUP_K_Z;
use constant IUP_K_y1     => 1024 + IUP_K_1;
use constant IUP_K_y2     => 1024 + IUP_K_2;
use constant IUP_K_y3     => 1024 + IUP_K_3;
use constant IUP_K_y4     => 1024 + IUP_K_4;
use constant IUP_K_y5     => 1024 + IUP_K_5;
use constant IUP_K_y6     => 1024 + IUP_K_6;
use constant IUP_K_y7     => 1024 + IUP_K_7;
use constant IUP_K_y8     => 1024 + IUP_K_8;
use constant IUP_K_y9     => 1024 + IUP_K_9;
use constant IUP_K_y0     => 1024 + IUP_K_0;
use constant IUP_K_yPlus         => 1024 + IUP_K_plus;
use constant IUP_K_yComma        => 1024 + IUP_K_comma;
use constant IUP_K_yMinus        => 1024 + IUP_K_minus;
use constant IUP_K_yPeriod       => 1024 + IUP_K_period;
use constant IUP_K_ySlash        => 1024 + IUP_K_slash;
use constant IUP_K_ySemicolon    => 1024 + IUP_K_semicolon;
use constant IUP_K_yEqual        => 1024 + IUP_K_equal;
use constant IUP_K_yBracketleft  => 1024 + IUP_K_bracketleft;
use constant IUP_K_yBracketright => 1024 + IUP_K_bracketright;
use constant IUP_K_yBackslash    => 1024 + IUP_K_backslash;
use constant IUP_K_yAsterisk     => 1024 + IUP_K_asterisk;

sub import {
  # hack: import Constants into caller's namespace
  my ($pkg, $callpkg) = @_;
  $callpkg ||= caller();
  #xxx warn "USING CALLER: $callpkg";
  no strict 'refs';
  *{"$callpkg\::$_"} = \&{"IUP::Constants::$_"} foreach @IUP::Constants::EXPORT;
}

1;
