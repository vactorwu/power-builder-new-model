HA$PBExportHeader$w_barras.srw
$PBExportComments$Generated MDI Toolbar Configuration
forward
global type w_barras from window
end type
type cbx_showmenu from checkbox within w_barras
end type
type rb_floating from radiobutton within w_barras
end type
type rb_bottom from radiobutton within w_barras
end type
type rb_right from radiobutton within w_barras
end type
type rb_top from radiobutton within w_barras
end type
type rb_left from radiobutton within w_barras
end type
type cb_done from commandbutton within w_barras
end type
type cbx_showtips from checkbox within w_barras
end type
type cbx_showtext from checkbox within w_barras
end type
type gb_options from groupbox within w_barras
end type
end forward

global type w_barras from window
string tag = "Configure la Barra de Herramientas"
integer x = 850
integer y = 468
integer width = 832
integer height = 944
boolean titlebar = true
string title = "Barra de Herramientas"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 79416533
string icon = "Menu5!"
boolean center = true
cbx_showmenu cbx_showmenu
rb_floating rb_floating
rb_bottom rb_bottom
rb_right rb_right
rb_top rb_top
rb_left rb_left
cb_done cb_done
cbx_showtips cbx_showtips
cbx_showtext cbx_showtext
gb_options gb_options
end type
global w_barras w_barras

type variables
/*  Parent window reference */
window		iw_window
end variables

event open;//*-----------------------------------------------------------------*/
//*    open:  Initialize display
//*-----------------------------------------------------------------*/

/*  Parent window is passed as reference  */
iw_window = message.powerobjectparm

/*  Set toolbar alignment status  */
Choose Case iw_window.ToolbarAlignment
		
	Case AlignAtBottom! 
		rb_bottom.Checked = True
		
	Case AlignAtLeft!
		rb_left.Checked = True
		
	Case AlignAtRight! 
		rb_right.Checked = True
		
	Case AlignAtTop! 
		rb_top.Checked = True
		
	Case Floating!
		rb_floating.Checked = True
		
End Choose

/*  Set toolbar visible status  */
If iw_window.ToolbarVisible Then
	cbx_showmenu.Checked = True
Else
	cbx_showmenu.Checked = False
End If

/*  Set toolbar text mode status  */
cbx_showtext.Checked = GetApplication ( ).ToolbarText 

/*  Set toolbar tips mode status  */
cbx_showtips.Checked = GetApplication ( ).ToolbarTips 
end event

on w_barras.create
this.cbx_showmenu=create cbx_showmenu
this.rb_floating=create rb_floating
this.rb_bottom=create rb_bottom
this.rb_right=create rb_right
this.rb_top=create rb_top
this.rb_left=create rb_left
this.cb_done=create cb_done
this.cbx_showtips=create cbx_showtips
this.cbx_showtext=create cbx_showtext
this.gb_options=create gb_options
this.Control[]={this.cbx_showmenu,&
this.rb_floating,&
this.rb_bottom,&
this.rb_right,&
this.rb_top,&
this.rb_left,&
this.cb_done,&
this.cbx_showtips,&
this.cbx_showtext,&
this.gb_options}
end on

on w_barras.destroy
destroy(this.cbx_showmenu)
destroy(this.rb_floating)
destroy(this.rb_bottom)
destroy(this.rb_right)
destroy(this.rb_top)
destroy(this.rb_left)
destroy(this.cb_done)
destroy(this.cbx_showtips)
destroy(this.cbx_showtext)
destroy(this.gb_options)
end on

type cbx_showmenu from checkbox within w_barras
integer x = 169
integer y = 496
integer width = 457
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 79416533
string text = "Mostrar &Menu"
end type

event clicked;//*-----------------------------------------------------------------*/
//*    clicked:  Indicate opposite toolbar visible status
//*-----------------------------------------------------------------*/
If this.Checked Then
	iw_window.ToolbarVisible = True
Else
	iw_window.ToolbarVisible = False
End If
end event

type rb_floating from radiobutton within w_barras
integer x = 169
integer y = 420
integer width = 402
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 79416533
string text = "&Flotando"
end type

event clicked;//*-----------------------------------------------------------------*/
//*    clicked:  Make toolbar floating
//*-----------------------------------------------------------------*/
iw_window.ToolbarAlignment = Floating!
end event

type rb_bottom from radiobutton within w_barras
integer x = 169
integer y = 184
integer width = 402
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 79416533
string text = "A&bajo"
end type

event clicked;//*-----------------------------------------------------------------*/
//*    clicked:  Align toolbar at bottom
//*-----------------------------------------------------------------*/
iw_window.ToolbarAlignment = AlignAtBottom!
end event

type rb_right from radiobutton within w_barras
integer x = 169
integer y = 264
integer width = 402
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 79416533
string text = "&Derecha"
end type

event clicked;//*-----------------------------------------------------------------*/
//*    clicked:  Align toolbar at right
//*-----------------------------------------------------------------*/
iw_window.ToolbarAlignment = AlignAtRight!
end event

type rb_top from radiobutton within w_barras
integer x = 169
integer y = 100
integer width = 402
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 79416533
string text = "&Arriba"
end type

event clicked;//*-----------------------------------------------------------------*/
//*    clicked:  Align toolbar on top
//*-----------------------------------------------------------------*/
iw_window.ToolbarAlignment = AlignAtTop!
end event

type rb_left from radiobutton within w_barras
integer x = 169
integer y = 344
integer width = 402
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 79416533
string text = "&Izquierda"
end type

event clicked;//*-----------------------------------------------------------------*/
//*    clicked:  Align toolbar on left
//*-----------------------------------------------------------------*/
iw_window.ToolbarAlignment = AlignAtLeft!
end event

type cb_done from commandbutton within w_barras
integer x = 238
integer y = 748
integer width = 334
integer height = 88
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Aceptar"
end type

event clicked;//*-----------------------------------------------------------------*/
//*    clicked:  Close "Toolbar" Window
//*-----------------------------------------------------------------*/
Close ( Parent )
end event

type cbx_showtips from checkbox within w_barras
integer x = 169
integer y = 652
integer width = 498
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 79416533
string text = "Mostrar &PowerTips"
end type

event clicked;//*-----------------------------------------------------------------*/
//*    clicked:  Set toolbar tips mode
//*-----------------------------------------------------------------*/
GetApplication ( ).ToolbarTips = this.Checked 
end event

type cbx_showtext from checkbox within w_barras
integer x = 169
integer y = 576
integer width = 457
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 79416533
string text = "Mostrar Te&xto"
end type

event clicked;//*-----------------------------------------------------------------*/
//*    clicked:  Set toolbar text mode
//*-----------------------------------------------------------------*/
GetApplication ( ).ToolbarText = this.Checked 
end event

type gb_options from groupbox within w_barras
integer x = 96
integer y = 24
integer width = 626
integer height = 712
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 79416533
string text = "Mover Menu "
end type

