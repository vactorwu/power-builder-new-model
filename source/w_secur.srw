HA$PBExportHeader$w_secur.srw
forward
global type w_secur from w_center
end type
type st_4 from statictext within w_secur
end type
type cb_1 from commandbutton within w_secur
end type
type st_3 from statictext within w_secur
end type
type sle_2 from singlelineedit within w_secur
end type
type sle_1 from singlelineedit within w_secur
end type
type st_2 from statictext within w_secur
end type
type st_1 from statictext within w_secur
end type
type st_5 from statictext within w_secur
end type
end forward

global type w_secur from w_center
integer width = 1399
integer height = 588
boolean titlebar = false
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
long backcolor = 15780518
st_4 st_4
cb_1 cb_1
st_3 st_3
sle_2 sle_2
sle_1 sle_1
st_2 st_2
st_1 st_1
st_5 st_5
end type
global w_secur w_secur

on w_secur.create
int iCurrent
call super::create
this.st_4=create st_4
this.cb_1=create cb_1
this.st_3=create st_3
this.sle_2=create sle_2
this.sle_1=create sle_1
this.st_2=create st_2
this.st_1=create st_1
this.st_5=create st_5
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_4
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.st_3
this.Control[iCurrent+4]=this.sle_2
this.Control[iCurrent+5]=this.sle_1
this.Control[iCurrent+6]=this.st_2
this.Control[iCurrent+7]=this.st_1
this.Control[iCurrent+8]=this.st_5
end on

on w_secur.destroy
call super::destroy
destroy(this.st_4)
destroy(this.cb_1)
destroy(this.st_3)
destroy(this.sle_2)
destroy(this.sle_1)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.st_5)
end on

event open;call super::open;Sle_1.text = Message.StringParm
end event

type st_4 from statictext within w_secur
integer x = 9
integer y = 360
integer width = 521
integer height = 200
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 32768
long backcolor = 15780518
string text = "Para registra su copia llame al 042-521924 indicando su serie y N$$HEX1$$fa00$$ENDHEX$$mero de Factura"
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_secur
integer x = 544
integer y = 364
integer width = 402
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Aceptar"
boolean default = true
end type

event clicked;CloseWithReturn(Parent, sle_2.text)
end event

type st_3 from statictext within w_secur
integer x = 37
integer y = 276
integer width = 402
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 15780518
string text = "Clave"
alignment alignment = center!
boolean focusrectangle = false
end type

type sle_2 from singlelineedit within w_secur
integer x = 443
integer y = 260
integer width = 709
integer height = 100
integer taborder = 10
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
textcase textcase = upper!
borderstyle borderstyle = stylelowered!
end type

event modified;cb_1.triggerevent(clicked!)
end event

type sle_1 from singlelineedit within w_secur
integer x = 443
integer y = 152
integer width = 709
integer height = 100
integer taborder = 10
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

type st_2 from statictext within w_secur
integer x = 32
integer y = 160
integer width = 402
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 15780518
string text = "Serie"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_1 from statictext within w_secur
integer y = 28
integer width = 1399
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 15780518
string text = "Seguridad de Sistema"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_5 from statictext within w_secur
integer x = 594
integer y = 468
integer width = 800
integer height = 116
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 32768
long backcolor = 15780518
string text = "de lo contrario tiene 30 dias para la evaluaci$$HEX1$$f300$$ENDHEX$$n"
boolean focusrectangle = false
end type

