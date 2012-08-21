HA$PBExportHeader$w_buscar.srw
forward
global type w_buscar from w_center
end type
type cb_aceptar from commandbutton within w_buscar
end type
type cb_cerrar from commandbutton within w_buscar
end type
type pb_refresh from u_pb within w_buscar
end type
type pb_orden from u_pb within w_buscar
end type
type pb_filtro from u_pb within w_buscar
end type
type em_buscar from editmask within w_buscar
end type
type rb_filtro from radiobutton within w_buscar
end type
type rb_seleccion from radiobutton within w_buscar
end type
type dw_lista from u_dw within w_buscar
end type
type st_2 from statictext within w_buscar
end type
type st_1 from statictext within w_buscar
end type
type am_1 from animation within w_buscar
end type
type gb_tipo from groupbox within w_buscar
end type
type ddlb_campo from dropdownlistbox within w_buscar
end type
type gb_busqueda from groupbox within w_buscar
end type
end forward

global type w_buscar from w_center
integer width = 2519
integer height = 1604
string title = "Busqueda de Productos"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
string icon = "Form!"
boolean center = true
cb_aceptar cb_aceptar
cb_cerrar cb_cerrar
pb_refresh pb_refresh
pb_orden pb_orden
pb_filtro pb_filtro
em_buscar em_buscar
rb_filtro rb_filtro
rb_seleccion rb_seleccion
dw_lista dw_lista
st_2 st_2
st_1 st_1
am_1 am_1
gb_tipo gb_tipo
ddlb_campo ddlb_campo
gb_busqueda gb_busqueda
end type
global w_buscar w_buscar

type variables
u_dw idw_lista
String is_campo, is_campotag, is_id,is_CPcampoid,  is_CPCodigo, is_CPDescripccion,Is_find
String is_columns[] ,  is_columnstag[] , Codigo
long il_fila
Int il_CampoBusqueda=1
Decimal id_Codigo
st_datos is_datos , is_datosnull
end variables

forward prototypes
public subroutine wf_dime_dwlista (u_dw a_dw)
public subroutine wf_tipodato (string as_campo)
public subroutine wf_abrir ()
public function string wf_iscampo (string as_campotag)
public function string wf_iscampotag (string as_campo)
public subroutine wf_accion ()
public subroutine wf_aceptar ()
public subroutine wf_cancelar ()
end prototypes

public subroutine wf_dime_dwlista (u_dw a_dw);idw_lista = a_dw
end subroutine

public subroutine wf_tipodato (string as_campo);String ls_tipodato,ls_limit,ls_style,ls_mask

ls_tipodato = idw_lista.describe(as_campo + ".coltype")
ls_limit = idw_lista.describe(as_campo + ".Edit.Limit")
ls_style = idw_lista.describe(as_campo + ".Edit.Style")
ls_mask = idw_lista.describe(as_campo + ".EditMask.Mask")




String ls_Char="xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"


choose case Left(ls_tipodato,4)
	case "char"//$$HEX2$$b7000900$$ENDHEX$$
				If ls_style="edit" then 
					em_buscar.SetMask(StringMask!,left(ls_char,long(ls_limit)))
				ElseIf ls_style="editmask" then 
					em_buscar.SetMask(StringMask!,ls_mask)
				End if
	case "date" ////DateMask! DateTimeMask!$$HEX1$$b700$$ENDHEX$$
			     If ls_style="editmask" then 
					em_buscar.SetMask(DateTimeMask!,ls_mask)
				End if
	case "deci","real"  //	DecimalMask!$$HEX3$$b70009000900$$ENDHEX$$
			  If ls_style="editmask" then 
					em_buscar.SetMask(DecimalMask!,ls_mask)
			End if
		
	case "Int ","long","ulong" //NumericMask!$$HEX1$$b700$$ENDHEX$$
		     If ls_style="editmask" then 
				em_buscar.SetMask(NumericMask!,ls_mask)
			End if
end choose
idw_lista.setredraw( False)
idw_lista.SetSort(is_campo + " ASC" )
idw_lista.Sort( )
idw_lista.setredraw( True)

em_buscar.setfocus( )

end subroutine

public subroutine wf_abrir ();//
//Is_find = Message.StringParm
//
//If IsNumber(Is_find) Then 
//	is_campotag =wf_iscampotag(is_CPCodigo)
//Else
//	is_campotag =wf_iscampotag(is_CPDescripccion)
//End If
//
//ddlb_campo.selectitem(ddlb_campo.Finditem(is_campotag,1))
//wf_tipodato( wf_iscampotag(is_campotag) )
//em_buscar.text = Is_find
//em_buscar.SelectText(Len(em_buscar.Text) + 1 , 0)
//em_buscar.triggerevent('ue_keyup')
//em_buscar.setfocus( )
end subroutine

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

public subroutine wf_accion ();//
end subroutine

public subroutine wf_aceptar ();//

end subroutine

public subroutine wf_cancelar ();//

end subroutine

on w_buscar.create
int iCurrent
call super::create
this.cb_aceptar=create cb_aceptar
this.cb_cerrar=create cb_cerrar
this.pb_refresh=create pb_refresh
this.pb_orden=create pb_orden
this.pb_filtro=create pb_filtro
this.em_buscar=create em_buscar
this.rb_filtro=create rb_filtro
this.rb_seleccion=create rb_seleccion
this.dw_lista=create dw_lista
this.st_2=create st_2
this.st_1=create st_1
this.am_1=create am_1
this.gb_tipo=create gb_tipo
this.ddlb_campo=create ddlb_campo
this.gb_busqueda=create gb_busqueda
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_aceptar
this.Control[iCurrent+2]=this.cb_cerrar
this.Control[iCurrent+3]=this.pb_refresh
this.Control[iCurrent+4]=this.pb_orden
this.Control[iCurrent+5]=this.pb_filtro
this.Control[iCurrent+6]=this.em_buscar
this.Control[iCurrent+7]=this.rb_filtro
this.Control[iCurrent+8]=this.rb_seleccion
this.Control[iCurrent+9]=this.dw_lista
this.Control[iCurrent+10]=this.st_2
this.Control[iCurrent+11]=this.st_1
this.Control[iCurrent+12]=this.am_1
this.Control[iCurrent+13]=this.gb_tipo
this.Control[iCurrent+14]=this.ddlb_campo
this.Control[iCurrent+15]=this.gb_busqueda
end on

on w_buscar.destroy
call super::destroy
destroy(this.cb_aceptar)
destroy(this.cb_cerrar)
destroy(this.pb_refresh)
destroy(this.pb_orden)
destroy(this.pb_filtro)
destroy(this.em_buscar)
destroy(this.rb_filtro)
destroy(this.rb_seleccion)
destroy(this.dw_lista)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.am_1)
destroy(this.gb_tipo)
destroy(this.ddlb_campo)
destroy(this.gb_busqueda)
end on

event open;call super::open;
//is_campoid 		= Nombre del Campo Id para devolver el Valor
//is_Codigo			= Nombre del Campo del Codigo para Buscar
//is_Descripccion	= Nombre del Campo de Descripcion para Buscar

wf_abrir( )
end event

type cb_aceptar from commandbutton within w_buscar
integer x = 654
integer y = 1384
integer width = 402
integer height = 112
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Aceptar"
boolean default = true
end type

event clicked;wf_aceptar( )
end event

type cb_cerrar from commandbutton within w_buscar
integer x = 1440
integer y = 1384
integer width = 402
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cancelar"
end type

event clicked;CloseWithReturn(Parent, "")
end event

type pb_refresh from u_pb within w_buscar
string tag = "Actualizar Lista"
integer x = 1961
integer y = 72
integer width = 101
integer height = 88
integer taborder = 50
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

em_buscar.text = ""
idw_lista.SetRedraw(true)
end event

type pb_orden from u_pb within w_buscar
string tag = "Ordenar Lista"
integer x = 1847
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

type pb_filtro from u_pb within w_buscar
string tag = "Filtra Lista"
integer x = 1728
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

type em_buscar from editmask within w_buscar
event ue_keydown pbm_keydown
event ue_keyup pbm_keyup
integer x = 288
integer y = 192
integer width = 1829
integer height = 84
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "Courier New"
long textcolor = 33554432
textcase textcase = upper!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
end type

event ue_keydown;
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

event ue_keyup;Integer li_ret
choose case key
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
			
			li_ret= idw_lista.setFilter(Nulo)
			li_ret=idw_lista.Filter()
			li_ret=idw_lista.setFilter(ls_Filtro)
			li_ret=idw_lista.Filter()
			idw_lista.triggerevent(RowfocusChanged!)
		End If
		wf_accion()
		idw_lista.setredraw(True)
end choose
end event

type rb_filtro from radiobutton within w_buscar
integer x = 1326
integer y = 92
integer width = 297
integer height = 48
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

type rb_seleccion from radiobutton within w_buscar
integer x = 946
integer y = 92
integer width = 402
integer height = 48
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

type dw_lista from u_dw within w_buscar
integer y = 332
integer width = 2496
integer height = 1036
boolean bringtotop = true
boolean controlmenu = true
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylebox!
boolean ib_sort = true
end type

event constructor;call super::constructor;wf_dime_dwlista(this)






end event

event rowfocuschanged;call super::rowfocuschanged;Blob ole_blob
if this.rowcount() > 0  then
	idw_lista.selectrow(0,false)
	idw_lista.selectrow(THIS.getrow(),true)
	idw_lista.event ue_getid( ) //	id_Codigo=this.object.idempresa [this.getrow()]	
	idw_lista.event ue_refresh( )
	idw_lista.setredraw(True)
end if
end event

event ue_dwnkey;call super::ue_dwnkey;this.accepttext( )

end event

type st_2 from statictext within w_buscar
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

type st_1 from statictext within w_buscar
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

type am_1 from animation within w_buscar
integer x = 2203
integer y = 104
integer width = 174
integer height = 132
integer taborder = 10
boolean originalsize = false
string animationname = "Z:\BUILD\PROYECTOS\PB\Pruebas\New Model\monitor.avi"
boolean autoplay = true
boolean transparent = true
end type

type gb_tipo from groupbox within w_buscar
integer x = 937
integer y = 36
integer width = 1166
integer height = 136
integer taborder = 20
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

type ddlb_campo from dropdownlistbox within w_buscar
integer x = 288
integer y = 72
integer width = 613
integer height = 648
integer taborder = 20
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

this.selectitem(il_CampoBusqueda)
is_campo =wf_iscampo(this.text)

wf_tipodato(is_campo)
end event

event selectionchanged;is_campo =wf_iscampo(this.text)
wf_tipodato( is_campo)

end event

type gb_busqueda from groupbox within w_buscar
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

