HA$PBExportHeader$w_reporte.srw
forward
global type w_reporte from window
end type
type pb_mail from picturebutton within w_reporte
end type
type pb_1 from picturebutton within w_reporte
end type
type pb_saveas from picturebutton within w_reporte
end type
type pb_actualizar from picturebutton within w_reporte
end type
type pb_ordenar from picturebutton within w_reporte
end type
type pb_filtrar from picturebutton within w_reporte
end type
type pb_final from picturebutton within w_reporte
end type
type pb_siguiente from picturebutton within w_reporte
end type
type pb_anterior from picturebutton within w_reporte
end type
type pb_inicio from picturebutton within w_reporte
end type
type pb_print from picturebutton within w_reporte
end type
type pb_scala from picturebutton within w_reporte
end type
type pb_zoom from picturebutton within w_reporte
end type
type dw_reporte from datawindow within w_reporte
end type
end forward

global type w_reporte from window
integer width = 3433
integer height = 2040
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
pb_mail pb_mail
pb_1 pb_1
pb_saveas pb_saveas
pb_actualizar pb_actualizar
pb_ordenar pb_ordenar
pb_filtrar pb_filtrar
pb_final pb_final
pb_siguiente pb_siguiente
pb_anterior pb_anterior
pb_inicio pb_inicio
pb_print pb_print
pb_scala pb_scala
pb_zoom pb_zoom
dw_reporte dw_reporte
end type
global w_reporte w_reporte

type variables
Boolean ib_regla
end variables

forward prototypes
public subroutine wf_retrieve ()
end prototypes

public subroutine wf_retrieve ();//
//
end subroutine

on w_reporte.create
this.pb_mail=create pb_mail
this.pb_1=create pb_1
this.pb_saveas=create pb_saveas
this.pb_actualizar=create pb_actualizar
this.pb_ordenar=create pb_ordenar
this.pb_filtrar=create pb_filtrar
this.pb_final=create pb_final
this.pb_siguiente=create pb_siguiente
this.pb_anterior=create pb_anterior
this.pb_inicio=create pb_inicio
this.pb_print=create pb_print
this.pb_scala=create pb_scala
this.pb_zoom=create pb_zoom
this.dw_reporte=create dw_reporte
this.Control[]={this.pb_mail,&
this.pb_1,&
this.pb_saveas,&
this.pb_actualizar,&
this.pb_ordenar,&
this.pb_filtrar,&
this.pb_final,&
this.pb_siguiente,&
this.pb_anterior,&
this.pb_inicio,&
this.pb_print,&
this.pb_scala,&
this.pb_zoom,&
this.dw_reporte}
end on

on w_reporte.destroy
destroy(this.pb_mail)
destroy(this.pb_1)
destroy(this.pb_saveas)
destroy(this.pb_actualizar)
destroy(this.pb_ordenar)
destroy(this.pb_filtrar)
destroy(this.pb_final)
destroy(this.pb_siguiente)
destroy(this.pb_anterior)
destroy(this.pb_inicio)
destroy(this.pb_print)
destroy(this.pb_scala)
destroy(this.pb_zoom)
destroy(this.dw_reporte)
end on

type pb_mail from picturebutton within w_reporte
boolean visible = false
integer x = 1445
integer width = 101
integer height = 88
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "Custom025!"
alignment htextalign = left!
end type

event clicked;openwithparm(w_mail,dw_reporte)
end event

type pb_1 from picturebutton within w_reporte
integer x = 219
integer y = 4
integer width = 101
integer height = 88
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "Custom041!"
alignment htextalign = left!
end type

event clicked;If ib_regla then
	dw_reporte.Object.DataWindow.Print.Preview.Rulers = 'No'
	ib_regla =  false
Else
	dw_reporte.Object.DataWindow.Print.Preview.Rulers = 'Yes'
	ib_regla =  True
End If
end event

type pb_saveas from picturebutton within w_reporte
string tag = "Guardar Como ...?"
integer x = 1170
integer y = 4
integer width = 101
integer height = 88
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "SaveAs!"
alignment htextalign = left!
string powertiptext = "Guardar Como ...?"
end type

event clicked;dw_reporte.saveas( )

end event

type pb_actualizar from picturebutton within w_reporte
string tag = "Actualizar"
integer x = 1019
integer y = 4
integer width = 101
integer height = 88
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "Retrieve5!"
alignment htextalign = left!
string powertiptext = "Actualizar"
end type

event clicked;wf_retrieve( )
end event

type pb_ordenar from picturebutton within w_reporte
string tag = "Ordenar"
integer x = 919
integer y = 4
integer width = 101
integer height = 88
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "Sort!"
alignment htextalign = left!
string powertiptext = "Ordenar"
end type

event clicked;String nulo
SetNull(nulo)
dw_reporte.SetRedraw(false)
dw_reporte.SetSort(Nulo)
dw_reporte.Sort()
dw_reporte.SetRedraw(true)


end event

type pb_filtrar from picturebutton within w_reporte
string tag = "Filtrar"
integer x = 818
integer y = 4
integer width = 101
integer height = 88
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "DefaultFonts!"
alignment htextalign = left!
string powertiptext = "Filtrar"
end type

event clicked;String nulo
SetNull(nulo)
dw_reporte.SetRedraw(false)
dw_reporte.setFilter(Nulo)
dw_reporte.Filter()
dw_reporte.SetRedraw(true)
end event

type pb_final from picturebutton within w_reporte
string tag = "P$$HEX1$$e100$$ENDHEX$$gina Final"
integer x = 667
integer y = 4
integer width = 101
integer height = 88
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "Custom035!"
alignment htextalign = left!
string powertiptext = "P$$HEX1$$e100$$ENDHEX$$gina Final"
end type

event clicked;dw_reporte.scrolltorow(dw_reporte.rowcount() )
end event

type pb_siguiente from picturebutton within w_reporte
string tag = "P$$HEX1$$e100$$ENDHEX$$gina Siguiente"
integer x = 571
integer y = 4
integer width = 101
integer height = 88
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "Custom034!"
alignment htextalign = left!
string powertiptext = "P$$HEX1$$e100$$ENDHEX$$gina Siguiente"
end type

event clicked;dw_reporte.scrollnextpage( )

end event

type pb_anterior from picturebutton within w_reporte
string tag = "P$$HEX1$$e100$$ENDHEX$$gina Anterior"
integer x = 475
integer y = 4
integer width = 101
integer height = 88
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "Custom033!"
alignment htextalign = left!
string powertiptext = "P$$HEX1$$e100$$ENDHEX$$gina Anterior"
end type

event clicked;dw_reporte.scrollpriorpage( )
end event

type pb_inicio from picturebutton within w_reporte
string tag = "P$$HEX1$$e100$$ENDHEX$$gina Primera"
integer x = 375
integer y = 4
integer width = 101
integer height = 88
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "Custom036!"
alignment htextalign = left!
string powertiptext = "P$$HEX1$$e100$$ENDHEX$$gina Primera"
end type

event clicked;dw_reporte.scrolltorow(1)
end event

type pb_print from picturebutton within w_reporte
string tag = "Imprimir"
integer x = 1307
integer y = 4
integer width = 101
integer height = 88
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "Print!"
alignment htextalign = left!
string powertiptext = "Imprimir"
end type

event clicked;datawindow ldw_impimir
ldw_impimir = parent.dw_reporte
OpenWithParm(w_print, ldw_impimir)
If Message.DoubleParm	 = 1 then
	dw_reporte.print()
End If

end event

type pb_scala from picturebutton within w_reporte
string tag = "Escala (Tama$$HEX1$$f100$$ENDHEX$$o de Impresi$$HEX1$$f300$$ENDHEX$$n)"
integer x = 23
integer y = 4
integer width = 101
integer height = 88
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "Search!"
alignment htextalign = left!
string powertiptext = "Escala (Tama$$HEX1$$f100$$ENDHEX$$o de Impresi$$HEX1$$f300$$ENDHEX$$n)"
end type

event clicked;datawindow ldw_impimir
ldw_impimir = parent.dw_reporte
OpenWithParm(w_print_scale , ldw_impimir)
end event

type pb_zoom from picturebutton within w_reporte
string tag = "Zoom (Tama$$HEX1$$f100$$ENDHEX$$o de Visualizaci$$HEX1$$f300$$ENDHEX$$n)"
integer x = 119
integer y = 4
integer width = 101
integer height = 88
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "Preview!"
alignment htextalign = left!
string powertiptext = "Zoom (Tama$$HEX1$$f100$$ENDHEX$$o de Visualizaci$$HEX1$$f300$$ENDHEX$$n)"
end type

event clicked;datawindow ldw_impimir
ldw_impimir = parent.dw_reporte
OpenWithParm(w_print_zoom , ldw_impimir)

end event

type dw_reporte from datawindow within w_reporte
integer x = 5
integer y = 120
integer width = 3378
integer height = 1764
integer taborder = 10
string title = "none"
string dataobject = "d_accesos2"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(SQLCA)
this.Object.DataWindow.Print.Preview = 'Yes'
this.Object.DataWindow.Print.Preview.zoom = 90
wf_retrieve( )
end event

