HA$PBExportHeader$w_prueba1.srw
forward
global type w_prueba1 from window
end type
type st_9 from statictext within w_prueba1
end type
type st_10 from statictext within w_prueba1
end type
type st_8 from statictext within w_prueba1
end type
type st_7 from statictext within w_prueba1
end type
type st_6 from statictext within w_prueba1
end type
type st_5 from statictext within w_prueba1
end type
type st_4 from statictext within w_prueba1
end type
type st_3 from statictext within w_prueba1
end type
type st_2 from statictext within w_prueba1
end type
type st_1 from statictext within w_prueba1
end type
type dw_1 from datawindow within w_prueba1
end type
type uo_cal from uo_calendario within w_prueba1
end type
end forward

global type w_prueba1 from window
integer width = 3333
integer height = 1936
boolean titlebar = true
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 8388608
string icon = "AppIcon!"
boolean center = true
st_9 st_9
st_10 st_10
st_8 st_8
st_7 st_7
st_6 st_6
st_5 st_5
st_4 st_4
st_3 st_3
st_2 st_2
st_1 st_1
dw_1 dw_1
uo_cal uo_cal
end type
global w_prueba1 w_prueba1

on w_prueba1.create
this.st_9=create st_9
this.st_10=create st_10
this.st_8=create st_8
this.st_7=create st_7
this.st_6=create st_6
this.st_5=create st_5
this.st_4=create st_4
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.dw_1=create dw_1
this.uo_cal=create uo_cal
this.Control[]={this.st_9,&
this.st_10,&
this.st_8,&
this.st_7,&
this.st_6,&
this.st_5,&
this.st_4,&
this.st_3,&
this.st_2,&
this.st_1,&
this.dw_1,&
this.uo_cal}
end on

on w_prueba1.destroy
destroy(this.st_9)
destroy(this.st_10)
destroy(this.st_8)
destroy(this.st_7)
destroy(this.st_6)
destroy(this.st_5)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.dw_1)
destroy(this.uo_cal)
end on

type st_9 from statictext within w_prueba1
integer x = 2350
integer y = 232
integer width = 736
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "none"
boolean focusrectangle = false
end type

type st_10 from statictext within w_prueba1
integer x = 2350
integer y = 300
integer width = 736
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "none"
boolean focusrectangle = false
end type

type st_8 from statictext within w_prueba1
integer x = 2350
integer y = 904
integer width = 736
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "none"
boolean focusrectangle = false
end type

type st_7 from statictext within w_prueba1
integer x = 2350
integer y = 836
integer width = 736
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "none"
boolean focusrectangle = false
end type

type st_6 from statictext within w_prueba1
integer x = 2350
integer y = 660
integer width = 736
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "none"
boolean focusrectangle = false
end type

type st_5 from statictext within w_prueba1
integer x = 2350
integer y = 588
integer width = 736
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "none"
boolean focusrectangle = false
end type

type st_4 from statictext within w_prueba1
integer x = 2350
integer y = 508
integer width = 736
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "none"
boolean focusrectangle = false
end type

type st_3 from statictext within w_prueba1
integer x = 2350
integer y = 424
integer width = 736
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "none"
boolean focusrectangle = false
end type

type st_2 from statictext within w_prueba1
integer x = 2350
integer y = 164
integer width = 736
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "none"
boolean focusrectangle = false
end type

type st_1 from statictext within w_prueba1
integer x = 2350
integer y = 96
integer width = 736
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "none"
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_prueba1
integer x = 59
integer y = 84
integer width = 1093
integer height = 1372
integer taborder = 20
string title = "none"
string dataobject = "d_fechatrabajo"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;This.InsertRow(0)
end event

event clicked;Any XX,YY, HH , WW , Protegida , Borde
Integer li_x , li_y

XX =THIS.DESCRIBE(dwo.name+".X")
YY = THIS.DESCRIBE(dwo.name+".Y")
HH = THIS.DESCRIBE(dwo.name+".Height")
WW =  THIS.DESCRIBE(dwo.name+".Width")
Borde = THIS.DESCRIBE(dwo.name+".Border")

st_1.text = "DW.X = " + String(dw_1.x)
st_2.text = "DW.Y = " + String(dw_1.y)
st_9.text = "DW.Height = " + String(dw_1.Height)
st_10.text = "DW.Width = " + String(dw_1.Width)

st_3.text = dwo.name+".X = " + String(XX)
st_4.text = dwo.name+".Y = " + String(YY)
st_5.text =dwo.name+".Height = " + String(HH)
st_6.text =dwo.name+".Width = " + String(WW)

li_x = dw_1.x + Integer(XX)
li_y = dw_1.y + Integer(YY) +  Integer(HH) 
choose case  Integer(Borde)
	case 0
		li_y = li_y + 10	
	case 1
		li_y = li_y + 30	
	case 2
		li_y = li_y + 15	
	case 3
		li_y = li_y + 25
	case 4
		li_y = li_y + 10			
	case 5
		li_y = li_y + 15
end choose

st_7.text ="MoverX = " + String(li_x)
st_8.text ="MoverY = " + String(li_y)

uo_cal.move(li_x,li_y)




end event

type uo_cal from uo_calendario within w_prueba1
integer x = 1234
integer y = 552
integer taborder = 20
end type

on uo_cal.destroy
call uo_calendario::destroy
end on

