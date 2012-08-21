HA$PBExportHeader$uo_comctl_progressbar.sru
$PBExportComments$COMCTL32 - Microsoft Common Control - ProgressBar32
forward
global type uo_comctl_progressbar from UserObject
end type
end forward

global type uo_comctl_progressbar from UserObject
UserObjects ObjectType=ExternalVisual!
int Width=256
int Height=152
long BackColor=0
string ClassName="msctls_progress32"
string LibraryName="comctl32.dll"
long Style=1174405120
end type
global uo_comctl_progressbar uo_comctl_progressbar

type variables
// Progress Meter Message Constants
Constant Private Long WM_USER		= 1024
Constant Private Long PBM_SETRANGE	= (WM_USER+1)
Constant Private Long PBM_SETPOS		= (WM_USER+2)
Constant Private Long PBM_DELTAPOS	= (WM_USER+3)
Constant Private Long PBM_SETSTEP		= (WM_USER+4)
Constant Private Long PBM_STEPIT		= (WM_USER+5)
Constant Private Long PBM_GETRANGE	= (WM_USER+7)
Constant Private Long PBM_GETPOS		= (WM_USER+8)

end variables

forward prototypes
public function long of_stepit ()
public function long of_setstep (readonly long alstep)
public function long of_setrange (readonly integer ailow, readonly integer aihigh)
public function long of_setpos (readonly long alpos)
public function long of_deltapos (readonly long alIncrement)
public function long of_getpos ()
public subroutine of_getrange (ref int aiLow, ref int aiHigh)
end prototypes

public function long of_stepit ();//===================================================================
// Function:	uo_ProgressBar::of_StepIt()
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

RETURN Send( Handle(This), PBM_STEPIT, 0, 0 )

end function

public function long of_setstep (readonly long alstep);//===================================================================
// Function:	uo_ProgressBar::of_SetStep()
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

RETURN Send( Handle(This), PBM_SETSTEP, alStep, 0 )

end function

public function long of_setrange (readonly integer ailow, readonly integer aihigh);//===================================================================
// Function:	uo_ProgressBar::of_SetRange()
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

RETURN Send( Handle(This), PBM_SETRANGE, 0, Long(aiLow, aiHigh) )

end function

public function long of_setpos (readonly long alpos);//===================================================================
// Function:	uo_ProgressBar::of_SetPos()
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

RETURN Send( Handle(This), PBM_SETPOS, alPos, 0 )

end function

public function long of_deltapos (readonly long alIncrement);//===================================================================
// Function:	uo_ProgressBar::of_DeltaPos()
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

RETURN Send( Handle(This), PBM_DELTAPOS, alIncrement, 0 )

end function

public function long of_getpos ();//===================================================================
// Function:	uo_comctl_progressbar::of_GetPos()
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

RETURN Send( Handle(This), PBM_GETPOS, 0, 0 )

end function

public subroutine of_getrange (ref int aiLow, ref int aiHigh);//===================================================================
// Function:	uo_comctl_progressbar::of_GetRange()
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

// Note: Use C-Style boolean. Non-Zero = TRUE, Zero = FALSE
aiLow = Send( Handle(This), PBM_GETRANGE, 1, 0 )
aiHigh = Send( Handle(This), PBM_GETRANGE, 0, 0 )

RETURN

end subroutine

