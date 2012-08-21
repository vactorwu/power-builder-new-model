HA$PBExportHeader$w_ventana_fondo.srw
forward
global type w_ventana_fondo from window
end type
type p_1 from picture within w_ventana_fondo
end type
end forward

global type w_ventana_fondo from window
integer x = 101
integer y = 100
integer width = 3342
integer height = 1756
boolean enabled = false
windowtype windowtype = child!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
p_1 p_1
end type
global w_ventana_fondo w_ventana_fondo

type variables
int ii_fondo
end variables

on w_ventana_fondo.create
this.p_1=create p_1
this.Control[]={this.p_1}
end on

on w_ventana_fondo.destroy
destroy(this.p_1)
end on

event open;this.title = "Panel Secundario"
end event

type p_1 from picture within w_ventana_fondo
integer width = 3424
integer height = 1512
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

event constructor;p_1.picturename =   gn_config.is_config.logo
end event

