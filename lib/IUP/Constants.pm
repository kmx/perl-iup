package IUP::Constants;
use strict;
use warnings;

use base 'Exporter';

my @ex_basic = qw(
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
);

my @ex_keys = qw(
  K_SP
  K_exclam
  K_quotedbl
  K_numbersign
  K_dollar
  K_percent
  K_ampersand
  K_apostrophe
  K_parentleft
  K_parentright
  K_asterisk
  K_plus
  K_comma
  K_minus
  K_period
  K_slash
  K_0
  K_1
  K_2
  K_3
  K_4
  K_5
  K_6
  K_7
  K_8
  K_9
  K_colon
  K_semicolon
  K_less
  K_equal
  K_greater
  K_question
  K_at
  K_A
  K_B
  K_C
  K_D
  K_E
  K_F
  K_G
  K_H
  K_I
  K_J
  K_K
  K_L
  K_M
  K_N
  K_O
  K_P
  K_Q
  K_R
  K_S
  K_T
  K_U
  K_V
  K_W
  K_X
  K_Y
  K_Z
  K_bracketleft
  K_backslash
  K_bracketright
  K_circum
  K_underscore
  K_grave
  K_a
  K_b
  K_c
  K_d
  K_e
  K_f
  K_g
  K_h
  K_i
  K_j
  K_k
  K_l
  K_m
  K_n
  K_o
  K_p
  K_q
  K_r
  K_s
  K_t
  K_u
  K_v
  K_w
  K_x
  K_y
  K_z
  K_braceleft
  K_bar
  K_braceright
  K_tilde

  K_BS
  K_TAB
  K_LF
  K_CR

  K_HOME
  K_UP
  K_PGUP
  K_LEFT
  K_MIDDLE
  K_RIGHT
  K_END
  K_DOWN
  K_PGDN
  K_INS
  K_DEL
  K_PAUSE
  K_ESC
  K_ccedilla
  K_F1
  K_F2
  K_F3
  K_F4
  K_F5
  K_F6
  K_F7
  K_F8
  K_F9
  K_F10
  K_F11
  K_F12
  K_Print
  K_Menu

  K_acute

  K_sHOME
  K_sUP
  K_sPGUP
  K_sLEFT
  K_sMIDDLE
  K_sRIGHT
  K_sEND
  K_sDOWN
  K_sPGDN
  K_sINS
  K_sDEL
  K_sSP
  K_sTAB
  K_sCR
  K_sBS
  K_sPAUSE
  K_sESC
  K_Ccedilla
  K_sF1
  K_sF2
  K_sF3
  K_sF4
  K_sF5
  K_sF6
  K_sF7
  K_sF8
  K_sF9
  K_sF10
  K_sF11
  K_sF12
  K_sPrint
  K_sMenu

  K_cHOME
  K_cUP
  K_cPGUP
  K_cLEFT
  K_cMIDDLE
  K_cRIGHT
  K_cEND
  K_cDOWN
  K_cPGDN
  K_cINS
  K_cDEL
  K_cSP
  K_cTAB
  K_cCR
  K_cBS
  K_cPAUSE
  K_cESC
  K_cCcedilla
  K_cF1
  K_cF2
  K_cF3
  K_cF4
  K_cF5
  K_cF6
  K_cF7
  K_cF8
  K_cF9
  K_cF10
  K_cF11
  K_cF12
  K_cPrint
  K_cMenu

  K_mHOME
  K_mUP
  K_mPGUP
  K_mLEFT
  K_mMIDDLE
  K_mRIGHT
  K_mEND
  K_mDOWN
  K_mPGDN
  K_mINS
  K_mDEL
  K_mSP
  K_mTAB
  K_mCR
  K_mBS
  K_mPAUSE
  K_mESC
  K_mCcedilla
  K_mF1
  K_mF2
  K_mF3
  K_mF4
  K_mF5
  K_mF6
  K_mF7
  K_mF8
  K_mF9
  K_mF10
  K_mF11
  K_mF12
  K_mPrint
  K_mMenu

  K_yHOME
  K_yUP
  K_yPGUP
  K_yLEFT
  K_yMIDDLE
  K_yRIGHT
  K_yEND
  K_yDOWN
  K_yPGDN
  K_yINS
  K_yDEL
  K_ySP
  K_yTAB
  K_yCR
  K_yBS
  K_yPAUSE
  K_yESC
  K_yCcedilla
  K_yF1
  K_yF2
  K_yF3
  K_yF4
  K_yF5
  K_yF6
  K_yF7
  K_yF8
  K_yF9
  K_yF10
  K_yF11
  K_yF12
  K_yPrint
  K_yMenu

  K_sPlus
  K_sComma
  K_sMinus
  K_sPeriod
  K_sSlash
  K_sAsterisk

  K_cA
  K_cB
  K_cC
  K_cD
  K_cE
  K_cF
  K_cG
  K_cH
  K_cI
  K_cJ
  K_cK
  K_cL
  K_cM
  K_cN
  K_cO
  K_cP
  K_cQ
  K_cR
  K_cS
  K_cT
  K_cU
  K_cV
  K_cW
  K_cX
  K_cY
  K_cZ
  K_c1
  K_c2
  K_c3
  K_c4
  K_c5
  K_c6
  K_c7
  K_c8
  K_c9
  K_c0
  K_cPlus
  K_cComma
  K_cMinus
  K_cPeriod
  K_cSlash
  K_cSemicolon
  K_cEqual
  K_cBracketleft
  K_cBracketright
  K_cBackslash
  K_cAsterisk

  K_mA
  K_mB
  K_mC
  K_mD
  K_mE
  K_mF
  K_mG
  K_mH
  K_mI
  K_mJ
  K_mK
  K_mL
  K_mM
  K_mN
  K_mO
  K_mP
  K_mQ
  K_mR
  K_mS
  K_mT
  K_mU
  K_mV
  K_mW
  K_mX
  K_mY
  K_mZ
  K_m1
  K_m2
  K_m3
  K_m4
  K_m5
  K_m6
  K_m7
  K_m8
  K_m9
  K_m0
  K_mPlus
  K_mComma
  K_mMinus
  K_mPeriod
  K_mSlash
  K_mSemicolon
  K_mEqual
  K_mBracketleft
  K_mBracketright
  K_mBackslash
  K_mAsterisk

  K_yA
  K_yB
  K_yC
  K_yD
  K_yE
  K_yF
  K_yG
  K_yH
  K_yI
  K_yJ
  K_yK
  K_yL
  K_yM
  K_yN
  K_yO
  K_yP
  K_yQ
  K_yR
  K_yS
  K_yT
  K_yU
  K_yV
  K_yW
  K_yX
  K_yY
  K_yZ
  K_y1
  K_y2
  K_y3
  K_y4
  K_y5
  K_y6
  K_y7
  K_y8
  K_y9
  K_y0
  K_yPlus
  K_yComma
  K_yMinus
  K_yPeriod
  K_ySlash
  K_ySemicolon
  K_yEqual
  K_yBracketleft
  K_yBracketright
  K_yBackslash
  K_yAsterisk
);

our %EXPORT_TAGS = (
  basic => [@ex_basic],
  keys  => [@ex_keys],
  all   => [@ex_basic, @ex_keys],
);
our @EXPORT_OK = (@ex_basic, @ex_keys);
our @EXPORT = @ex_basic;

### basic ###

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

#xxx-consider-later
#use constant IUP_NUMMAXCODES => 1280; # 5*256=1280  Normal+Shift+Ctrl+Alt+Sys

# from 32 to 126, all character sets are equal, the key code is the same as the character code.
use constant K_SP          => 32; # ' ' (0x20)
use constant K_exclam      => 33; # '!'
use constant K_quotedbl    => 34; # '\"'
use constant K_numbersign  => 35; # '#'
use constant K_dollar      => 36; # '$'
use constant K_percent     => 37; # '%'
use constant K_ampersand   => 38; # '&'
use constant K_apostrophe  => 39; # '\''
use constant K_parentleft  => 40; # '('
use constant K_parentright => 41; # ')'
use constant K_asterisk    => 42; # '*'
use constant K_plus        => 43; # '+'
use constant K_comma       => 44; # ','
use constant K_minus       => 45; # '-'
use constant K_period      => 46; # '.'
use constant K_slash       => 47; # '/'
use constant K_0           => 48; # '0' (0x30)
use constant K_1           => 49; # '1'
use constant K_2           => 50; # '2'
use constant K_3           => 51; # '3'
use constant K_4           => 52; # '4'
use constant K_5           => 53; # '5'
use constant K_6           => 54; # '6'
use constant K_7           => 55; # '7'
use constant K_8           => 56; # '8'
use constant K_9           => 57; # '9'
use constant K_colon       => 58; # ':'
use constant K_semicolon   => 59; # ';'
use constant K_less        => 60; # '<'
use constant K_equal       => 61; # '='
use constant K_greater     => 62; # '>'
use constant K_question    => 63; # '?'
use constant K_at          => 64; # '@'
use constant K_A           => 65; # 'A' (0x41)
use constant K_B           => 66; # 'B'
use constant K_C           => 67; # 'C'
use constant K_D           => 68; # 'D'
use constant K_E           => 69; # 'E'
use constant K_F           => 70; # 'F'
use constant K_G           => 71; # 'G'
use constant K_H           => 72; # 'H'
use constant K_I           => 73; # 'I'
use constant K_J           => 74; # 'J'
use constant K_K           => 75; # 'K'
use constant K_L           => 76; # 'L'
use constant K_M           => 77; # 'M'
use constant K_N           => 78; # 'N'
use constant K_O           => 79; # 'O'
use constant K_P           => 80; # 'P'
use constant K_Q           => 81; # 'Q'
use constant K_R           => 82; # 'R'
use constant K_S           => 83; # 'S'
use constant K_T           => 84; # 'T'
use constant K_U           => 85; # 'U'
use constant K_V           => 86; # 'V'
use constant K_W           => 87; # 'W'
use constant K_X           => 88; # 'X'
use constant K_Y           => 89; # 'Y'
use constant K_Z           => 90; # 'Z'
use constant K_bracketleft => 91; # ''['
use constant K_backslash   => 92; # '\\'
use constant K_bracketright=> 93; # '']'
use constant K_circum      => 94; # '^'
use constant K_underscore  => 95; # ''_'
use constant K_grave       => 96; # '`'
use constant K_a           => 97; # 'a' (0x61)
use constant K_b           => 98; # 'b'
use constant K_c           => 99; # 'c'
use constant K_d           => 100; # 'd'
use constant K_e           => 101; # 'e'
use constant K_f           => 102; # 'f'
use constant K_g           => 103; # 'g'
use constant K_h           => 104; # 'h'
use constant K_i           => 105; # 'i'
use constant K_j           => 106; # 'j'
use constant K_k           => 107; # 'k'
use constant K_l           => 108; # 'l'
use constant K_m           => 109; # 'm'
use constant K_n           => 110; # 'n'
use constant K_o           => 111; # 'o'
use constant K_p           => 112; # 'p'
use constant K_q           => 113; # 'q'
use constant K_r           => 114; # 'r'
use constant K_s           => 115; # 's'
use constant K_t           => 116; # 't'
use constant K_u           => 117; # 'u'
use constant K_v           => 118; # 'v'
use constant K_w           => 119; # 'w'
use constant K_x           => 120; # 'x'
use constant K_y           => 121; # 'y'
use constant K_z           => 122; # 'z'
use constant K_braceleft   => 123; # '{'
use constant K_bar         => 124; # '|'
use constant K_braceright  => 125; # ''}'
use constant K_tilde       => 126; # '~'

# also define the escape sequences that have keys associated
use constant K_BS     => 8; # '\b'
use constant K_TAB    => 9; # '\t'
use constant K_LF     => 10; # '\n' (0x0A) not a real key, is a combination of CR with a modifier, just to document
use constant K_CR     => 13; # '\r' (0x0D)

use constant K_HOME     => 128 + 1;
use constant K_UP       => 128 + 2;
use constant K_PGUP     => 128 + 3;
use constant K_LEFT     => 128 + 4;
use constant K_MIDDLE   => 128 + 5;
use constant K_RIGHT    => 128 + 6;
use constant K_END      => 128 + 7;
use constant K_DOWN     => 128 + 8;
use constant K_PGDN     => 128 + 9;
use constant K_INS      => 128 + 10;
use constant K_DEL      => 128 + 11;
use constant K_PAUSE    => 128 + 12;
use constant K_ESC      => 128 + 13;
use constant K_ccedilla => 128 + 14;
use constant K_F1       => 128 + 15;
use constant K_F2       => 128 + 16;
use constant K_F3       => 128 + 17;
use constant K_F4       => 128 + 18;
use constant K_F5       => 128 + 19;
use constant K_F6       => 128 + 20;
use constant K_F7       => 128 + 21;
use constant K_F8       => 128 + 22;
use constant K_F9       => 128 + 23;
use constant K_F10      => 128 + 24;
use constant K_F11      => 128 + 25;
use constant K_F12      => 128 + 26;
use constant K_Print    => 128 + 27;
use constant K_Menu     => 128 + 28;

use constant K_acute    => 128 + 29; # no Shift/Ctrl/Alt

use constant K_sHOME    => 256 + K_HOME;
use constant K_sUP      => 256 + K_UP;
use constant K_sPGUP    => 256 + K_PGUP;
use constant K_sLEFT    => 256 + K_LEFT;
use constant K_sMIDDLE  => 256 + K_MIDDLE;
use constant K_sRIGHT   => 256 + K_RIGHT;
use constant K_sEND     => 256 + K_END;
use constant K_sDOWN    => 256 + K_DOWN;
use constant K_sPGDN    => 256 + K_PGDN;
use constant K_sINS     => 256 + K_INS;
use constant K_sDEL     => 256 + K_DEL;
use constant K_sSP      => 256 + K_SP;
use constant K_sTAB     => 256 + K_TAB;
use constant K_sCR      => 256 + K_CR;
use constant K_sBS      => 256 + K_BS;
use constant K_sPAUSE   => 256 + K_PAUSE;
use constant K_sESC     => 256 + K_ESC;
use constant K_Ccedilla => 256 + K_ccedilla;
use constant K_sF1      => 256 + K_F1;
use constant K_sF2      => 256 + K_F2;
use constant K_sF3      => 256 + K_F3;
use constant K_sF4      => 256 + K_F4;
use constant K_sF5      => 256 + K_F5;
use constant K_sF6      => 256 + K_F6;
use constant K_sF7      => 256 + K_F7;
use constant K_sF8      => 256 + K_F8;
use constant K_sF9      => 256 + K_F9;
use constant K_sF10     => 256 + K_F10;
use constant K_sF11     => 256 + K_F11;
use constant K_sF12     => 256 + K_F12;
use constant K_sPrint   => 256 + K_Print;
use constant K_sMenu    => 256 + K_Menu;

use constant K_cHOME     => 512 + K_HOME;
use constant K_cUP       => 512 + K_UP;
use constant K_cPGUP     => 512 + K_PGUP;
use constant K_cLEFT     => 512 + K_LEFT;
use constant K_cMIDDLE   => 512 + K_MIDDLE;
use constant K_cRIGHT    => 512 + K_RIGHT;
use constant K_cEND      => 512 + K_END;
use constant K_cDOWN     => 512 + K_DOWN;
use constant K_cPGDN     => 512 + K_PGDN;
use constant K_cINS      => 512 + K_INS;
use constant K_cDEL      => 512 + K_DEL;
use constant K_cSP       => 512 + K_SP;
use constant K_cTAB      => 512 + K_TAB;
use constant K_cCR       => 512 + K_CR;
use constant K_cBS       => 512 + K_BS;
use constant K_cPAUSE    => 512 + K_PAUSE;
use constant K_cESC      => 512 + K_ESC;
use constant K_cCcedilla => 512 + K_ccedilla;
use constant K_cF1       => 512 + K_F1;
use constant K_cF2       => 512 + K_F2;
use constant K_cF3       => 512 + K_F3;
use constant K_cF4       => 512 + K_F4;
use constant K_cF5       => 512 + K_F5;
use constant K_cF6       => 512 + K_F6;
use constant K_cF7       => 512 + K_F7;
use constant K_cF8       => 512 + K_F8;
use constant K_cF9       => 512 + K_F9;
use constant K_cF10      => 512 + K_F10;
use constant K_cF11      => 512 + K_F11;
use constant K_cF12      => 512 + K_F12;
use constant K_cPrint    => 512 + K_Print;
use constant K_cMenu     => 512 + K_Menu;

use constant K_mHOME     => 768 + K_HOME;
use constant K_mUP       => 768 + K_UP;
use constant K_mPGUP     => 768 + K_PGUP;
use constant K_mLEFT     => 768 + K_LEFT;
use constant K_mMIDDLE   => 768 + K_MIDDLE;
use constant K_mRIGHT    => 768 + K_RIGHT;
use constant K_mEND      => 768 + K_END;
use constant K_mDOWN     => 768 + K_DOWN;
use constant K_mPGDN     => 768 + K_PGDN;
use constant K_mINS      => 768 + K_INS;
use constant K_mDEL      => 768 + K_DEL;
use constant K_mSP       => 768 + K_SP;
use constant K_mTAB      => 768 + K_TAB;
use constant K_mCR       => 768 + K_CR;
use constant K_mBS       => 768 + K_BS;
use constant K_mPAUSE    => 768 + K_PAUSE;
use constant K_mESC      => 768 + K_ESC;
use constant K_mCcedilla => 768 + K_ccedilla;
use constant K_mF1       => 768 + K_F1;
use constant K_mF2       => 768 + K_F2;
use constant K_mF3       => 768 + K_F3;
use constant K_mF4       => 768 + K_F4;
use constant K_mF5       => 768 + K_F5;
use constant K_mF6       => 768 + K_F6;
use constant K_mF7       => 768 + K_F7;
use constant K_mF8       => 768 + K_F8;
use constant K_mF9       => 768 + K_F9;
use constant K_mF10      => 768 + K_F10;
use constant K_mF11      => 768 + K_F11;
use constant K_mF12      => 768 + K_F12;
use constant K_mPrint    => 768 + K_Print;
use constant K_mMenu     => 768 + K_Menu;

use constant K_yHOME     => 1024 + K_HOME;
use constant K_yUP       => 1024 + K_UP;
use constant K_yPGUP     => 1024 + K_PGUP;
use constant K_yLEFT     => 1024 + K_LEFT;
use constant K_yMIDDLE   => 1024 + K_MIDDLE;
use constant K_yRIGHT    => 1024 + K_RIGHT;
use constant K_yEND      => 1024 + K_END;
use constant K_yDOWN     => 1024 + K_DOWN;
use constant K_yPGDN     => 1024 + K_PGDN;
use constant K_yINS      => 1024 + K_INS;
use constant K_yDEL      => 1024 + K_DEL;
use constant K_ySP       => 1024 + K_SP;
use constant K_yTAB      => 1024 + K_TAB;
use constant K_yCR       => 1024 + K_CR;
use constant K_yBS       => 1024 + K_BS;
use constant K_yPAUSE    => 1024 + K_PAUSE;
use constant K_yESC      => 1024 + K_ESC;
use constant K_yCcedilla => 1024 + K_ccedilla;
use constant K_yF1       => 1024 + K_F1;
use constant K_yF2       => 1024 + K_F2;
use constant K_yF3       => 1024 + K_F3;
use constant K_yF4       => 1024 + K_F4;
use constant K_yF5       => 1024 + K_F5;
use constant K_yF6       => 1024 + K_F6;
use constant K_yF7       => 1024 + K_F7;
use constant K_yF8       => 1024 + K_F8;
use constant K_yF9       => 1024 + K_F9;
use constant K_yF10      => 1024 + K_F10;
use constant K_yF11      => 1024 + K_F11;
use constant K_yF12      => 1024 + K_F12;
use constant K_yPrint    => 1024 + K_Print;
use constant K_yMenu     => 1024 + K_Menu;

use constant K_sPlus         => 256 + K_plus;
use constant K_sComma        => 256 + K_comma;
use constant K_sMinus        => 256 + K_minus;
use constant K_sPeriod       => 256 + K_period;
use constant K_sSlash        => 256 + K_slash;
use constant K_sAsterisk     => 256 + K_asterisk;

use constant K_cA     => 512 + K_A;
use constant K_cB     => 512 + K_B;
use constant K_cC     => 512 + K_C;
use constant K_cD     => 512 + K_D;
use constant K_cE     => 512 + K_E;
use constant K_cF     => 512 + K_F;
use constant K_cG     => 512 + K_G;
use constant K_cH     => 512 + K_H;
use constant K_cI     => 512 + K_I;
use constant K_cJ     => 512 + K_J;
use constant K_cK     => 512 + K_K;
use constant K_cL     => 512 + K_L;
use constant K_cM     => 512 + K_M;
use constant K_cN     => 512 + K_N;
use constant K_cO     => 512 + K_O;
use constant K_cP     => 512 + K_P;
use constant K_cQ     => 512 + K_Q;
use constant K_cR     => 512 + K_R;
use constant K_cS     => 512 + K_S;
use constant K_cT     => 512 + K_T;
use constant K_cU     => 512 + K_U;
use constant K_cV     => 512 + K_V;
use constant K_cW     => 512 + K_W;
use constant K_cX     => 512 + K_X;
use constant K_cY     => 512 + K_Y;
use constant K_cZ     => 512 + K_Z;
use constant K_c1     => 512 + K_1;
use constant K_c2     => 512 + K_2;
use constant K_c3     => 512 + K_3;
use constant K_c4     => 512 + K_4;
use constant K_c5     => 512 + K_5;
use constant K_c6     => 512 + K_6;
use constant K_c7     => 512 + K_7;
use constant K_c8     => 512 + K_8;
use constant K_c9     => 512 + K_9;
use constant K_c0     => 512 + K_0;
use constant K_cPlus         => 512 + K_plus;
use constant K_cComma        => 512 + K_comma;
use constant K_cMinus        => 512 + K_minus;
use constant K_cPeriod       => 512 + K_period;
use constant K_cSlash        => 512 + K_slash;
use constant K_cSemicolon    => 512 + K_semicolon;
use constant K_cEqual        => 512 + K_equal;
use constant K_cBracketleft  => 512 + K_bracketleft;
use constant K_cBracketright => 512 + K_bracketright;
use constant K_cBackslash    => 512 + K_backslash;
use constant K_cAsterisk     => 512 + K_asterisk;

use constant K_mA     => 768 + K_A;
use constant K_mB     => 768 + K_B;
use constant K_mC     => 768 + K_C;
use constant K_mD     => 768 + K_D;
use constant K_mE     => 768 + K_E;
use constant K_mF     => 768 + K_F;
use constant K_mG     => 768 + K_G;
use constant K_mH     => 768 + K_H;
use constant K_mI     => 768 + K_I;
use constant K_mJ     => 768 + K_J;
use constant K_mK     => 768 + K_K;
use constant K_mL     => 768 + K_L;
use constant K_mM     => 768 + K_M;
use constant K_mN     => 768 + K_N;
use constant K_mO     => 768 + K_O;
use constant K_mP     => 768 + K_P;
use constant K_mQ     => 768 + K_Q;
use constant K_mR     => 768 + K_R;
use constant K_mS     => 768 + K_S;
use constant K_mT     => 768 + K_T;
use constant K_mU     => 768 + K_U;
use constant K_mV     => 768 + K_V;
use constant K_mW     => 768 + K_W;
use constant K_mX     => 768 + K_X;
use constant K_mY     => 768 + K_Y;
use constant K_mZ     => 768 + K_Z;
use constant K_m1     => 768 + K_1;
use constant K_m2     => 768 + K_2;
use constant K_m3     => 768 + K_3;
use constant K_m4     => 768 + K_4;
use constant K_m5     => 768 + K_5;
use constant K_m6     => 768 + K_6;
use constant K_m7     => 768 + K_7;
use constant K_m8     => 768 + K_8;
use constant K_m9     => 768 + K_9;
use constant K_m0     => 768 + K_0;
use constant K_mPlus         => 768 + K_plus;
use constant K_mComma        => 768 + K_comma;
use constant K_mMinus        => 768 + K_minus;
use constant K_mPeriod       => 768 + K_period;
use constant K_mSlash        => 768 + K_slash;
use constant K_mSemicolon    => 768 + K_semicolon;
use constant K_mEqual        => 768 + K_equal;
use constant K_mBracketleft  => 768 + K_bracketleft;
use constant K_mBracketright => 768 + K_bracketright;
use constant K_mBackslash    => 768 + K_backslash;
use constant K_mAsterisk     => 768 + K_asterisk;

use constant K_yA     => 1024 + K_A;
use constant K_yB     => 1024 + K_B;
use constant K_yC     => 1024 + K_C;
use constant K_yD     => 1024 + K_D;
use constant K_yE     => 1024 + K_E;
use constant K_yF     => 1024 + K_F;
use constant K_yG     => 1024 + K_G;
use constant K_yH     => 1024 + K_H;
use constant K_yI     => 1024 + K_I;
use constant K_yJ     => 1024 + K_J;
use constant K_yK     => 1024 + K_K;
use constant K_yL     => 1024 + K_L;
use constant K_yM     => 1024 + K_M;
use constant K_yN     => 1024 + K_N;
use constant K_yO     => 1024 + K_O;
use constant K_yP     => 1024 + K_P;
use constant K_yQ     => 1024 + K_Q;
use constant K_yR     => 1024 + K_R;
use constant K_yS     => 1024 + K_S;
use constant K_yT     => 1024 + K_T;
use constant K_yU     => 1024 + K_U;
use constant K_yV     => 1024 + K_V;
use constant K_yW     => 1024 + K_W;
use constant K_yX     => 1024 + K_X;
use constant K_yY     => 1024 + K_Y;
use constant K_yZ     => 1024 + K_Z;
use constant K_y1     => 1024 + K_1;
use constant K_y2     => 1024 + K_2;
use constant K_y3     => 1024 + K_3;
use constant K_y4     => 1024 + K_4;
use constant K_y5     => 1024 + K_5;
use constant K_y6     => 1024 + K_6;
use constant K_y7     => 1024 + K_7;
use constant K_y8     => 1024 + K_8;
use constant K_y9     => 1024 + K_9;
use constant K_y0     => 1024 + K_0;
use constant K_yPlus         => 1024 + K_plus;
use constant K_yComma        => 1024 + K_comma;
use constant K_yMinus        => 1024 + K_minus;
use constant K_yPeriod       => 1024 + K_period;
use constant K_ySlash        => 1024 + K_slash;
use constant K_ySemicolon    => 1024 + K_semicolon;
use constant K_yEqual        => 1024 + K_equal;
use constant K_yBracketleft  => 1024 + K_bracketleft;
use constant K_yBracketright => 1024 + K_bracketright;
use constant K_yBackslash    => 1024 + K_backslash;
use constant K_yAsterisk     => 1024 + K_asterisk;

1;
