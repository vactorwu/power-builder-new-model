HA$PBExportHeader$u_dw.sru
$PBExportComments$userobject con clase del datawindow.
forward
global type u_dw from datawindow
end type
end forward

global type u_dw from datawindow
integer width = 494
integer height = 360
integer taborder = 10
boolean livescroll = true
borderstyle borderstyle = stylelowered!
event ue_refresh ( )
event ue_getid ( )
event ue_mousemove pbm_mousemove
event ue_processenter pbm_dwnprocessenter
event ue_keydown pbm_keydown
event ue_keyup pbm_keyup
event ue_newprevious pbm_custom01
event ue_new pbm_custom02
event ue_newafter pbm_custom03
event ue_modifyprevious pbm_custom04
event ue_modify pbm_custom05
event ue_modifyafter pbm_custom06
event ue_deleteprevious pbm_custom07
event ue_delete pbm_custom08
event ue_deleteafter pbm_custom09
event ue_saveprevious pbm_custom10
event ue_save pbm_custom11
event ue_saveafter pbm_custom12
event ue_cancelprevious pbm_custom13
event ue_cancel pbm_custom14
event ue_cancelafter pbm_custom15
event ue_undoprevious pbm_custom16
event ue_undo pbm_custom17
event ue_undoafter pbm_custom18
event ue_findprevious pbm_custom19
event ue_find pbm_custom20
event ue_findafter pbm_custom21
event ue_tofirst pbm_custom22
event ue_toprior pbm_custom23
event ue_tonext pbm_custom24
event ue_tolast pbm_custom25
event ue_ddkeysrch pbm_custom26
event possave pbm_custom27
event ue_itemnewprevious pbm_custom31
event ue_itemnew pbm_custom32
event ue_itemnewafter pbm_custom33
event ue_itemmodifyprevious pbm_custom34
event ue_itemmodify pbm_custom35
event ue_itemmodifyafter pbm_custom36
event ue_itemdeleteprevious pbm_custom37
event ue_itemdelete pbm_custom38
event ue_itemdeleteafter pbm_custom39
event ue_itemsaveprevious pbm_custom40
event ue_itemsave pbm_custom41
event ue_itemsaveafter pbm_custom42
event ue_itemcancelprevious pbm_custom43
event ue_itemcancel pbm_custom44
event ue_itemcancelafter pbm_custom45
event ue_itemundoprevious pbm_custom46
event ue_itemundo pbm_custom47
event ue_itemundoafter pbm_custom48
event ue_itemfindprevious pbm_custom49
event ue_itemfind pbm_custom50
event ue_itemfindafter pbm_custom51
event ue_itemtofirst pbm_custom52
event ue_itemtoprior pbm_custom53
event ue_itemtonext pbm_custom54
event ue_itemtolast pbm_custom55
event ue_dwnkey pbm_dwnkey

event ue_seleccion_calendario ( string as_campo,  datetime adt_valor )
end type
global u_dw u_dw

type variables

window   iw_handle
n_cst_dwsrv_resize inv_dwresize
n_basedw inv_basedw

boolean  ib_sort = False
string is_where,is_type = 'A'
long il_oldrow,il_newrow,il_contador
////////////////////////
Public:
boolean MultiSelect = False
long LastRow
integer ii_ShowStatus = 50 // Mostrar onde vai de 50 em 50 (por defeito)

Private:
string is_OrderCol,  is_SortType = "D"
boolean ib_Arrows = False, ib_MouseDown = False, ib_Selected = False

Public:
// - Common return value constants:
constant integer 		SUCCESS = 1
constant integer 		FAILURE = -1
constant integer 		NO_ACTION = 0
// - Continue/Prevent return value constants:
constant integer 		CONTINUE_ACTION = 1
constant integer 		PREVENT_ACTION = 0

//u_mc			iuo_Calendario
uo_calendario	iuo_Calendario
Boolean 		ib_Calenadario	
String 		is_CalenadarioColumnas[]
String 		is_CalenadarioColumnaActiva
Integer		ii_CalenadarioColumnas
end variables

forward prototypes
public function integer of_objects (datawindow adw_handle, ref string as_objlist[], string as_objtype, string as_band, boolean ab_visibleonly)
public subroutine of_resize (boolean as_estado)
public subroutine of_dropdownsearch (boolean as_estado)
public function integer uf_centrar (string as_point)
public function integer of_columns (datawindow adw_handle, ref string as_objlist[], string as_objtype, string as_band, boolean ab_visibleonly)
public function integer of_columnstag (datawindow adw_handle, ref string as_objlist[], ref string as_objlisttag[], string as_objtype, string as_band, boolean ab_visibleonly)
public function integer of_setdropdowncalendar (boolean ab_switch)
public function integer of_getparentwindow (window aw_parent)
public subroutine of_setregistrarcalendario (boolean ab_opcion)
public function integer of_setcampocalendario (string as_campo)
public subroutine of_cerrarcalendario ()
end prototypes

event ue_refresh();// Aqui actua como el Retrieve
end event

event ue_getid();// qui se ombiene el ID
end event

event ue_mousemove;Any XX,YY,HH,WW
Any Li_XX,Li_YY,Li_HH,Li_WW
If ib_Calenadario Then
	If IsValid(iuo_Calendario) Then	
	XX =This.Describe(is_CalenadarioColumnaActiva+".X")
	YY = This.Describe(is_CalenadarioColumnaActiva+".Y")
	HH = This.Describe(is_CalenadarioColumnaActiva+".Height")
	WW = This.Describe(is_CalenadarioColumnaActiva+".Width")
	Li_XX	=	Integer(XX)
	Li_YY	=	Integer(YY)
	Li_HH	=	Integer(HH)
	Li_WW=	Integer(WW)		
		
	//This.title ="ANCHO  " +String(Li_XX) + " - " + String(Li_XX + Li_WW) + "ALTO  "+ String(Li_YY) + " - " + String(Li_YY + Li_HH) +"     Xpos = "	+ String(Xpos) + "  -  Ypos = "	+ String(Ypos) + "  -  Flags = "	+ String(Flags) 
	
		If ((  Xpos >= Li_XX and Xpos <=  (Li_XX + Li_WW) ) and  (Ypos >= Li_YY and Ypos <= (Li_YY + Li_HH)))  Then // or Xpos=< (Li_XX + Li_WW) and  (Ypos >= Li_YY or Ypos =< (Li_YY + Li_HH))
		Else
				this.post of_cerrarcalendario()
		End If
	End If				
End If
end event

event ue_processenter;// Procesa al Presionar Enter
end event

event ue_keydown;// Evento que ocurre al Presionar una tecla
end event

event ue_keyup;// Evento que ocurre al levantar una tecla presionada
end event

event ue_newprevious;RETURN 1
end event

event ue_new;
//***************************************************************************************************************************************************************************************
// Cambio el cursor.
//***************************************************************************************************************************************************************************************

setpointer(hourglass!)

//***************************************************************************************************************************************************************************************
// Cambio las propiedades del datawindow.
//***************************************************************************************************************************************************************************************
this.setredraw(false)
//***************************************************************************************************************************************************************************************
// Limpio el buffer del datawindow.
//***************************************************************************************************************************************************************************************
this.reset()
//***************************************************************************************************************************************************************************************
// Inserto un nuevo registro en el buffer del datawindow.
//***************************************************************************************************************************************************************************************
il_oldrow = this.getrow()
il_newrow = this.insertrow(0)
this.scrolltorow(il_newrow)
//***************************************************************************************************************************************************************************************
// Ejecuto el show de botones correspondiente.
//***************************************************************************************************************************************************************************************
iw_handle.dynamic wf_buttons('New')
//***************************************************************************************************************************************************************************************
// Valido los inputs correspondientes.
//***************************************************************************************************************************************************************************************

//iw_handle.dynamic wf_init(this.dataobject)

//***************************************************************************************************************************************************************************************
// Le doy el foco correspondiente al datawindow.
//***************************************************************************************************************************************************************************************

this.setfocus()
this.setredraw(true)

//***************************************************************************************************************************************************************************************
// Enabiliso el datawindow 
//***************************************************************************************************************************************************************************************

this.enabled = true

//***************************************************************************************************************************************************************************************
// Le asigno los valores correspondientes a las variables.
//***************************************************************************************************************************************************************************************

il_contador = 1

RETURN 1
end event

event ue_newafter;RETURN 1
end event

event ue_modifyprevious;RETURN 1
end event

event ue_modify;If this.rowcount( ) > 0 then
//***************************************************************************************************************************************************************************************
// Cambio el cursor.
//***************************************************************************************************************************************************************************************

setpointer(hourglass!)

//***************************************************************************************************************************************************************************************
// Cambio las propiedades del datawindow.
//***************************************************************************************************************************************************************************************

this.setredraw(false)

//***************************************************************************************************************************************************************************************
// Enabiliso el datawindow 
//***************************************************************************************************************************************************************************************

this.enabled = true

//***************************************************************************************************************************************************************************************
// Ejecuto el show de botones correspondiente.
//***************************************************************************************************************************************************************************************

iw_handle.dynamic wf_buttons('Modified')

//***************************************************************************************************************************************************************************************
// Valido los inputs correspondientes.
//***************************************************************************************************************************************************************************************

//iw_handle.dynamic wf_init(this.dataobject)

//***************************************************************************************************************************************************************************************
// Le doy el foco correspondiente al datawindow.
//***************************************************************************************************************************************************************************************

this.setfocus()
this.setredraw(true)

//***************************************************************************************************************************************************************************************
// Le asigno los valores correspondientes a las variables.
//***************************************************************************************************************************************************************************************
	RETURN 1
Else
	Return 0
End If
il_contador = 1
end event

event ue_modifyafter;RETURN 1
end event

event ue_deleteprevious;RETURN 1
end event

event ue_delete;
//***************************************************************************************************************************************************************************************
// Evento.
//***************************************************************************************************************************************************************************************

 
// si se esta modificando que se cancele 
// si es nuevo que haga un retrieve
// si no se modifico que se elimine
long rou

if  messagebox("Advertecia " + Gn_Config.Is_Work.Aplicacion  ,"Desea eliminar este registro ......???",StopSign!,YesNo!)= 1 then
	this.setredraw( False)
	this.deleterow(this.getrow())
	this.accepttext()
	if this.update() > 0 then
		commit using SQLCA;		
			if SQLCA.sqlcode < 0 then
				messagebox("Error en la Base de Datos", "Error #"+string(SQLCA.sqldbcode)+":"+SQLCA.sqlerrtext)
				halt close
			end if	
			RETURN 1
	else 
		rollback using SQLCA;			
		this.triggerevent("ue_next")
		this.triggerevent("ue_prior")
			if SQLCA.sqlcode < 0 then
				messagebox("Error en la Base de Datos", "Error #"+string(SQLCA.sqldbcode)+":"+SQLCA.sqlerrtext)
				halt close
			end if
			Return 0
	end if
end if
end event

event ue_deleteafter;RETURN 1
end event

event ue_saveprevious;RETURN 1
end event

event ue_save;long ll_contador = 0
long ll_sqlnrows = 5

//*************************************************************************************************************************************************************************************
// Verifico los inputs antes de actualizar la informaci$$HEX1$$f300$$ENDHEX$$n.
//*************************************************************************************************************************************************************************************
If this.rowcount() > 0 then
	if this.accepttext() = 1 then
	  if iw_handle.dynamic wf_valid(this) then
		 this.post setfocus()
		 this.enabled = true
		 return
	  else
		 this.enabled = false 
		 this.post setredraw(true)
	  end if
	else
	  this.post setfocus()
	  this.post setredraw(true)
	  return
	end if
	
	//*************************************************************************************************************************************************************************************
	// Pseudocodigo de bloqueo de tabla y generaci$$HEX1$$f300$$ENDHEX$$n del pk.
	//*************************************************************************************************************************************************************************************
	
	if  this.getitemstatus(this.getrow(),0,primary!) = newmodified! then 
	  do while ll_sqlnrows <> 1
		 ll_sqlnrows = iw_handle.dynamic wf_flags('Block',this.dataobject)
		 if ll_sqlnrows = 0 then iw_handle.dynamic wf_message()
		 il_contador ++
	  loop
	 // if this.getitemstatus(this.getrow(),0,primary!) = newmodified! then this.setitem(il_newrow,1,of_key(il_newrow,this.dataobject)) 
	  if this.getitemstatus(this.getrow(),0,primary!) = newmodified! then this.setitem(il_newrow,1, iw_handle.dynamic wf_primarykey()) 
	end if
	
	//*************************************************************************************************************************************************************************************
	// Actualizo la informaci$$HEX1$$f300$$ENDHEX$$n del datawindow correspondiente.
	//*************************************************************************************************************************************************************************************
	
	if this.update() = 1 then
	  commit using SQLCA;
	else
	  rollback using SQLCA;
	end if
	
	//*************************************************************************************************************************************************************************************
	// Pseudocodigo para el desbloqueo de la tabla.
	//*************************************************************************************************************************************************************************************
	
	if  this.getitemstatus(this.getrow(),0,primary!) = notmodified! then iw_handle.dynamic wf_flags('Unblock',this.dataobject)
	
	//*************************************************************************************************************************************************************************************
	// Ejecuto el show de botones correspondiente.
	//*************************************************************************************************************************************************************************************
	
	iw_handle.dynamic wf_buttons('Save')
	
	//*************************************************************************************************************************************************************************************
	// Asigno los nuevos valores a las variables correspondientes.
	//*************************************************************************************************************************************************************************************
Else
	Return 
End If
il_contador = 1

RETURN 1
end event

event ue_saveafter;RETURN 1

end event

event ue_cancelprevious;RETURN 1
end event

event ue_cancel;RETURN 1
end event

event ue_cancelafter;RETURN 1
end event

event ue_undoprevious;RETURN 1

end event

event ue_undo;//***************************************************************************************************************************************************************************************
// Restablesco la ultima acci$$HEX1$$f300$$ENDHEX$$n correspondiente.
//***************************************************************************************************************************************************************************************

this.setredraw(false)

//***************************************************************************************************************************************************************************************
// Acpeto el texto del buffer current al original.
//***************************************************************************************************************************************************************************************

//if this.accepttext() <> 1 then return

//***************************************************************************************************************************************************************************************
// Realizo el efecto de undo correspondiente.
//***************************************************************************************************************************************************************************************

choose case this.getitemstatus(this.getrow(),0,primary!)
  case newmodified! ,New!
     this.deleterow(il_newrow)	
     iw_handle.dynamic wf_buttons('Save')	
 	  this.enabled = false 
	  this.post setredraw(true)
  case datamodified!
    // this.reselectrow(this.getrow())
	this.event ue_refresh( )
  case notmodified!
	  iw_handle.dynamic wf_buttons('Save')	
 	  this.enabled = false 
	  this.post setredraw(true)
end choose

//***************************************************************************************************************************************************************************************
// Ejecuto el show de botones correspondiente.
//***************************************************************************************************************************************************************************************
//iw_handle.dynamic wf_buttons('Undo')

//***************************************************************************************************************************************************************************************
// Le doy el foco correspondiente al datawindow.
//***************************************************************************************************************************************************************************************

this.setfocus()
this.setredraw(true)
RETURN 1
end event

event ue_undoafter;RETURN 1
end event

event ue_findprevious;RETURN 1
end event

event ue_find;RETURN 1
end event

event ue_findafter;RETURN 1
end event

event ue_tofirst;
//***************************************************************************************************************************************************************************************
// Escroleo.
//***************************************************************************************************************************************************************************************

this.scrolltorow(1)
end event

event ue_toprior;
//***************************************************************************************************************************************************************************************
// Escroleo.
//***************************************************************************************************************************************************************************************

this.scrollpriorrow()
end event

event ue_tonext;
//***************************************************************************************************************************************************************************************
// Escroleo.
//***************************************************************************************************************************************************************************************

this.scrollnextrow()
end event

event ue_tolast;
//***************************************************************************************************************************************************************************************
// Escroleo.
//***************************************************************************************************************************************************************************************

this.scrolltorow(this.rowcount())
end event

event ue_itemnewprevious;RETURN 1
end event

event ue_itemnew;RETURN 1
end event

event ue_itemnewafter;RETURN 1
end event

event ue_itemmodifyprevious;RETURN 1
end event

event ue_itemmodify;RETURN 1
end event

event ue_itemmodifyafter;RETURN 1
end event

event ue_itemdeleteprevious;RETURN 1
end event

event ue_itemdelete;RETURN 1
end event

event ue_itemdeleteafter;RETURN 1
end event

event ue_itemsaveprevious;RETURN 1
end event

event ue_itemsave;RETURN 1
end event

event ue_itemsaveafter;RETURN 1
end event

event ue_itemcancelprevious;RETURN 1
end event

event ue_itemcancel;RETURN 1
end event

event ue_itemcancelafter;RETURN 1
end event

event ue_itemundoprevious;RETURN 1
end event

event ue_itemundo;RETURN 1
end event

event ue_itemundoafter;RETURN 1
end event

event ue_itemfindprevious;RETURN 1
end event

event ue_itemfind;RETURN 1
end event

event ue_itemfindafter;RETURN 1
end event

event ue_itemtofirst;
//***************************************************************************************************************************************************************************************
// Escroleo.
//***************************************************************************************************************************************************************************************

this.scrolltorow(1)
end event

event ue_itemtoprior;
//***************************************************************************************************************************************************************************************
// Escroleo.
//***************************************************************************************************************************************************************************************

this.scrollpriorrow()
end event

event ue_itemtonext;
//***************************************************************************************************************************************************************************************
// Escroleo.
//***************************************************************************************************************************************************************************************

this.scrollnextrow()
end event

event ue_itemtolast;
//***************************************************************************************************************************************************************************************
// Escroleo.
//***************************************************************************************************************************************************************************************

this.scrolltorow(this.rowcount())
end event

event ue_dwnkey;
//******************************************************************************************************************************************************************************************
// Evento.
//******************************************************************************************************************************************************************************************

this.postevent("ue_ddkeysrch")
end event

event ue_seleccion_calendario(string as_campo, datetime adt_valor);//
end event

public function integer of_objects (datawindow adw_handle, ref string as_objlist[], string as_objtype, string as_band, boolean ab_visibleonly);
string  ls_objstring, ls_objholder
integer li_start = 1, li_tab = 0, li_count = 0

//**************************************************************************************************************************************************************************************
// Capturo.
//**************************************************************************************************************************************************************************************

ls_objstring = adw_handle.describe("datawindow.objects")

//**************************************************************************************************************************************************************************************
// Primera posicion.
//**************************************************************************************************************************************************************************************

li_tab =  pos(ls_objstring,"~t", li_start)

do while li_tab > 0
	
	ls_objholder = mid(ls_objstring, li_start, (li_tab - li_start))
	
	if  (adw_handle.describe(ls_objholder + ".tag") <> 'No') and (adw_handle.describe(ls_objholder + ".type") = as_objtype or as_objtype = "*") and (adw_handle.describe(ls_objholder + ".band") = as_band or as_band = "*") and (adw_handle.describe(ls_objholder + ".visible") = "1" or not ab_visibleonly) then
	  li_count ++
	  as_objlist[li_count] = ls_objholder
	end if

	li_start = li_tab + 1
	li_tab =  pos(ls_objstring, "~t", li_start)
	
loop 

//**************************************************************************************************************************************************************************************
// Verifico el $$HEX1$$fa00$$ENDHEX$$ltimo.
//**************************************************************************************************************************************************************************************

ls_objholder = mid(ls_objstring,li_start,len(ls_objstring))

//**************************************************************************************************************************************************************************************
// Determino el tipo, banda y visibilidad del $$HEX1$$fa00$$ENDHEX$$ltimo.
//**************************************************************************************************************************************************************************************

if  (adw_handle.describe(ls_objholder + ".tag") <> 'No') and (adw_handle.describe(ls_objholder + ".type") = as_objtype or as_objtype = "*") and (adw_handle.describe(ls_objholder + ".band") = as_band or as_band = "*") and (adw_handle.describe(ls_objholder + ".visible") = "1" or not ab_visibleonly) then
  li_count ++
  as_objlist[li_count] = ls_objholder
end if

return li_count
end function

public subroutine of_resize (boolean as_estado);
//***************************************************************************************************************************************************************************************
// Creo o destruyo el objeto.
//***************************************************************************************************************************************************************************************

if as_estado then
  inv_dwresize = create n_cst_dwsrv_resize
  inv_dwresize.of_setorigsize (this.width, this.height)
else
  destroy inv_dwresize
end if

end subroutine

public subroutine of_dropdownsearch (boolean as_estado);
//***************************************************************************************************************************************************************************************
// Creo o destruyo el objeto.
//***************************************************************************************************************************************************************************************

if as_estado then
  inv_basedw = create n_basedw
else
  destroy inv_basedw 
end if
end subroutine

public function integer uf_centrar (string as_point);int li_screenheight, li_screenwidth, li_rc, li_x=1, li_y=1 ,li_xx,li_yy
environment	lenv_obj
window vent
If IsNull ( this ) Or Not IsValid ( this ) Then Return -1

If GetEnvironment ( lenv_obj ) = -1 Then Return -1
vent = iw_handle
//li_screenheight = PixelsToUnits ( lenv_obj.ScreenHeight, YPixelsToUnits! )
//li_screenwidth  = PixelsToUnits ( lenv_obj.ScreenWidth, XPixelsToUnits! )
li_screenheight = vent.Height
li_screenwidth  = vent.Width
If Not ( li_screenheight > 0 ) Or Not ( li_screenwidth > 0 ) Then Return -1
li_xx = this.x
li_yy = this.y
If li_screenwidth > this.Width Then
	li_x = ( li_screenwidth/ 2 ) - ( this.Width / 2 )
End If
If li_screenheight > this.Height Then
	li_y = ( (li_screenheight - 400)/ 2 ) - ( this.Height / 2 )
End If

If as_point = "XY" or as_point = "YX" then
	li_rc = this.Move ( li_x, li_y )
ElseIf as_point="X" then
	li_rc = this.Move ( li_x, li_yy )
ElseIf as_point="Y" then
	li_rc = this.Move ( li_xx, li_y )
ElseIf as_point="X0" or as_point="0X" then
	li_rc = this.Move ( li_x, 0 )
ElseIf as_point="Y0" or as_point="0Y" then
	li_rc = this.Move ( 0, li_y )
Else
	li_rc = 1
End IF


If li_rc <> 1 Then Return -1

RETURN 1
end function

public function integer of_columns (datawindow adw_handle, ref string as_objlist[], string as_objtype, string as_band, boolean ab_visibleonly);
string  ls_objstring, ls_objholder
integer li_start = 1, li_tab = 0, li_count = 0

//**************************************************************************************************************************************************************************************
// Capturo.
//**************************************************************************************************************************************************************************************

ls_objstring = adw_handle.describe("datawindow.objects")

//**************************************************************************************************************************************************************************************
// Primera posicion.
//**************************************************************************************************************************************************************************************

li_tab =  pos(ls_objstring,"~t", li_start)

do while li_tab > 0
	
	ls_objholder = mid(ls_objstring, li_start, (li_tab - li_start))
	
	if  (adw_handle.describe(ls_objholder + ".type") = as_objtype or as_objtype = "*") and (adw_handle.describe(ls_objholder + ".band") = as_band or as_band = "*") and (adw_handle.describe(ls_objholder + ".visible") = "1" or not ab_visibleonly) then
	  li_count ++
	  as_objlist[li_count] = ls_objholder
	end if

	li_start = li_tab + 1
	li_tab =  pos(ls_objstring, "~t", li_start)
	
loop 

//**************************************************************************************************************************************************************************************
// Verifico el $$HEX1$$fa00$$ENDHEX$$ltimo.
//**************************************************************************************************************************************************************************************

ls_objholder = mid(ls_objstring,li_start,len(ls_objstring))

//**************************************************************************************************************************************************************************************
// Determino el tipo, banda y visibilidad del $$HEX1$$fa00$$ENDHEX$$ltimo.
//**************************************************************************************************************************************************************************************

if  (adw_handle.describe(ls_objholder + ".type") = as_objtype or as_objtype = "*") and (adw_handle.describe(ls_objholder + ".band") = as_band or as_band = "*") and (adw_handle.describe(ls_objholder + ".visible") = "1" or not ab_visibleonly) then
  li_count ++
  as_objlist[li_count] = ls_objholder
end if

return li_count
end function

public function integer of_columnstag (datawindow adw_handle, ref string as_objlist[], ref string as_objlisttag[], string as_objtype, string as_band, boolean ab_visibleonly);
string  ls_objstring, ls_objholder
integer li_start = 1, li_tab = 0, li_count = 0

//**************************************************************************************************************************************************************************************
// Capturo.
//**************************************************************************************************************************************************************************************

ls_objstring = adw_handle.describe("datawindow.objects")

//**************************************************************************************************************************************************************************************
// Primera posicion.
//**************************************************************************************************************************************************************************************

li_tab =  pos(ls_objstring,"~t", li_start)

do while li_tab > 0
	
	ls_objholder = mid(ls_objstring, li_start, (li_tab - li_start))
	
if  (adw_handle.describe(ls_objholder + ".tag") <> 'No') and (adw_handle.describe(ls_objholder + ".type") = as_objtype or as_objtype = "*") and (adw_handle.describe(ls_objholder + ".band") = as_band or as_band = "*") and (adw_handle.describe(ls_objholder + ".visible") = "1" or not ab_visibleonly) then
	  li_count ++
	  as_objlist[li_count] = ls_objholder
	  as_objlisttag[li_count] = adw_handle.describe(ls_objholder + ".tag")
	end if

	li_start = li_tab + 1
	li_tab =  pos(ls_objstring, "~t", li_start)
	
loop 

//**************************************************************************************************************************************************************************************
// Verifico el $$HEX1$$fa00$$ENDHEX$$ltimo.
//**************************************************************************************************************************************************************************************

ls_objholder = mid(ls_objstring,li_start,len(ls_objstring))

//**************************************************************************************************************************************************************************************
// Determino el tipo, banda y visibilidad del $$HEX1$$fa00$$ENDHEX$$ltimo.
//**************************************************************************************************************************************************************************************

if  (adw_handle.describe(ls_objholder + ".tag") <> 'No') and (adw_handle.describe(ls_objholder + ".type") = as_objtype or as_objtype = "*") and (adw_handle.describe(ls_objholder + ".band") = as_band or as_band = "*") and (adw_handle.describe(ls_objholder + ".visible") = "1" or not ab_visibleonly) then
  li_count ++
  	  as_objlist[li_count] = ls_objholder
	  as_objlisttag[li_count] = adw_handle.describe(ls_objholder + ".tag")
end if

return li_count
end function

public function integer of_setdropdowncalendar (boolean ab_switch);////////////////////////////////////////////////////////////////////////////////
////	Public Function:	of_SetDropDownCalendar
////	Arguments:		boolean
////   					true  - Start (create) the service
////   					false - Stop (destroy ) the service
////	Returns:			Integer - 1 if Successful operation, 0 = No action taken and -1 if an error occured
////	Description:		Starts or stops the DropDown Calendar visual object.
////////////////////////////////////////////////////////////////////////////////
////	Rev. History		Version
////						6.0		Initial version
//// 						6.0.01	Enhanced so that the Message object is not overwritten by the 
////								 OpenUserObject function.
////////////////////////////////////////////////////////////////////////////////
////	Copyright $$HEX2$$a9002000$$ENDHEX$$1996-2000 Sybase, Inc. and its subsidiaries.  All rights reserved.  Any distribution of the 
//// PowerBuilder Foundation Classes (PFC) source code by other than Sybase, Inc. and its subsidiaries is prohibited.
////////////////////////////////////////////////////////////////////////////////
//window lw_parent
//string	ls_classname
//powerobject	lpo_message
//
//// Check arguments
//if IsNull(ab_switch) then return FAILURE
//
//// Get parent window reference.
//of_GetParentWindow(lw_parent)
//if IsNull(lw_parent) or not IsValid(lw_parent) then return FAILURE
//
//if ab_Switch then
//	if not IsValid (iuo_Calendar) then
//		// If using pfc_n_msg, store the Message Object (dynamic call).
//		if IsValid(message) then
//			ls_classname = Trim(Lower(message.ClassName()))
//			if ls_classname = "n_msg" then lpo_message = Create Using "n_msg"
//			if IsValid(lpo_message) then message.Dynamic of_CopyTo(lpo_message)
//		end if				
//		
//		// Tell the object to behave as a dropdown object.
//		lnv_calendarattrib.ib_dropdown = true
//		lw_parent.OpenUserObjectWithParm(iuo_Calendar, lnv_calendarattrib)
//		iuo_Calendar.of_SetRequestor (this)
//		
//		// If using pfc_n_msg, restore the Message Object (dynamic call).
//		if IsValid(lpo_message) then 
//			lpo_message.Dynamic of_CopyTo(message)
//			Destroy lpo_message
//		end if
//		return SUCCESS
//	end if
//else 
//	if IsValid (iuo_Calendar) then
//		lw_parent.CloseUserObject(iuo_Calendar)
//		return SUCCESS
//	end if	
//end if 
//
return NO_ACTION
end function

public function integer of_getparentwindow (window aw_parent);//////////////////////////////////////////////////////////////////////////////
//	Public Function:	of_GetParentWindow
//	Arguments:		aw_parent   The Parent window for this object (passed by reference).
//	   								If a parent window is not found, aw_parent is NULL
//	Returns:			Integer - 1 if it succeeds and -1 if an error occurs
//	Description:		Calculates the parent window of a window object
//////////////////////////////////////////////////////////////////////////////
//	Rev. History		Version
//						5.0   Initial version
//////////////////////////////////////////////////////////////////////////////
//	Copyright $$HEX2$$a9002000$$ENDHEX$$1996-2000 Sybase, Inc. and its subsidiaries.  All rights reserved.  Any distribution of the 
// PowerBuilder Foundation Classes (PFC) source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//////////////////////////////////////////////////////////////////////////////
powerobject	lpo_parent

lpo_parent = this.GetParent()

// Loop getting the parent of the object until it is of type window!
do while IsValid (lpo_parent) 
	if lpo_parent.TypeOf() <> window! then
		lpo_parent = lpo_parent.GetParent()
	else
		exit
	end if
loop

if IsNull(lpo_parent) or not IsValid (lpo_parent) then
	setnull(aw_parent)	
	return FAILURE
end if

aw_parent = lpo_parent

return SUCCESS
end function

public subroutine of_setregistrarcalendario (boolean ab_opcion);	ib_Calenadario = ab_Opcion


end subroutine

public function integer of_setcampocalendario (string as_campo);
string  ls_objstring, ls_objholder
integer li_start = 1, li_tab = 0

//**************************************************************************************************************************************************************************************
// Capturo.
//**************************************************************************************************************************************************************************************

ls_objstring = This.describe("datawindow.objects")

//**************************************************************************************************************************************************************************************
// Primera posicion.
//**************************************************************************************************************************************************************************************

li_tab =  pos(ls_objstring,"~t", li_start)

do while li_tab > 0
	
	ls_objholder = mid(ls_objstring, li_start, (li_tab - li_start))
	
	
	if left(This.describe(ls_objholder+ ".coltype"),4) = 'date' and ls_objholder = as_campo and ib_Calenadario then
	  ii_CalenadarioColumnas ++
	  is_CalenadarioColumnas[ii_CalenadarioColumnas] = ls_objholder
	end if

	li_start = li_tab + 1
	li_tab =  pos(ls_objstring, "~t", li_start)
	
loop 

//**************************************************************************************************************************************************************************************
// Verifico el $$HEX1$$fa00$$ENDHEX$$ltimo.
//**************************************************************************************************************************************************************************************

ls_objholder = mid(ls_objstring,li_start,len(ls_objstring))

//**************************************************************************************************************************************************************************************
// Determino el tipo del $$HEX1$$fa00$$ENDHEX$$ltimo.
//**************************************************************************************************************************************************************************************

if left(This.describe(ls_objholder+ ".coltype"),4) = 'date' and ls_objholder = as_campo and ib_Calenadario then
  ii_CalenadarioColumnas ++
	  is_CalenadarioColumnas[ii_CalenadarioColumnas] = ls_objholder
end if

return ii_CalenadarioColumnas
end function

public subroutine of_cerrarcalendario ();If IsValid(iuo_Calendario) Then
	this.SetFocus( )
	iw_handle.closeUserObject(iuo_Calendario )
	is_CalenadarioColumnaActiva = ""
End If
end subroutine

event constructor;
window			lw_window
graphicobject 	lgo_objecttemp

//***************************************************************************************************************************************************************************************
// Ventana pariente.
//***************************************************************************************************************************************************************************************

lgo_objecttemp = Parent

do while typeof(lgo_objecttemp) <> Window!
  lgo_objecttemp = lgo_objecttemp.getparent()
loop

iw_handle = lgo_objecttemp

//***************************************************************************************************************************************************************************************
// Inicializo el datawindow.
//***************************************************************************************************************************************************************************************

this.settransobject(SQLCA) 
end event

event clicked;string ls_AddPict, ls_CurObj, ls_Picture, ls_CurCol , ls_Protegida , ls_Eval
integer li_PictPos,li_i
Long ll_Row
IF ib_sort THEN
		ls_CurObj = String(dwo.Name)
		IF Row = 0 AND THIS.DESCRIBE(ls_CurObj + ".Text") <> "!" AND THIS.DESCRIBE(ls_CurObj + ".Band") = "header" THEN // Valid header object?
		ls_CurCol = Left(ls_CurObj,Len(ls_CurObj) - 2)
		IF is_OrderCol <> ls_CurCol THEN // DIFferent Column
			THIS.ModIFy("DESTROY p_" + is_OrderCol)
			is_OrderCol = Left(ls_CurObj,Len(ls_CurObj) - 2)
			//segun sistema operativo
			//ls_Picture = "ORDERUP.BMP"
			ls_Picture = "UP.BMP"
			is_SortType = "A" // AscENDing sort
			li_PictPos = Integer(THIS.DESCRIBE(ls_CurObj + ".X"))+ (Integer(THIS.DESCRIBE(ls_CurObj + ".Width")) - 70)
			ls_AddPict ='create bitmap(band=FOReground filename="' + ls_Picture + '" ' + &
							' x="' + String(li_PictPos) + "~tInteger(DESCRIBE('" + is_OrderCol + & 
							".X')) + (Integer(DESCRIBE('" + is_OrderCol + ".Width'))" + ' - 70)" y="24" ' + &
							' height="33" width="51" border="0" name=p_' + is_OrderCol + ' visible="1")'
			THIS.ModIFy(ls_AddPict)
			THIS.SetSort(is_OrderCol + " " + is_SortType)
			THIS.Sort()
		ELSE
			IF is_SortType = "A" THEN
				//segun sistema orerativo
				//ls_Picture = "ORDERDW.BMP"
				ls_Picture = "Down.BMP"
				is_SortType = "D"
			ELSE
				//segun sistema orerativo
				//ls_Picture = "ORDERUP.BMP"
				ls_Picture = "UP.BMP"
				is_SortType = "A"
			END IF
			THIS.ModIFy('p_' + is_OrderCol + '.filename = "' + ls_Picture + '"')
			THIS.SetSort(is_OrderCol + " " + is_SortType)
			THIS.Sort()
		END IF
		END IF
	END IF
	
IF ib_Calenadario THEN
		ls_CurObj = String(dwo.Name)
		Any XX,YY, HH , WW , Protegida 
		Integer li_x , li_y
		String Pariente 
		Pariente = Parent.Classname( )
		FOR li_i = 1  TO ii_calenadariocolumnas
			IF is_calenadariocolumnas[li_i] = ls_CurObj THEN		
				IF IsValid(iuo_Calendario) THEN
					iw_handle.closeUserObject(iuo_Calendario )
					is_CalenadarioColumnaActiva = ""
				ELSE
					XX =THIS.DESCRIBE(ls_CurObj+".X")
					YY = THIS.DESCRIBE(ls_CurObj+".Y")
					HH = THIS.DESCRIBE(ls_CurObj+".Height")
					WW =  THIS.DESCRIBE(ls_CurObj+".Width")
					Protegida = THIS.DESCRIBE(ls_CurObj+".Protect")

					
					ll_row = THIS.GetRow()
					ls_Protegida = String(Protegida)				
					IF NOT IsNumber(ls_Protegida) THEN    
							  ls_Protegida = Right(ls_Protegida,  Len(ls_Protegida) - Pos(ls_Protegida, "~t"))    
								ls_eval = "Evaluate(~"" + ls_Protegida + ", "   + String(ll_row) + ")"    
								Protegida = THIS.DESCRIBE(ls_eval)
					END IF
					
					is_CalenadarioColumnaActiva = ls_CurObj
					IF Mid(Pariente,1,1) = "t" THEN
						li_X = Integer(XX) + THIS.X + 10
						li_Y = Integer(YY) +  Integer(HH) + THIS.Y + 115			
						IF THIS.Titlebar THEN li_X = li_X + 5
						IF THIS.Titlebar THEN li_Y = li_Y + 80
						
						IF THIS.Width <= (li_X + 859) THEN li_X = li_X + Integer(WW) - 842
						IF THIS.Height <= (li_Y + 624) THEN li_Y = li_Y - Integer(HH) - 624
					ELSE
						li_X = Integer(XX) + THIS.X - 10
						li_Y = Integer(YY) +  Integer(HH) + THIS.Y 		
						IF THIS.Titlebar THEN li_X = li_X + 5
						IF THIS.Titlebar THEN li_Y = li_Y + 80
						
						//IF THIS.Width <= (li_X + 859) THEN li_X = li_X + Integer(WW) - 842
						//IF THIS.Height <= (li_Y + 624) THEN li_Y = li_Y - Integer(HH) - 624
					END IF
					
					IF Integer(Mid(String(Protegida),1,1)) = 0 THEN
						iw_handle.OpenUserObjectWithParm(iuo_Calendario,ls_CurObj , li_X, li_Y )
						iuo_Calendario.of_setDataWindow(THIS)
						iuo_Calendario.Set_Campo(ls_CurObj)
						iuo_Calendario.of_SeleccionarFecha()
						iuo_Calendario.Set_Calendario()
						iuo_Calendario.SetFocus( )
					END IF
				END IF				
			END IF
		Next
END IF

end event

event sqlpreview;
//***************************************************************************************************************************************************************************************
// Asigno el sql correcto.
//***************************************************************************************************************************************************************************************

if keydown(keyf1!) then messagebox(Gn_Config.Is_Work.Aplicacion,sqlsyntax + is_where)

//***************************************************************************************************************************************************************************************
// Asigno el sql correcto.
//***************************************************************************************************************************************************************************************

this.setsqlpreview(sqlsyntax + is_where)
end event

event dberror;
//**************************************************************************************************************************************************************************************
// Reparo el error en caso sea de primary key.
//**************************************************************************************************************************************************************************************

choose case lower(left(sqlsyntax,6))
  case 'insert'
     //this.setitem(il_newrow,1,of_key(il_newrow,this.dataobject))
     this.setitem(il_newrow,1,iw_handle.dynamic wf_primarykey())
  case else
    messagebox(Gn_Config.Is_Work.Aplicacion,sqlerrtext + ' - ' + this.dataobject)
	 return
end choose

//**************************************************************************************************************************************************************************************
// Actualizo la informaci$$HEX1$$f300$$ENDHEX$$n de la persona.
//**************************************************************************************************************************************************************************************

if this.update() = 1 then
  commit using SQLCA;
else
  rollback using SQLCA;
end if

//**************************************************************************************************************************************************************************************
// Valor de retorno de la funci$$HEX1$$f300$$ENDHEX$$n.
//**************************************************************************************************************************************************************************************

RETURN 1
end event

on u_dw.create
end on

on u_dw.destroy
end on

