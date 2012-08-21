HA$PBExportHeader$w_manto.srw
forward
global type w_manto from w_class
end type
type gb_comandos from groupbox within w_manto
end type
type tab_todo from tab within w_manto
end type
type tp_manto from userobject within tab_todo
end type
type dw_manto from u_dw within tp_manto
end type
type pb_borrar from picturebutton within tp_manto
end type
type pb_abrir from picturebutton within tp_manto
end type
type ole_1 from olecontrol within tp_manto
end type
type tp_manto from userobject within tab_todo
dw_manto dw_manto
pb_borrar pb_borrar
pb_abrir pb_abrir
ole_1 ole_1
end type
type tp_lista from userobject within tab_todo
end type
type dw_lista from u_dw within tp_lista
end type
type am_1 from animation within tp_lista
end type
type st_2 from statictext within tp_lista
end type
type st_1 from statictext within tp_lista
end type
type rb_filtro from radiobutton within tp_lista
end type
type rb_seleccion from radiobutton within tp_lista
end type
type pb_refresh from u_pb within tp_lista
end type
type pb_orden from u_pb within tp_lista
end type
type pb_filtro from u_pb within tp_lista
end type
type gb_tipo from groupbox within tp_lista
end type
type ddlb_campo from dropdownlistbox within tp_lista
end type
type em_buscar from editmask within tp_lista
end type
type sle_buscar from u_sle within tp_lista
end type
type gb_busqueda from groupbox within tp_lista
end type
type tp_lista from userobject within tab_todo
dw_lista dw_lista
am_1 am_1
st_2 st_2
st_1 st_1
rb_filtro rb_filtro
rb_seleccion rb_seleccion
pb_refresh pb_refresh
pb_orden pb_orden
pb_filtro pb_filtro
gb_tipo gb_tipo
ddlb_campo ddlb_campo
em_buscar em_buscar
sle_buscar sle_buscar
gb_busqueda gb_busqueda
end type
type tab_todo from tab within w_manto
tp_manto tp_manto
tp_lista tp_lista
end type
type shl_cerrar from statichyperlink within w_manto
end type
type shl_grabar from statichyperlink within w_manto
end type
type shl_eliminar from statichyperlink within w_manto
end type
type shl_modificar from statichyperlink within w_manto
end type
type shl_nuevo from statichyperlink within w_manto
end type
type uo_nav from uo_navegacion within w_manto
end type
type pb_cancelar from picturebutton within w_manto
end type
type pb_grabar from picturebutton within w_manto
end type
type pb_eliminar from picturebutton within w_manto
end type
type pb_nuevo from picturebutton within w_manto
end type
type pb_cerrar from picturebutton within w_manto
end type
type shl_cancelar from statichyperlink within w_manto
end type
type pb_modificar from picturebutton within w_manto
end type
type pb_ventana_y_libreria from picturebutton within w_manto
end type
end forward

global type w_manto from w_class
integer width = 3808
integer height = 2324
string title = "Cat$$HEX1$$e100$$ENDHEX$$logo"
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
gb_comandos gb_comandos
tab_todo tab_todo
shl_cerrar shl_cerrar
shl_grabar shl_grabar
shl_eliminar shl_eliminar
shl_modificar shl_modificar
shl_nuevo shl_nuevo
uo_nav uo_nav
pb_cancelar pb_cancelar
pb_grabar pb_grabar
pb_eliminar pb_eliminar
pb_nuevo pb_nuevo
pb_cerrar pb_cerrar
shl_cancelar shl_cancelar
pb_modificar pb_modificar
pb_ventana_y_libreria pb_ventana_y_libreria
end type
global w_manto w_manto

type variables
Boolean modificado,Ib_buscar, Ib_InsertarAlGrabar = TRUE
Long Il_Fila,Il_Filas,Il_Columna
Decimal Id_Codigo
String  Is_Campo, Is_CampoTag,Is_CampoFinal
String  Is_Campo_Anterior , Is_Campo_Actual , Is_Campo_Posterior
Long act , deact
String Is_Columns[] ,  Is_ColumnsTag[]

end variables

forward prototypes
public subroutine wf_botones (string estado)
public function integer wf_activate (omactivatetype aat_type)
public function boolean wf_esultimaventana ()
public subroutine wf_tipodato (string as_campo)
public subroutine wf_dwchild ()
public function integer wf_centrardw (u_dw as_dw, string as_point)
public function string wf_iscampo (string as_campotag)
public function string wf_iscampotag (string as_campo)
public subroutine wf_primarykey ()
public subroutine wf_datos ()
public subroutine wf_datos_adicionales ()
public function long wf_dwkey (keycode key, unsignedlong keyflags)
public function long wf_dwkeyenter (keycode key, unsignedlong keyflags)
public subroutine wf_nombre_ventana ()
end prototypes

public subroutine wf_botones (string estado);//**************************************************************************************************************************************************************************************
// Cambio las propiedades del menu.
//**************************************************************************************************************************************************************************************

choose case estado
 
  case 'New','Modified'

	shl_nuevo.enabled=false
	shl_modificar.enabled=false
	shl_eliminar.enabled=false
	shl_grabar.enabled=true
	shl_cancelar.enabled=true
	shl_cerrar.enabled=false
	
	shl_nuevo.TextColor=RGB(255,0,0)
	shl_modificar.TextColor=RGB(255,0,0)
	shl_eliminar.TextColor=RGB(255,0,0)
	shl_grabar.TextColor=RGB(0,0,255)
	shl_cancelar.TextColor=RGB(0,0,255)
	shl_cerrar.TextColor=RGB(255,0,0)
	
	tab_todo.tp_lista.rb_filtro.enabled = false
	tab_todo.tp_lista.rb_seleccion.enabled = false
	tab_todo.tp_lista.ddlb_campo.enabled = false
	tab_todo.tp_lista.sle_buscar.enabled = false
	tab_todo.tp_lista.pb_filtro.enabled = false
	tab_todo.tp_lista.pb_orden.enabled = false
	tab_todo.tp_lista.pb_refresh.enabled = false
 case 'Save'

	shl_nuevo.enabled=true
	shl_modificar.enabled=true
	shl_eliminar.enabled=true
	shl_grabar.enabled=false
	shl_cancelar.enabled=false	
	shl_cerrar.enabled=true
	
	shl_nuevo.TextColor=RGB(0,0,255)
	shl_modificar.TextColor=RGB(0,0,255)
	shl_eliminar.TextColor=RGB(0,0,255)
	shl_grabar.TextColor=RGB(255,0,0)
	shl_cancelar.TextColor=RGB(255,0,0)
	shl_cerrar.TextColor=RGB(0,0,255)
	
    	tab_todo.tp_lista.rb_filtro.enabled = True
    	tab_todo.tp_lista.rb_seleccion.enabled = True
	tab_todo.tp_lista.ddlb_campo.enabled = True
	tab_todo.tp_lista.sle_buscar.enabled = True
	tab_todo.tp_lista.pb_filtro.enabled = True
	tab_todo.tp_lista.pb_orden.enabled = True
	tab_todo.tp_lista.pb_refresh.enabled = True
end choose
end subroutine

public function integer wf_activate (omactivatetype aat_type);//Activate the control 
//Funcion Name
//Argumet omactivatetype aat_type
If tab_todo.tp_manto.ole_1.activate(aat_Type) <> 0 Then
	Messagebox("OLE Activate","Unable to Activate")
	Return -1
End If

Return 1

end function

public function boolean wf_esultimaventana ();// Determine if there are any other sheets open

window		lw_Sheet, lw_Frame

lw_Frame = This.ParentWindow()

// Get the first sheet
lw_Sheet = lw_Frame.GetFirstSheet()

Do While IsValid(lw_Sheet)
	If lw_Sheet <> This Then Return False	// Found another sheet open
	lw_Sheet = lw_Frame.GetNextSheet(lw_Sheet)
Loop

Return True

end function

public subroutine wf_tipodato (string as_campo);String ls_tipodato,ls_limit,ls_style,ls_mask

ls_tipodato = idw_lista.describe(as_campo + ".coltype")
ls_limit = idw_lista.describe(as_campo + ".Edit.Limit")
ls_style = idw_lista.describe(as_campo + ".Edit.Style")
ls_mask = idw_lista.describe(as_campo + ".EditMask.Mask")




String ls_Char="aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"


choose case Left(ls_tipodato,4)
	case "char"//$$HEX2$$b7000900$$ENDHEX$$
				If ls_style="edit" then 
				 	tab_todo.tp_lista.em_buscar.SetMask(StringMask!,left(ls_char,long(ls_limit)))
				ElseIf ls_style="editmask" then 
					tab_todo.tp_lista.em_buscar.SetMask(StringMask!,ls_mask)
				End if
	case "date" ////DateMask! DateTimeMask!$$HEX1$$b700$$ENDHEX$$
			     If ls_style="editmask" then 
					tab_todo.tp_lista.em_buscar.SetMask(DateTimeMask!,ls_mask)
				End if
	case "deci","real"  //	DecimalMask!$$HEX3$$b70009000900$$ENDHEX$$
			  If ls_style="editmask" then 
					tab_todo.tp_lista.em_buscar.SetMask(DecimalMask!,ls_mask)
			End if
		
	case "Int ","long","ulong" //NumericMask!$$HEX1$$b700$$ENDHEX$$
		     If ls_style="editmask" then 
					tab_todo.tp_lista.em_buscar.SetMask(NumericMask!,ls_mask)
			End if
end choose
idw_lista.setredraw( False)
idw_lista.SetSort(is_campo + " ASC" )
idw_lista.Sort( )
idw_lista.setredraw( True)

tab_todo.tp_lista.em_buscar.setfocus( )

end subroutine

public subroutine wf_dwchild ();//
end subroutine

public function integer wf_centrardw (u_dw as_dw, string as_point);int li_screenheight, li_screenwidth, li_rc, li_x=1, li_y=1 ,li_xx,li_yy
environment	lenv_obj
//window vent
If IsNull ( this ) Or Not IsValid ( this ) Then Return -1
If IsNull ( as_dw ) Or Not IsValid ( as_dw ) Then Return -1
If GetEnvironment ( lenv_obj ) = -1 Then Return -1
//vent = this
//li_screenheight = PixelsToUnits ( lenv_obj.ScreenHeight, YPixelsToUnits! )
//li_screenwidth  = PixelsToUnits ( lenv_obj.ScreenWidth, XPixelsToUnits! )
li_screenheight = tab_todo.tp_lista.Height
li_screenwidth  = tab_todo.tp_lista.Width

If Not ( li_screenheight > 0 ) Or Not ( li_screenwidth > 0 ) Then Return -1
li_xx = as_dw.x
li_yy = as_dw.y

If li_screenwidth > as_dw.Width Then
	li_x = ( li_screenwidth/ 2 ) - ( as_dw.Width / 2 )
End If
If li_screenheight > as_dw.Height Then
	li_y = ( (li_screenheight)/ 2 ) - ( as_dw.Height / 2 )
End If

If as_point = "XY" or as_point = "YX" then
	li_rc = as_dw.Move ( li_x, li_y )
ElseIf as_point="X" then
	li_rc = as_dw.Move ( li_x, li_yy )
ElseIf as_point="Y" then
	li_rc = as_dw.Move ( li_xx, li_y )
ElseIf as_point="X0" or as_point="0X" then
	li_rc = as_dw.Move ( li_x, 0 )
ElseIf as_point="Y0" or as_point="0Y" then
	li_rc = as_dw.Move ( 0, li_y )
Else
	li_rc = 1
End IF


If li_rc <> 1 Then Return -1

Return 1
end function

public function string wf_iscampo (string as_campotag);String ls_Campo
Int li_numcols
For li_numcols = 1 to upperbound(is_columns)
	If (is_columnstag[li_numcols] = as_campotag ) Then
		ls_Campo = is_columns[li_numcols]
		Exit 
	End If
Next

Return ls_Campo
end function

public function string wf_iscampotag (string as_campo);String ls_Campo
Int li_numcols
For li_numcols = 1 to upperbound(is_columns)
	If (is_columns[li_numcols] = as_campo ) Then
		ls_Campo = is_columnstag[li_numcols]
		Exit 
	End If
Next

Return ls_Campo
end function

public subroutine wf_primarykey ();Long ll_retorno
//***************************************************************************************************************************************************************************************
// Genero el primary key.
//***************************************************************************************************************************************************************************************


ll_retorno = idw_activa.setitem( idw_activa.getrow() ,Is_CampoCod, gn_config.of_get_codigo( Is_Tabla, II_LargoCod))
end subroutine

public subroutine wf_datos ();
dwItemStatus l_status
String ls_fecha,ls_hora
DateTime ldt_FechaSys 
l_status = idw_activa.GetItemStatus( idw_activa.getrow() , 0, Primary!)

ldt_FechaSys = gn_config.of_datetime()

choose case l_status
	case New!, NewModified!
			idw_activa.Object.fecharegistro[idw_activa.getrow()]= ldt_FechaSys
			idw_activa.Object.usuarioregistro[idw_activa.getrow()] = gn_config.of_user()
			idw_activa.Object.estacionregistro[idw_activa.getrow()] =gn_config.of_terminal()
	case DataModified!
			idw_activa.Object.fechamodifico[idw_activa.getrow()]= ldt_FechaSys
			idw_activa.Object.usuariomodifico[idw_activa.getrow()] = gn_config.of_user()
			idw_activa.Object.estacionmodifico[idw_activa.getrow()] =gn_config.of_terminal()
end choose

wf_datos_adicionales()
end subroutine

public subroutine wf_datos_adicionales ();//
end subroutine

public function long wf_dwkey (keycode key, unsignedlong keyflags);//
Return 1
end function

public function long wf_dwkeyenter (keycode key, unsignedlong keyflags);//
Return 1

end function

public subroutine wf_nombre_ventana ();String ls_ventana , ls_libreria
ClassDefinition lcd

lcd = this.ClassDefinition
ls_ventana = This.Classname( )
ls_libreria =  lcd.LibraryName
Messagebox(ls_libreria,ls_ventana)

end subroutine

on w_manto.create
int iCurrent
call super::create
this.gb_comandos=create gb_comandos
this.tab_todo=create tab_todo
this.shl_cerrar=create shl_cerrar
this.shl_grabar=create shl_grabar
this.shl_eliminar=create shl_eliminar
this.shl_modificar=create shl_modificar
this.shl_nuevo=create shl_nuevo
this.uo_nav=create uo_nav
this.pb_cancelar=create pb_cancelar
this.pb_grabar=create pb_grabar
this.pb_eliminar=create pb_eliminar
this.pb_nuevo=create pb_nuevo
this.pb_cerrar=create pb_cerrar
this.shl_cancelar=create shl_cancelar
this.pb_modificar=create pb_modificar
this.pb_ventana_y_libreria=create pb_ventana_y_libreria
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_comandos
this.Control[iCurrent+2]=this.tab_todo
this.Control[iCurrent+3]=this.shl_cerrar
this.Control[iCurrent+4]=this.shl_grabar
this.Control[iCurrent+5]=this.shl_eliminar
this.Control[iCurrent+6]=this.shl_modificar
this.Control[iCurrent+7]=this.shl_nuevo
this.Control[iCurrent+8]=this.uo_nav
this.Control[iCurrent+9]=this.pb_cancelar
this.Control[iCurrent+10]=this.pb_grabar
this.Control[iCurrent+11]=this.pb_eliminar
this.Control[iCurrent+12]=this.pb_nuevo
this.Control[iCurrent+13]=this.pb_cerrar
this.Control[iCurrent+14]=this.shl_cancelar
this.Control[iCurrent+15]=this.pb_modificar
this.Control[iCurrent+16]=this.pb_ventana_y_libreria
end on

on w_manto.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.gb_comandos)
destroy(this.tab_todo)
destroy(this.shl_cerrar)
destroy(this.shl_grabar)
destroy(this.shl_eliminar)
destroy(this.shl_modificar)
destroy(this.shl_nuevo)
destroy(this.uo_nav)
destroy(this.pb_cancelar)
destroy(this.pb_grabar)
destroy(this.pb_eliminar)
destroy(this.pb_nuevo)
destroy(this.pb_cerrar)
destroy(this.shl_cancelar)
destroy(this.pb_modificar)
destroy(this.pb_ventana_y_libreria)
end on

event open;call super::open;
this.y = 0

String T1,T2,T3,T4,T5,T6
String A1,A2,A3,A4,A5,A6
String En=Char(13) ,Es="  "

 T1 ="Nuevo" 
 T2 ="Modificar"
 T3 ="Eliminar" 
 T4 ="Grabar" 
 T5 ="Cancelar" 
 T6 ="Cerar"

 A1 ="[Ins]" 
 A2 ="[Ctrl+M]"
 A3 ="[Del]" 
 A4 ="[Ctrl+G]" 
 A5 ="[Ctrl+Z]" 
 A6 ="[Ctrl+F4]"

 
shl_nuevo.text      	= T1+EN+A1
shl_modificar.text 	= T2+EN+A2
shl_eliminar.text   	= T3+EN+A3
shl_grabar.text     	= T4+EN+A4
shl_Cancelar.text  	= T5+EN+A5
shl_Cerrar.text     	= T6+EN+A6

pb_nuevo.PowerTipText     	= T1+Es+A1
pb_modificar.PowerTipText 	= T2+Es+A2
pb_eliminar.PowerTipText  	= T3+Es+A3
pb_grabar.PowerTipText    	= T4+Es+A4
pb_Cancelar.PowerTipText 	= T5+Es+A5
pb_Cerrar.PowerTipText 	= T6+Es+A6

wf_resize(true)
inv_resize.of_Register(tab_todo, inv_resize.SCALERIGHTBOTTOM )

inv_resize.of_Register(gb_comandos, inv_resize.FIXEDBOTTOM )

inv_resize.of_Register(shl_nuevo, inv_resize.FIXEDBOTTOM )
inv_resize.of_Register(shl_modificar, inv_resize.FIXEDBOTTOM )
inv_resize.of_Register(shl_eliminar, inv_resize.FIXEDBOTTOM )
inv_resize.of_Register(shl_grabar, inv_resize.FIXEDBOTTOM )
inv_resize.of_Register(shl_cancelar, inv_resize.FIXEDBOTTOM )
inv_resize.of_Register(shl_cerrar, inv_resize.FIXEDBOTTOM )

inv_resize.of_Register(uo_nav, inv_resize.FIXEDBOTTOM )

inv_resize.of_Register(pb_nuevo, inv_resize.FIXEDBOTTOM )
inv_resize.of_Register(pb_modificar, inv_resize.FIXEDBOTTOM )
inv_resize.of_Register(pb_eliminar, inv_resize.FIXEDBOTTOM )
inv_resize.of_Register(pb_grabar, inv_resize.FIXEDBOTTOM )
inv_resize.of_Register(pb_cancelar, inv_resize.FIXEDBOTTOM )
inv_resize.of_Register(pb_cerrar, inv_resize.FIXEDBOTTOM )



inv_resize.of_Register(tab_todo.tp_lista.dw_lista, inv_resize.SCALERIGHTBOTTOM ) 
//inv_resize.of_Register(tab_todo.tp_manto.dw_manto, inv_resize.SCALERIGHTBOTTOM ) 
inv_resize.of_Register(tab_todo.tp_manto.pb_abrir, inv_resize.FIXEDRIGHT ) 
inv_resize.of_Register(tab_todo.tp_manto.pb_borrar, inv_resize.FIXEDRIGHT ) 
inv_resize.of_Register(gb_comandos, inv_resize.FIXEDRIGHTBOTTOM )

f_get_toolbar_profile(This, 1)





end event

event ue_modify;call super::ue_modify;If ii_Modify = 1 Then
	idw_activa.setfocus( )
	wf_botones ('Modified')
	tab_todo.tp_lista.dw_lista.enabled =  false
End If
end event

event ue_save;call super::ue_save;
String ls_Codigo

IF ii_Save = 1 THEN
	IF (idw_activa.enabled = FALSE) THEN
		IF idw_activa.rowcount( ) > 0 THEN
			id_Codigo = idw_activa.GetItemDecimal(idw_activa.getrow(),Is_CampoId)
			ls_Codigo = idw_activa.GetItemString(idw_activa.getrow(),Is_CampoCod)
			idw_activa.setredraw(FALSE )
			idw_lista.setredraw( FALSE )
			IF modificado THEN
				idw_lista.reselectrow(idw_lista.getrow())
			ELSE
				idw_lista.EVENT ue_refresh( )
				//idw_lista.retrieve(gn_config.is_work.empresa)
			END IF
			THIS.idw_lista.ScrollToRow(THIS.idw_lista.find( Is_CampoCod+" = '"+ls_Codigo+"'",1,THIS.idw_lista.rowcount()))
			idw_activa.setredraw(TRUE)
			idw_lista.setredraw(TRUE)
			wf_botones ('Save')
			idw_lista.enabled =  TRUE
		END IF
	END IF
END IF


end event

event ue_new;call super::ue_new;If ii_New = 1 Then
	idw_activa.setfocus( )
	wf_botones ('New')
	idw_lista.enabled =  false
End If
end event

event ue_undo;call super::ue_undo;If ii_Undo = 1 Then
	if (idw_activa.enabled=  false) then
		idw_lista.triggerevent(rowfocuschanged!)
		idw_lista.enabled =  true
		wf_botones ('Save')
	end if
End If
	
end event

event ue_postopen;call super::ue_postopen;if idw_lista.rowcount() > 0 then
	this.triggerevent('ue_tolast')	
	tab_todo.tp_lista.em_buscar.setfocus( )
Else
	this.triggerevent('ue_new')
End If
	

end event

event closequery;call super::closequery;IF shl_grabar.enabled = FALSE THEN
	IF Ib_PreguntarSalir THEN
		IF Messagebox(Gn_Config.Is_Work.Aplicacion,'Desea cerrar el modulo  ' + upper(string(THIS.Title)) ,question!,yesno!,1) = 2 THEN
				  RETURN 1
			ELSE
				  //f_save_toolbar_profile(This)
				  wf_resize(FALSE)
				  RETURN 0
			END IF
      END IF			
ELSE
	 RETURN 1
END IF
end event

event resize;call super::resize;
wf_centrardw(idw_activa ,"X")
wf_centrardw(idw_lista,"X")

end event

event doubleclicked;call super::doubleclicked;wf_nombre_ventana()
end event

type gb_comandos from groupbox within w_manto
integer x = 101
integer y = 1492
integer width = 3538
integer height = 360
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Comandos"
end type

type tab_todo from tab within w_manto
integer x = 5
integer width = 3689
integer height = 1916
integer taborder = 80
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "Courier New"
long backcolor = 67108864
boolean focusonbuttondown = true
boolean powertips = true
boolean boldselectedtext = true
alignment alignment = center!
integer selectedtab = 2
tp_manto tp_manto
tp_lista tp_lista
end type

on tab_todo.create
this.tp_manto=create tp_manto
this.tp_lista=create tp_lista
this.Control[]={this.tp_manto,&
this.tp_lista}
end on

on tab_todo.destroy
destroy(this.tp_manto)
destroy(this.tp_lista)
end on

type tp_manto from userobject within tab_todo
event create ( )
event destroy ( )
integer x = 18
integer y = 112
integer width = 3653
integer height = 1788
long backcolor = 67108864
string text = "Datos de"
long tabtextcolor = 33554432
string picturename = "Window!"
long picturemaskcolor = 536870912
dw_manto dw_manto
pb_borrar pb_borrar
pb_abrir pb_abrir
ole_1 ole_1
end type

on tp_manto.create
this.dw_manto=create dw_manto
this.pb_borrar=create pb_borrar
this.pb_abrir=create pb_abrir
this.ole_1=create ole_1
this.Control[]={this.dw_manto,&
this.pb_borrar,&
this.pb_abrir,&
this.ole_1}
end on

on tp_manto.destroy
destroy(this.dw_manto)
destroy(this.pb_borrar)
destroy(this.pb_abrir)
destroy(this.ole_1)
end on

type dw_manto from u_dw within tp_manto
integer y = 52
integer width = 3621
integer height = 1300
integer taborder = 50
boolean enabled = false
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
boolean ib_sort = true
long il_oldrow = 1
end type

event constructor;call super::constructor;wf_dime_dw (this)
wf_centrardw(this,"X")

end event

event ue_new;call super::ue_new;wf_primarykey( ) 
wf_datos()

tab_todo.tp_lista.enabled = false
uo_nav.enabled = false
tab_todo.selecttab(tab_todo.tp_manto)
idw_activa.setfocus( )

Return 1
end event

event ue_dwnkey;call super::ue_dwnkey;IF	wf_dwkey(key,keyflags) <> 1  THEN RETURN

IF key = keyenter! THEN  
	idw_activa.accepttext( )	
	IF	wf_dwkeyenter(key,keyflags) <> 1  THEN RETURN
	
	If Upper(idw_activa.getcolumnname( )) =Upper(is_campofinal) Then
		pb_grabar.event clicked( )
	Else 
  		send(handle(this), 256, 9, long(0,0))
		idw_activa.SelectText(1, Len(idw_activa.GetText()))
		idw_activa.setfocus( )
	End If
END IF

end event

event ue_deleteprevious;call super::ue_deleteprevious;If idw_lista.rowcount( ) > 0 then
	il_Fila = idw_lista.getrow( )
	il_Filas = idw_lista.rowcount( )
	Return 1
Else
	messagebox("Advertecia " + Gn_Config.Is_Work.Aplicacion  ,"No existe registro para eliminar......!!!",Exclamation!,ok!)
	Return 0
End If
end event

event ue_deleteafter;call super::ue_deleteafter;If idw_lista.rowcount( ) > 0 then
	idw_lista.setredraw(false)
	idw_lista.event ue_refresh( )
	//idw_lista.retrieve(gn_config.is_config.empresa)
	idw_lista.scrolltorow(il_Fila)
	idw_lista.triggerevent( rowfocuschanged!)
	idw_activa.setredraw(true)
	idw_lista.setredraw(true)
End if

end event

event ue_find;call super::ue_find;If Not(idw_activa.enabled) then
	tab_todo.selecttab( tab_todo.tp_lista)
	tab_todo.tp_lista.em_buscar.setfocus()
End If
end event

event ue_modify;call super::ue_modify;

	tab_todo.tp_lista.enabled = false
	uo_nav.enabled = false
	tab_todo.selecttab(tab_todo.tp_manto)
	idw_activa.setfocus( )

Return 1
end event

event ue_saveafter;call super::ue_saveafter;
tab_todo.tp_lista.enabled = true
uo_nav.enabled = true
tab_todo.selecttab(tab_todo.tp_lista)
idw_lista.setfocus( )
IF Ib_InsertarAlGrabar THEN pb_nuevo.postevent(Clicked!)

Return 1
end event

event ue_undoafter;call super::ue_undoafter;If Not (idw_activa.enabled) then
	tab_todo.tp_lista.enabled = true
	uo_nav.enabled = true
	tab_todo.selecttab(tab_todo.tp_lista)
	idw_lista.setfocus( )
End If

Return 1
end event

type pb_borrar from picturebutton within tp_manto
boolean visible = false
integer x = 3008
integer y = 1140
integer width = 101
integer height = 88
integer taborder = 70
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "Courier New"
string picturename = "DELETE.BMP"
end type

type pb_abrir from picturebutton within tp_manto
boolean visible = false
integer x = 3013
integer y = 1040
integer width = 101
integer height = 88
integer taborder = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "Courier New"
string picturename = "Save!"
end type

type ole_1 from olecontrol within tp_manto
boolean visible = false
integer x = 2258
integer y = 1004
integer width = 558
integer height = 200
integer taborder = 60
boolean bringtotop = true
borderstyle borderstyle = stylelowered!
long backcolor = 74481808
boolean focusrectangle = false
string binarykey = "w_manto.win"
boolean resizable = true
omactivation activation = activateondoubleclick!
omdisplaytype displaytype = displayascontent!
omcontentsallowed contentsallowed = containsany!
end type

event doubleclicked;// Activate the object
// If using 32-bit Windows, inplace activation is possible
If ge_Environment.Win16 Then
	wf_activate(offsite!)
Else
	wf_activate(inplace!)
End If

end event

type tp_lista from userobject within tab_todo
event create ( )
event destroy ( )
integer x = 18
integer y = 112
integer width = 3653
integer height = 1788
long backcolor = 67108864
string text = "Lista de "
long tabtextcolor = 33554432
string picturename = "DataWindow5!"
long picturemaskcolor = 536870912
dw_lista dw_lista
am_1 am_1
st_2 st_2
st_1 st_1
rb_filtro rb_filtro
rb_seleccion rb_seleccion
pb_refresh pb_refresh
pb_orden pb_orden
pb_filtro pb_filtro
gb_tipo gb_tipo
ddlb_campo ddlb_campo
em_buscar em_buscar
sle_buscar sle_buscar
gb_busqueda gb_busqueda
end type

on tp_lista.create
this.dw_lista=create dw_lista
this.am_1=create am_1
this.st_2=create st_2
this.st_1=create st_1
this.rb_filtro=create rb_filtro
this.rb_seleccion=create rb_seleccion
this.pb_refresh=create pb_refresh
this.pb_orden=create pb_orden
this.pb_filtro=create pb_filtro
this.gb_tipo=create gb_tipo
this.ddlb_campo=create ddlb_campo
this.em_buscar=create em_buscar
this.sle_buscar=create sle_buscar
this.gb_busqueda=create gb_busqueda
this.Control[]={this.dw_lista,&
this.am_1,&
this.st_2,&
this.st_1,&
this.rb_filtro,&
this.rb_seleccion,&
this.pb_refresh,&
this.pb_orden,&
this.pb_filtro,&
this.gb_tipo,&
this.ddlb_campo,&
this.em_buscar,&
this.sle_buscar,&
this.gb_busqueda}
end on

on tp_lista.destroy
destroy(this.dw_lista)
destroy(this.am_1)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.rb_filtro)
destroy(this.rb_seleccion)
destroy(this.pb_refresh)
destroy(this.pb_orden)
destroy(this.pb_filtro)
destroy(this.gb_tipo)
destroy(this.ddlb_campo)
destroy(this.em_buscar)
destroy(this.sle_buscar)
destroy(this.gb_busqueda)
end on

type dw_lista from u_dw within tp_lista
integer y = 332
integer width = 3621
integer height = 1036
integer taborder = 80
boolean bringtotop = true
boolean controlmenu = true
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylebox!
boolean ib_sort = true
end type

event constructor;call super::constructor;uo_nav.uf_dw( this)
wf_dime_dwlista(this)
wf_centrardw(this,"X")
This.event ue_refresh( )





end event

event rowfocuschanged;call super::rowfocuschanged;Blob ole_blob
if this.rowcount() > 0  then
	THIS.selectrow(0,false)
	THIS.selectrow(THIS.getrow(),true)
	THIS.event ue_getid( ) //	id_Codigo=this.object.idempresa [this.getrow()]	
	idw_activa.event ue_refresh( )
	//idw_activa.retrieve(id_Codigo)
	idw_activa.setredraw(True)
	uo_nav.triggerevent('ue_showboton')	
else
	idw_activa.reset( )
	//idw_lista.reset( )	
end if
end event

event ue_dwnkey;call super::ue_dwnkey;This.accepttext( )

end event

type am_1 from animation within tp_lista
integer x = 2203
integer y = 104
integer width = 174
integer height = 132
integer taborder = 50
string animationname = "monitor.avi"
boolean autoplay = true
boolean transparent = true
end type

type st_2 from statictext within tp_lista
integer x = 46
integer y = 204
integer width = 238
integer height = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "Courier New"
long textcolor = 33554432
long backcolor = 67108864
string text = "Buscar:"
boolean focusrectangle = false
end type

type st_1 from statictext within tp_lista
integer x = 50
integer y = 72
integer width = 142
integer height = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "Courier New"
long textcolor = 33554432
long backcolor = 67108864
string text = "Por:"
boolean focusrectangle = false
end type

type rb_filtro from radiobutton within tp_lista
integer x = 1422
integer y = 92
integer width = 297
integer height = 56
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "Courier New"
long textcolor = 33554432
long backcolor = 67108864
string text = "Filtro"
boolean checked = true
end type

type rb_seleccion from radiobutton within tp_lista
integer x = 978
integer y = 92
integer width = 402
integer height = 56
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "Courier New"
long textcolor = 33554432
long backcolor = 67108864
string text = "Selecci$$HEX1$$f300$$ENDHEX$$n"
end type

type pb_refresh from u_pb within tp_lista
string tag = "Actualizar Lista"
integer x = 1961
integer y = 72
integer width = 101
integer height = 88
integer taborder = 40
integer textsize = -9
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "Courier New"
string text = ""
boolean originalsize = false
string picturename = "Update5!"
boolean map3dcolors = true
string powertiptext = "Actualizar Lista"
end type

event clicked;call super::clicked;String Blanco
Blanco = ""
idw_lista.SetRedraw(false)

idw_lista.setFilter(Blanco)
idw_lista.Filter()

idw_lista.SetSort(Blanco)
idw_lista.Sort()

sle_buscar.text = ""
idw_lista.SetRedraw(true)
end event

type pb_orden from u_pb within tp_lista
string tag = "Ordenar Lista"
integer x = 1847
integer y = 72
integer width = 101
integer height = 88
integer taborder = 30
integer textsize = -9
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "Courier New"
string text = ""
boolean originalsize = false
string picturename = "Sort!"
boolean map3dcolors = true
string powertiptext = "Ordenar Lista"
end type

event clicked;call super::clicked;String nulo
SetNull(nulo)
idw_lista.SetRedraw(false)
idw_lista.SetSort(Nulo)
idw_lista.Sort()
idw_lista.SetRedraw(true)


end event

type pb_filtro from u_pb within tp_lista
string tag = "Filtra Lista"
integer x = 1728
integer y = 72
integer width = 101
integer height = 88
integer taborder = 20
integer textsize = -9
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "Courier New"
string text = ""
boolean originalsize = false
string picturename = "Where!"
boolean map3dcolors = true
string powertiptext = "Filtra Lista"
end type

event clicked;call super::clicked;String nulo
SetNull(nulo)
idw_lista.SetRedraw(false)
idw_lista.setFilter(Nulo)
idw_lista.Filter()
idw_lista.SetRedraw(true)
end event

type gb_tipo from groupbox within tp_lista
integer x = 937
integer y = 36
integer width = 1166
integer height = 136
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "Courier New"
long textcolor = 33554432
long backcolor = 67108864
string text = "Tipo"
end type

type ddlb_campo from dropdownlistbox within tp_lista
integer x = 288
integer y = 72
integer width = 613
integer height = 648
integer taborder = 20
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
boolean sorted = false
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event constructor;int li_numcols

li_numcols = idw_lista.dynamic of_columnstag(idw_lista, is_columns ,  is_columnstag,"column","*", true)

For li_numcols = 1 to upperbound(is_columns)
	this.additem( is_columnstag[li_numcols])
Next

this.selectitem(1)
is_campo =wf_iscampo(this.text)

wf_tipodato(is_campo)
end event

event selectionchanged;is_campo =wf_iscampo(this.text)
wf_tipodato( is_campo)

end event

type em_buscar from editmask within tp_lista
event ue_keyown pbm_keydown
event ue_keyup pbm_keyup
integer x = 288
integer y = 192
integer width = 1829
integer height = 84
integer taborder = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "Courier New"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
end type

event ue_keyown;
choose case key
	case KeyEscape!  
		this.text=""
		TriggerEvent('ue_keyup')
		this.setfocus()
	case KeyEnter!  
		idw_lista.TriggerEvent('ue_buscar')
	case KeyLeftArrow!,KeyUpArrow!     //arriba
 			idw_lista.scrollpriorrow()
	case KeyRightArrow! ,KeyDownArrow!//abajo
			idw_lista.scrollnextrow()
	case KeyHome!     //inicio
 		   idw_lista.scrolltorow(1)
	case KeyEnd!	   //fin
			idw_lista.scrolltorow(idw_lista.rowcount())
	case KeyPageUp!   //pagina arriba
			idw_lista.ScrollPriorPage ( )
	case KeyPageDown!	//pagina abajo
			idw_lista.ScrollNextPage()
	
end choose

end event

event ue_keyup;choose case key
	case KeyEscape!, KeyEnter! 
	case KeyLeftArrow!,KeyUpArrow!  , KeyRightArrow! ,KeyDownArrow!
		
	case KeyHome!  ,KeyEnd!	  ,KeyPageUp!  ,KeyPageDown!	//pagina abajo
			
	case else
		
		String nulo,ls_Filtro,ls_tipodato
		nulo = ''
		idw_lista.setredraw(False)
		
		ls_tipodato = idw_lista.describe(is_campo + ".coltype")

choose case Left(ls_tipodato,4)
	case "char"
			If Len(this.text ) >0 Then
				ls_Filtro = " "+is_Campo+" LIKE '%"+this.text+"%'"
			Else
				ls_Filtro =""
			End If
	case "date"
			ls_Filtro = " date("+is_Campo+") >= Date('"+this.text+"')"

	case "deci","real" , "Int ","long","ulong" //NumericMask!$$HEX1$$b700$$ENDHEX$$
			ls_Filtro = " "+is_Campo+" >= "+this.text
end choose

		If rb_seleccion.checked = True Then

			il_Fila = idw_lista.find( ls_Filtro,1,idw_lista.rowcount())
			idw_lista.ScrollToRow(il_Fila)
			idw_lista.triggerevent(RowfocusChanged!)
		Else
			
			idw_lista.setFilter(Nulo)

			idw_lista.setFilter(ls_Filtro)
			idw_lista.Filter()
			idw_lista.triggerevent(RowfocusChanged!)
		End If
		
		idw_lista.setredraw(True)
end choose
end event

type sle_buscar from u_sle within tp_lista
boolean visible = false
integer x = 288
integer y = 192
integer width = 1829
integer height = 84
integer taborder = 20
integer textsize = -9
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "Courier New"
boolean enabled = false
textcase textcase = upper!
end type

event ue_keyup;call super::ue_keyup;choose case key
	case KeyEscape!, KeyEnter! 
	case KeyLeftArrow!,KeyUpArrow!  , KeyRightArrow! ,KeyDownArrow!
		
	case KeyHome!  ,KeyEnd!	  ,KeyPageUp!  ,KeyPageDown!	//pagina abajo
			
	case else
		
		String nulo,ls_Filtro
		nulo = ''
		idw_lista.setredraw(False)
		
		ls_Filtro = " "+is_Campo+" LIKE '%"+this.text+"%'"
		If rb_seleccion.checked = True Then

			il_Fila = idw_lista.find( ls_Filtro,1,idw_lista.rowcount())
			idw_lista.ScrollToRow(il_Fila)
			idw_lista.triggerevent(RowfocusChanged!)
		Else
			
			idw_lista.setFilter(Nulo)

			idw_lista.setFilter(ls_Filtro)
			idw_lista.Filter()
			idw_lista.triggerevent(RowfocusChanged!)
		End If
		
		idw_lista.setredraw(True)
end choose
end event

event ue_keydown;call super::ue_keydown;
choose case key
	case KeyEscape!  
		this.text=""
		TriggerEvent('ue_keyup')
		this.setfocus()
	case KeyEnter!  
		idw_lista.TriggerEvent('ue_buscar')
	case KeyLeftArrow!,KeyUpArrow!     //arriba
 			idw_lista.scrollpriorrow()
	case KeyRightArrow! ,KeyDownArrow!//abajo
			idw_lista.scrollnextrow()
	case KeyHome!     //inicio
 		   idw_lista.scrolltorow(1)
	case KeyEnd!	   //fin
			idw_lista.scrolltorow(idw_lista.rowcount())
	case KeyPageUp!   //pagina arriba
			idw_lista.ScrollPriorPage ( )
	case KeyPageDown!	//pagina abajo
			idw_lista.ScrollNextPage()
	
end choose

end event

type gb_busqueda from groupbox within tp_lista
integer x = 23
integer width = 2153
integer height = 300
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "Courier New"
long textcolor = 33554432
long backcolor = 67108864
string text = "Busqueda"
end type

type shl_cerrar from statichyperlink within w_manto
integer x = 3136
integer y = 1700
integer width = 311
integer height = 140
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string pointer = "HyperLink!"
long textcolor = 16711680
long backcolor = 67108864
boolean enabled = false
string text = "Cerrar"
alignment alignment = center!
boolean focusrectangle = false
end type

event clicked;pb_cancelar.TriggerEvent(Clicked!)
end event

type shl_grabar from statichyperlink within w_manto
integer x = 1047
integer y = 1700
integer width = 311
integer height = 140
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string pointer = "HyperLink!"
long textcolor = 134217857
long backcolor = 67108864
boolean enabled = false
string text = "Grabar"
alignment alignment = center!
boolean focusrectangle = false
end type

event clicked;pb_grabar.TriggerEvent(Clicked!)
end event

type shl_eliminar from statichyperlink within w_manto
integer x = 736
integer y = 1700
integer width = 311
integer height = 140
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string pointer = "HyperLink!"
long textcolor = 134217856
long backcolor = 67108864
string text = "Eliminar"
alignment alignment = center!
boolean focusrectangle = false
end type

event clicked;pb_eliminar.TriggerEvent(Clicked!)
end event

type shl_modificar from statichyperlink within w_manto
integer x = 425
integer y = 1700
integer width = 311
integer height = 140
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string pointer = "HyperLink!"
long textcolor = 134217856
long backcolor = 67108864
string text = "Modificar"
alignment alignment = center!
boolean focusrectangle = false
end type

event clicked;pb_modificar.TriggerEvent(Clicked!)
end event

type shl_nuevo from statichyperlink within w_manto
integer x = 114
integer y = 1700
integer width = 311
integer height = 140
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string pointer = "HyperLink!"
long textcolor = 134217856
long backcolor = 67108864
string text = "Nuevo"
alignment alignment = center!
boolean focusrectangle = false
end type

event clicked;pb_nuevo.TriggerEvent(Clicked!)
end event

type uo_nav from uo_navegacion within w_manto
event destroy ( )
integer x = 1669
integer y = 1592
integer taborder = 50
boolean bringtotop = true
end type

on uo_nav.destroy
call uo_navegacion::destroy
end on

event constructor;call super::constructor;this.uf_dw(tab_todo.tp_lista.dw_lista)
end event

type pb_cancelar from picturebutton within w_manto
integer x = 1426
integer y = 1548
integer width = 174
integer height = 152
integer taborder = 70
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
boolean cancel = true
boolean originalsize = true
string picturename = "Imagenes\Gif32\Error.gif"
string powertiptext = " "
end type

event clicked;if shl_cancelar.enabled =  true then
	Parent.TriggerEvent('ue_undo')
End If
end event

type pb_grabar from picturebutton within w_manto
integer x = 1115
integer y = 1548
integer width = 174
integer height = 152
integer taborder = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
boolean originalsize = true
string picturename = "Imagenes\Gif32\Guardar.gif"
string powertiptext = " "
end type

event clicked;if shl_grabar.enabled =  true then
	Parent.TriggerEvent('ue_save')
End If
end event

type pb_eliminar from picturebutton within w_manto
integer x = 805
integer y = 1548
integer width = 174
integer height = 152
integer taborder = 30
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
boolean originalsize = true
string picturename = "Imagenes\Gif32\Del.gif"
string powertiptext = " "
end type

event clicked;if shl_eliminar.enabled =  true then
	Parent.TriggerEvent('ue_delete')
End If
end event

type pb_nuevo from picturebutton within w_manto
integer x = 183
integer y = 1548
integer width = 174
integer height = 152
integer taborder = 10
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
boolean originalsize = true
string picturename = "Imagenes\Gif32\Add.gif"
string powertiptext = " "
end type

event clicked;if shl_nuevo.enabled =  true then
	Parent.TriggerEvent('ue_new')
End If
end event

type pb_cerrar from picturebutton within w_manto
integer x = 3205
integer y = 1548
integer width = 174
integer height = 152
integer taborder = 40
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
boolean originalsize = true
string picturename = "Imagenes\Gif32\Apagar.gif"
string powertiptext = " "
end type

event clicked;Close(Parent)
end event

type shl_cancelar from statichyperlink within w_manto
integer x = 1358
integer y = 1700
integer width = 311
integer height = 140
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string pointer = "HyperLink!"
long textcolor = 134217857
long backcolor = 67108864
boolean enabled = false
string text = "Cancelar"
alignment alignment = center!
boolean focusrectangle = false
end type

event clicked;pb_cancelar.TriggerEvent(Clicked!)
end event

type pb_modificar from picturebutton within w_manto
integer x = 494
integer y = 1548
integer width = 174
integer height = 152
integer taborder = 20
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
boolean originalsize = true
string picturename = "Imagenes\Gif32\Modificar01.gif"
string powertiptext = " "
end type

event clicked;if shl_modificar.enabled =  true then
	Parent.TriggerEvent('ue_modify')
End If
end event

type pb_ventana_y_libreria from picturebutton within w_manto
integer x = 23
integer y = 1268
integer width = 1440
integer height = 96
integer taborder = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "Courier New"
string text = "Ventana y Libreria"
boolean originalsize = true
end type

event clicked;
IF gb_VentanaLibreria THEN 
	wf_nombre_ventana()
END IF
end event

event constructor;
	THIS.Visible    = gb_VentanaLibreria
	THIS.Enabled =  gb_VentanaLibreria
end event


Start of PowerBuilder Binary Data Section : Do NOT Edit
0Cw_manto.bin 
2B00000600e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe00000006000000000000000000000001000000010000000000001000fffffffe00000000fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000fffffffe00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1Cw_manto.bin 
End of PowerBuilder Binary Data Section : No Source Expected After This Point
