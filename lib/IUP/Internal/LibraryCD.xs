#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"
#include "ppport.h"

#include <iup.h>
#include <cd.h>

MODULE = IUP::Internal::LibraryCD	PACKAGE = IUP::Internal::LibraryCD

BOOT:
IupOpen(NULL, NULL);

#### Original C function from <iup.h>
# Ihandle* IupInsert (Ihandle* ih, Ihandle* ref_child, Ihandle* child);
Ihandle*
_IupInsert(ih,ref_child,child)
		Ihandle* ih = SvOK(ST(0)) ? (Ihandle*)SvUV(ST(0)) : NULL;
		Ihandle* ref_child = SvOK(ST(1)) ? (Ihandle*)SvUV(ST(1)) : NULL;
		Ihandle* child = SvOK(ST(2)) ? (Ihandle*)SvUV(ST(2)) : NULL;
	CODE:
		RETVAL = IupInsert(ih,ref_child,child);
		if (RETVAL == NULL) XSRETURN_UNDEF;
	OUTPUT:
		RETVAL
