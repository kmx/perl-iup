#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"
#include "ppport.h"

#include <iup.h>
#include <cd.h>
#include <cdiup.h>

/* macros for processing args in fuctions with variable arg list, e.g. 'func(...)' */
#define myST2IHN(a) (items>(a)) && (SvIOK(ST(a))) ? INT2PTR(Ihandle*, SvIVX(ST(a))) : NULL;
#define myST2STR(a) (items>(a)) && (SvPOK(ST(a))) ? SvPVX(ST(a)) : NULL;
#define myST2INT(a) (items>(a)) && (SvIOK(ST(a))) ? SvIVX(ST(a)) : 0;

/* convert 'SV' to 'Ihandle*' + do undef->NULL conversion */
#define mySV2IHN(a) (SvIOK(a) ? INT2PTR(Ihandle *, SvIVX(a)) : NULL)

cdCanvas* ref2cnv(SV* ref) {
  HV* h;
  SV** s;
  if ((h = (HV*)(SvRV(ref))) == NULL) return NULL;
  if ((s = hv_fetchs(h, "___cnvhandle", 0)) != NULL) return INT2PTR(cdCanvas*,SvIVX(*s));
  return NULL;
}

MODULE = IUP::Internal::Canvas	PACKAGE = IUP::Internal::Canvas

BOOT:
/* xxx warn("Helo from bootstrap!"); */

# cdCanvas*   cdCreateCanvas(cdContext *context, void *data);

cdCanvas*
_cdCreateCanvas_CD_IUP(ih)
		Ihandle* ih;
	CODE:
		RETVAL = cdCreateCanvas(CD_IUP, ih);
	OUTPUT:
		RETVAL

##### NEW IMPLEMENTATION
# void cdCanvasLine(cdCanvas* canvas, int x1, int y1, int x2, int y2);
void
cdCanvasLine(canvas,x1,y1,x2,y2)
		SV* canvas;
		int x1;
		int y1;
		int x2;
		int y2;
	CODE:
		/* xxx hack xxx */
		cdCanvasActivate(ref2cnv(canvas));
		cdCanvasForeground(ref2cnv(canvas), CD_BLUE);
		cdCanvasClear(ref2cnv(canvas));
		cdCanvasLine(ref2cnv(canvas),x1,y1,x2,y2);

##### NEW IMPLEMENTATION
# void cdCanvasMark(cdCanvas* canvas, int x, int y);
void
cdCanvasMark(canvas,x,y)
		SV* canvas;
		int x;
		int y;
	CODE:		
		cdCanvasMark(ref2cnv(canvas),x,y);

##### NEW IMPLEMENTATION
# int cdCanvasUpdateYAxis(canvas, int *y);
int
cdCanvasUpdateYAxis(canvas,y)
		SV* canvas;
		int y;
	CODE:		
		int newy = y;
		RETVAL = cdCanvasUpdateYAxis(ref2cnv(canvas),&newy);
	OUTPUT:
		RETVAL
		
#### Original C function from <.../cd/include/cd.h>
# char* cdVersion(void);
char*
_cdVersion()
	CODE:
		RETVAL = cdVersion();
	OUTPUT:
		RETVAL

#### Original C function from <.../cd/include/cd.h>
# char* cdVersionDate(void);
char*
_cdVersionDate()
	CODE:
		RETVAL = cdVersionDate();
	OUTPUT:
		RETVAL

#### Original C function from <.../cd/include/cd.h>
# int cdVersionNumber(void);
int
_cdVersionNumber()
	CODE:
		RETVAL = cdVersionNumber();
	OUTPUT:
		RETVAL

#### Original C function from <.../cd/include/cd.h>
# cdCanvas* cdCreateCanvas(cdContext *context, void *data);
cdCanvas*
_cdCreateCanvas(context,data)
		cdContext* context
		void* data
	CODE:
		RETVAL = cdCreateCanvas(context,data);
	OUTPUT:
		RETVAL

#### Original C function from <.../cd/include/cd.h>
# cdCanvas* cdCreateCanvasf(cdContext *context, const char* format, ...);
cdCanvas*
_cdCreateCanvasf(context,format,...)
		cdContext* context
		const char* format
	CODE:
		RETVAL = cdCreateCanvasf(context,format);
	OUTPUT:
		RETVAL

#### Original C function from <.../cd/include/cd.h>
# void cdKillCanvas(cdCanvas* canvas);
void
_cdKillCanvas(canvas)
		cdCanvas* canvas
	CODE:
		cdKillCanvas(canvas);

#### Original C function from <.../cd/include/cd.h>
# cdContext* cdCanvasGetContext(cdCanvas* canvas);
cdContext*
_cdCanvasGetContext(canvas)
		cdCanvas* canvas;
	CODE:
		RETVAL = cdCanvasGetContext(canvas);
	OUTPUT:
		RETVAL

#### Original C function from <.../cd/include/cd.h>
# int cdCanvasActivate(cdCanvas* canvas);
int
_cdCanvasActivate(canvas)
		cdCanvas* canvas;
	CODE:
		RETVAL = cdCanvasActivate(canvas);
	OUTPUT:
		RETVAL

#### Original C function from <.../cd/include/cd.h>
# void cdCanvasDeactivate(cdCanvas* canvas);
void
_cdCanvasDeactivate(canvas)
		cdCanvas* canvas;
	CODE:
		cdCanvasDeactivate(canvas);

#### Original C function from <.../cd/include/cd.h>
# int cdUseContextPlus(int use);
int
_cdUseContextPlus(use)
		int use;
	CODE:
		RETVAL = cdUseContextPlus(use);
	OUTPUT:
		RETVAL

#### Original C function from <.../cd/include/cd.h>
# typedef int (*cdCallback)(cdCanvas* canvas, ...);
typedefint(*
_cdCallback)(canvas,...)
		cdCanvas* canvas;
	CODE:
		RETVAL = cdCallback)(canvas);
	OUTPUT:
		RETVAL
