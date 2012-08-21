HA$PBExportHeader$nvo_comctl_progressbar.sru
$PBExportComments$NVO Class Wrapper for ProgressBar.
forward
global type nvo_comctl_progressbar from nonvisualobject
end type
end forward

type PBRANGE from structure
	long		Low
	long		High
end type

global type nvo_comctl_progressbar from nonvisualobject
end type
global nvo_comctl_progressbar nvo_comctl_progressbar

type prototypes
// User32 API calls
Function long CreateWindowExA( ulong dwExStyle, string lpClassName, string lpWindowName, ulong dwStyle, long xPos, long yPos, long nWidth, long nHeight, long hWndParent, long hMenu, long hInstance, long lpParam ) Library "user32" alias for "CreateWindowExA;Ansi"
Function boolean MoveWindow( long hWnd, long xPos, long yPos, long nWidth, long nHeight, boolean bRepaint ) Library "user32"
Function boolean DestroyWindow( long hWnd ) Library "user32"
Function boolean IsWindow( long hWnd ) Library "user32"

// ComCtrl API calls
Subroutine InitCommonControls() Library "comctl32.dll"
end prototypes

type variables
// Window Handle to Progress Bar
Private long ilHandle

// Progress Meter Message Constants
Constant Private Long WM_USER		= 1024
Constant Private Long PBM_SETRANGE	= (WM_USER+1)
Constant Private Long PBM_SETPOS		= (WM_USER+2)
Constant Private Long PBM_DELTAPOS	= (WM_USER+3)
Constant Private Long PBM_SETSTEP		= (WM_USER+4)
Constant Private Long PBM_STEPIT		= (WM_USER+5)
Constant Private Long PBM_GETRANGE	= (WM_USER+7)
Constant Private Long PBM_GETPOS		= (WM_USER+8)

// Window Classname
Constant Private String PROGRESS_CLASS	= "msctls_progress32"
// Window ID
Constant Private Long ID_PROGRESS		= 100


// ProgressBar Styles
Constant Public Long PBS_SMOOTH		= 1

Constant Public Long PBS_VERTICAL		= 4


end variables

forward prototypes
public function long of_createprogressbar (readonly long alparent, readonly long alstyle, readonly long alx, readonly long aly, readonly long alwidth, readonly long alheight)
public function boolean of_destroy ()
public function long of_deltapos (readonly long alincrement)
public function long of_setpos (readonly long alpos)
public function long of_setrange (readonly integer ailow, readonly integer aihigh)
public function long of_setstep (readonly long alstep)
public function long of_stepit ()
public function long of_getrange (ref integer ailow, ref integer aihigh)
public function long of_getpos ()
public function boolean of_movewindow (readonly long alx, readonly long aly, readonly long alwidth, readonly long alheight)
public function long of_gethandle ()
end prototypes

public function long of_createprogressbar (readonly long alparent, readonly long alstyle, readonly long alx, readonly long aly, readonly long alwidth, readonly long alheight);//===================================================================
// Function:	nvo_comctl_progressbar::of_CreateProgressBar
//-------------------------------------------------------------------
// Description:Creates a progress bar using the CreateWindowEX API
//					function. This allows the user to explicitly set the
//					parent (for example a statusbar).
//
//	NOTE: All window co-oridinates (X,Y,Width,Height) are in PIXELS !
//			Use the UnitsToPixels() function to convert PB units to
//			pixels BEFORE calling this function.
//-------------------------------------------------------------------
// Parameters:
//
//	alParent
//		Handle to parent or owner window
//	alStyle
//		ProgressBar styles. See the PBS_xxx constants
//	alX
//		X Position relative to the parent window
//	alY
//		Y Position relative to the parent window
//	alWidth
//		Width of progress bar
//	alHeight
//		Height of progress bar
//-------------------------------------------------------------------
// Returns:	Returns the window handle if successful.
//				Returns 0 if progress bar was not created.
//-------------------------------------------------------------------
// Author: RCSizer - May 1999
//===================================================================

// Window Style constants
Constant long WS_CHILD		= 1073741824
Constant long WS_VISIBLE	= 268435456

long	llHandle

// Initialise Common Controls
InitCommonControls()

// Create Progress Bar
llHandle = CreateWindowExA( &
	0,											/* No extended Styles */ &
	PROGRESS_CLASS,						/* Registered Window ClassName */ &
	"", 										/* No Window Name */ &
	WS_CHILD + WS_VISIBLE + alStyle,	/* Window Styles. See PBS_xxx constants */ &
	alX, alY, alWidth, alHeight,		/* Window position */ &
	alParent,								/* Parent window, can be a statusbar or any other control */ &
	ID_PROGRESS,							/* Control ID */ &
	Handle(GetApplication()),			/* Application Handle */ &
	0 											/* Pointer to window-creation data */ )

// Save handle if window is created successfully
IF (llHandle > 0) THEN This.ilHandle = llHandle

// Return result of CreateWindowEX
RETURN llHandle

end function

public function boolean of_destroy ();//===================================================================
// Function:	nvo_comctl_progressbar::of_Destroy
//-------------------------------------------------------------------
// Description:Destroys any previously created statusbar
//-------------------------------------------------------------------
// Parameters: <none>
//-------------------------------------------------------------------
// Returns:	TRUE if window was destroyed, or window was not created.
//				FALSE if window could not be destroyed
//-------------------------------------------------------------------
// Author: RCSizer - May 1999
//===================================================================

boolean	lbDestroy = TRUE

// Destroy window if it was created
IF IsWindow(This.ilHandle) THEN lbDestroy = DestroyWindow( This.ilHandle )

// Reset window handle
This.ilHandle = 0

RETURN lbDestroy

end function

public function long of_deltapos (readonly long alincrement);//===================================================================
// Function:	nvo_comctl_progressbar::of_DeltaPos()
//-------------------------------------------------------------------
// Description:The PBM_DELTAPOS message advances the current position 
//					of a progress bar by a specified increment and redraws
//					the bar to reflect the new position. 
//-------------------------------------------------------------------
// Parameters:	wParam = (WPARAM) nIncrement
//					lParam = 0
//
//	nIncrement 
//		Amount to advance the position. 
//-------------------------------------------------------------------
// Returns:	Returns the previous position. 
//-------------------------------------------------------------------
// $$HEX2$$a9002000$$ENDHEX$$1997 Microsoft Corporation. All rights reserved.
//===================================================================

IF IsWindow(This.ilHandle) THEN
	RETURN Send( This.ilHandle, PBM_DELTAPOS, alIncrement, 0 )
ELSE
	RETURN -1
END IF

end function

public function long of_setpos (readonly long alpos);//===================================================================
// Function:	nvo_comctl_progressbar::of_SetPos()
//-------------------------------------------------------------------
// Description:The PBM_SETPOS message sets the current position for 
//					a progress bar and redraws the bar to reflect the new
//					position. 
//-------------------------------------------------------------------
// Parameters:	wParam = (WPARAM) nNewPos
//					lParam = 0
//
//nNewPos 
//     New position. 
//-------------------------------------------------------------------
// Returns:	Returns the previous position. 
//-------------------------------------------------------------------
// $$HEX2$$a9002000$$ENDHEX$$1997 Microsoft Corporation. All rights reserved.
//===================================================================

IF IsWindow(This.ilHandle) THEN
	RETURN Send( This.ilHandle, PBM_SETPOS, alPos, 0 )
ELSE
	RETURN -1
END IF

end function

public function long of_setrange (readonly integer ailow, readonly integer aihigh);//===================================================================
// Function:	nvo_comctl_progressbar::of_SetRange()
//-------------------------------------------------------------------
// Description:The PBM_SETRANGE message sets the minimum and maximum 
//					values for a progress bar and redraws the bar to
//					reflect the new range. 
//-------------------------------------------------------------------
// Parameters:	wParam = 0
//					lParam = MAKELPARAM(nMinRange, nMaxRange)
//
//	nMinRange  
//		Minimum range value. By default, the minimum value is zero. 
//	nMaxRange 
//		Maximum range value. By default, the maximum value is 100. 
//-------------------------------------------------------------------
// Returns:	Returns the previous range values if successful, or zero 
//				otherwise. The low-order word specifies the previous 
//				minimum value, and the high-order word specifies the 
//				previous maximum value. 
//-------------------------------------------------------------------
// $$HEX2$$a9002000$$ENDHEX$$1997 Microsoft Corporation. All rights reserved.
//===================================================================

IF IsWindow(This.ilHandle) THEN
	RETURN Send( This.ilHandle, PBM_SETRANGE, 0, Long(aiLow, aiHigh) )
ELSE
	RETURN -1
END IF


end function

public function long of_setstep (readonly long alstep);//===================================================================
// Function:	nvo_comctl_progressbar::of_SetStep()
//-------------------------------------------------------------------
// Description:The PBM_SETSTEP message specifies the step increment 
//					for a progress bar. The step increment is the amount 
//					by which the progress bar increases its current 
//					position whenever it receives a PBM_STEPIT message. 
//					By default, the step increment is set to 10. 
//-------------------------------------------------------------------
// Parameters:	wParam = (WPARAM) nStepInc
//					lParam = 0
//
//	nStepInc 
//		New step increment. 
//-------------------------------------------------------------------
// Returns:	Returns the previous step increment. 
//-------------------------------------------------------------------
// $$HEX2$$a9002000$$ENDHEX$$1997 Microsoft Corporation. All rights reserved.
//===================================================================

IF IsWindow(This.ilHandle) THEN
	RETURN Send( This.ilHandle, PBM_SETSTEP, alStep, 0 )
ELSE
	RETURN -1
END IF

end function

public function long of_stepit ();//===================================================================
// Function:	nvo_comctl_progressbar::of_StepIt()
//-------------------------------------------------------------------
// Description:The PBM_STEPIT message advances the current position 
//					for a progress bar by the step increment and redraws 
//					the bar to reflect the new position. An application sets
//					the step increment by sending the PBM_SETSTEP message. 
//
// NOTE:	When the position exceeds the maximum range value, this 
//			message resets the current position so that the progress
//			indicator starts over again from the beginning. 
//-------------------------------------------------------------------
// Parameters:	wParam = 0 
//					lParam = 0
//-------------------------------------------------------------------
// Returns:	Returns the previous position. 
//-------------------------------------------------------------------
// $$HEX2$$a9002000$$ENDHEX$$1997 Microsoft Corporation. All rights reserved.
//===================================================================

IF IsWindow(This.ilHandle) THEN
	RETURN Send( This.ilHandle, PBM_STEPIT, 0, 0 )
ELSE
	RETURN -1
END IF

end function

public function long of_getrange (ref integer ailow, ref integer aihigh);//===================================================================
// Function:	nvo_comctl_progressbar::of_GetRange()
//-------------------------------------------------------------------
// Description:The PBM_GETRANGE message retrieves information about the 
//					current high and low limits of a given progress bar.
//-------------------------------------------------------------------
// Parameters:	wParam = (BOOLEAN)
//					lParam = (PBRANGE)
//
//	wParam
//		Flag value specifying which limit value is to be used as the 
//		message's return value. This parameter can be:
//
//		Value  Meaning
//		TRUE   Return the low limit.
//		FALSE  Return the high limit.
//
// lParam
//		Address of a PBRANGE structure that is to be filled 
//		with the high and low limits of the progress bar control.
//		If this parameter is set to NULL, the control will 
//		return only the limit specified by wParam.
//-------------------------------------------------------------------
// Returns:	Returns an INT that represents the limit value specified 
//				by wParam. If lParam is not NULL, lParam must point to 
//				a PBRANGE structure that is to be filled with both limit 
//				values.
//-------------------------------------------------------------------
// $$HEX2$$a9002000$$ENDHEX$$1997 Microsoft Corporation. All rights reserved.
//===================================================================

IF IsWindow(This.ilHandle) THEN
	// Note: Use C-Style boolean. Non-Zero = TRUE, Zero = FALSE
	aiLow = Send( This.ilHandle, PBM_GETRANGE, 1, 0 )
	aiHigh = Send( This.ilHandle, PBM_GETRANGE, 0, 0 )
	RETURN 1
ELSE
	RETURN -1
END IF

end function

public function long of_getpos ();//===================================================================
// Function:	nvo_comctl_progressbar::of_GetPos()
//-------------------------------------------------------------------
// Description:The PBM_GETPOS message retrieves the current position 
//					of the progress bar
//-------------------------------------------------------------------
// Parameters:	wParam = 0
//					lParam = 0
//-------------------------------------------------------------------
// Returns:	Returns the current position. 
//-------------------------------------------------------------------
// $$HEX2$$a9002000$$ENDHEX$$1997 Microsoft Corporation. All rights reserved.
//===================================================================

IF IsWindow(This.ilHandle) THEN
	RETURN Send( This.ilHandle, PBM_GETPOS, 0, 0 )
ELSE
	RETURN -1
END IF

end function

public function boolean of_movewindow (readonly long alx, readonly long aly, readonly long alwidth, readonly long alheight);//===================================================================
// Function:	nvo_comctl_progressbar::of_MoveWindow
//-------------------------------------------------------------------
// Description:Uses the MoveWindow API function to move and resize
//					the progress control.
//
//	NOTE: All window co-oridinates (X,Y,Width,Height) are in PIXELS !
//			Use the UnitsToPixels() function to convert PB units to
//			pixels BEFORE calling this function.
//-------------------------------------------------------------------
// Parameters:
//
//	alX
//		X Position relative to the parent window
//	alY
//		Y Position relative to the parent window
//	alWidth
//		Width of progress bar
//	alHeight
//		Height of progress bar
//-------------------------------------------------------------------
// Returns:	TRUE = Move successful
//				FALSE = Move failed or invalid window handle
//-------------------------------------------------------------------
// Author: RCSizer - May 1999
//===================================================================

IF IsWindow(This.ilHandle) THEN
	RETURN MoveWindow( This.ilHandle, alX, alY, alWidth, alHeight, TRUE )
ELSE
	RETURN FALSE
END IF

end function

public function long of_gethandle ();IF IsWindow( This.ilHandle ) THEN
	RETURN This.ilHandle
ELSE
	RETURN -1
END IF

end function

on nvo_comctl_progressbar.create
TriggerEvent( this, "constructor" )
end on

on nvo_comctl_progressbar.destroy
TriggerEvent( this, "destructor" )
end on

event destructor;// Destroy window if it has been created
This.of_Destroy()

RETURN 0

end event

