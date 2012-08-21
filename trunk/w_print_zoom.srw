HA$PBExportHeader$w_print_zoom.srw
$PBExportComments$ventana de zoom del reporte.
forward
global type w_print_zoom from window
end type
type em_custom from editmask within w_print_zoom
end type
type st_percent from statictext within w_print_zoom
end type
type cb_ok from commandbutton within w_print_zoom
end type
type cb_cancel from commandbutton within w_print_zoom
end type
type rb_custom from radiobutton within w_print_zoom
end type
type rb_30 from radiobutton within w_print_zoom
end type
type rb_65 from radiobutton within w_print_zoom
end type
type rb_100 from radiobutton within w_print_zoom
end type
type rb_200 from radiobutton within w_print_zoom
end type
type gb_escalas from groupbox within w_print_zoom
end type
end forward

global type w_print_zoom from window
integer x = 827
integer y = 528
integer width = 1079
integer height = 640
boolean titlebar = true
string title = "Zoom (Tama$$HEX1$$f100$$ENDHEX$$o de Visualizaci$$HEX1$$f300$$ENDHEX$$n)"
windowtype windowtype = response!
long backcolor = 67108864
em_custom em_custom
st_percent st_percent
cb_ok cb_ok
cb_cancel cb_cancel
rb_custom rb_custom
rb_30 rb_30
rb_65 rb_65
rb_100 rb_100
rb_200 rb_200
gb_escalas gb_escalas
end type
global w_print_zoom w_print_zoom

type variables
//int ii_zoom
datawindow idw_dw
end variables

event open;
string ls_temporal

//****************************************************************************************************************************************************************************************
// Parametro.
//****************************************************************************************************************************************************************************************



idw_dw = message.powerobjectparm

//****************************************************************************************************************************************************************************************
// Zoom.
//****************************************************************************************************************************************************************************************

ls_temporal = idw_dw.describe('DataWindow.Print.Preview.Zoom')

//****************************************************************************************************************************************************************************************
// Selecciono.
//****************************************************************************************************************************************************************************************

choose case ls_temporal
  case '200'
    rb_200.checked = true
    rb_200.triggerevent(clicked!)
  case '100'
    rb_100.checked = true
    rb_100.triggerevent(clicked!)
  case '65'
    rb_65.checked = true
    rb_65.triggerevent(clicked!)
  case '30'
    rb_30.checked = true
    rb_30.triggerevent(clicked!)
  case else
    rb_custom.checked = true
    em_custom.text = ls_temporal
end choose
end event

on w_print_zoom.create
this.em_custom=create em_custom
this.st_percent=create st_percent
this.cb_ok=create cb_ok
this.cb_cancel=create cb_cancel
this.rb_custom=create rb_custom
this.rb_30=create rb_30
this.rb_65=create rb_65
this.rb_100=create rb_100
this.rb_200=create rb_200
this.gb_escalas=create gb_escalas
this.Control[]={this.em_custom,&
this.st_percent,&
this.cb_ok,&
this.cb_cancel,&
this.rb_custom,&
this.rb_30,&
this.rb_65,&
this.rb_100,&
this.rb_200,&
this.gb_escalas}
end on

on w_print_zoom.destroy
destroy(this.em_custom)
destroy(this.st_percent)
destroy(this.cb_ok)
destroy(this.cb_cancel)
destroy(this.rb_custom)
destroy(this.rb_30)
destroy(this.rb_65)
destroy(this.rb_100)
destroy(this.rb_200)
destroy(this.gb_escalas)
end on

type em_custom from editmask within w_print_zoom
event spun pbm_enchange
integer x = 379
integer y = 376
integer width = 233
integer height = 76
integer taborder = 30
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 16777215
string text = "50"
borderstyle borderstyle = stylelowered!
string mask = "####"
boolean spin = true
double increment = 5
string minmax = "1~~1000"
end type

on spun;rb_custom.checked = true

end on

type st_percent from statictext within w_print_zoom
integer x = 622
integer y = 388
integer width = 59
integer height = 60
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "%"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_ok from commandbutton within w_print_zoom
integer x = 759
integer y = 68
integer width = 251
integer height = 88
integer taborder = 20
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "OK"
boolean default = true
end type

event clicked;
string ls_temporal

//***************************************************************************************************************************************************************************************
// Propiedad.
//***************************************************************************************************************************************************************************************

ls_temporal = "datawindow.print.preview.zoom=" + em_custom.text

//***************************************************************************************************************************************************************************************
// Puntero.
//***************************************************************************************************************************************************************************************

setpointer(hourglass!)

//***************************************************************************************************************************************************************************************
// Modifico
//***************************************************************************************************************************************************************************************

idw_dw.modify(ls_temporal)
close ( parent )	 
end event

type cb_cancel from commandbutton within w_print_zoom
integer x = 759
integer y = 176
integer width = 251
integer height = 88
integer taborder = 40
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Cancelar"
boolean cancel = true
end type

on clicked;close ( parent)
end on

type rb_custom from radiobutton within w_print_zoom
integer x = 96
integer y = 380
integer width = 338
integer height = 72
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Otro"
boolean checked = true
end type

on clicked;em_custom.setfocus()
end on

type rb_30 from radiobutton within w_print_zoom
integer x = 96
integer y = 312
integer width = 256
integer height = 72
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = " &30 %"
end type

on clicked;em_custom.text = '30'
end on

type rb_65 from radiobutton within w_print_zoom
integer x = 96
integer y = 244
integer width = 256
integer height = 72
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = " &65 %"
end type

on clicked;em_custom.text = '65'
end on

type rb_100 from radiobutton within w_print_zoom
integer x = 96
integer y = 172
integer width = 288
integer height = 72
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "&100 %"
end type

on clicked;em_custom.text = '100'
end on

type rb_200 from radiobutton within w_print_zoom
integer x = 96
integer y = 96
integer width = 274
integer height = 72
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "&200 %"
end type

on clicked;em_custom.text = '200'

end on

type gb_escalas from groupbox within w_print_zoom
integer x = 37
integer y = 24
integer width = 672
integer height = 480
integer taborder = 10
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Zoom"
borderstyle borderstyle = styleraised!
end type

