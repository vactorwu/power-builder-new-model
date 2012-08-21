HA$PBExportHeader$uo_lb_sortby.sru
$PBExportComments$Listbox on StatusBar
forward
global type uo_lb_sortby from dropdownlistbox
end type
end forward

global type uo_lb_sortby from dropdownlistbox
int Width=352
int Height=360
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
long TextColor=33554432
int TextSize=-6
int Weight=400
string FaceName="MS Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Roman!
FontPitch FontPitch=Variable!
string Item[]={"Ascending",&
"Descending"}
end type
global uo_lb_sortby uo_lb_sortby

event selectionchanged;//====================================================================
// Script - selectionchanged for uo_lb_sortby
//--------------------------------------------------------------------
// Description:Simple messagebox to demonstrate that the events
//					are fired as usual. Each control will have to be a
//					user object with events coded on the user object.
//					This is because the control is not placed on the 
//					window, the user must use OpenUserObject().
//					Also, this control must be moved and resized at runtime.
//--------------------------------------------------------------------
// Author:	RCSIZER		Date: May, 1999
//====================================================================
MessageBox( This.ClassName(), "Selection Changed" )

RETURN 0

end event

