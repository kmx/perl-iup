#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"
#include "ppport.h"

#include <iup.h>
#include <iupcontrols.h>
#include <iup_pplot.h>
#include <iupgl.h>

/* macros for processing args in fuctions with variable arg list, e.g. 'func(...)' */
#define myST2IHN(a) (items>(a)) && (SvIOK(ST(a))) ? INT2PTR(Ihandle*, SvIVX(ST(a))) : NULL;
#define myST2STR(a) (items>(a)) && (SvPOK(ST(a))) ? SvPVX(ST(a)) : NULL;
#define myST2INT(a) (items>(a)) && (SvIOK(ST(a))) ? SvIVX(ST(a)) : 0;

/* convert 'SV' to 'Ihandle*' + do undef->NULL conversion */
#define mySV2IHN(a) (SvIOK(a) ? INT2PTR(Ihandle *, SvIVX(a)) : NULL)

/* GetParam callback stuff */

typedef struct _getparam_data {
  int has_func;
  int obj_initialized;
  SV* func_ref;
  SV* obj_ref;
} getparam_data;

static int cb_param_action(Ihandle* dialog, int param_index, void* user_data) {
  int count, ret = 1;  
  getparam_data* gp = (getparam_data*)user_data;  
  if (gp->has_func && !gp->obj_initialized) {
    /* called for the first time; we need to set ihandle value to $obj_ref */
    dSP;
    ENTER;
    SAVETMPS;
    
    PUSHMARK(SP);
    XPUSHs(gp->obj_ref);
    XPUSHs(sv_2mortal(newSViv(PTR2IV(dialog))));
    PUTBACK;

    call_method("ihandle",G_DISCARD);

    FREETMPS;
    LEAVE;

    gp->obj_initialized = 1;
  }
  if (gp->has_func) {
    dSP;
    ENTER;
    SAVETMPS;
    
    PUSHMARK(SP);
    XPUSHs(gp->obj_ref);
    XPUSHs(sv_2mortal(newSViv(param_index)));
    PUTBACK;

    count = call_sv(gp->func_ref,G_SCALAR);

    SPAGAIN;

    if (count != 1) croak("Error: GetParam's action has not returned single scalar value!\n");
    ret = POPi;

    PUTBACK;
    FREETMPS;
    LEAVE;
  }
  return ret;
}

MODULE = IUP::Internal::LibraryIUP	PACKAGE = IUP::Internal::LibraryIUP

# http://perldoc.perl.org/perlxs.html
# http://perldoc.perl.org/perlxstut.html

BOOT:
//xxx warn("Helo from bootstrap!");
IupOpen(NULL, NULL);
IupControlsOpen();
IupPPlotOpen();
IupGLCanvasOpen();
//xxx ??? IupImageLibOpen();

################################################################################ iup.h

#### Original C function from <iup.h>
# void IupClose (void);
void
_IupClose()
	CODE:
		IupClose();

#### Original C function from <iup.h>
# void IupImageLibOpen (void);
void
_IupImageLibOpen()
	CODE:
		IupImageLibOpen();

#### Original C function from <iup.h>
# int IupMainLoop (void);
int
_IupMainLoop()
	CODE:
		RETVAL = IupMainLoop();
	OUTPUT:
		RETVAL

#### Original C function from <iup.h>
# int IupLoopStep (void);
int
_IupLoopStep()
	CODE:
		RETVAL = IupLoopStep();
	OUTPUT:
		RETVAL

#### Original C function from <iup.h>
# int IupLoopStepWait (void);
int
_IupLoopStepWait()
	CODE:
		RETVAL = IupLoopStepWait();
	OUTPUT:
		RETVAL

#### Original C function from <iup.h>
# int IupMainLoopLevel (void);
int
_IupMainLoopLevel()
	CODE:
		RETVAL = IupMainLoopLevel();
	OUTPUT:
		RETVAL

#### Original C function from <iup.h>
# void IupFlush (void);
void
_IupFlush()
	CODE:
		IupFlush();

#### Original C function from <iup.h>
# void IupExitLoop (void);
void
_IupExitLoop()
	CODE:
		IupExitLoop();

#### Original C function from <iup.h>
# void IupUpdate (Ihandle* ih);
void
_IupUpdate(ih)
		Ihandle* ih = myST2IHN(0);
	CODE:
		IupUpdate(ih);

#### Original C function from <iup.h>
# void IupUpdateChildren(Ihandle* ih);
void
_IupUpdateChildren(ih)
		Ihandle* ih = myST2IHN(0);
	CODE:
		IupUpdateChildren(ih);

#### Original C function from <iup.h>
# void IupRedraw (Ihandle* ih, int children);
void
_IupRedraw(ih,children)
		Ihandle* ih = myST2IHN(0);
		int children;
	CODE:
		IupRedraw(ih,children);

#### Original C function from <iup.h>
# void IupRefresh (Ihandle* ih);
void
_IupRefresh(ih)
		Ihandle* ih = myST2IHN(0);
	CODE:
		IupRefresh(ih);

#### Original C function from <iup.h>
# char* IupMapFont (const char *iupfont);
char*
_IupMapFont(iupfont)
		char* iupfont = myST2STR(0);
	CODE:
		RETVAL = IupMapFont(iupfont);
	OUTPUT:
		RETVAL

#### Original C function from <iup.h>
# char* IupUnMapFont (const char *driverfont);
char*
_IupUnMapFont(driverfont)
		const char* driverfont = myST2STR(0);
	CODE:
		RETVAL = IupUnMapFont(driverfont);
	OUTPUT:
		RETVAL

#### Original C function from <iup.h>
# int IupHelp (const char* url);
int
_IupHelp(url)
		char* url = myST2STR(0);
	CODE:
		RETVAL = IupHelp(url);
	OUTPUT:
		RETVAL

#### Original C function from <iup.h>
# char* IupLoad (const char *filename);
char*
_IupLoad(filename)
		const char* filename;
	CODE:
		RETVAL = IupLoad(filename);
	OUTPUT:
		RETVAL

#### Original C function from <iup.h>
# char* IupLoadBuffer (const char *buffer);
char*
_IupLoadBuffer(buffer)
		char* buffer = myST2STR(0);
	CODE:
		RETVAL = IupLoadBuffer(buffer);
	OUTPUT:
		RETVAL

#### Original C function from <iup.h>
# char* IupVersion (void);
char*
_IupVersion()
	CODE:
		RETVAL = IupVersion();
	OUTPUT:
		RETVAL

#### Original C function from <iup.h>
# char* IupVersionDate (void);
char*
_IupVersionDate()
	CODE:
		RETVAL = IupVersionDate();
	OUTPUT:
		RETVAL

#### Original C function from <iup.h>
# int IupVersionNumber (void);
int
_IupVersionNumber()
	CODE:
		RETVAL = IupVersionNumber();
	OUTPUT:
		RETVAL

#### Original C function from <iup.h>
# void IupSetLanguage (const char *lng);
void
_IupSetLanguage(lng)
		char* lng = myST2STR(0);
	CODE:
		IupSetLanguage(lng);

#### Original C function from <iup.h>
# char* IupGetLanguage (void);
char*
_IupGetLanguage()
	CODE:
		RETVAL = IupGetLanguage();
	OUTPUT:
		RETVAL

#### Original C function from <iup.h>
# void IupDestroy (Ihandle* ih);
void
_IupDestroy(ih)
		Ihandle* ih = myST2IHN(0);
	CODE:
		IupDestroy(ih);

#### Original C function from <iup.h>
# void IupDetach (Ihandle* child);
void
_IupDetach(child)
		Ihandle* child = myST2IHN(0);
	CODE:
		IupDetach(child);

#### Original C function from <iup.h>
# Ihandle* IupAppend (Ihandle* ih, Ihandle* child);
Ihandle*
_IupAppend(ih,child)
		Ihandle* ih = myST2IHN(0);
		Ihandle* child = myST2IHN(1);
	CODE:
		RETVAL = IupAppend(ih,child);
	OUTPUT:
		RETVAL

#### Original C function from <iup.h>
# Ihandle* IupInsert (Ihandle* ih, Ihandle* ref_child, Ihandle* child);
Ihandle*
_IupInsert(ih,ref_child,child)
		Ihandle* ih = myST2IHN(0);
		Ihandle* ref_child = myST2IHN(1);
		Ihandle* child = myST2IHN(2);
	CODE:
		RETVAL = IupInsert(ih,ref_child,child);
	OUTPUT:
		RETVAL

#### Original C function from <iup.h>
# Ihandle* IupGetChild (Ihandle* ih, int pos);
Ihandle*
_IupGetChild(ih,pos)
		Ihandle* ih = myST2IHN(0);
		int pos;
	CODE:
		RETVAL = IupGetChild(ih,pos);
	OUTPUT:
		RETVAL

#### Original C function from <iup.h>
# int IupGetChildPos (Ihandle* ih, Ihandle* child);
int
_IupGetChildPos(ih,child)
		Ihandle* ih = myST2IHN(0);
		Ihandle* child = myST2IHN(1);
	CODE:
		RETVAL = IupGetChildPos(ih,child);
	OUTPUT:
		RETVAL

#### Original C function from <iup.h>
# int IupGetChildCount(Ihandle* ih);
int
_IupGetChildCount(ih)
		Ihandle* ih = myST2IHN(0);
	CODE:
		RETVAL = IupGetChildCount(ih);
	OUTPUT:
		RETVAL

#### Original C function from <iup.h>
# Ihandle* IupGetNextChild (Ihandle* ih, Ihandle* child);
Ihandle*
_IupGetNextChild(ih,child)
		Ihandle* ih = myST2IHN(0);
		Ihandle* child = myST2IHN(1);
	CODE:
		RETVAL = IupGetNextChild(ih,child);
	OUTPUT:
		RETVAL

#### Original C function from <iup.h>
# Ihandle* IupGetBrother (Ihandle* ih);
Ihandle*
_IupGetBrother(ih)
		Ihandle* ih = myST2IHN(0);
	CODE:
		RETVAL = IupGetBrother(ih);
	OUTPUT:
		RETVAL

#### Original C function from <iup.h>
# Ihandle* IupGetParent (Ihandle* ih);
Ihandle*
_IupGetParent(ih)
		Ihandle* ih = myST2IHN(0);
	CODE:
		RETVAL = IupGetParent(ih);
	OUTPUT:
		RETVAL

#### Original C function from <iup.h>
# Ihandle* IupGetDialog (Ihandle* ih);
Ihandle*
_IupGetDialog(ih)
		Ihandle* ih = myST2IHN(0);
	CODE:
		RETVAL = IupGetDialog(ih);
	OUTPUT:
		RETVAL

#### Original C function from <iup.h>
# Ihandle* IupGetDialogChild(Ihandle* ih, const char* name);
Ihandle*
_IupGetDialogChild(ih,name)
		Ihandle* ih = myST2IHN(0);
		const char* name;
	CODE:
		RETVAL = IupGetDialogChild(ih,name);
	OUTPUT:
		RETVAL

#### Original C function from <iup.h>
# int IupReparent (Ihandle* ih, Ihandle* new_parent);
int
_IupReparent(ih,new_parent)
		Ihandle* ih = myST2IHN(0);
		Ihandle* new_parent = myST2IHN(1);
	CODE:
		RETVAL = IupReparent(ih,new_parent);
	OUTPUT:
		RETVAL

#### Original C function from <iup.h>
# int IupPopup (Ihandle* ih, int x, int y);
int
_IupPopup(ih,x,y)
		Ihandle* ih = myST2IHN(0);
		int x;
		int y;
	CODE:
		RETVAL = IupPopup(ih,x,y);
	OUTPUT:
		RETVAL

#### Original C function from <iup.h>
# int IupShow (Ihandle* ih);
int
_IupShow(ih)
		Ihandle* ih = myST2IHN(0);
	CODE:
		RETVAL = IupShow(ih);
	OUTPUT:
		RETVAL

#### Original C function from <iup.h>
# int IupShowXY (Ihandle* ih, int x, int y);
int
_IupShowXY(ih,x,y)
		Ihandle* ih = myST2IHN(0);
		int x;
		int y;
	CODE:
		RETVAL = IupShowXY(ih,x,y);
	OUTPUT:
		RETVAL

#### Original C function from <iup.h>
# int IupHide (Ihandle* ih);
int
_IupHide(ih)
		Ihandle* ih = myST2IHN(0);
	CODE:
		RETVAL = IupHide(ih);
	OUTPUT:
		RETVAL

#### Original C function from <iup.h>
# int IupMap (Ihandle* ih);
int
_IupMap(ih)
		Ihandle* ih = myST2IHN(0);
	CODE:
		RETVAL = IupMap(ih);
	OUTPUT:
		RETVAL

#### Original C function from <iup.h>
# void IupUnmap (Ihandle *ih);
void
_IupUnmap(ih)
		Ihandle* ih = myST2IHN(0);
	CODE:
		IupUnmap(ih);

#### Original C function from <iup.h>
# void IupSetAttribute (Ihandle* ih, const char* name, const char* value);
void
_IupSetAttribute(ih,name,value)
		Ihandle* ih = myST2IHN(0);
		char* name = myST2STR(1);
		char* value = myST2STR(2);
	CODE:
		//xxx warn("#XS# ih='%p' name='%s' value='%s'", ih, name, value);
		IupSetAttribute(ih,name,value);

#### Original C function from <iup.h>
# void IupStoreAttribute(Ihandle* ih, const char* name, const char* value);
void
_IupStoreAttribute(ih,name,value)
		Ihandle* ih = myST2IHN(0);
		const char* name;
		const char* value;
	CODE:
		IupStoreAttribute(ih,name,value);

#### Original C function from <iup.h>
# Ihandle* IupSetAttributes (Ihandle* ih, const char *str);
Ihandle*
_IupSetAttributes(ih,str)
		Ihandle* ih = myST2IHN(0);
		const char* str;
	CODE:
		RETVAL = IupSetAttributes(ih,str);
	OUTPUT:
		RETVAL

#### Original C function from <iup.h>
# char* IupGetAttribute (Ihandle* ih, const char* name);
char*
_IupGetAttribute(ih,name)
		Ihandle* ih = myST2IHN(0);
		const char* name;
	CODE:
		RETVAL = IupGetAttribute(ih,name);
	OUTPUT:
		RETVAL

#### Original C function from <iup.h>
# char* IupGetAttributes (Ihandle* ih);
char*
_IupGetAttributes(ih)
		Ihandle* ih = myST2IHN(0);
	CODE:
		RETVAL = IupGetAttributes(ih);
	OUTPUT:
		RETVAL

#### Original C function from <iup.h>
# int IupGetInt (Ihandle* ih, const char* name);
int
_IupGetInt(ih,name)
		Ihandle* ih = myST2IHN(0);
		const char* name;
	CODE:
		RETVAL = IupGetInt(ih,name);
	OUTPUT:
		RETVAL

#### Original C function from <iup.h>
# int IupGetInt2 (Ihandle* ih, const char* name);
int
_IupGetInt2(ih,name)
		Ihandle* ih = myST2IHN(0);
		const char* name;
	CODE:
		RETVAL = IupGetInt2(ih,name);
	OUTPUT:
		RETVAL

#### Original C function from <iup.h>
# int IupGetIntInt (Ihandle *ih, const char* name, int *i1, int *i2);
int
_IupGetIntInt(ih,name,i1,i2)
		Ihandle* ih = myST2IHN(0);
		const char* name;
		int &i1;
		int &i2;
	CODE:
		RETVAL = IupGetIntInt(ih,name,&i1,&i2);
	OUTPUT:
		RETVAL

#### Original C function from <iup.h>
# float IupGetFloat (Ihandle* ih, const char* name);
float
_IupGetFloat(ih,name)
		Ihandle* ih = myST2IHN(0);
		const char* name;
	CODE:
		RETVAL = IupGetFloat(ih,name);
	OUTPUT:
		RETVAL

#### Original C function from <iup.h>
# void IupSetfAttribute (Ihandle* ih, const char* name, const char* format, ...);
void
_IupSetfAttribute(ih,name,format,...)
		Ihandle* ih = myST2IHN(0);
		const char* name;
		const char* format;
	CODE:
		IupSetfAttribute(ih,name,format);

#### Original C function from <iup.h>
# void IupResetAttribute(Ihandle *ih, const char* name);
void
_IupResetAttribute(ih,name)
		Ihandle* ih = myST2IHN(0);
		const char* name;
	CODE:
		IupResetAttribute(ih,name);

#### Original C function from <iup.h>
# Ihandle* IupSetAtt(const char* handle_name, Ihandle* ih, const char* name, ...);
Ihandle*
_IupSetAtt(handle_name,ih,name,...)
		const char* handle_name;
		Ihandle* ih = myST2IHN(0);
		const char* name;
	CODE:
		RETVAL = IupSetAtt(handle_name,ih,name);
	OUTPUT:
		RETVAL

#### Original C function from <iup.h>
# void IupSetGlobal (const char* name, const char* value);
void
_IupSetGlobal(name,value)
		char* name = myST2STR(0);
		char* value = myST2STR(1);
	CODE:
		IupSetGlobal(name,value);

#### Original C function from <iup.h>
# void IupStoreGlobal (const char* name, const char* value);
void
_IupStoreGlobal(name,value)
		char* name = myST2STR(0);
		char* value = myST2STR(1);
	CODE:
		IupStoreGlobal(name,value);

#### Original C function from <iup.h>
# char* IupGetGlobal (const char* name);
char*
_IupGetGlobal(name)
		char* name = myST2STR(0);
	CODE:
		RETVAL = IupGetGlobal(name);
	OUTPUT:
		RETVAL

#### Original C function from <iup.h>
# Ihandle* IupSetFocus (Ihandle* ih);
Ihandle*
_IupSetFocus(ih)
		Ihandle* ih = myST2IHN(0);
	CODE:
		RETVAL = IupSetFocus(ih);
	OUTPUT:
		RETVAL

#### Original C function from <iup.h>
# Ihandle* IupGetFocus (void);
Ihandle*
_IupGetFocus()
	CODE:
		RETVAL = IupGetFocus();
	OUTPUT:
		RETVAL

#### Original C function from <iup.h>
# Ihandle* IupPreviousField (Ihandle* ih); 
Ihandle*
_IupPreviousField(ih)
		Ihandle* ih = myST2IHN(0);
	CODE:
		RETVAL = IupPreviousField(ih);
	OUTPUT:
		RETVAL

#### Original C function from <iup.h>
# Ihandle* IupNextField (Ihandle* ih);
Ihandle*
_IupNextField(ih)
		Ihandle* ih = myST2IHN(0);
	CODE:
		RETVAL = IupNextField(ih);
	OUTPUT:
		RETVAL

#### Original C function from <iup.h>
# Icallback IupGetCallback(Ihandle* ih, const char *name);
Icallback
_IupGetCallback(ih,name)
		Ihandle* ih = myST2IHN(0);
		const char* name;
	CODE:
		RETVAL = IupGetCallback(ih,name);
	OUTPUT:
		RETVAL

#### Original C function from <iup.h>
# Icallback IupSetCallback(Ihandle* ih, const char *name, Icallback func);
Icallback
_IupSetCallback(ih,name,func)
		Ihandle* ih = myST2IHN(0);
		const char* name;
		Icallback func;
	CODE:
		RETVAL = IupSetCallback(ih,name,func);
	OUTPUT:
		RETVAL

#### Original C function from <iup.h>
# Ihandle* IupSetCallbacks(Ihandle* ih, const char *name, Icallback func, ...);
Ihandle*
_IupSetCallbacks(ih,name,func,...)
		Ihandle* ih = myST2IHN(0);
		const char* name;
		Icallback func;
	CODE:
		RETVAL = IupSetCallbacks(ih,name,func);
	OUTPUT:
		RETVAL

#### Original C function from <iup.h>
# Icallback IupGetFunction (const char *name);
Icallback
_IupGetFunction(name)
		const char* name;
	CODE:
		RETVAL = IupGetFunction(name);
	OUTPUT:
		RETVAL

#### Original C function from <iup.h>
# Icallback IupSetFunction (const char *name, Icallback func);
Icallback
_IupSetFunction(name,func)
		const char* name;
		Icallback func;
	CODE:
		RETVAL = IupSetFunction(name,func);
	OUTPUT:
		RETVAL

#### Original C function from <iup.h>
# Ihandle* IupGetHandle (const char *name);
Ihandle*
_IupGetHandle(name)
		char* name = myST2STR(0);
	CODE:
		RETVAL = IupGetHandle(name);
	OUTPUT:
		RETVAL

#### Original C function from <iup.h>
# Ihandle* IupSetHandle (const char *name, Ihandle* ih);
Ihandle*
_IupSetHandle(name,ih)
		const char* name;
		Ihandle* ih = myST2IHN(1);
	CODE:
		RETVAL = IupSetHandle(name,ih);
	OUTPUT:
		RETVAL

#### Original C function from <iup.h>
# char* IupGetName (Ihandle* ih);
char*
_IupGetName(ih)
		Ihandle* ih = myST2IHN(0);
	CODE:
		RETVAL = IupGetName(ih);
	OUTPUT:
		RETVAL

#### Original C function from <iup.h>
# void IupSetAttributeHandle(Ihandle* ih, const char* name, Ihandle* ih_named);
void
_IupSetAttributeHandle(ih,name,ih_named)
		Ihandle* ih = myST2IHN(0);
		const char* name;
		Ihandle* ih_named = myST2IHN(2);
	CODE:
		//xxx warn("#XS# ih='%p' name='%s' ih_named='%p'", ih, name, ih_named);
		IupSetAttributeHandle(ih,name,ih_named);

#### Original C function from <iup.h>
# Ihandle* IupGetAttributeHandle(Ihandle* ih, const char* name);
Ihandle*
_IupGetAttributeHandle(ih,name)
		Ihandle* ih = myST2IHN(0);
		const char* name;
	CODE:
		RETVAL = IupGetAttributeHandle(ih,name);
	OUTPUT:
		RETVAL

#### Original C function from <iup.h>
# char* IupGetClassName(Ihandle* ih);
char*
_IupGetClassName(ih)
		Ihandle* ih = myST2IHN(0);
	CODE:
		RETVAL = IupGetClassName(ih);
	OUTPUT:
		RETVAL

#### Original C function from <iup.h>
# char* IupGetClassType(Ihandle* ih);
char*
_IupGetClassType(ih)
		Ihandle* ih = myST2IHN(0);
	CODE:
		RETVAL = IupGetClassType(ih);
	OUTPUT:
		RETVAL

#### Original C function from <iup.h>
# void IupSaveClassAttributes(Ihandle* ih);
void
_IupSaveClassAttributes(ih)
		Ihandle* ih = myST2IHN(0);
	CODE:
		IupSaveClassAttributes(ih);

#### Original C function from <iup.h>
# void IupSetClassDefaultAttribute(const char* classname, const char *name, const char* value);
void
_IupSetClassDefaultAttribute(classname,name,value)
		char* classname = myST2STR(0);
		char* name = myST2STR(1);
		char* value = myST2STR(2);
	CODE:
		IupSetClassDefaultAttribute(classname,name,value);

#### Original C function from <iup.h>
# Ihandle* IupCreate (const char *classname);
Ihandle*
_IupCreate(classname)
		const char* classname;
	CODE:
		RETVAL = IupCreate(classname);
	OUTPUT:
		RETVAL

#### Original C function from <iup.h>
# Ihandle* IupCreatep(const char *classname, void *first, ...);
Ihandle*
_IupCreatep(classname,first,...)
		const char* classname;
		void* first;
	CODE:
		RETVAL = IupCreatep(classname,first);
	OUTPUT:
		RETVAL

#### Original C function from <iup.h>
# Ihandle* IupFill (void);
Ihandle*
_IupFill()
	CODE:
		RETVAL = IupFill();
	OUTPUT:
		RETVAL

#### Original C function from <iup.h>
# Ihandle* IupRadio (Ihandle* child);
Ihandle*
_IupRadio(child)
		Ihandle* child = myST2IHN(0);
	CODE:
		RETVAL = IupRadio(child);
	OUTPUT:
		RETVAL

#### Original C function from <iup.h>
# Ihandle* IupNormalizer (Ihandle* ih_first, ...);
Ihandle*
_IupNormalizer(...)
	PREINIT:
		int i;
	CODE:
		if (items>1) {
		  Ihandle** pointers = malloc( (items+1) * sizeof(void*) );		  
		  for(i=0; i<items; i++) pointers[i] = mySV2IHN(ST(i));
                  pointers[i] = NULL;
		  RETVAL = IupNormalizerv(pointers);
		  free(pointers);		  
		}
		else if (items==1) RETVAL = SvOK(ST(0)) ? IupNormalizer(mySV2IHN(ST(0)), NULL) : NULL;
		else RETVAL = IupNormalizer(NULL);
	OUTPUT:
		RETVAL

#### Original C function from <iup.h>
# Ihandle* IupVbox (Ihandle* child, ...);
Ihandle*
_IupVbox(...)
	PREINIT:
		int i;
	CODE:
		if (items>1) {
		  Ihandle** pointers = malloc( (items+1) * sizeof(void*) );		  
		  for(i=0; i<items; i++) pointers[i] = mySV2IHN(ST(i));
                  pointers[i] = NULL;
		  RETVAL = IupVboxv(pointers);
		  free(pointers);		  
		}
		else if (items==1) RETVAL = SvOK(ST(0)) ? IupVbox(mySV2IHN(ST(0)), NULL) : NULL;
		else RETVAL = IupVbox(NULL);
	OUTPUT:
		RETVAL

#### Original C function from <iup.h>
# Ihandle* IupZbox (Ihandle* child, ...);
Ihandle*
_IupZbox(...)
	PREINIT:
		int i;
	CODE:
		if (items>1) {
		  Ihandle** pointers = malloc( (items+1) * sizeof(void*) );		  
		  for(i=0; i<items; i++) pointers[i] = mySV2IHN(ST(i));
                  pointers[i] = NULL;
		  RETVAL = IupZboxv(pointers);
		  free(pointers);		  
		}
		else if (items==1) RETVAL = SvOK(ST(0)) ? IupZbox(mySV2IHN(ST(0)), NULL) : NULL;
		else RETVAL = IupZbox(NULL);
	OUTPUT:
		RETVAL

#### Original C function from <iup.h>
# Ihandle* IupHbox (Ihandle* child,...);
Ihandle*
_IupHbox(...)
	PREINIT:
		int i;
	CODE:
		if (items>1) {
		  Ihandle** pointers = malloc( (items+1) * sizeof(void*) );		  
		  for(i=0; i<items; i++) pointers[i] = mySV2IHN(ST(i));
                  pointers[i] = NULL;
		  RETVAL = IupHboxv(pointers);
		  free(pointers);		  
		}
		else if (items==1) RETVAL = SvOK(ST(0)) ? IupHbox(mySV2IHN(ST(0)), NULL) : NULL;
		else RETVAL = IupHbox(NULL);
	OUTPUT:
		RETVAL

#### Original C function from <iup.h>
# Ihandle* IupCbox (Ihandle* child, ...);
Ihandle*
_IupCbox(...)
	PREINIT:
		int i;
	CODE:
		if (items>1) {
		  Ihandle** pointers = malloc( (items+1) * sizeof(void*) );		  
		  for(i=0; i<items; i++) pointers[i] = mySV2IHN(ST(i));
                  pointers[i] = NULL;
		  RETVAL = IupCboxv(pointers);
		  free(pointers);		  
		}
		else if (items==1) RETVAL = SvOK(ST(0)) ? IupCbox(mySV2IHN(ST(0)), NULL) : NULL;
		else RETVAL = IupCbox(NULL);
	OUTPUT:
		RETVAL

#### Original C function from <iup.h>
# Ihandle* IupSbox (Ihandle *child);
Ihandle*
_IupSbox(child)
		Ihandle* child = myST2IHN(0);
	CODE:
		RETVAL = IupSbox(child);
	OUTPUT:
		RETVAL

#### Original C function from <iup.h>
# Ihandle* IupSplit (Ihandle* child1, Ihandle* child2);
Ihandle*
_IupSplit(child1,child2)
		Ihandle* child1 = myST2IHN(0);
		Ihandle* child2 = myST2IHN(1);
	CODE:
		RETVAL = IupSplit(child1,child2);
	OUTPUT:
		RETVAL

#### Original C function from <iup.h>
# Ihandle* IupFrame (Ihandle* child);
Ihandle*
_IupFrame(child)
		Ihandle* child = myST2IHN(0);
	CODE:
		RETVAL = IupFrame(child);
	OUTPUT:
		RETVAL

#### Original C function from <iup.h>
# Ihandle* IupImage (int width, int height, const unsigned char *pixmap);
Ihandle*
_IupImage(width,height,pixmap)
		int width;
		int height;
		SV * pixmap;
	CODE:
		RETVAL = IupImage(width,height,(unsigned char *)SvPVbyte_nolen(pixmap));
	OUTPUT:
		RETVAL

#### Original C function from <iup.h>
# Ihandle* IupImageRGB (int width, int height, const unsigned char *pixmap);
Ihandle*
_IupImageRGB(width,height,pixmap)
		int width;
		int height;
		SV * pixmap;
	CODE:
		RETVAL = IupImageRGB(width,height,(unsigned char *)SvPVbyte_nolen(pixmap));
	OUTPUT:
		RETVAL

#### Original C function from <iup.h>
# Ihandle* IupImageRGBA (int width, int height, const unsigned char *pixmap);
Ihandle*
_IupImageRGBA(width,height,pixmap)
		int width;
		int height;
		SV * pixmap;
	CODE:
		RETVAL = IupImageRGBA(width,height,(unsigned char *)SvPVbyte_nolen(pixmap));
	OUTPUT:
		RETVAL

#### Original C function from <iup.h>
# Ihandle* IupItem (const char* title, const char* action);
Ihandle*
_IupItem(title,action)
		const char* title = myST2STR(0);
		const char* action = myST2STR(1);
	CODE:
		RETVAL = IupItem(title,action);
	OUTPUT:
		RETVAL

#### Original C function from <iup.h>
# Ihandle* IupSubmenu (const char* title, Ihandle* child);
Ihandle*
_IupSubmenu(title,child)
		const char* title = myST2STR(0);
		Ihandle* child = myST2IHN(1);
	CODE:
		RETVAL = IupSubmenu(title,child);
	OUTPUT:
		RETVAL

#### Original C function from <iup.h>
# Ihandle* IupSeparator (void);
Ihandle*
_IupSeparator()
	CODE:
		RETVAL = IupSeparator();
	OUTPUT:
		RETVAL

#### Original C function from <iup.h>
# Ihandle* IupMenu (Ihandle* child,...);
Ihandle*
_IupMenu(...)
	PREINIT:
		int i;
	CODE:
		if (items>1) {
		  Ihandle** pointers = malloc( (items+1) * sizeof(void*) );		  
		  for(i=0; i<items; i++) pointers[i] = mySV2IHN(ST(i));
                  pointers[i] = NULL;
		  RETVAL = IupMenuv(pointers);
		  free(pointers);		  
		}
		else if (items==1) RETVAL = SvOK(ST(0)) ? IupMenu(mySV2IHN(ST(0)), NULL) : NULL;
		else RETVAL = IupMenu(NULL);
	OUTPUT:
		RETVAL

#### Original C function from <iup.h>
# Ihandle* IupButton (const char* title, const char* action);
Ihandle*
_IupButton(title,action)
		const char* title = myST2STR(0);
		const char* action = myST2STR(1);
	CODE:
		RETVAL = IupButton(title,action);
	OUTPUT:
		RETVAL

#### Original C function from <iup.h>
# Ihandle* IupCanvas (const char* action);
Ihandle*
_IupCanvas(action)
		const char* action = myST2STR(0);
	CODE:
		RETVAL = IupCanvas(action);
	OUTPUT:
		RETVAL

#### Original C function from <iup.h>
# Ihandle* IupDialog (Ihandle* child);
Ihandle*
_IupDialog(child)
		Ihandle* child = myST2IHN(0);
	CODE:
		RETVAL = IupDialog(child);
	OUTPUT:
		RETVAL

#### Original C function from <iup.h>
# Ihandle* IupUser (void);
Ihandle*
_IupUser()
	CODE:
		RETVAL = IupUser();
	OUTPUT:
		RETVAL

#### Original C function from <iup.h>
# Ihandle* IupLabel (const char* title);
Ihandle*
_IupLabel(title)
		const char* title = myST2STR(0);
	CODE:
		RETVAL = IupLabel(title);
	OUTPUT:
		RETVAL

#### Original C function from <iup.h>
# Ihandle* IupList (const char* action);
Ihandle*
_IupList(action)
		const char* action;
	CODE:
		RETVAL = IupList(action);
	OUTPUT:
		RETVAL

#### Original C function from <iup.h>
# Ihandle* IupText (const char* action);
Ihandle*
_IupText(action)
		const char* action;
	CODE:
		RETVAL = IupText(action);
	OUTPUT:
		RETVAL

#### Original C function from <iup.h>
# Ihandle* IupMultiLine (const char* action);
Ihandle*
_IupMultiLine(action)
		const char* action;
	CODE:
		RETVAL = IupMultiLine(action);
	OUTPUT:
		RETVAL

#### Original C function from <iup.h>
# Ihandle* IupToggle (const char* title, const char* action);
Ihandle*
_IupToggle(title,action)
		const char* title = myST2STR(0);
		const char* action = myST2STR(1);
	CODE:
		RETVAL = IupToggle(title,action);
	OUTPUT:
		RETVAL

#### Original C function from <iup.h>
# Ihandle* IupTimer (void);
Ihandle*
_IupTimer()
	CODE:
		RETVAL = IupTimer();
	OUTPUT:
		RETVAL

#### Original C function from <iup.h>
# Ihandle* IupClipboard (void);
Ihandle*
_IupClipboard()
	CODE:
		RETVAL = IupClipboard();
	OUTPUT:
		RETVAL

#### Original C function from <iup.h>
# Ihandle* IupProgressBar(void);
Ihandle*
_IupProgressBar()
	CODE:
		RETVAL = IupProgressBar();
	OUTPUT:
		RETVAL

#### Original C function from <iup.h>
# Ihandle* IupVal (const char *type);
Ihandle*
_IupVal(type)
		char* type = myST2STR(0);
	CODE:
		RETVAL = IupVal(type);
	OUTPUT:
		RETVAL

#### Original C function from <iup.h>
# Ihandle* IupTabs (Ihandle* child, ...);
Ihandle*
_IupTabs(...)
	PREINIT:
		int i;
	CODE:
		if (items>1) {
		  Ihandle** pointers = malloc( (items+1) * sizeof(void*) );		  
		  for(i=0; i<items; i++) pointers[i] = mySV2IHN(ST(i));
                  pointers[i] = NULL;
		  RETVAL = IupTabsv(pointers);
		  free(pointers);		  
		}
		else if (items==1) RETVAL = SvOK(ST(0)) ? IupTabs(mySV2IHN(ST(0)), NULL) : NULL;
		else RETVAL = IupTabs(NULL);
	OUTPUT:
		RETVAL

#### Original C function from <iup.h>
# Ihandle* IupTree (void);
Ihandle*
_IupTree()
	CODE:
		RETVAL = IupTree();
	OUTPUT:
		RETVAL

#### Original C function from <iup.h>
# Ihandle* IupSpin (void);
Ihandle*
_IupSpin()
	CODE:
		RETVAL = IupSpin();
	OUTPUT:
		RETVAL

#### Original C function from <iup.h>
# Ihandle* IupSpinbox (Ihandle* child);
Ihandle*
_IupSpinbox(child)
		Ihandle* child = myST2IHN(0);
	CODE:
		RETVAL = IupSpinbox(child);
	OUTPUT:
		RETVAL

#### Original C function from <iup.h>
# int IupSaveImageAsText(Ihandle* ih, const char* file_name, const char* format, const char* name);
int
_IupSaveImageAsText(ih,file_name,format,name)
		Ihandle* ih = myST2IHN(0);
		const char* file_name;
		const char* format;
		const char* name;
	CODE:
		RETVAL = IupSaveImageAsText(ih,file_name,format,name);
	OUTPUT:
		RETVAL

#### Original C function from <iup.h>
# void IupTextConvertLinColToPos(Ihandle* ih, int lin, int col, int *pos);
void
_IupTextConvertLinColToPos(ih,lin,col,pos)
		Ihandle* ih = myST2IHN(0);
		int lin;
		int col;
		int &pos;
	CODE:
		IupTextConvertLinColToPos(ih,lin,col,&pos);

#### Original C function from <iup.h>
# void IupTextConvertPosToLinCol(Ihandle* ih, int pos, int *lin, int *col);
void
_IupTextConvertPosToLinCol(ih,pos,lin,col)
		Ihandle* ih = myST2IHN(0);
		int pos;
		int &lin;
		int &col;
	CODE:
		IupTextConvertPosToLinCol(ih,pos,&lin,&col);

#### Original C function from <iup.h>
# int IupConvertXYToPos(Ihandle* ih, int x, int y);
int
_IupConvertXYToPos(ih,x,y)
		Ihandle* ih = myST2IHN(0);
		int x;
		int y;
	CODE:
		RETVAL = IupConvertXYToPos(ih,x,y);
	OUTPUT:
		RETVAL

#### Original C function from <iup.h>
# int IupTreeSetUserId(Ihandle* ih, int id, void* userid);
int
_IupTreeSetUserId(ih,id,userid)
		Ihandle* ih = myST2IHN(0);
		int id;
		void* userid;
	CODE:
		RETVAL = IupTreeSetUserId(ih,id,userid);
	OUTPUT:
		RETVAL

#### Original C function from <iup.h>
# void* IupTreeGetUserId(Ihandle* ih, int id);
void*
_IupTreeGetUserId(ih,id)
		Ihandle* ih = myST2IHN(0);
		int id;
	CODE:
		RETVAL = IupTreeGetUserId(ih,id);
	OUTPUT:
		RETVAL

#### Original C function from <iup.h>
# int IupTreeGetId(Ihandle* ih, void *userid);
int
_IupTreeGetId(ih,userid)
		Ihandle* ih = myST2IHN(0);
		void* userid;
	CODE:
		RETVAL = IupTreeGetId(ih,userid);
	OUTPUT:
		RETVAL

#### Original C function from <iup.h>
# void IupTreeSetAttribute (Ihandle* ih, const char* name, int id, const char* value);
void
_IupTreeSetAttribute(ih,name,id,value)
		Ihandle* ih = myST2IHN(0);
		const char* name;
		int id;
		const char* value;
	CODE:
		IupTreeSetAttribute(ih,name,id,value);

#### Original C function from <iup.h>
# void IupTreeStoreAttribute(Ihandle* ih, const char* name, int id, const char* value);
void
_IupTreeStoreAttribute(ih,name,id,value)
		Ihandle* ih = myST2IHN(0);
		const char* name;
		int id;
		const char* value;
	CODE:
		IupTreeStoreAttribute(ih,name,id,value);

#### Original C function from <iup.h>
# char* IupTreeGetAttribute (Ihandle* ih, const char* name, int id);
char*
_IupTreeGetAttribute(ih,name,id)
		Ihandle* ih = myST2IHN(0);
		const char* name;
		int id;
	CODE:
		RETVAL = IupTreeGetAttribute(ih,name,id);
	OUTPUT:
		RETVAL

#### Original C function from <iup.h>
# int IupTreeGetInt (Ihandle* ih, const char* name, int id);
int
_IupTreeGetInt(ih,name,id)
		Ihandle* ih = myST2IHN(0);
		const char* name;
		int id;
	CODE:
		RETVAL = IupTreeGetInt(ih,name,id);
	OUTPUT:
		RETVAL

#### Original C function from <iup.h>
# float IupTreeGetFloat (Ihandle* ih, const char* name, int id);
float
_IupTreeGetFloat(ih,name,id)
		Ihandle* ih = myST2IHN(0);
		const char* name;
		int id;
	CODE:
		RETVAL = IupTreeGetFloat(ih,name,id);
	OUTPUT:
		RETVAL

#### Original C function from <iup.h>
# void IupTreeSetfAttribute (Ihandle* ih, const char* name, int id, const char* format, ...);
void
_IupTreeSetfAttribute(ih,name,id,format,...)
		Ihandle* ih = myST2IHN(0);
		const char* name;
		int id;
		const char* format;
	CODE:
		IupTreeSetfAttribute(ih,name,id,format);

#### Original C function from <iup.h>
# void IupTreeSetAttributeHandle(Ihandle* ih, const char* a, int id, Ihandle* ih_named);
void
_IupTreeSetAttributeHandle(ih,a,id,ih_named)
		Ihandle* ih = myST2IHN(0);
		const char* a;
		int id;
		Ihandle* ih_named = myST2IHN(3);
	CODE:
		IupTreeSetAttributeHandle(ih,a,id,ih_named);

#### Original C function from <iup.h>
# Ihandle* IupFileDlg(void);
Ihandle*
_IupFileDlg()
	CODE:
		RETVAL = IupFileDlg();
	OUTPUT:
		RETVAL

#### Original C function from <iup.h>
# Ihandle* IupMessageDlg(void);
Ihandle*
_IupMessageDlg()
	CODE:
		RETVAL = IupMessageDlg();
	OUTPUT:
		RETVAL

#### Original C function from <iup.h>
# Ihandle* IupColorDlg(void);
Ihandle*
_IupColorDlg()
	CODE:
		RETVAL = IupColorDlg();
	OUTPUT:
		RETVAL

#### Original C function from <iup.h>
# Ihandle* IupFontDlg(void);
Ihandle*
_IupFontDlg()
	CODE:
		RETVAL = IupFontDlg();
	OUTPUT:
		RETVAL

#### Original C function from <iup.h>
# int IupGetFile(char *arq);
int
_IupGetFile(arq)
		char* arq;
	INIT:
		int rv;
		char tmp[MAXPATHLEN];		
		/* somehow handle the situation when arq is longer then MAXPATHLEN-1 */		
		tmp[MAXPATHLEN-1] = 0;
		strncpy(tmp,arq,MAXPATHLEN-1);
	PPCODE:
		rv = IupGetFile(tmp);
		warn("rv=%d a=%s", rv, tmp);
		/* gonna return array: (retval, filename) */
		XPUSHs(sv_2mortal(newSViv(rv)));
		if (rv == -1)
		  XPUSHs(sv_2mortal(newSVpv(NULL,0))); /* undef */
		else
		  XPUSHs(sv_2mortal(newSVpv(tmp,0)));

#### Original C function from <iup.h>
# void IupMessage(const char *title, const char *msg);
void
_IupMessage(title,msg)
		const char* title = myST2STR(0);
		const char* msg = myST2STR(1);
	CODE:
		IupMessage(title,msg);

#### Original C function from <iup.h>
# void IupMessagef(const char *title, const char *format, ...);
void
_IupMessagef(title,format,...)
		const char* title = myST2STR(0);
		const char* format = myST2STR(1);
	CODE:
		IupMessagef(title,format);

#### Original C function from <iup.h>
# int IupAlarm(const char *title, const char *msg, const char *b1, const char *b2, const char *b3);
int
_IupAlarm(title,msg,b1,b2,b3)
		const char* title = myST2STR(0);
		const char* msg = myST2STR(1);
		const char* b1 = myST2STR(2);
		const char* b2 = myST2STR(3);
		const char* b3 = myST2STR(4);
	CODE:
		RETVAL = IupAlarm(title,msg,b1,b2,b3);
	OUTPUT:
		RETVAL

#### Original C function from <iup.h>
# int IupScanf(const char *format, ...);
int
_IupScanf(format,...)
		const char* format;
	CODE:
		RETVAL = IupScanf(format);
	OUTPUT:
		RETVAL

#### Original C function from <iup.h>
# int IupGetText(const char* title, char* text);
int
_IupGetText(title,text)
		char* title = myST2STR(0);
		char* text = myST2STR(1); /* xxx asi reference */
	CODE:
		RETVAL = IupGetText(title,text);
	OUTPUT:
		RETVAL

#### Original C function from <iup.h>
# int IupGetColor(int x, int y, unsigned char* r, unsigned char* g, unsigned char* b);
int
_IupGetColor(x,y,r,g,b)
		int x;
		int y;
		unsigned char r;
		unsigned char g;
		unsigned char b;
	INIT:
		int rv;
		unsigned char newr = r;
		unsigned char newg = g;
		unsigned char newb = b;
	PPCODE:
		rv = IupGetColor(x,y,&newr,&newg,&newb);
		/* gonna return array: (retval, newr, newg, newb) */
		XPUSHs(sv_2mortal(newSViv(rv)));
		XPUSHs(sv_2mortal(newSViv(newr)));
		XPUSHs(sv_2mortal(newSViv(newg)));
		XPUSHs(sv_2mortal(newSViv(newb)));

#### Original C function from <iup.h>
# int IupGetParam(const char* title, Iparamcb action, void* user_data, const char* format,...);
int
_IupGetParam(title,action,action_data,format,...)
		char* title = myST2STR(0);
		SV* action;
		SV* action_data;
		char* format = myST2STR(3);
	INIT:
		getparam_data gp;
		void* gp_user_data = (void*)&gp;
		int rv, i, size, line_size = 0;
		int param_extra, param_count; 		
		void* param_data[50]; /* xxx why 50? */
		char param_type[50];
		const char* f = format;
		const char* s;
		int varparam = 4; /* position in variable param list */
		
		param_count = iupGetParamCount(format, &param_extra);
		memset(param_data, 0, sizeof(void*)*50);
		memset(param_type, 0, sizeof(char)*50);
		
		/* warn param count mismatch; however no warning if absolutely no defaults given */
		if(param_count != items-4 && items > 4 && param_count > 0) warn("Warning: GetParam() param count mismatch (got %d, expected %d)",items-4,param_count);		  
		
		for (i = 0; i < param_count; i++) {
		  char t = iupGetParamType(f, &line_size);
		  if (t == 't') { /* if separator */
		    f += line_size;
		    i--; /* compensate next increment */
		    continue;
		  }
		  
		  switch(t) {
		    case 'b':
		    case 'i':
		    case 'l':
		      param_data[i] = malloc(sizeof(int));
		      if (varparam > items-1) {
		        // xxx warn("FATAL.i!!! cur=%d items=%d", varparam, items);
			*(int*)(param_data[i]) = 0;
		      }
		      else *(int*)(param_data[i]) = SvIV(ST(varparam));
		      varparam++;
		      break;
		    case 'a':
		    case 'r':
		      param_data[i] = malloc(sizeof(float));
		      if (varparam > items-1) {
		        // xxx warn("FATAL.f!!! cur=%d items=%d", varparam, items);
			*(float*)(param_data[i]) = 0.0;
		      }
		      else *(float*)(param_data[i]) = SvNV(ST(varparam));
		      varparam++;
		      break;
		    case 'f':
		    case 'c':
		    case 's':
		    case 'm':
		      if (varparam > items-1) {
		        // xxx warn("FATAL.s!!! cur=%d items=%d", varparam, items);
		        s = "";
		      }
		      else s = SvPV_nolen(ST(varparam));
		      varparam++;
		      size = strlen(s);
		      if (size < 512) /* xxx not nice */
		        param_data[i] = malloc(512);
		      else
		        param_data[i] = malloc(2*size);
		      memcpy(param_data[i], s, size+1);
		      break;
		  }

		  param_type[i] = t;
		  f += line_size;
		}
		
	PPCODE:
		gp.has_func = 0;
		if (SvOK(action)) {
		  gp.has_func = 1;
		  gp.obj_initialized = 0;
		  gp.func_ref = action;
		  gp.obj_ref = action_data;
		}
		
		rv = IupGetParamv(title, cb_param_action, gp_user_data, format, param_count, param_extra, param_data);

		/* gonna return array: (retval, newval1, newval2, ...) */
		XPUSHs(sv_2mortal(newSViv(rv)));
		for (i = 0; i < param_count; i++) {
		  switch(param_type[i]) {
		    case 'b':
		    case 'i':
		    case 'l':
		      XPUSHs(sv_2mortal(newSViv( *(int*)(param_data[i]) )));
		      break;
		    case 'a':
		    case 'r':
		      XPUSHs(sv_2mortal(newSVnv( *(float*)(param_data[i]) )));
		      break;
		    case 'f':
		    case 'c':
		    case 's':
		    case 'm':
		      XPUSHs(sv_2mortal(newSVpv( param_data[i], 0 )));
		      break;
		  }
		}
		for (i = 0; i < param_count; i++) free(param_data[i]);

#### Original C function from <iup.h>
# int IupListDialog(int type, const char *title, int size, const char** list, int op, int max_col, int max_lin, int* marks);
int
_IupListDialog(type,title,list,op,max_col,max_lin,marks)
		int type;
		char *title = myST2STR(1);
		SV* list;
		int op;
		int max_col;
		int max_lin;
		SV* marks;
	INIT:
		int i, rv;
		int items1 = -1, items2 = -1, items = -1;
		const char** i_list = NULL;		  
		int* i_marks = NULL;
		STRLEN l;
	PPCODE:
		if ((!SvROK(list)) || (SvTYPE(SvRV(list)) != SVt_PVAV) || ((items1 = av_len((AV *)SvRV(list))) < 0)) {
		  warn("Warning: invalid 'list' argument of ListDialog()");
		  XSRETURN_UNDEF;
		}

		if (SvOK(marks) && ((!SvROK(marks)) || (SvTYPE(SvRV(marks)) != SVt_PVAV) || ((items2 = av_len((AV *)SvRV(marks))) < 0))) {
		  warn("Warning: invalid 'marks' argument of ListDialog()");
		  XSRETURN_UNDEF;
		}
		
		items = items1+1;
		i_marks = malloc( (items) * sizeof(int) );
		i_list = malloc( (items) * sizeof(void*) );		  
		
		/* create i_marks array */
		if (items2 >= 0) {
		  if (items1 != items2)
		    warn("Warning: 'list' and 'marks' arrays have different size(%d vs. %d) in ListDialog()",items1+1, items2+1);
		  if (items2 > items1)
		    items2 = items1;
		  for(i=0; i<=items2; i++) i_marks[i]= SvIV(*av_fetch((AV *)SvRV(marks), i, 0));
		  for(   ; i<=items1; i++) i_marks[i]= 0;
		}

		/* create i_list array */
		for(i=0; i<items; i++) i_list[i] = SvPV(*av_fetch((AV *)SvRV(list), i, 0), l);
		
		/* call IUP function */
		rv = IupListDialog(type,title,items,i_list,op,max_col,max_lin,i_marks);
		
		/* arrange return values */
		for(i=0; i<items; i++) av_store((AV*)SvRV(marks), i, newSViv(i_marks[i]));
		XPUSHs(sv_2mortal(newSViv(rv)));
		if(GIMME_V == G_ARRAY)
		  for(i=0; i<items; i++)
		    if(i_marks[i])
		      XPUSHs(sv_2mortal(newSVpv(i_list[i],0)));
		if (i_list != NULL) free(i_list);
		if (i_marks != NULL) free(i_marks);

#### Original C function from <iup.h>
# int IupGetAllNames(char** names, int max_n);
int
_IupGetAllNames(max_n)
		int max_n = myST2INT(0);
	INIT:
		int i, rv, count;
		int items = -1;
		char** list = NULL;		  
	PPCODE:
		count = IupGetAllNames(NULL,0);
		if (max_n > 0) count = max_n;
		list = malloc( count * sizeof(void*) );
		rv = IupGetAllNames(list,count);
		if(GIMME_V == G_ARRAY) {
		  for(i=0; i<count; i++) XPUSHs(sv_2mortal(newSVpv(list[i],0)));
		}
		else {
		  XPUSHs(sv_2mortal(newSViv(rv)));
		}
		if (list != NULL) free(list);

#### Original C function from <iup.h>
# int IupGetAllDialogs(char** names, int max_n);
int
_IupGetAllDialogs(max_n)
		int max_n = myST2INT(0);
	INIT:
		int i, rv, count;
		char** list = NULL;		  
	PPCODE:
		count = IupGetAllDialogs(NULL,0);
		if (max_n > 0) count = max_n;
		list = malloc( count * sizeof(void*) );
		rv = IupGetAllDialogs(list,count);
		if(GIMME_V == G_ARRAY) {
		  for(i=0; i<count; i++) XPUSHs(sv_2mortal(newSVpv(list[i],0)));
		}
		else {
		  XPUSHs(sv_2mortal(newSViv(rv)));
		}
		if (list != NULL) free(list);

#### Original C function from <iup.h>
# int IupGetClassAttributes(const char* classname, char** names, int max_n);
int
_IupGetClassAttributes(classname,max_n)
		const char* classname = myST2STR(0);
		int max_n = myST2INT(1);
	INIT:
		int i, rv, count;
		char** list = NULL;		  
	PPCODE:
		count = IupGetClassAttributes(classname,NULL,0);
		if (max_n > 0) count = max_n;
		list = malloc( count * sizeof(void*) );
		rv = IupGetClassAttributes(classname,list,count);
		if(GIMME_V == G_ARRAY) {
		  for(i=0; i<count; i++) XPUSHs(sv_2mortal(newSVpv(list[i],0)));
		}
		else {
		  XPUSHs(sv_2mortal(newSViv(rv)));
		}
		if (list != NULL) free(list);

#### Original C function from <iup.h>
# int IupGetAllAttributes(Ihandle* ih, char** names, int max_n);
int
_IupGetAllAttributes(ih,max_n)
		Ihandle* ih = myST2IHN(0);
		int max_n = myST2INT(1);
	INIT:
		int i, rv, count;
		char** list = NULL;		  
	PPCODE:
		count = IupGetAllAttributes(ih,NULL,0);
		if (max_n > 0) count = max_n;
		list = malloc( count * sizeof(void*) );
		rv = IupGetAllAttributes(ih,list,count);
		if(GIMME_V == G_ARRAY) {
		  for(i=0; i<count; i++) XPUSHs(sv_2mortal(newSVpv(list[i],0)));
		}
		else {
		  XPUSHs(sv_2mortal(newSViv(rv)));
		}
		if (list != NULL) free(list);

################################################################################ iupcontrols.h

#### Original C function from <iupcontrols.h>
# Ihandle* IupColorBrowser(void);
Ihandle*
_IupColorBrowser()
	CODE:
		RETVAL = IupColorBrowser();
	OUTPUT:
		RETVAL

#### Original C function from <iupcontrols.h>
# Ihandle* IupDial(const char* type);
Ihandle*
_IupDial(type)
		char* type = myST2STR(0);
	CODE:
		RETVAL = IupDial(type);
	OUTPUT:
		RETVAL

#### Original C function from <iupcontrols.h>
# int IupControlsOpen(void);
int
_IupControlsOpen()
	CODE:
		RETVAL = IupControlsOpen();
	OUTPUT:
		RETVAL

#### Original C function from <iupcontrols.h>
# void IupControlsClose(void); 
void
_IupControlsClose()
	CODE:
		IupControlsClose();

#### Original C function from <iupcontrols.h>
# Ihandle* IupColorbar(void);
Ihandle*
_IupColorbar()
	CODE:
		RETVAL = IupColorbar();
	OUTPUT:
		RETVAL

#### Original C function from <iupcontrols.h>
# Ihandle* IupCells(void);
Ihandle*
_IupCells()
	CODE:
		RETVAL = IupCells();
	OUTPUT:
		RETVAL

#### Original C function from <iupcontrols.h>
# Ihandle* IupMatrix(const char *action);
Ihandle*
_IupMatrix(action)
		char* action = myST2STR(0);
	CODE:
		RETVAL = IupMatrix(action);
	OUTPUT:
		RETVAL

#### Original C function from <iupcontrols.h>
# void IupMatSetAttribute (Ihandle* ih, const char* name, int lin, int col, char* value);
void
_IupMatSetAttribute(ih,name,lin,col,value)
		Ihandle* ih = myST2IHN(0);
		const char* name;
		int lin;
		int col;
		char* value;
	CODE:
		IupMatSetAttribute(ih,name,lin,col,value);

#### Original C function from <iupcontrols.h>
# void IupMatStoreAttribute(Ihandle* ih, const char* name, int lin, int col, char* value);
void
_IupMatStoreAttribute(ih,name,lin,col,value)
		Ihandle* ih = myST2IHN(0);
		const char* name;
		int lin;
		int col;
		char* value;
	CODE:
		IupMatStoreAttribute(ih,name,lin,col,value);

#### Original C function from <iupcontrols.h>
# char* IupMatGetAttribute (Ihandle* ih, const char* name, int lin, int col);
char*
_IupMatGetAttribute(ih,name,lin,col)
		Ihandle* ih = myST2IHN(0);
		const char* name;
		int lin;
		int col;
	CODE:
		RETVAL = (char*)IupMatGetAttribute(ih,name,lin,col);
	OUTPUT:
		RETVAL

#### Original C function from <iupcontrols.h>
# int IupMatGetInt (Ihandle* ih, const char* name, int lin, int col);
int
_IupMatGetInt(ih,name,lin,col)
		Ihandle* ih = myST2IHN(0);
		const char* name;
		int lin;
		int col;
	CODE:
		RETVAL = IupMatGetInt(ih,name,lin,col);
	OUTPUT:
		RETVAL

#### Original C function from <iupcontrols.h>
# float IupMatGetFloat (Ihandle* ih, const char* name, int lin, int col);
float
_IupMatGetFloat(ih,name,lin,col)
		Ihandle* ih = myST2IHN(0);
		const char* name;
		int lin;
		int col;
	CODE:
		RETVAL = IupMatGetFloat(ih,name,lin,col);
	OUTPUT:
		RETVAL

#### Original C function from <iupcontrols.h>
# void IupMatSetfAttribute (Ihandle* ih, const char* name, int lin, int col, char* format, ...);
void
_IupMatSetfAttribute(ih,name,lin,col,format,...)
		Ihandle* ih = myST2IHN(0);
		const char* name;
		int lin;
		int col;
		char* format;
	CODE:
		IupMatSetfAttribute(ih,name,lin,col,format);

################################################################################ iup_pplot.h

#### Original C function from <iup_pplot.h>
# void IupPPlotOpen(void);
void
_IupPPlotOpen()
	CODE:
		IupPPlotOpen();

#### Original C function from <iup_pplot.h>
# Ihandle* IupPPlot(void);
Ihandle*
_IupPPlot()
	CODE:
		RETVAL = IupPPlot();
	OUTPUT:
		RETVAL

#### Original C function from <iup_pplot.h>
# void IupPPlotBegin(Ihandle *ih, int strXdata);

#### Original C function from <iup_pplot.h>
# void IupPPlotAdd(Ihandle *ih, float x, float y);

#### Original C function from <iup_pplot.h>
# void IupPPlotAddStr(Ihandle *ih, const char* x, float y);

#### Original C function from <iup_pplot.h>
# int IupPPlotEnd(Ihandle *ih);

#### Original C function from <iup_pplot.h>
# void IupPPlotInsertStr(Ihandle *ih, int index, int sample_index, const char* x, float y);

#### Original C function from <iup_pplot.h>
# void IupPPlotInsert(Ihandle *ih, int index, int sample_index, float x, float y);

#### Original C function from <iup_pplot.h>
# void IupPPlotTransform(Ihandle* ih, float x, float y, int *ix, int *iy);

#### Original C function from <iup_pplot.h>
#void IupPPlotPaintTo(Ihandle *ih, void *cnv);

################################################################################ iupgl.h

#### Original C function from <iupgl.h>
# Ihandle *IupGLCanvas(const char *action);
Ihandle*
_IupGLCanvas(type)
		char* type = myST2STR(0);
	CODE:
		RETVAL = IupGLCanvas(type);
	OUTPUT:
		RETVAL

#### Original C function from <iupgl.h>
# void IupGLCanvasOpen(void);

#### Original C function from <iupgl.h>
# void IupGLMakeCurrent(Ihandle* ih);

#### Original C function from <iupgl.h>
# int IupGLIsCurrent(Ihandle* ih);

#### Original C function from <iupgl.h>
# void IupGLSwapBuffers(Ihandle* ih);

#### Original C function from <iupgl.h>
# void IupGLPalette(Ihandle* ih, int index, float r, float g, float b);

#### Original C function from <iupgl.h>
# void IupGLUseFont(Ihandle* ih, int first, int count, int list_base);

#### Original C function from <iupgl.h>
# void IupGLWait(int gl);
