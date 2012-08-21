HA$PBExportHeader$w_prueba.srw
$PBExportComments$Custom MDI frame with DW button bar user object
forward
global type w_prueba from window
end type
type mdi_1 from mdiclient within w_prueba
end type
type pb_1 from picturebutton within w_prueba
end type
type cb_1 from commandbutton within w_prueba
end type
end forward

global type w_prueba from window
integer width = 1979
integer height = 1468
boolean titlebar = true
string title = "Untitled"
string menuname = "m_tppsoftbase"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowtype windowtype = mdihelp!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
mdi_1 mdi_1
pb_1 pb_1
cb_1 cb_1
end type
global w_prueba w_prueba

on w_prueba.create
if this.MenuName = "m_tppsoftbase" then this.MenuID = create m_tppsoftbase
this.mdi_1=create mdi_1
this.pb_1=create pb_1
this.cb_1=create cb_1
this.Control[]={this.mdi_1,&
this.pb_1,&
this.cb_1}
end on

on w_prueba.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.mdi_1)
destroy(this.pb_1)
destroy(this.cb_1)
end on

event resize;int	nX, nY, nWidth, nHeight

nX = WorkSpaceX (this)
nY = WorkSpaceY (this)

nWidth  = this.WorkSpaceWidth( ) //ancho
nHeight = this.WorkSpaceHeight( )// alto

nWidth = nWidth - (cb_1.y + cb_1.height)
nWidth = nWidth - mdi_1.MicroHelpHeight

mdi_1.Move (cb_1.Width,0)
mdi_1.Resize (nWidth, nHeight )

end event

type mdi_1 from mdiclient within w_prueba
long BackColor=268435456
end type

type pb_1 from picturebutton within w_prueba
integer y = 264
integer width = 101
integer height = 88
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "ApplicationIcon!"
alignment htextalign = left!
end type

type cb_1 from commandbutton within w_prueba
integer y = 108
integer width = 402
integer height = 112
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "a"
end type

