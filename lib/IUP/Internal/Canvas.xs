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

# http://perldoc.perl.org/perlxs.html
# http://perldoc.perl.org/perlxstut.html

# special internal function
cdCanvas*
_cdCreateCanvas_CD_IUP(ih)
		Ihandle* ih;
	CODE:
		RETVAL = cdCreateCanvas(CD_IUP, ih);
	OUTPUT:
		RETVAL

### generated part - start ###

#### Original C function from <.../cd/include/cd.h>
# char* cdVersion(void);
char*
cdVersion()
	CODE:
		RETVAL = cdVersion();
	OUTPUT:
		RETVAL

#### Original C function from <.../cd/include/cd.h>
# char* cdVersionDate(void);
char*
cdVersionDate()
	CODE:
		RETVAL = cdVersionDate();
	OUTPUT:
		RETVAL

#### Original C function from <.../cd/include/cd.h>
# int cdVersionNumber(void);
int
cdVersionNumber()
	CODE:
		RETVAL = cdVersionNumber();
	OUTPUT:
		RETVAL

#### Original C function from <.../cd/include/cd.h>
# cdCanvas* cdCreateCanvas(cdContext *context, void *data);
cdCanvas*
cdCreateCanvas(context,data)
		cdContext* context;
		void* data;
	CODE:
		RETVAL = cdCreateCanvas(context,data);
	OUTPUT:
		RETVAL

#### Original C function from <.../cd/include/cd.h>
# cdCanvas* cdCreateCanvasf(cdContext *context, const char* format, ...);
cdCanvas*
cdCreateCanvasf(context,format,...)
		cdContext* context;
		const char* format;
	CODE:
		RETVAL = cdCreateCanvasf(context,format);
	OUTPUT:
		RETVAL

#### Original C function from <.../cd/include/cd.h>
# void cdKillCanvas(cdCanvas* canvas);
void
cdKillCanvas(canvas)
		SV* canvas;
	CODE:
		cdKillCanvas(ref2cnv(canvas));

#### Original C function from <.../cd/include/cd.h>
# cdContext* cdCanvasGetContext(cdCanvas* canvas);
cdContext*
cdGetContext(canvas)
		SV* canvas;
	CODE:
		RETVAL = cdCanvasGetContext(ref2cnv(canvas));
	OUTPUT:
		RETVAL

#### Original C function from <.../cd/include/cd.h>
# int cdCanvasActivate(cdCanvas* canvas);
int
cdActivate(canvas)
		SV* canvas;
	CODE:
		RETVAL = cdCanvasActivate(ref2cnv(canvas));
	OUTPUT:
		RETVAL

#### Original C function from <.../cd/include/cd.h>
# void cdCanvasDeactivate(cdCanvas* canvas);
void
cdDeactivate(canvas)
		SV* canvas;
	CODE:
		cdCanvasDeactivate(ref2cnv(canvas));

#### Original C function from <.../cd/include/cd.h>
# int cdUseContextPlus(int use);
#xxx TODO - add some ifdefs
#int
#cdUseContextPlus(use)
#		int use;
#	CODE:
#		RETVAL = cdUseContextPlus(use);
#	OUTPUT:
#		RETVAL

#### Original C function from <.../cd/include/cd.h>
# void cdInitContextPlus(void); 
#xxx TODO - add some ifdefs
#void
#cdInitContextPlus()
#	CODE:
#		cdInitContextPlus();

#### Original C function from <.../cd/include/cd.h>
# int cdContextRegisterCallback(cdContext *context, int cb, cdCallback func);
#xxx TODO
#int
#cdContextRegisterCallback(context,cb,func)
#		cdContext* context;
#		int cb;
#		cdCallback func;
#	CODE:
#		RETVAL = cdContextRegisterCallback(context,cb,func);
#	OUTPUT:
#		RETVAL

#### Original C function from <.../cd/include/cd.h>
# unsigned long cdContextCaps(cdContext *context);
unsigned long
cdContextCaps(context)
		cdContext* context;
	CODE:
		RETVAL = cdContextCaps(context);
	OUTPUT:
		RETVAL

#### Original C function from <.../cd/include/cd.h>
# int cdCanvasSimulate(cdCanvas* canvas, int mode);
int
cdSimulate(canvas,mode)
		SV* canvas;
		int mode;
	CODE:
		RETVAL = cdCanvasSimulate(ref2cnv(canvas),mode);
	OUTPUT:
		RETVAL

#### Original C function from <.../cd/include/cd.h>
# void cdCanvasFlush(cdCanvas* canvas);
void
cdFlush(canvas)
		SV* canvas;
	CODE:
		cdCanvasFlush(ref2cnv(canvas));

#### Original C function from <.../cd/include/cd.h>
# void cdCanvasClear(cdCanvas* canvas);
void
cdClear(canvas)
		SV* canvas;
	CODE:
		cdCanvasClear(ref2cnv(canvas));

#### Original C function from <.../cd/include/cd.h>
# cdState* cdCanvasSaveState(cdCanvas* canvas);
cdState*
cdSaveState(canvas)
		SV* canvas;
	CODE:
		RETVAL = cdCanvasSaveState(ref2cnv(canvas));
	OUTPUT:
		RETVAL

#### Original C function from <.../cd/include/cd.h>
# void cdCanvasRestoreState(cdCanvas* canvas, cdState* state);
void
cdRestoreState(canvas,state__)
		SV* canvas;
		cdState* state__;
	CODE:
		cdCanvasRestoreState(ref2cnv(canvas),state__);

#### Original C function from <.../cd/include/cd.h>
# void cdReleaseState(cdState* state);
void
cdReleaseState(state)
		cdState* state;
	CODE:
		cdReleaseState(state);

#### Original C function from <.../cd/include/cd.h>
# void cdCanvasSetAttribute(cdCanvas* canvas, const char* name, char* data);
void
cdSetAttribute(canvas,name,data)
		SV* canvas;
		const char* name;
		char* data;
	CODE:
		cdCanvasSetAttribute(ref2cnv(canvas),name,data);

#### Original C function from <.../cd/include/cd.h>
# void cdCanvasSetfAttribute(cdCanvas* canvas, const char* name, const char* format, ...);
void
cdSetfAttribute(canvas,name,format,...)
		SV* canvas;
		const char* name;
		const char* format;
	CODE:
		cdCanvasSetfAttribute(ref2cnv(canvas),name,format);

#### Original C function from <.../cd/include/cd.h>
# char* cdCanvasGetAttribute(cdCanvas* canvas, const char* name);
char*
cdGetAttribute(canvas,name)
		SV* canvas;
		const char* name;
	CODE:
		RETVAL = cdCanvasGetAttribute(ref2cnv(canvas),name);
	OUTPUT:
		RETVAL

#### Original C function from <.../cd/include/cd.h>
# int cdCanvasPlay(cdCanvas* canvas, cdContext *context, int xmin, int xmax, int ymin, int ymax, void *data);
int
cdPlay(canvas,context,xmin,xmax,ymin,ymax,data)
		SV* canvas;
		cdContext* context;
		int xmin;
		int xmax;
		int ymin;
		int ymax;
		void* data;
	CODE:
		RETVAL = cdCanvasPlay(ref2cnv(canvas),context,xmin,xmax,ymin,ymax,data);
	OUTPUT:
		RETVAL

#### Original C function from <.../cd/include/cd.h>
# void cdCanvasGetSize(cdCanvas* canvas, int *width, int *height, double *width_mm, double *height_mm);
#xxx TODO
#void
#cdGetSize(canvas,width,height,width_mm,height_mm)
#		SV* canvas;
#		int &width;
#		int &height;
#		double* width_mm;
#		double* height_mm;
#	CODE:
#		cdCanvasGetSize(ref2cnv(canvas),&width,&height,width_mm,height_mm);

#### Original C function from <.../cd/include/cd.h>
# int cdCanvasUpdateYAxis(cdCanvas* canvas, int* y);
int
cdUpdateYAxis(canvas,y)
		SV* canvas;
		int &y;
	CODE:
		RETVAL = cdCanvasUpdateYAxis(ref2cnv(canvas),&y);
	OUTPUT:
		RETVAL

#### Original C function from <.../cd/include/cd.h>
# double cdfCanvasUpdateYAxis(cdCanvas* canvas, double* y);
#xxx TODO
#double
#cdfUpdateYAxis(canvas,y)
#		SV* canvas;
#		double* y;
#	CODE:
#		RETVAL = cdfCanvasUpdateYAxis(ref2cnv(canvas),y);
#	OUTPUT:
#		RETVAL

#### Original C function from <.../cd/include/cd.h>
# int cdCanvasYAxisMode(cdCanvas* canvas, int invert);
int
cdYAxisMode(canvas,invert)
		SV* canvas;
		int invert;
	CODE:
		RETVAL = cdCanvasYAxisMode(ref2cnv(canvas),invert);
	OUTPUT:
		RETVAL

#### Original C function from <.../cd/include/cd.h>
# int cdCanvasInvertYAxis(cdCanvas* canvas, int y);
int
cdInvertYAxis(canvas,y)
		SV* canvas;
		int y;
	CODE:
		RETVAL = cdCanvasInvertYAxis(ref2cnv(canvas),y);
	OUTPUT:
		RETVAL

#### Original C function from <.../cd/include/cd.h>
# double cdfCanvasInvertYAxis(cdCanvas* canvas, double y);
double
cdfInvertYAxis(canvas,y)
		SV* canvas;
		double y;
	CODE:
		RETVAL = cdfCanvasInvertYAxis(ref2cnv(canvas),y);
	OUTPUT:
		RETVAL

#### Original C function from <.../cd/include/cd.h>
# void cdCanvasMM2Pixel(cdCanvas* canvas, double mm_dx, double mm_dy, int *dx, int *dy);
void
cdMM2Pixel(canvas,mm_dx,mm_dy,dx,dy)
		SV* canvas;
		double mm_dx;
		double mm_dy;
		int &dx;
		int &dy;
	CODE:
		cdCanvasMM2Pixel(ref2cnv(canvas),mm_dx,mm_dy,&dx,&dy);

#### Original C function from <.../cd/include/cd.h>
# void cdCanvasPixel2MM(cdCanvas* canvas, int dx, int dy, double *mm_dx, double *mm_dy);
#xxx TODO
#void
#cdPixel2MM(canvas,dx,dy,mm_dx,mm_dy)
#		SV* canvas;
#		int dx;
#		int dy;
#		double* mm_dx;
#		double* mm_dy;
#	CODE:
#		cdCanvasPixel2MM(ref2cnv(canvas),dx,dy,mm_dx,mm_dy);

#### Original C function from <.../cd/include/cd.h>
# void cdfCanvasMM2Pixel(cdCanvas* canvas, double mm_dx, double mm_dy, double *dx, double *dy);
#xxx TODO
#void
#cdfMM2Pixel(canvas,mm_dx,mm_dy,dx,dy)
#		SV* canvas;
#		double mm_dx;
#		double mm_dy;
#		double* dx;
#		double* dy;
#	CODE:
#		cdfCanvasMM2Pixel(ref2cnv(canvas),mm_dx,mm_dy,dx,dy);

#### Original C function from <.../cd/include/cd.h>
# void cdfCanvasPixel2MM(cdCanvas* canvas, double dx, double dy, double *mm_dx, double *mm_dy);
#xxx TODO
#void
#cdfPixel2MM(canvas,dx,dy,mm_dx,mm_dy)
#		SV* canvas;
#		double dx;
#		double dy;
#		double* mm_dx;
#		double* mm_dy;
#	CODE:
#		cdfCanvasPixel2MM(ref2cnv(canvas),dx,dy,mm_dx,mm_dy);

#### Original C function from <.../cd/include/cd.h>
# void cdCanvasOrigin(cdCanvas* canvas, int x, int y);
void
cdOrigin(canvas,x,y)
		SV* canvas;
		int x;
		int y;
	CODE:
		cdCanvasOrigin(ref2cnv(canvas),x,y);

#### Original C function from <.../cd/include/cd.h>
# void cdfCanvasOrigin(cdCanvas* canvas, double x, double y);
void
cdfOrigin(canvas,x,y)
		SV* canvas;
		double x;
		double y;
	CODE:
		cdfCanvasOrigin(ref2cnv(canvas),x,y);

#### Original C function from <.../cd/include/cd.h>
# void cdCanvasGetOrigin(cdCanvas* canvas, int *x, int *y);
void
cdGetOrigin(canvas,x,y)
		SV* canvas;
		int &x;
		int &y;
	CODE:
		cdCanvasGetOrigin(ref2cnv(canvas),&x,&y);

#### Original C function from <.../cd/include/cd.h>
# void cdfCanvasGetOrigin(cdCanvas* canvas, double *x, double *y);
#xxx TODO
#void
#cdfGetOrigin(canvas,x,y)
#		SV* canvas;
#		double* x;
#		double* y;
#	CODE:
#		cdfCanvasGetOrigin(ref2cnv(canvas),x,y);

#### Original C function from <.../cd/include/cd.h>
# void cdCanvasTransform(cdCanvas* canvas, const double* matrix);
#xxx TODO
#void
#cdTransform(canvas,matrix)
#		SV* canvas;
#		const double* matrix;
#	CODE:
#		cdCanvasTransform(ref2cnv(canvas),matrix);

#### Original C function from <.../cd/include/cd.h>
# double* cdCanvasGetTransform(cdCanvas* canvas);
#xxx TODO
#double*
#cdGetTransform(canvas)
#		SV* canvas;
#	CODE:
#		RETVAL = cdCanvasGetTransform(ref2cnv(canvas));
#	OUTPUT:
#		RETVAL

#### Original C function from <.../cd/include/cd.h>
# void cdCanvasTransformMultiply(cdCanvas* canvas, const double* matrix);
#xxx TODO
#void
#cdTransformMultiply(canvas,matrix)
#		SV* canvas;
#		const double* matrix;
#	CODE:
#		cdCanvasTransformMultiply(ref2cnv(canvas),matrix);

#### Original C function from <.../cd/include/cd.h>
# void cdCanvasTransformRotate(cdCanvas* canvas, double angle);
void
cdTransformRotate(canvas,angle)
		SV* canvas;
		double angle;
	CODE:
		cdCanvasTransformRotate(ref2cnv(canvas),angle);

#### Original C function from <.../cd/include/cd.h>
# void cdCanvasTransformScale(cdCanvas* canvas, double sx, double sy);
void
cdTransformScale(canvas,sx,sy)
		SV* canvas;
		double sx;
		double sy;
	CODE:
		cdCanvasTransformScale(ref2cnv(canvas),sx,sy);

#### Original C function from <.../cd/include/cd.h>
# void cdCanvasTransformTranslate(cdCanvas* canvas, double dx, double dy);
void
cdTransformTranslate(canvas,dx,dy)
		SV* canvas;
		double dx;
		double dy;
	CODE:
		cdCanvasTransformTranslate(ref2cnv(canvas),dx,dy);

#### Original C function from <.../cd/include/cd.h>
# void cdCanvasTransformPoint(cdCanvas* canvas, int x, int y, int *tx, int *ty);
void
cdTransformPoint(canvas,x,y,tx,ty)
		SV* canvas;
		int x;
		int y;
		int &tx;
		int &ty;
	CODE:
		cdCanvasTransformPoint(ref2cnv(canvas),x,y,&tx,&ty);

#### Original C function from <.../cd/include/cd.h>
# void cdfCanvasTransformPoint(cdCanvas* canvas, double x, double y, double *tx, double *ty);
#xxx TODO
#void
#cdfTransformPoint(canvas,x,y,tx,ty)
#		SV* canvas;
#		double x;
#		double y;
#		double* tx;
#		double* ty;
#	CODE:
#		cdfCanvasTransformPoint(ref2cnv(canvas),x,y,tx,ty);

#### Original C function from <.../cd/include/cd.h>
# int cdCanvasClip(cdCanvas* canvas, int mode);
int
cdClip(canvas,mode)
		SV* canvas;
		int mode;
	CODE:
		RETVAL = cdCanvasClip(ref2cnv(canvas),mode);
	OUTPUT:
		RETVAL

#### Original C function from <.../cd/include/cd.h>
# void cdCanvasClipArea(cdCanvas* canvas, int xmin, int xmax, int ymin, int ymax);
void
cdClipArea(canvas,xmin,xmax,ymin,ymax)
		SV* canvas;
		int xmin;
		int xmax;
		int ymin;
		int ymax;
	CODE:
		cdCanvasClipArea(ref2cnv(canvas),xmin,xmax,ymin,ymax);

#### Original C function from <.../cd/include/cd.h>
# int cdCanvasGetClipArea(cdCanvas* canvas, int *xmin, int *xmax, int *ymin, int *ymax);
int
cdGetClipArea(canvas,xmin,xmax,ymin,ymax)
		SV* canvas;
		int &xmin;
		int &xmax;
		int &ymin;
		int &ymax;
	CODE:
		RETVAL = cdCanvasGetClipArea(ref2cnv(canvas),&xmin,&xmax,&ymin,&ymax);
	OUTPUT:
		RETVAL

#### Original C function from <.../cd/include/cd.h>
# void cdfCanvasClipArea(cdCanvas* canvas, double xmin, double xmax, double ymin, double ymax);
void
cdfClipArea(canvas,xmin,xmax,ymin,ymax)
		SV* canvas;
		double xmin;
		double xmax;
		double ymin;
		double ymax;
	CODE:
		cdfCanvasClipArea(ref2cnv(canvas),xmin,xmax,ymin,ymax);

#### Original C function from <.../cd/include/cd.h>
# int cdfCanvasGetClipArea(cdCanvas* canvas, double *xmin, double *xmax, double *ymin, double *ymax);
#xxx TODO
#int
#cdfGetClipArea(canvas,xmin,xmax,ymin,ymax)
#		SV* canvas;
#		double* xmin;
#		double* xmax;
#		double* ymin;
#		double* ymax;
#	CODE:
#		RETVAL = cdfCanvasGetClipArea(ref2cnv(canvas),xmin,xmax,ymin,ymax);
#	OUTPUT:
#		RETVAL

#### Original C function from <.../cd/include/cd.h>
# int cdCanvasIsPointInRegion(cdCanvas* canvas, int x, int y);
int
cdIsPointInRegion(canvas,x,y)
		SV* canvas;
		int x;
		int y;
	CODE:
		RETVAL = cdCanvasIsPointInRegion(ref2cnv(canvas),x,y);
	OUTPUT:
		RETVAL

#### Original C function from <.../cd/include/cd.h>
# void cdCanvasOffsetRegion(cdCanvas* canvas, int x, int y);
void
cdOffsetRegion(canvas,x,y)
		SV* canvas;
		int x;
		int y;
	CODE:
		cdCanvasOffsetRegion(ref2cnv(canvas),x,y);

#### Original C function from <.../cd/include/cd.h>
# void cdCanvasGetRegionBox(cdCanvas* canvas, int *xmin, int *xmax, int *ymin, int *ymax);
void
cdGetRegionBox(canvas,xmin,xmax,ymin,ymax)
		SV* canvas;
		int &xmin;
		int &xmax;
		int &ymin;
		int &ymax;
	CODE:
		cdCanvasGetRegionBox(ref2cnv(canvas),&xmin,&xmax,&ymin,&ymax);

#### Original C function from <.../cd/include/cd.h>
# int cdCanvasRegionCombineMode(cdCanvas* canvas, int mode);
int
cdRegionCombineMode(canvas,mode)
		SV* canvas;
		int mode;
	CODE:
		RETVAL = cdCanvasRegionCombineMode(ref2cnv(canvas),mode);
	OUTPUT:
		RETVAL

#### Original C function from <.../cd/include/cd.h>
# void cdCanvasPixel(cdCanvas* canvas, int x, int y, long color);
void
cdPixel(canvas,x,y,color)
		SV* canvas;
		int x;
		int y;
		long color;
	CODE:
		cdCanvasPixel(ref2cnv(canvas),x,y,color);

#### Original C function from <.../cd/include/cd.h>
# void cdCanvasMark(cdCanvas* canvas, int x, int y);
void
cdMark(canvas,x,y)
		SV* canvas;
		int x;
		int y;
	CODE:
		cdCanvasMark(ref2cnv(canvas),x,y);

#### Original C function from <.../cd/include/cd.h>
# void cdCanvasBegin(cdCanvas* canvas, int mode);
void
cdBegin(canvas,mode)
		SV* canvas;
		int mode;
	CODE:
		cdCanvasBegin(ref2cnv(canvas),mode);

#### Original C function from <.../cd/include/cd.h>
# void cdCanvasPathSet(cdCanvas* canvas, int action);
void
cdPathSet(canvas,action)
		SV* canvas;
		int action;
	CODE:
		cdCanvasPathSet(ref2cnv(canvas),action);

#### Original C function from <.../cd/include/cd.h>
# void cdCanvasEnd(cdCanvas* canvas);
void
cdEnd(canvas)
		SV* canvas;
	CODE:
		cdCanvasEnd(ref2cnv(canvas));

#### Original C function from <.../cd/include/cd.h>
# void cdCanvasLine(cdCanvas* canvas, int x1, int y1, int x2, int y2);
void
cdLine(canvas,x1,y1,x2,y2)
		SV* canvas;
		int x1;
		int y1;
		int x2;
		int y2;
	CODE:
		cdCanvasLine(ref2cnv(canvas),x1,y1,x2,y2);

#### Original C function from <.../cd/include/cd.h>
# void cdCanvasVertex(cdCanvas* canvas, int x, int y);
void
cdVertex(canvas,x,y)
		SV* canvas;
		int x;
		int y;
	CODE:
		cdCanvasVertex(ref2cnv(canvas),x,y);

#### Original C function from <.../cd/include/cd.h>
# void cdCanvasRect(cdCanvas* canvas, int xmin, int xmax, int ymin, int ymax);
void
cdRect(canvas,xmin,xmax,ymin,ymax)
		SV* canvas;
		int xmin;
		int xmax;
		int ymin;
		int ymax;
	CODE:
		cdCanvasRect(ref2cnv(canvas),xmin,xmax,ymin,ymax);

#### Original C function from <.../cd/include/cd.h>
# void cdCanvasBox(cdCanvas* canvas, int xmin, int xmax, int ymin, int ymax);
void
cdBox(canvas,xmin,xmax,ymin,ymax)
		SV* canvas;
		int xmin;
		int xmax;
		int ymin;
		int ymax;
	CODE:
		cdCanvasBox(ref2cnv(canvas),xmin,xmax,ymin,ymax);

#### Original C function from <.../cd/include/cd.h>
# void cdCanvasArc(cdCanvas* canvas, int xc, int yc, int w, int h, double angle1, double angle2);
void
cdArc(canvas,xc,yc,w,h,angle1,angle2)
		SV* canvas;
		int xc;
		int yc;
		int w;
		int h;
		double angle1;
		double angle2;
	CODE:
		cdCanvasArc(ref2cnv(canvas),xc,yc,w,h,angle1,angle2);

#### Original C function from <.../cd/include/cd.h>
# void cdCanvasSector(cdCanvas* canvas, int xc, int yc, int w, int h, double angle1, double angle2);
void
cdSector(canvas,xc,yc,w,h,angle1,angle2)
		SV* canvas;
		int xc;
		int yc;
		int w;
		int h;
		double angle1;
		double angle2;
	CODE:
		cdCanvasSector(ref2cnv(canvas),xc,yc,w,h,angle1,angle2);

#### Original C function from <.../cd/include/cd.h>
# void cdCanvasChord(cdCanvas* canvas, int xc, int yc, int w, int h, double angle1, double angle2);
void
cdChord(canvas,xc,yc,w,h,angle1,angle2)
		SV* canvas;
		int xc;
		int yc;
		int w;
		int h;
		double angle1;
		double angle2;
	CODE:
		cdCanvasChord(ref2cnv(canvas),xc,yc,w,h,angle1,angle2);

#### Original C function from <.../cd/include/cd.h>
# void cdCanvasText(cdCanvas* canvas, int x, int y, const char* s);
void
cdText(canvas,x,y,s)
		SV* canvas;
		int x;
		int y;
		const char* s;
	CODE:
		cdCanvasText(ref2cnv(canvas),x,y,s);

#### Original C function from <.../cd/include/cd.h>
# void cdfCanvasLine(cdCanvas* canvas, double x1, double y1, double x2, double y2);
void
cdfLine(canvas,x1,y1,x2,y2)
		SV* canvas;
		double x1;
		double y1;
		double x2;
		double y2;
	CODE:
		cdfCanvasLine(ref2cnv(canvas),x1,y1,x2,y2);

#### Original C function from <.../cd/include/cd.h>
# void cdfCanvasVertex(cdCanvas* canvas, double x, double y);
void
cdfVertex(canvas,x,y)
		SV* canvas;
		double x;
		double y;
	CODE:
		cdfCanvasVertex(ref2cnv(canvas),x,y);

#### Original C function from <.../cd/include/cd.h>
# void cdfCanvasRect(cdCanvas* canvas, double xmin, double xmax, double ymin, double ymax);
void
cdfRect(canvas,xmin,xmax,ymin,ymax)
		SV* canvas;
		double xmin;
		double xmax;
		double ymin;
		double ymax;
	CODE:
		cdfCanvasRect(ref2cnv(canvas),xmin,xmax,ymin,ymax);

#### Original C function from <.../cd/include/cd.h>
# void cdfCanvasBox(cdCanvas* canvas, double xmin, double xmax, double ymin, double ymax);
void
cdfBox(canvas,xmin,xmax,ymin,ymax)
		SV* canvas;
		double xmin;
		double xmax;
		double ymin;
		double ymax;
	CODE:
		cdfCanvasBox(ref2cnv(canvas),xmin,xmax,ymin,ymax);

#### Original C function from <.../cd/include/cd.h>
# void cdfCanvasArc(cdCanvas* canvas, double xc, double yc, double w, double h, double angle1, double angle2);
void
cdfArc(canvas,xc,yc,w,h,angle1,angle2)
		SV* canvas;
		double xc;
		double yc;
		double w;
		double h;
		double angle1;
		double angle2;
	CODE:
		cdfCanvasArc(ref2cnv(canvas),xc,yc,w,h,angle1,angle2);

#### Original C function from <.../cd/include/cd.h>
# void cdfCanvasSector(cdCanvas* canvas, double xc, double yc, double w, double h, double angle1, double angle2);
void
cdfSector(canvas,xc,yc,w,h,angle1,angle2)
		SV* canvas;
		double xc;
		double yc;
		double w;
		double h;
		double angle1;
		double angle2;
	CODE:
		cdfCanvasSector(ref2cnv(canvas),xc,yc,w,h,angle1,angle2);

#### Original C function from <.../cd/include/cd.h>
# void cdfCanvasChord(cdCanvas* canvas, double xc, double yc, double w, double h, double angle1, double angle2);
void
cdfChord(canvas,xc,yc,w,h,angle1,angle2)
		SV* canvas;
		double xc;
		double yc;
		double w;
		double h;
		double angle1;
		double angle2;
	CODE:
		cdfCanvasChord(ref2cnv(canvas),xc,yc,w,h,angle1,angle2);

#### Original C function from <.../cd/include/cd.h>
# void cdfCanvasText(cdCanvas* canvas, double x, double y, const char* s);
void
cdfText(canvas,x,y,s)
		SV* canvas;
		double x;
		double y;
		const char* s;
	CODE:
		cdfCanvasText(ref2cnv(canvas),x,y,s);

#### Original C function from <.../cd/include/cd.h>
# void cdCanvasSetBackground(cdCanvas* canvas, long color);
void
cdSetBackground(canvas,color)
		SV* canvas;
		long color;
	CODE:
		cdCanvasSetBackground(ref2cnv(canvas),color);

#### Original C function from <.../cd/include/cd.h>
# void cdCanvasSetForeground(cdCanvas* canvas, long color);
void
cdSetForeground(canvas,color)
		SV* canvas;
		long color;
	CODE:
		cdCanvasSetForeground(ref2cnv(canvas),color);

#### Original C function from <.../cd/include/cd.h>
# long cdCanvasBackground(cdCanvas* canvas, long color);
long
cdBackground(canvas,color)
		SV* canvas;
		long color;
	CODE:
		RETVAL = cdCanvasBackground(ref2cnv(canvas),color);
	OUTPUT:
		RETVAL

#### Original C function from <.../cd/include/cd.h>
# long cdCanvasForeground(cdCanvas* canvas, long color);
long
cdForeground(canvas,color)
		SV* canvas;
		long color;
	CODE:
		RETVAL = cdCanvasForeground(ref2cnv(canvas),color);
	OUTPUT:
		RETVAL

#### Original C function from <.../cd/include/cd.h>
# int cdCanvasBackOpacity(cdCanvas* canvas, int opacity);
int
cdBackOpacity(canvas,opacity)
		SV* canvas;
		int opacity;
	CODE:
		RETVAL = cdCanvasBackOpacity(ref2cnv(canvas),opacity);
	OUTPUT:
		RETVAL

#### Original C function from <.../cd/include/cd.h>
# int cdCanvasWriteMode(cdCanvas* canvas, int mode);
int
cdWriteMode(canvas,mode)
		SV* canvas;
		int mode;
	CODE:
		RETVAL = cdCanvasWriteMode(ref2cnv(canvas),mode);
	OUTPUT:
		RETVAL

#### Original C function from <.../cd/include/cd.h>
# int cdCanvasLineStyle(cdCanvas* canvas, int style);
int
cdLineStyle(canvas,style)
		SV* canvas;
		int style;
	CODE:
		RETVAL = cdCanvasLineStyle(ref2cnv(canvas),style);
	OUTPUT:
		RETVAL

#### Original C function from <.../cd/include/cd.h>
# void cdCanvasLineStyleDashes(cdCanvas* canvas, const int* dashes, int count);
#xxx TODO
#void
#cdLineStyleDashes(canvas,dashes,count)
#		SV* canvas;
#		const int* dashes;
#		int count;
#	CODE:
#		cdCanvasLineStyleDashes(ref2cnv(canvas),dashes,count);

#### Original C function from <.../cd/include/cd.h>
# int cdCanvasLineWidth(cdCanvas* canvas, int width);
int
cdLineWidth(canvas,width)
		SV* canvas;
		int width;
	CODE:
		RETVAL = cdCanvasLineWidth(ref2cnv(canvas),width);
	OUTPUT:
		RETVAL

#### Original C function from <.../cd/include/cd.h>
# int cdCanvasLineJoin(cdCanvas* canvas, int join);
int
cdLineJoin(canvas,join)
		SV* canvas;
		int join;
	CODE:
		RETVAL = cdCanvasLineJoin(ref2cnv(canvas),join);
	OUTPUT:
		RETVAL

#### Original C function from <.../cd/include/cd.h>
# int cdCanvasLineCap(cdCanvas* canvas, int cap);
int
cdLineCap(canvas,cap)
		SV* canvas;
		int cap;
	CODE:
		RETVAL = cdCanvasLineCap(ref2cnv(canvas),cap);
	OUTPUT:
		RETVAL

#### Original C function from <.../cd/include/cd.h>
# int cdCanvasInteriorStyle(cdCanvas* canvas, int style);
int
cdInteriorStyle(canvas,style)
		SV* canvas;
		int style;
	CODE:
		RETVAL = cdCanvasInteriorStyle(ref2cnv(canvas),style);
	OUTPUT:
		RETVAL

#### Original C function from <.../cd/include/cd.h>
# int cdCanvasHatch(cdCanvas* canvas, int style);
int
cdHatch(canvas,style)
		SV* canvas;
		int style;
	CODE:
		RETVAL = cdCanvasHatch(ref2cnv(canvas),style);
	OUTPUT:
		RETVAL

#### Original C function from <.../cd/include/cd.h>
# void cdCanvasStipple(cdCanvas* canvas, int w, int h, const unsigned char* stipple);
void
cdStipple(canvas,w,h,stipple)
		SV* canvas;
		int w;
		int h;
		const unsigned char* stipple;
	CODE:
		cdCanvasStipple(ref2cnv(canvas),w,h,stipple);

#### Original C function from <.../cd/include/cd.h>
# unsigned char* cdCanvasGetStipple(cdCanvas* canvas, int *n, int *m);
unsigned char*
cdGetStipple(canvas,n,m)
		SV* canvas;
		int &n;
		int &m;
	CODE:
		RETVAL = cdCanvasGetStipple(ref2cnv(canvas),&n,&m);
	OUTPUT:
		RETVAL

#### Original C function from <.../cd/include/cd.h>
# void cdCanvasPattern(cdCanvas* canvas, int w, int h, long const int *pattern);
#xxx TODO
#void
#cdPattern(canvas,w,h,pattern)
#		SV* canvas;
#		int w;
#		int h;
#		long const int* pattern;
#	CODE:
#		cdCanvasPattern(ref2cnv(canvas),w,h,pattern);

#### Original C function from <.../cd/include/cd.h>
# long* cdCanvasGetPattern(cdCanvas* canvas, int* n, int* m);
#xxx TODO
#long*
#cdGetPattern(canvas,n,m)
#		SV* canvas;
#		int &n;
#		int &m;
#	CODE:
#		RETVAL = cdCanvasGetPattern(ref2cnv(canvas),&n,&m);
#	OUTPUT:
#		RETVAL

#### Original C function from <.../cd/include/cd.h>
# int cdCanvasFillMode(cdCanvas* canvas, int mode);
int
cdFillMode(canvas,mode)
		SV* canvas;
		int mode;
	CODE:
		RETVAL = cdCanvasFillMode(ref2cnv(canvas),mode);
	OUTPUT:
		RETVAL

#### Original C function from <.../cd/include/cd.h>
# int cdCanvasFont(cdCanvas* canvas, const char* type_face, int style, int size);
int
cdFont(canvas,type_face,style,size)
		SV* canvas;
		const char* type_face;
		int style;
		int size;
	CODE:
		RETVAL = cdCanvasFont(ref2cnv(canvas),type_face,style,size);
	OUTPUT:
		RETVAL

#### Original C function from <.../cd/include/cd.h>
# void cdCanvasGetFont(cdCanvas* canvas, char *type_face, int *style, int *size);
void
cdGetFont(canvas,type_face,style,size)
		SV* canvas;
		char* type_face;
		int &style;
		int &size;
	CODE:
		cdCanvasGetFont(ref2cnv(canvas),type_face,&style,&size);

#### Original C function from <.../cd/include/cd.h>
# char* cdCanvasNativeFont(cdCanvas* canvas, const char* font);
char*
cdNativeFont(canvas,font)
		SV* canvas;
		const char* font;
	CODE:
		RETVAL = cdCanvasNativeFont(ref2cnv(canvas),font);
	OUTPUT:
		RETVAL

#### Original C function from <.../cd/include/cd.h>
# int cdCanvasTextAlignment(cdCanvas* canvas, int alignment);
int
cdTextAlignment(canvas,alignment)
		SV* canvas;
		int alignment;
	CODE:
		RETVAL = cdCanvasTextAlignment(ref2cnv(canvas),alignment);
	OUTPUT:
		RETVAL

#### Original C function from <.../cd/include/cd.h>
# double cdCanvasTextOrientation(cdCanvas* canvas, double angle);
double
cdTextOrientation(canvas,angle)
		SV* canvas;
		double angle;
	CODE:
		RETVAL = cdCanvasTextOrientation(ref2cnv(canvas),angle);
	OUTPUT:
		RETVAL

#### Original C function from <.../cd/include/cd.h>
# int cdCanvasMarkType(cdCanvas* canvas, int type);
int
cdMarkType(canvas,type)
		SV* canvas;
		int type;
	CODE:
		RETVAL = cdCanvasMarkType(ref2cnv(canvas),type);
	OUTPUT:
		RETVAL

#### Original C function from <.../cd/include/cd.h>
# int cdCanvasMarkSize(cdCanvas* canvas, int size);
int
cdMarkSize(canvas,size)
		SV* canvas;
		int size;
	CODE:
		RETVAL = cdCanvasMarkSize(ref2cnv(canvas),size);
	OUTPUT:
		RETVAL

#### Original C function from <.../cd/include/cd.h>
# void cdCanvasVectorText(cdCanvas* canvas, int x, int y, const char* s);
void
cdVectorText(canvas,x,y,s)
		SV* canvas;
		int x;
		int y;
		const char* s;
	CODE:
		cdCanvasVectorText(ref2cnv(canvas),x,y,s);

#### Original C function from <.../cd/include/cd.h>
# void cdCanvasMultiLineVectorText(cdCanvas* canvas, int x, int y, const char* s);
void
cdMultiLineVectorText(canvas,x,y,s)
		SV* canvas;
		int x;
		int y;
		const char* s;
	CODE:
		cdCanvasMultiLineVectorText(ref2cnv(canvas),x,y,s);

#### Original C function from <.../cd/include/cd.h>
# char* cdCanvasVectorFont(cdCanvas* canvas, const char *filename);
char*
cdVectorFont(canvas,filename)
		SV* canvas;
		const char* filename;
	CODE:
		RETVAL = cdCanvasVectorFont(ref2cnv(canvas),filename);
	OUTPUT:
		RETVAL

#### Original C function from <.../cd/include/cd.h>
# void cdCanvasVectorTextDirection(cdCanvas* canvas, int x1, int y1, int x2, int y2);
void
cdVectorTextDirection(canvas,x1,y1,x2,y2)
		SV* canvas;
		int x1;
		int y1;
		int x2;
		int y2;
	CODE:
		cdCanvasVectorTextDirection(ref2cnv(canvas),x1,y1,x2,y2);

#### Original C function from <.../cd/include/cd.h>
# double* cdCanvasVectorTextTransform(cdCanvas* canvas, const double* matrix);
#xxx TODO
#double*
#cdVectorTextTransform(canvas,matrix)
#		SV* canvas;
#		const double* matrix;
#	CODE:
#		RETVAL = cdCanvasVectorTextTransform(ref2cnv(canvas),matrix);
#	OUTPUT:
#		RETVAL

#### Original C function from <.../cd/include/cd.h>
# void cdCanvasVectorTextSize(cdCanvas* canvas, int size_x, int size_y, const char* s);
#xxx TODO
#void
#cdVectorTextSize(canvas,size_x,size_y,s)
#		SV* canvas;
#		int size_x;
#		int size_y;
#		const char* s;
#	CODE:
#		cdCanvasVectorTextSize(ref2cnv(canvas),size_x,size_y,s);

#### Original C function from <.../cd/include/cd.h>
# int cdCanvasVectorCharSize(cdCanvas* canvas, int size);
int
cdVectorCharSize(canvas,size)
		SV* canvas;
		int size;
	CODE:
		RETVAL = cdCanvasVectorCharSize(ref2cnv(canvas),size);
	OUTPUT:
		RETVAL

#### Original C function from <.../cd/include/cd.h>
# void cdCanvasVectorFontSize(cdCanvas* canvas, double size_x, double size_y);
void
cdVectorFontSize(canvas,size_x,size_y)
		SV* canvas;
		double size_x;
		double size_y;
	CODE:
		cdCanvasVectorFontSize(ref2cnv(canvas),size_x,size_y);

#### Original C function from <.../cd/include/cd.h>
# void cdCanvasGetVectorFontSize(cdCanvas* canvas, double *size_x, double *size_y);
#xxx TODO
#void
#cdGetVectorFontSize(canvas,size_x,size_y)
#		SV* canvas;
#		double* size_x;
#		double* size_y;
#	CODE:
#		cdCanvasGetVectorFontSize(ref2cnv(canvas),size_x,size_y);

#### Original C function from <.../cd/include/cd.h>
# void cdCanvasGetVectorTextSize(cdCanvas* canvas, const char* s, int *x, int *y);
void
cdGetVectorTextSize(canvas,s,x,y)
		SV* canvas;
		const char* s;
		int &x;
		int &y;
	CODE:
		cdCanvasGetVectorTextSize(ref2cnv(canvas),s,&x,&y);

#### Original C function from <.../cd/include/cd.h>
# void cdCanvasGetVectorTextBounds(cdCanvas* canvas, const char* s, int x, int y, int *rect);
void
cdGetVectorTextBounds(canvas,s,x,y,rect)
		SV* canvas;
		const char* s;
		int x;
		int y;
		int &rect;
	CODE:
		cdCanvasGetVectorTextBounds(ref2cnv(canvas),s,x,y,&rect);

#### Original C function from <.../cd/include/cd.h>
# void cdCanvasGetVectorTextBox(cdCanvas* canvas, int x, int y, const char *s, int *xmin, int *xmax, int *ymin, int *ymax);
void
cdGetVectorTextBox(canvas,x,y,s,xmin,xmax,ymin,ymax)
		SV* canvas;
		int x;
		int y;
		const char* s;
		int &xmin;
		int &xmax;
		int &ymin;
		int &ymax;
	CODE:
		cdCanvasGetVectorTextBox(ref2cnv(canvas),x,y,s,&xmin,&xmax,&ymin,&ymax);

#### Original C function from <.../cd/include/cd.h>
# void cdCanvasGetFontDim(cdCanvas* canvas, int *max_width, int *height, int *ascent, int *descent);
#xxx TODO
#void cdCanvasGetFontD
#im(canvas,max_width,height,ascent,descent)
#		SV* canvas;
#		int &max_width;
#		int &height;
#		int &ascent;
#		int &descent;
#	CODE:
#		RETVAL = im(ref2cnv(canvas),&max_width,&height,&ascent,&descent);
#	OUTPUT:
#		RETVAL

#### Original C function from <.../cd/include/cd.h>
# void cdCanvasGetTextSize(cdCanvas* canvas, const char* s, int *width, int *height);
void
cdGetTextSize(canvas,s,width,height)
		SV* canvas;
		const char* s;
		int &width;
		int &height;
	CODE:
		cdCanvasGetTextSize(ref2cnv(canvas),s,&width,&height);

#### Original C function from <.../cd/include/cd.h>
# void cdCanvasGetTextBox(cdCanvas* canvas, int x, int y, const char* s, int *xmin, int *xmax, int *ymin, int *ymax);
void
cdGetTextBox(canvas,x,y,s,xmin,xmax,ymin,ymax)
		SV* canvas;
		int x;
		int y;
		const char* s;
		int &xmin;
		int &xmax;
		int &ymin;
		int &ymax;
	CODE:
		cdCanvasGetTextBox(ref2cnv(canvas),x,y,s,&xmin,&xmax,&ymin,&ymax);

#### Original C function from <.../cd/include/cd.h>
# void cdCanvasGetTextBounds(cdCanvas* canvas, int x, int y, const char* s, int *rect);
void
cdGetTextBounds(canvas,x,y,s,rect)
		SV* canvas;
		int x;
		int y;
		const char* s;
		int &rect;
	CODE:
		cdCanvasGetTextBounds(ref2cnv(canvas),x,y,s,&rect);

#### Original C function from <.../cd/include/cd.h>
# int cdCanvasGetColorPlanes(cdCanvas* canvas);
int
cdGetColorPlanes(canvas)
		SV* canvas;
	CODE:
		RETVAL = cdCanvasGetColorPlanes(ref2cnv(canvas));
	OUTPUT:
		RETVAL

#### Original C function from <.../cd/include/cd.h>
# void cdCanvasPalette(cdCanvas* canvas, int n, const long *palette, int mode);
#xxx TODO
#void
#cdPalette(canvas,n,palette,mode)
#		SV* canvas;
#		int n;
#		const long* palette;
#		int mode;
#	CODE:
#		cdCanvasPalette(ref2cnv(canvas),n,palette,mode);

#### Original C function from <.../cd/include/cd.h>
# void cdCanvasGetImageRGB(cdCanvas* canvas, unsigned char* r, unsigned char* g, unsigned char* b, int x, int y, int w, int h);
void
cdGetImageRGB(canvas,r,g,b,x,y,w,h)
		SV* canvas;
		unsigned char* r;
		unsigned char* g;
		unsigned char* b;
		int x;
		int y;
		int w;
		int h;
	CODE:
		cdCanvasGetImageRGB(ref2cnv(canvas),r,g,b,x,y,w,h);

#### Original C function from <.../cd/include/cd.h>
# void cdCanvasPutImageRectRGB(cdCanvas* canvas, int iw, int ih, const unsigned char* r, const unsigned char* g, const unsigned char* b, int x, int y, int w, int h, int xmin, int xmax, int ymin, int ymax);
#xxx TODO
#void
#cdPutImageRectRGB(canvas,iw,ih,r,g,b,x,y,w,h,xmin,xmax,ymin,ymax)
#		SV* canvas;
#		int iw;
#		int ih;
#		const unsigned char* r;
#		const unsigned char* g;
#		const unsigned char* b;
#		int x;
#		int y;
#		int w;
#		int h;
#		int xmin;
#		int xmax;
#		int ymin;
#		int ymax;
#	CODE:
#		cdCanvasPutImageRectRGB(ref2cnv(canvas),iw,ih,r,g,b,x,y,w,h,xmin,xmax,ymin,ymax);

#### Original C function from <.../cd/include/cd.h>
# void cdCanvasPutImageRectRGBA(cdCanvas* canvas, int iw, int ih, const unsigned char* r, const unsigned char* g, const unsigned char* b, const unsigned char* a, int x, int y, int w, int h, int xmin, int xmax, int ymin, int ymax);
#xxx TODO
#void
#cdPutImageRectRGBA(canvas,iw,ih,r,g,b,a,x,y,w,h,xmin,xmax,ymin,ymax)
#		SV* canvas;
#		int iw;
#		int ih;
#		const unsigned char* r;
#		const unsigned char* g;
#		const unsigned char* b;
#		const unsigned char* a;
#		int x;
#		int y;
#		int w;
#		int h;
#		int xmin;
#		int xmax;
#		int ymin;
#		int ymax;
#	CODE:
#		cdCanvasPutImageRectRGBA(ref2cnv(canvas),iw,ih,r,g,b,a,x,y,w,h,xmin,xmax,ymin,ymax);

#### Original C function from <.../cd/include/cd.h>
# void cdCanvasPutImageRectMap(cdCanvas* canvas, int iw, int ih, const unsigned char* index, const long* colors, int x, int y, int w, int h, int xmin, int xmax, int ymin, int ymax);
#xxx TODO
#void
#cdPutImageRectMap(canvas,iw,ih,index,colors,x,y,w,h,xmin,xmax,ymin,ymax)
#		SV* canvas;
#		int iw;
#		int ih;
#		const unsigned char* index;
#		const long* colors;
#		int x;
#		int y;
#		int w;
#		int h;
#		int xmin;
#		int xmax;
#		int ymin;
#		int ymax;
#	CODE:
#		cdCanvasPutImageRectMap(ref2cnv(canvas),iw,ih,index,colors,x,y,w,h,xmin,xmax,ymin,ymax);

#### Original C function from <.../cd/include/cd.h>
# cdImage* cdCanvasCreateImage(cdCanvas* canvas, int w, int h);
cdImage*
cdCreateImage(canvas,w,h)
		SV* canvas;
		int w;
		int h;
	CODE:
		RETVAL = cdCanvasCreateImage(ref2cnv(canvas),w,h);
	OUTPUT:
		RETVAL

#### Original C function from <.../cd/include/cd.h>
# void cdKillImage(cdImage* image);
void
cdKillImage(image)
		cdImage* image;
	CODE:
		cdKillImage(image);

#### Original C function from <.../cd/include/cd.h>
# void cdCanvasGetImage(cdCanvas* canvas, cdImage* image, int x, int y);
void
cdGetImage(canvas,image,x,y)
		SV* canvas;
		cdImage* image;
		int x;
		int y;
	CODE:
		cdCanvasGetImage(ref2cnv(canvas),image,x,y);

#### Original C function from <.../cd/include/cd.h>
# void cdCanvasPutImageRect(cdCanvas* canvas, cdImage* image, int x, int y, int xmin, int xmax, int ymin, int ymax);
void
cdPutImageRect(canvas,image,x,y,xmin,xmax,ymin,ymax)
		SV* canvas;
		cdImage* image;
		int x;
		int y;
		int xmin;
		int xmax;
		int ymin;
		int ymax;
	CODE:
		cdCanvasPutImageRect(ref2cnv(canvas),image,x,y,xmin,xmax,ymin,ymax);

#### Original C function from <.../cd/include/cd.h>
# void cdCanvasScrollArea(cdCanvas* canvas, int xmin, int xmax, int ymin, int ymax, int dx, int dy);
void
cdScrollArea(canvas,xmin,xmax,ymin,ymax,dx,dy)
		SV* canvas;
		int xmin;
		int xmax;
		int ymin;
		int ymax;
		int dx;
		int dy;
	CODE:
		cdCanvasScrollArea(ref2cnv(canvas),xmin,xmax,ymin,ymax,dx,dy);

#### Original C function from <.../cd/include/cd.h>
# cdBitmap* cdCreateBitmap(int w, int h, int type);
cdBitmap*
cdCreateBitmap(w,h,type)
		int w;
		int h;
		int type;
	CODE:
		RETVAL = cdCreateBitmap(w,h,type);
	OUTPUT:
		RETVAL

#### Original C function from <.../cd/include/cd.h>
# cdBitmap* cdInitBitmap(int w, int h, int type, ...);
cdBitmap*
cdInitBitmap(w,h,type,...)
		int w;
		int h;
		int type;
	CODE:
		RETVAL = cdInitBitmap(w,h,type);
	OUTPUT:
		RETVAL

#### Original C function from <.../cd/include/cd.h>
# void cdKillBitmap(cdBitmap* bitmap);
void
cdKillBitmap(bitmap)
		cdBitmap* bitmap;
	CODE:
		cdKillBitmap(bitmap);

#### Original C function from <.../cd/include/cd.h>
# unsigned char* cdBitmapGetData(cdBitmap* bitmap, int dataptr);
unsigned char*
cdBitmapGetData(bitmap,dataptr)
		cdBitmap* bitmap;
		int dataptr;
	CODE:
		RETVAL = cdBitmapGetData(bitmap,dataptr);
	OUTPUT:
		RETVAL

#### Original C function from <.../cd/include/cd.h>
# void cdBitmapSetRect(cdBitmap* bitmap, int xmin, int xmax, int ymin, int ymax);
void
cdBitmapSetRect(bitmap,xmin,xmax,ymin,ymax)
		cdBitmap* bitmap;
		int xmin;
		int xmax;
		int ymin;
		int ymax;
	CODE:
		cdBitmapSetRect(bitmap,xmin,xmax,ymin,ymax);

#### Original C function from <.../cd/include/cd.h>
# void cdCanvasPutBitmap(cdCanvas* canvas, cdBitmap* bitmap, int x, int y, int w, int h);
void
cdPutBitmap(canvas,bitmap,x,y,w,h)
		SV* canvas;
		cdBitmap* bitmap;
		int x;
		int y;
		int w;
		int h;
	CODE:
		cdCanvasPutBitmap(ref2cnv(canvas),bitmap,x,y,w,h);

#### Original C function from <.../cd/include/cd.h>
# void cdCanvasGetBitmap(cdCanvas* canvas, cdBitmap* bitmap, int x, int y);
void
cdGetBitmap(canvas,bitmap,x,y)
		SV* canvas;
		cdBitmap* bitmap;
		int x;
		int y;
	CODE:
		cdCanvasGetBitmap(ref2cnv(canvas),bitmap,x,y);

#### Original C function from <.../cd/include/cd.h>
# void cdBitmapRGB2Map(cdBitmap* bitmap_rgb, cdBitmap* bitmap_map);
void
cdBitmapRGB2Map(bitmap_rgb,bitmap_map)
		cdBitmap* bitmap_rgb;
		cdBitmap* bitmap_map;
	CODE:
		cdBitmapRGB2Map(bitmap_rgb,bitmap_map);

#### Original C function from <.../cd/include/cd.h>
# long cdEncodeColor(unsigned char red, unsigned char green, unsigned char blue);
long
cdEncodeColor(red,green,blue)
		unsigned char red;
		unsigned char green;
		unsigned char blue;
	CODE:
		RETVAL = cdEncodeColor(red,green,blue);
	OUTPUT:
		RETVAL

#### Original C function from <.../cd/include/cd.h>
# void cdDecodeColor(long color, unsigned char* red, unsigned char* green, unsigned char* blue);
void
cdDecodeColor(color,red,green,blue)
		long color;
		unsigned char* red;
		unsigned char* green;
		unsigned char* blue;
	CODE:
		cdDecodeColor(color,red,green,blue);

#### Original C function from <.../cd/include/cd.h>
# unsigned char cdDecodeAlpha(long color);
unsigned char
cdDecodeAlpha(color)
		long color;
	CODE:
		RETVAL = cdDecodeAlpha(color);
	OUTPUT:
		RETVAL

#### Original C function from <.../cd/include/cd.h>
# long cdEncodeAlpha(long color, unsigned char alpha);
long
cdEncodeAlpha(color,alpha)
		long color;
		unsigned char alpha;
	CODE:
		RETVAL = cdEncodeAlpha(color,alpha);
	OUTPUT:
		RETVAL

#### Original C function from <.../cd/include/cd.h>
# void cdRGB2Map(int width, int height, const unsigned char* red, const unsigned char* green, const unsigned char* blue, unsigned char* index, int pal_size, long *color);
#xxx TODO
#void
#cdRGB2Map(width,height,red,green,blue,index,pal_size,color)
#		int width;
#		int height;
#		const unsigned char* red;
#		const unsigned char* green;
#		const unsigned char* blue;
#		unsigned char* index;
#		int pal_size;
#		long* color;
#	CODE:
#		cdRGB2Map(width,height,red,green,blue,index,pal_size,color);


### generated part - end ###
