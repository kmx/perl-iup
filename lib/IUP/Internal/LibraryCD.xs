#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"
#include "ppport.h"

#include <iup.h>
#include <cd.h>

/* macros for processing args in fuctions with variable arg list, e.g. 'func(...)' */
#define myST2IHN(a) (items>(a)) && (SvIOK(ST(a))) ? INT2PTR(Ihandle*, SvIVX(ST(a))) : NULL;
#define myST2STR(a) (items>(a)) && (SvPOK(ST(a))) ? SvPVX(ST(a)) : NULL;
/* #define myST2STR(a) (items>(a)) && (SvPOK(ST(a))) ? SvPV_nolen(ST(a)) : NULL; */

static char* aa = "nnnnn";

char* testptr(Ihandle* a, const char* s) {
  if(s==NULL) {
    fprintf(stderr,"yes.NULL a=%p s=%s\n",a,s);
    return NULL;
  }
  else {
    fprintf(stderr,"not.NULL a=%p s=%s\n",a,s);
    return aa;
  }
}

MODULE = IUP::Internal::LibraryCD	PACKAGE = IUP::Internal::LibraryCD

BOOT:
fprintf(stderr,"aa=%p, %d\n",aa,aa);

#### Original C function from <iup.h>

Ihandle*
_TestPtr1(ih,str)
		Ihandle* ih;
		char* str;
	CODE:
		RETVAL = testptr(ih,str);
	OUTPUT:
		RETVAL

char*
_TestPtr2(...)
		Ihandle* ih 	= myST2IHN(0);
		const char* str = myST2STR(1);
	CODE:
		RETVAL = testptr(ih,str);
	OUTPUT:
		RETVAL
