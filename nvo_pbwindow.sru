HA$PBExportHeader$nvo_pbwindow.sru
$PBExportComments$NVO to encapsulate window functions
forward
global type nvo_pbwindow from nonvisualobject
end type
end forward

global type nvo_pbwindow from nonvisualobject autoinstantiate
end type

type prototypes
// Win32 API 
function long FindWindowA( String lpClassName, String lpWindowName ) Library "user32" alias for "FindWindowA;Ansi"
function long FindWindowExA( long hParent, long hChildAfter, String lpszClass, String lpszWindow ) Library "user32" alias for "FindWindowExA;Ansi"

end prototypes

type variables
// Private constants
Constant Private ulong GW_CHILD		= 5
Constant Private ulong GW_HWNDNEXT	= 2

Constant Private String PB6_StatusClass= "FNHELP60"
Constant Private String PB5_StatusClass= "FNHELP050"
end variables

forward prototypes
public function long of_getstatusbar (readonly window awframe)
end prototypes

public function long of_getstatusbar (readonly window awframe);//====================================================================
// Function - of_getstatusbar for nvo_pbwindow
//--------------------------------------------------------------------
// Description:Returns the handle of the STANDARD PB statusbar on the 
//					give MDI frame window.
//--------------------------------------------------------------------
// Arguments:	
//
//	window awframe
//		Frame window. Must have a windowtype of MDIHelp!
//--------------------------------------------------------------------
// Returns:	(LONG) - Handle of statusbar on MDI Frame window.
//				Returns ZERO if the window is invalid, or has no statusbar
//--------------------------------------------------------------------
// Author:	RCSIZER		Date: May, 1999
//====================================================================
long			llNULL, llhStatusBar
string		lsClassName, lsWindowName
Environment	lEnv

// Check the argument is a valid window, and get current environment settings
IF IsValid( awFrame ) AND (GetEnvironment(lEnv) = 1) THEN

	// Check that this an MDI frame window with a standard statusbar
	IF (awFrame.WindowType = MDIHelp!) THEN

		// Set classname of statusbar based on PB version
		CHOOSE CASE lEnv.PBMajorRevision
			CASE 5
				lsClassName = PB5_StatusClass
			CASE 6
				lsClassName = PB6_StatusClass
			// Add code here for PB4 and PB7
			Case Else
				lsClassName = PB6_StatusClass
		END CHOOSE

		// Get handle to statusbar
		SetNull(lsWindowName)
		SetNull(llNULL)
		llhStatusBar = FindWindowEXA( Handle(awFrame), llNULL, lsClassName, lsWindowName )
	END IF
END IF

RETURN llhStatusBar

end function

on nvo_pbwindow.create
call super::create
TriggerEvent( this, "constructor" )
end on

on nvo_pbwindow.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

