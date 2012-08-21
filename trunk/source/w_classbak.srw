HA$PBExportHeader$w_classbak.srw
$PBExportComments$ventana clase para el mantenimiento de la aplicaci$$HEX1$$f300$$ENDHEX$$n.
forward
global type w_classbak from window
end type
end forward

global type w_classbak from window
integer y = 360
integer width = 2994
integer height = 1844
boolean titlebar = true
string menuname = "m_tppsoftmanto"
boolean controlmenu = true
boolean minbox = true
long backcolor = 79741120
boolean center = true
event ue_new pbm_custom01
event ue_save pbm_custom04
event ue_undo pbm_custom06
event ue_delete pbm_custom03
event ue_tofirst pbm_custom06
event ue_toprior pbm_custom07
event ue_tonext pbm_custom08
event ue_tolast pbm_custom09
event ue_print pbm_custom08
event ue_postopen pbm_custom12
event ue_modify pbm_custom02
event ue_find pbm_custom07
event ue_cancel pbm_custom05
event ue_itemcancel pbm_custom25
end type
global w_classbak w_classbak

type prototypes
Function uLong FindWindowExA( uLong hwndParent, uLong hwndChildAfter, Ref String lpszClass, Ref String lpszWindow ) Library "user32.dll" alias for "FindWindowExA;Ansi"
end prototypes

type variables


n_cst_resize inv_resize
boolean ib_estado ,ib_ShowButtons
String Is_Tabla 
String Is_CampoCod
String Is_CampoId
String Is_Codigo=Space(10)
Int II_LargoCod
Integer &
ii_Cancel ,&
ii_Delete  ,&
ii_Find ,&
ii_Modify ,&
ii_New ,&
ii_Save ,&
ii_Undo ,&
ii_ItemCancel ,&
ii_ItemDelete  ,&
ii_ItemFind ,&
ii_ItemModify ,&
ii_ItemNew ,&
ii_ItemSave ,&
ii_ItemUndo

protected u_dw idw_activa, idw_lista , idw_detalle






end variables

forward prototypes
public subroutine wf_message ()
public function integer wf_flags (string as_estado, string as_dataobject)
public subroutine wf_resize (boolean as_estado)
public subroutine wf_dime_dw (u_dw a_dw)
public function integer wf_centrar ()
public subroutine wf_dime_dwlista (u_dw a_dw)
public subroutine wf_buttons (string estado)
public function boolean wf_valid (u_dw adw_handle)
public subroutine wf_primarykey ()
public function boolean wf_colvalid (string as_colname)
public subroutine wf_datos ()
public subroutine wf_dime_dwdetalle (u_dw a_dw)
end prototypes

event ue_new;ii_New = 0
If idw_activa.event ue_newprevious(1,1) = 1 Then
	If idw_activa.event ue_new(1,1) = 1 Then
		If idw_activa.event ue_newafter(1,1) = 1 Then 
			ii_New = 1
		End If
	End If
End If


end event

event ue_save;ii_Save = 0
If idw_activa.event ue_saveprevious(1,1) = 1 Then
	If idw_activa.event ue_save(1,1) = 1 Then
		If idw_activa.event ue_saveafter(1,1) = 1 Then
			ii_Save = 1
		End If
	End If
End If

//If idw_activa.triggerevent('ue_saveprevious') = 1 Then
//	If idw_activa.triggerevent('ue_save') = 1 Then
//		idw_activa.triggerevent('ue_saveafter')
//	End If
//End If

end event

event ue_undo;ii_Undo = 0
If idw_activa.event ue_undoprevious(1,1) = 1 Then
	If idw_activa.event ue_undo(1,1) = 1 Then
		If idw_activa.event ue_undoafter(1,1)  = 1 Then
			ii_Undo = 1
		End If
	End If
End If

//If idw_activa.triggerevent('ue_undoprevious') = 1 Then
//	If idw_activa.triggerevent('ue_undo') = 1 Then
//		idw_activa.triggerevent('ue_undoafter')
//	End If
//End If

end event

event ue_delete;
//***************************************************************************************************************************************************************************************
// Triggerevent del evento al datawindow.
//***************************************************************************************************************************************************************************************
ii_Delete = 0
If idw_activa.event ue_deleteprevious(1,1) = 1 Then
	If idw_activa.event ue_delete(1,1) = 1 Then
		If idw_activa.event ue_deleteafter(1,1)  = 1 Then
			ii_Delete = 1
		End If
	End If
End If
end event

event ue_tofirst;
//***************************************************************************************************************************************************************************************
// Triggerevent del evento al datawindow.
//***************************************************************************************************************************************************************************************

idw_lista.triggerevent('ue_tofirst')
end event

event ue_toprior;//***************************************************************************************************************************************************************************************
// Triggerevent del evento al datawindow.
//***************************************************************************************************************************************************************************************
idw_lista.triggerevent('ue_toprior')
end event

event ue_tonext;
//***************************************************************************************************************************************************************************************
// Triggerevent del evento al datawindow.
//***************************************************************************************************************************************************************************************
idw_lista.triggerevent('ue_tonext')
end event

event ue_tolast;
//***************************************************************************************************************************************************************************************
// Triggerevent del evento al datawindow.
//***************************************************************************************************************************************************************************************
idw_lista.triggerevent('ue_tolast')
end event

event ue_print;//
end event

event ue_postopen;//
end event

event ue_modify;ii_Modify = 0
If  idw_activa.event ue_modifyprevious(1,1) = 1 Then
	If idw_activa.event ue_modify(1,1) = 1 Then
		If idw_activa.event ue_modifyafter(1,1)  = 1 Then
			ii_Modify =  1
		End If
	End If
End If

//If idw_activa.triggerevent('ue_modifyprevious') = 1 Then
//	If idw_activa.triggerevent('ue_modify') = 1 Then
//		idw_activa.triggerevent('ue_modifyafter')
//	End If
//End If

end event

event ue_find;ii_Find = 0
If idw_activa.event ue_findprevious(1,1) = 1 Then
	If idw_activa.event ue_find(1,1) = 1 Then
		If idw_activa.event ue_findafter(1,1) = 1 Then
			ii_Find = 1
		End If
	End If
End If

//If idw_activa.triggerevent('ue_findprevious') = 1 Then
//	If idw_activa.triggerevent('ue_find') = 1 Then
//		idw_activa.triggerevent('ue_findafter')
//	End If
//End If

end event

event ue_cancel;ii_Cancel = 0
If idw_activa.event ue_cancelprevious(1,1) = 1 Then
	If idw_activa.event ue_cancel(1,1) = 1 Then
		If idw_activa.event ue_cancelafter(1,1)  = 1 Then
			ii_Cancel = 1
		End If
	End If
End If
end event

event ue_itemcancel;ii_ItemCancel = 0
If idw_detalle.event ue_cancelprevious(wparam,lparam) = 1 Then
	If idw_detalle.event ue_cancel(wparam,lparam) = 1 Then
		If idw_detalle.event ue_cancelafter(wparam,lparam)  = 1 Then
			ii_ItemCancel = 1
		End If
	End If
End If
end event

public subroutine wf_message ();
//***************************************************************************************************************************************************************************************
// Incremento el contador de intentos de bloqueo.
//***************************************************************************************************************************************************************************************

idw_activa.il_contador = idw_activa.il_contador + 1

//***************************************************************************************************************************************************************************************
// Abro la ventana de mensajes correspondiente.
//***************************************************************************************************************************************************************************************

openwithparm(w_message,2)

//***************************************************************************************************************************************************************************************
// Desbloqueo el flag de bloqueo logico de la tabla de postulantes.
//***************************************************************************************************************************************************************************************

if idw_activa.il_contador >= 3 then this.wf_flags('Unblock',idw_activa.dataobject)
end subroutine

public function integer wf_flags (string as_estado, string as_dataobject);
//**************************************************************************************************************************************************************************************
// Retorno.
//**************************************************************************************************************************************************************************************

return 1
end function

public subroutine wf_resize (boolean as_estado);
//**************************************************************************************************************************************************************************************
// Creo o destruyo el objeto.
//**************************************************************************************************************************************************************************************

if as_estado then
  inv_resize = create n_cst_resize
  inv_resize.of_setorigsize (this.workspacewidth(), this.workspaceheight())  
  inv_resize.of_setminsize(1500,1500)  
else
  destroy inv_resize
end if
end subroutine

public subroutine wf_dime_dw (u_dw a_dw);idw_activa = a_dw

end subroutine

public function integer wf_centrar ();int li_screenheight, li_screenwidth, li_rc, li_x=1, li_y=1
environment	lenv_obj

If IsNull ( this ) Or Not IsValid ( this ) Then Return -1

If GetEnvironment ( lenv_obj ) = -1 Then Return -1

li_screenheight = PixelsToUnits ( lenv_obj.ScreenHeight, YPixelsToUnits! )
li_screenwidth  = PixelsToUnits ( lenv_obj.ScreenWidth, XPixelsToUnits! )
If Not ( li_screenheight > 0 ) Or Not ( li_screenwidth > 0 ) Then Return -1

If li_screenwidth > this.Width Then
	li_x = ( li_screenwidth/ 2 ) - ( this.Width / 2 )
End If
If li_screenheight > this.Height Then
	li_y = ( (li_screenheight - 400)/ 2 ) - ( this.Height / 2 )
End If

li_rc = this.Move ( li_x, li_y )

If li_rc <> 1 Then Return -1

Return 1
end function

public subroutine wf_dime_dwlista (u_dw a_dw);idw_lista=a_dw
end subroutine

public subroutine wf_buttons (string estado);//**************************************************************************************************************************************************************************************
// Cambio las propiedades del menu.
//**************************************************************************************************************************************************************************************
String ls_menu 

ls_menu = This.menuname

If Not IsValid(m_tppsoftmanto) Then
	This.changemenu(m_tppsoftmanto)
End If

	choose case estado
	 
	  case 'New','Modified'
		m_tppsoftmanto.enabled=false
		m_tppsoftmanto.m_archivo.m_nuevo.enabled=false
		m_tppsoftmanto.m_archivo.m_modificar.enabled=false
		m_tppsoftmanto.m_archivo.m_eliminar.enabled=false
		m_tppsoftmanto.m_archivo.m_guardar.enabled=true
		m_tppsoftmanto.m_archivo.m_cerrar.enabled=false
		m_tppsoftmanto.m_archivo.m_cancelar.enabled=true
		
		m_tppsoftmanto.m_archivo.m_primero.enabled = false
		m_tppsoftmanto.m_archivo.m_anterior.enabled = false
		m_tppsoftmanto.m_archivo.m_siguiente.enabled = false
		m_tppsoftmanto.m_archivo.m_ultimo.enabled =  false 
		
		m_tppsoftmanto.m_archivo.m_buscar.enabled=false
	 
	case 'Save'
		m_tppsoftmanto.m_archivo.m_nuevo.enabled=true
		m_tppsoftmanto.m_archivo.m_modificar.enabled=true
		m_tppsoftmanto.m_archivo.m_eliminar.enabled=true
		m_tppsoftmanto.m_archivo.m_guardar.enabled=false
		m_tppsoftmanto.m_archivo.m_cerrar.enabled=true
		m_tppsoftmanto.m_archivo.m_cancelar.enabled=false	
	
		m_tppsoftmanto.m_archivo.m_primero.enabled = true
		m_tppsoftmanto.m_archivo.m_anterior.enabled = true
		m_tppsoftmanto.m_archivo.m_siguiente.enabled = true
		m_tppsoftmanto.m_archivo.m_ultimo.enabled =  true 	
		
		m_tppsoftmanto.m_archivo.m_buscar.enabled=true
	
	  case 'Modified'
		m_tppsoftmanto.m_archivo.m_cancelar.enabled=true
		m_tppsoftmanto.m_archivo.m_buscar.enabled=false
	end choose


end subroutine

public function boolean wf_valid (u_dw adw_handle);
integer li_numcols 
string   ls_columns[]

//***************************************************************************************************************************************************************************************
// Le asigno el dw. correspondiente.
//***************************************************************************************************************************************************************************************

if adw_handle.accepttext() = -1 then return true

//***************************************************************************************************************************************************************************************
// Valido las columnas.
//***************************************************************************************************************************************************************************************

li_numcols = adw_handle.dynamic of_objects(adw_handle,ls_columns,"column","*", true)

for li_numcols = 1 to upperbound(ls_columns)
	if left(adw_handle.describe(ls_columns[li_numcols] + ".coltype"),4) = 'time' then
		if isnull(adw_handle.getitemtime(adw_handle.getrow(),ls_columns[li_numcols])) then goto error	 
	end if	
	
	if left(adw_handle.describe(ls_columns[li_numcols] + ".coltype"),4) = 'date' then		
		if left(adw_handle.describe(ls_columns[li_numcols] + ".coltype"),8) = 'datetime' then
				if isnull(adw_handle.getitemdatetime(adw_handle.getrow(),ls_columns[li_numcols])) then goto error	
		else 
				if isnull(adw_handle.getitemdate(adw_handle.getrow(),ls_columns[li_numcols])) 	 then goto error			
		end if		
	end if	
	
	if left(adw_handle.describe(ls_columns[li_numcols] + ".coltype"),4) = 'long' then
		if isnull(adw_handle.getitemnumber(adw_handle.getrow(),ls_columns[li_numcols])) then goto error
	end if
	
	if left(adw_handle.describe(ls_columns[li_numcols] + ".coltype"),4) = 'deci' then
		if isnull(adw_handle.getitemdecimal(adw_handle.getrow(),ls_columns[li_numcols])) then goto error
	end if  
	
	if left(adw_handle.describe(ls_columns[li_numcols] + ".coltype"),4) = 'char' then
		if isnull(trim(adw_handle.getitemstring(adw_handle.getrow(),ls_columns[li_numcols]))) or trim(adw_handle.getitemstring(adw_handle.getrow(),ls_columns[li_numcols])) = '' then goto error
	end if

next

//***************************************************************************************************************************************************************************************
// Error.
//***************************************************************************************************************************************************************************************

error:
  if li_numcols <= upperbound(ls_columns) then  
    adw_handle.setfocus()
    adw_handle.setcolumn(ls_columns[li_numcols])
    messagebox(Gn_Config.Is_Work.Aplicacion,adw_handle.describe(ls_columns[li_numcols] + ".tag"),Stopsign!)
	 return true	
  end if

//***************************************************************************************************************************************************************************************
// Return.
//***************************************************************************************************************************************************************************************
li_numcols = adw_handle.dynamic of_columns(adw_handle,ls_columns,"column","*", true)

for li_numcols = 1 to upperbound(ls_columns)
	If wf_colvalid (ls_columns[li_numcols]) Then
		 return true	
	End If
next

	 return False	
end function

public subroutine wf_primarykey ();//
end subroutine

public function boolean wf_colvalid (string as_colname);Return False
end function

public subroutine wf_datos ();//
end subroutine

public subroutine wf_dime_dwdetalle (u_dw a_dw);idw_detalle = a_dw

end subroutine

on w_classbak.create
if this.MenuName = "m_tppsoftmanto" then this.MenuID = create m_tppsoftmanto
end on

on w_classbak.destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event resize;
//***************************************************************************************************************************************************************************************
// Resize.
//***************************************************************************************************************************************************************************************

if isvalid(inv_resize) then inv_resize.event pfc_resize (sizetype,this.workspacewidth(),this.workspaceheight())
end event

event open;wf_centrar () 
this.postevent('ue_postopen')


end event

