HA$PBExportHeader$w_prueba_resize.srw
$PBExportComments$Custom MDI frame with DW button bar user object
forward
global type w_prueba_resize from w_class
end type
type cb_10 from commandbutton within w_prueba_resize
end type
type cb_9 from commandbutton within w_prueba_resize
end type
type cb_8 from commandbutton within w_prueba_resize
end type
type cb_7 from commandbutton within w_prueba_resize
end type
type cb_6 from commandbutton within w_prueba_resize
end type
type cb_5 from commandbutton within w_prueba_resize
end type
type cb_4 from commandbutton within w_prueba_resize
end type
type cb_3 from commandbutton within w_prueba_resize
end type
type cb_2 from commandbutton within w_prueba_resize
end type
type cb_1 from commandbutton within w_prueba_resize
end type
end forward

global type w_prueba_resize from w_class
integer width = 1966
integer height = 2508
boolean resizable = true
cb_10 cb_10
cb_9 cb_9
cb_8 cb_8
cb_7 cb_7
cb_6 cb_6
cb_5 cb_5
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
end type
global w_prueba_resize w_prueba_resize

forward prototypes
public function integer wf_centrar (commandbutton as_any, string as_point)
end prototypes

public function integer wf_centrar (commandbutton as_any, string as_point);int li_screenheight, li_screenwidth, li_rc, li_x=1, li_y=1 ,li_xx,li_yy
environment	lenv_obj
window vent
If IsNull ( this ) Or Not IsValid ( this ) Then Return -1

If GetEnvironment ( lenv_obj ) = -1 Then Return -1
vent = this
//li_screenheight = PixelsToUnits ( lenv_obj.ScreenHeight, YPixelsToUnits! )
//li_screenwidth  = PixelsToUnits ( lenv_obj.ScreenWidth, XPixelsToUnits! )
li_screenheight = vent.Height
li_screenwidth  = vent.Width
If Not ( li_screenheight > 0 ) Or Not ( li_screenwidth > 0 ) Then Return -1
li_xx = as_any.x
li_yy = as_any.y
If li_screenwidth > as_any.Width Then
	li_x = ( li_screenwidth/ 2 ) - ( as_any.Width / 2 )
End If
If li_screenheight > as_any.Height Then
	li_y = ( (li_screenheight - 400)/ 2 ) - ( as_any.Height / 2 )
End If

If as_point = "XY" or as_point = "YX" then
	li_rc = as_any.Move ( li_x, li_y )
ElseIf as_point="X" then
	li_rc = as_any.Move ( li_x, li_yy )
ElseIf as_point="Y" then
	li_rc = as_any.Move ( li_xx, li_y )
ElseIf as_point="X0" or as_point="0X" then
	li_rc = as_any.Move ( li_x, 0 )
ElseIf as_point="Y0" or as_point="0Y" then
	li_rc = as_any.Move ( 0, li_y )
Else
	li_rc = 1
End IF


If li_rc <> 1 Then Return -1

Return 1
end function

on w_prueba_resize.create
int iCurrent
call super::create
this.cb_10=create cb_10
this.cb_9=create cb_9
this.cb_8=create cb_8
this.cb_7=create cb_7
this.cb_6=create cb_6
this.cb_5=create cb_5
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_10
this.Control[iCurrent+2]=this.cb_9
this.Control[iCurrent+3]=this.cb_8
this.Control[iCurrent+4]=this.cb_7
this.Control[iCurrent+5]=this.cb_6
this.Control[iCurrent+6]=this.cb_5
this.Control[iCurrent+7]=this.cb_4
this.Control[iCurrent+8]=this.cb_3
this.Control[iCurrent+9]=this.cb_2
this.Control[iCurrent+10]=this.cb_1
end on

on w_prueba_resize.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_10)
destroy(this.cb_9)
destroy(this.cb_8)
destroy(this.cb_7)
destroy(this.cb_6)
destroy(this.cb_5)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
end on

event open;call super::open;wf_resize(true)

inv_resize.of_Register(cb_1, inv_resize.FIXEDRIGHT )
inv_resize.of_Register(cb_2, inv_resize.FIXEDBOTTOM )
inv_resize.of_Register(cb_3, inv_resize.FIXEDRIGHTBOTTOM )
inv_resize.of_Register(cb_4, inv_resize.SCALE )
inv_resize.of_Register(cb_5, inv_resize.SCALERIGHT )
inv_resize.of_Register(cb_6, inv_resize.SCALEBOTTOM )
inv_resize.of_Register(cb_7, inv_resize.SCALERIGHTBOTTOM )
inv_resize.of_Register(cb_8, inv_resize.FIXEDRIGHT_SCALEBOTTOM ) 
inv_resize.of_Register(cb_9, inv_resize.FIXEDBOTTOM_SCALERIGHT )
wf_centrar( cb_10,"X")
end event

event resize;call super::resize;wf_centrar( cb_10,"X")
end event

type cb_10 from commandbutton within w_prueba_resize
integer x = 247
integer y = 1744
integer width = 782
integer height = 112
integer taborder = 90
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Centro"
end type

type cb_9 from commandbutton within w_prueba_resize
integer x = 247
integer y = 1556
integer width = 782
integer height = 112
integer taborder = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "none"
end type

type cb_8 from commandbutton within w_prueba_resize
integer x = 247
integer y = 1404
integer width = 782
integer height = 112
integer taborder = 70
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "none"
end type

type cb_7 from commandbutton within w_prueba_resize
integer x = 247
integer y = 1268
integer width = 782
integer height = 112
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "none"
end type

type cb_6 from commandbutton within w_prueba_resize
integer x = 247
integer y = 1084
integer width = 782
integer height = 112
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "none"
end type

type cb_5 from commandbutton within w_prueba_resize
integer x = 247
integer y = 900
integer width = 782
integer height = 112
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "none"
end type

type cb_4 from commandbutton within w_prueba_resize
integer x = 247
integer y = 732
integer width = 782
integer height = 112
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "none"
end type

type cb_3 from commandbutton within w_prueba_resize
integer x = 247
integer y = 512
integer width = 782
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "none"
end type

type cb_2 from commandbutton within w_prueba_resize
integer x = 247
integer y = 344
integer width = 782
integer height = 112
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "none"
end type

type cb_1 from commandbutton within w_prueba_resize
integer x = 247
integer y = 172
integer width = 782
integer height = 112
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "none"
end type

