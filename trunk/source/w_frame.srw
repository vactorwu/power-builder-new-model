HA$PBExportHeader$w_frame.srw
forward
global type w_frame from w_base
end type
type mdi_1 from mdiclient within w_frame
end type
end forward

global type w_frame from w_base
integer width = 3657
integer height = 3016
string menuname = "m_tppsoftini"
windowtype windowtype = mdihelp!
windowstate windowstate = maximized!
string icon = "OleGenReg!"
event ue_mdi_move ( )
event ue_resize ( )
mdi_1 mdi_1
end type
global w_frame w_frame

type prototypes
Function uLong FindWindowExA( uLong hwndParent, uLong hwndChildAfter, Ref String lpszClass, Ref String lpszWindow ) Library "user32.dll" alias for "FindWindowExA;Ansi"
end prototypes

type variables
Integer	ii_SheetNum = 0
integer  ii_fondo = 0
Boolean ib_ShowButtons

end variables

event ue_mdi_move(); integer  wh,      ww

  // Get current MDI workspace
  wh=this.workspaceheight ( )
  ww=this.workspacewidth ( )

  // Set background image
  If ( handle (w_ventana_fondo) > 0 ) then
		wh -=191
		ww -= 17	// Approx Microhelp Height??
		w_ventana_fondo.width = ww - 80 
		w_ventana_fondo.height = wh - 200
		ww = 30 //100
 		wh = 10 //100
		Move(w_ventana_fondo, ww, wh)
  End If
	
  // Be sure focus is on us and not the background image
  SetFocus(this)
end event

event ue_resize();If ii_fondo >= 2  then
If IsValid(w_ventana_fondo) Then
	w_ventana_fondo.p_1.setredraw(false)
	w_ventana_fondo.p_1.height = w_ventana_fondo.height 
	w_ventana_fondo.p_1.width  = w_ventana_fondo.width
	w_ventana_fondo.p_1.setredraw(true)
End IF
Else
	ii_fondo = ii_fondo +1
End If
end event

on w_frame.create
int iCurrent
call super::create
if this.MenuName = "m_tppsoftini" then this.MenuID = create m_tppsoftini
this.mdi_1=create mdi_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.mdi_1
end on

on w_frame.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.mdi_1)
end on

event open;call super::open;
This.title = Gn_Config.Is_Work.Aplicacion



end event

event resize;call super::resize;Postevent("ue_resize")
Triggerevent("ue_mdi_move")
	
    
     
end event

event closequery;call super::closequery;If gb_Entro Then
	IF MessageBox(Gn_Config.Is_Work.Aplicacion+" Cerrar el Sistema", "Esta usted Seguro de cerrar el sistema", Question!, YesNo!) = 2 THEN
			  RETURN 1
	ELSE
				 RETURN 0
	END IF
Else
	Return 0
End If


end event

event ue_postopen;call super::ue_postopen;If gb_Fondo  then
	OpenSheet(w_ventana_fondo,w_frame, 1, Original!)
	//w_ventana_fondo.p_1.setredraw(false)
	Postevent("ue_resize")
	Triggerevent("ue_mdi_move")
	//Triggerevent("ue_mdi_move") Postevent
	//event xp_icons()
End If
OpenSheetWithParm(w_ingresoseguro2, "", w_frame, 2, Original!)

Return 1
end event

type mdi_1 from mdiclient within w_frame
long BackColor=268435456
end type

