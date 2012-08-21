HA$PBExportHeader$w_pruebacode.srw
forward
global type w_pruebacode from window
end type
type sle_2 from singlelineedit within w_pruebacode
end type
type sle_1 from singlelineedit within w_pruebacode
end type
type cb_1 from commandbutton within w_pruebacode
end type
type st_5 from statictext within w_pruebacode
end type
type st_4 from statictext within w_pruebacode
end type
type st_3 from statictext within w_pruebacode
end type
type st_2 from statictext within w_pruebacode
end type
type st_1 from statictext within w_pruebacode
end type
end forward

global type w_pruebacode from window
integer width = 1979
integer height = 1428
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
sle_2 sle_2
sle_1 sle_1
cb_1 cb_1
st_5 st_5
st_4 st_4
st_3 st_3
st_2 st_2
st_1 st_1
end type
global w_pruebacode w_pruebacode

event open;String Valor
Valor = "12345678"
st_1.text = uf_bar_to_ean13(valor)
st_2.text = uf_bar_show_ean13(valor)
st_3.text = uf_bar_conver__ean13(uf_bar_ean13(valor))
st_4.text = uf_bar_conver_ean13(uf_bar_ean13(valor)) //  traduce el ean13 a Fuentes
st_5.text = uf_bar_ean13(valor) // devuelve cualquier  el valor <= convertido a ean13
end event

on w_pruebacode.create
this.sle_2=create sle_2
this.sle_1=create sle_1
this.cb_1=create cb_1
this.st_5=create st_5
this.st_4=create st_4
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.Control[]={this.sle_2,&
this.sle_1,&
this.cb_1,&
this.st_5,&
this.st_4,&
this.st_3,&
this.st_2,&
this.st_1}
end on

on w_pruebacode.destroy
destroy(this.sle_2)
destroy(this.sle_1)
destroy(this.cb_1)
destroy(this.st_5)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
end on

type sle_2 from singlelineedit within w_pruebacode
integer y = 1188
integer width = 1504
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
string text = "none"
borderstyle borderstyle = stylelowered!
end type

type sle_1 from singlelineedit within w_pruebacode
integer y = 1024
integer width = 1509
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
string text = "none"
borderstyle borderstyle = stylelowered!
end type

type cb_1 from commandbutton within w_pruebacode
integer x = 439
integer y = 872
integer width = 457
integer height = 112
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "none"
end type

event clicked;sle_2.text = String(uf_bar_code_128(sle_1.text))
end event

type st_5 from statictext within w_pruebacode
integer x = 82
integer y = 712
integer width = 763
integer height = 124
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "none"
boolean border = true
boolean focusrectangle = false
end type

type st_4 from statictext within w_pruebacode
integer x = 901
integer y = 328
integer width = 997
integer height = 280
integer textsize = -20
integer weight = 400
fontcharset fontcharset = symbol!
fontpitch fontpitch = variable!
fontfamily fontfamily = decorative!
string facename = "LamEan13Large_CodeBar"
long textcolor = 33554432
long backcolor = 67108864
string text = "none"
boolean border = true
boolean focusrectangle = false
end type

type st_3 from statictext within w_pruebacode
integer x = 896
integer y = 52
integer width = 992
integer height = 240
integer textsize = -20
integer weight = 400
fontcharset fontcharset = symbol!
fontpitch fontpitch = variable!
fontfamily fontfamily = decorative!
string facename = "LamEan13CodeBar"
long textcolor = 33554432
long backcolor = 67108864
string text = "none"
boolean border = true
boolean focusrectangle = false
end type

type st_2 from statictext within w_pruebacode
integer x = 82
integer y = 220
integer width = 763
integer height = 352
integer textsize = -20
integer weight = 400
fontcharset fontcharset = symbol!
fontpitch fontpitch = variable!
fontfamily fontfamily = decorative!
string facename = "LamEan13Large_CodeBar"
long textcolor = 33554432
long backcolor = 67108864
string text = "none"
boolean border = true
boolean focusrectangle = false
end type

type st_1 from statictext within w_pruebacode
integer x = 82
integer y = 36
integer width = 763
integer height = 180
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
string text = "none"
boolean border = true
boolean focusrectangle = false
end type

