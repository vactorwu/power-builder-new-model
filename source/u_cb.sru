HA$PBExportHeader$u_cb.sru
$PBExportComments$Base commandbutton class
forward
global type u_cb from commandbutton
end type
end forward

global type u_cb from commandbutton
integer width = 247
integer height = 108
integer taborder = 10
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "none"
end type
global u_cb u_cb

forward prototypes
public function window of_parent ()
end prototypes

public function window of_parent ();/*
FUNCTION:	of_parent() returns window

				Obtains the parent window for a command button.  

				See u_cb_cancel for how this is useful: 
				Close(of_parent()) always returns a reference to 
				the window containing the cb, even if the 
				commandbutton is on another object, like a tabpage.
*/


graphicobject 	lgo_temp
window			lw_window

lgo_temp = Parent

// Loop and find Window which this commandbutton is on 

DO WHILE TypeOf(lgo_temp) <> Window!
	lgo_temp = lgo_temp.GetParent( )
LOOP

//	Assign graphic object variable to window reference variable
lw_window = lgo_temp

RETURN lw_window

end function

