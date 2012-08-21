HA$PBExportHeader$w_base.srw
$PBExportComments$Base window class
forward
global type w_base from window
end type
end forward

global type w_base from window
integer x = 1056
integer y = 484
integer width = 2569
integer height = 1516
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
event type integer ue_postopen ( )
end type
global w_base w_base

type variables

end variables

forward prototypes
public function integer of_getframe (ref window aw_frame)
public function integer of_setstatusbar (boolean ab_switch)
end prototypes

public function integer of_getframe (ref window aw_frame);/*
FUNCTION:	of_getframe(ref window aw_frame) returns int

				Using Current Window Parent reference, loops and finds 
				the MDI Frame Window, which is returned in the aw_frame argument.  
				Return value is 1 for valid ref, -1 for no valid ref.  
*/

integer li_rc

aw_frame = This.ParentWindow()

//	Using Current Window Parent reference (i.e. ParentWindow() ), loop 
//	and find the MDI Frame Window
DO WHILE IsValid(aw_frame)
	IF aw_frame.windowtype <> MDI! AND& 
		aw_frame.windowtype <> MDIHelp! THEN
		aw_frame = aw_frame.ParentWindow( )
	ELSE
		EXIT
	END IF
LOOP

// Verify a valid reference was found
If IsValid(aw_frame) THEN
	li_rc = 1
ELSE
	li_rc = -1
END IF

Return li_rc
end function

public function integer of_setstatusbar (boolean ab_switch);////////////////////////////////////////////////////////////////////////////////
////
////	Function:  		of_SetStatusBar
////
////	Access:  		public
////
////	Arguments:		
////	ab_switch		True - start (create) the service,
////						False - stop (destroy) the service
////
////	Returns:  		Integer
////	 1 - Successful operation.
////	 0 - No action taken.
////	-1 - An error was encountered.
////
////	Description:
////	Starts or stops the Statusbar service
////
////////////////////////////////////////////////////////////////////////////////
////
////	Revision History
////
////	Version
////	5.0   Initial version
////	5.0.02   Disable service for non-Windows platforms
////	5.0.03	Only let service work on MDI w/microhelp window types
////
////////////////////////////////////////////////////////////////////////////////
////
////	Copyright $$HEX2$$a9002000$$ENDHEX$$1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
////	Any distribution of the PowerBuilder Foundation Classes (PFC)
////	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
////
////////////////////////////////////////////////////////////////////////////////
//
//environment	lenv_obj
//
//// Check arguments
//If IsNull(ab_switch) Then 
//	Return -1
//End If
//
//If this.windowtype <> mdihelp! Then
//	Return -1
//End If 
//
//// Check current platform to determine if statusbar service is supported
//GetEnvironment (lenv_obj)
//if IsValid (lenv_obj) then
//	if lenv_obj.ostype <> windows! and lenv_obj.ostype <> windowsnt! then
//		return -1
//	end if
//end if
//
//if ab_switch then
//	if IsNull(inv_statusbar) Or not IsValid (inv_statusbar) then
//		inv_statusbar = create n_cst_winsrv_statusbartpp
//		inv_statusbar.of_SetRequestor (this)
//		Return 1
//	end if
//else
//	if IsValid (inv_statusbar) then
//		destroy inv_statusbar
//		Return 1
//	end if
//end if

Return 0
end function

on w_base.create
end on

on w_base.destroy
end on

event open;This.EVENT POST ue_postopen()
end event

