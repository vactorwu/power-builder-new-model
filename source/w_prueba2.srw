HA$PBExportHeader$w_prueba2.srw
$PBExportComments$Custom MDI frame with DW button bar user object
forward
global type w_prueba2 from window
end type
type cb_1 from commandbutton within w_prueba2
end type
type dw_1 from datawindow within w_prueba2
end type
end forward

global type w_prueba2 from window
integer width = 2519
integer height = 1596
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_1 cb_1
dw_1 dw_1
end type
global w_prueba2 w_prueba2

on w_prueba2.create
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.cb_1,&
this.dw_1}
end on

on w_prueba2.destroy
destroy(this.cb_1)
destroy(this.dw_1)
end on

type cb_1 from commandbutton within w_prueba2
integer x = 1911
integer y = 180
integer width = 402
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

event clicked;dw_1.settransobject( SQLCA )
dw_1.retrieve(12-05-1980)
messagebox("","1")

dw_1.retrieve(1980-05-12)
messagebox("","2")

dw_1.retrieve("12/05/1980")
messagebox("","3")

dw_1.retrieve(12/05/1980)
messagebox("","4")

dw_1.retrieve('12/05/1980')
messagebox("","5")

dw_1.retrieve(date('12/05/1980'))
messagebox("","6")

dw_1.retrieve(datetime('12/05/1980'))
messagebox("","7")
end event

type dw_1 from datawindow within w_prueba2
integer x = 55
integer y = 144
integer width = 1714
integer height = 1112
integer taborder = 10
string title = "none"
string dataobject = "dw_pru"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject( SQLCA )
end event

