HA$PBExportHeader$w_util_filtro.srw
forward
global type w_util_filtro from window
end type
type mle_filtrooriginal from multilineedit within w_util_filtro
end type
type cb_4 from commandbutton within w_util_filtro
end type
type cb_3 from commandbutton within w_util_filtro
end type
type cb_2 from commandbutton within w_util_filtro
end type
type cb_1 from commandbutton within w_util_filtro
end type
type dw_filtro from datawindow within w_util_filtro
end type
type gb_filtrooriginal from groupbox within w_util_filtro
end type
type gb_filtronuevo from groupbox within w_util_filtro
end type
end forward

global type w_util_filtro from window
integer x = 215
integer y = 220
integer width = 2537
integer height = 1184
boolean titlebar = true
string title = "Filtro"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
mle_filtrooriginal mle_filtrooriginal
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
dw_filtro dw_filtro
gb_filtrooriginal gb_filtrooriginal
gb_filtronuevo gb_filtronuevo
end type
global w_util_filtro w_util_filtro

type variables
u_dw idwfiltro
DataWindowChild idwc_Columnas
DataWindowChild idwc_Valor
String is_campo, is_campotag, is_id,is_CPcampoid,  is_CPCodigo, is_CPDescripccion,Is_find
String is_columns[] ,  is_columnstag[]
long il_fila
Int il_CampoBusqueda=1

end variables

on w_util_filtro.create
this.mle_filtrooriginal=create mle_filtrooriginal
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_filtro=create dw_filtro
this.gb_filtrooriginal=create gb_filtrooriginal
this.gb_filtronuevo=create gb_filtronuevo
this.Control[]={this.mle_filtrooriginal,&
this.cb_4,&
this.cb_3,&
this.cb_2,&
this.cb_1,&
this.dw_filtro,&
this.gb_filtrooriginal,&
this.gb_filtronuevo}
end on

on w_util_filtro.destroy
destroy(this.mle_filtrooriginal)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_filtro)
destroy(this.gb_filtrooriginal)
destroy(this.gb_filtronuevo)
end on

event open;Long ll_fila

idwfiltro = Message.PowerObjectParm



IF dw_filtro.GetChild('columna', idwc_Columnas) = -1 THEN MessageBox(  "Error", "Not a DataWindowChild")
IF dw_filtro.GetChild('valor', idwc_Valor) = -1 THEN MessageBox(  "Error", "Not a DataWindowChild")
		  
int li_numcols

li_numcols = idwfiltro.of_columnstag(idwfiltro, is_columns ,  is_columnstag,"column","*", true)

For li_numcols = 1 to upperbound(is_columns)
	ll_fila = idwc_Columnas.InsertRow(0)
	idwc_Columnas.SetItem(ll_fila ,"nombrecolumna" , is_columns[li_numcols])
	idwc_Columnas.SetItem(ll_fila ,"mostrarcolumna" , is_columnstag[li_numcols])
Next


end event

type mle_filtrooriginal from multilineedit within w_util_filtro
integer x = 59
integer y = 64
integer width = 2350
integer height = 180
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
boolean border = false
boolean vscrollbar = true
boolean autovscroll = true
boolean displayonly = true
end type

type cb_4 from commandbutton within w_util_filtro
integer x = 1641
integer y = 936
integer width = 375
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "none"
end type

type cb_3 from commandbutton within w_util_filtro
integer x = 1266
integer y = 936
integer width = 375
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "none"
end type

type cb_2 from commandbutton within w_util_filtro
integer x = 2034
integer y = 552
integer width = 375
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Borrar"
end type

event clicked;Integer	li_row

dw_filtro.DeleteRow(dw_filtro.GetRow())

// Make sure there is at least one row in the datawindow.
IF dw_filtro.RowCount() =0 THEN 
	li_row = dw_filtro.InsertRow(0)
	If li_row > 0 Then
		dw_filtro.SetRow (li_row)
		dw_filtro.ScrollToRow (li_row)
		dw_filtro.SetColumn(1)
	End If
End If

dw_filtro.SetColumn(1)
SetFocus (dw_filtro)
end event

type cb_1 from commandbutton within w_util_filtro
integer x = 2034
integer y = 452
integer width = 375
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Agregar"
end type

event clicked;Integer	li_row

li_row = dw_filtro.InsertRow(0)
If li_row > 0 Then
	dw_filtro.SetRow (li_row)
	dw_filtro.ScrollToRow (li_row)
	dw_filtro.SetColumn(1)
End If
SetFocus (dw_filtro)
end event

type dw_filtro from datawindow within w_util_filtro
integer x = 59
integer y = 388
integer width = 1952
integer height = 500
integer taborder = 10
string dataobject = "d_util_filtro"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type gb_filtrooriginal from groupbox within w_util_filtro
integer x = 14
integer y = 4
integer width = 2432
integer height = 276
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Criterio Original de Filtro "
end type

type gb_filtronuevo from groupbox within w_util_filtro
integer x = 14
integer y = 340
integer width = 2432
integer height = 568
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Nuevo Criterio de Filtro"
end type

