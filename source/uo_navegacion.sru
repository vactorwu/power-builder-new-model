HA$PBExportHeader$uo_navegacion.sru
forward
global type uo_navegacion from userobject
end type
type pb_primero from u_pb within uo_navegacion
end type
type pb_anterior from u_pb within uo_navegacion
end type
type pb_siguiente from u_pb within uo_navegacion
end type
type pb_final from u_pb within uo_navegacion
end type
type sle_record from u_sle within uo_navegacion
end type
end forward

global type uo_navegacion from userobject
integer width = 1467
integer height = 152
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event ue_showboton ( )
event ue_inicio ( )
event ue_anterior ( )
event ue_siguiente ( )
event ue_final ( )
pb_primero pb_primero
pb_anterior pb_anterior
pb_siguiente pb_siguiente
pb_final pb_final
sle_record sle_record
end type
global uo_navegacion uo_navegacion

type variables
u_dw dwnav
end variables

forward prototypes
public subroutine uf_dw (u_dw a_dw)
end prototypes

event ue_showboton();IF IsValid(dwnav) Then
	if dwnav.rowcount( ) > 0 then
		this.sle_record.text = "Registro: "+String(dwnav.getrow())+" de "+String(dwnav.rowcount())
	Else
		this.sle_record.text = "Registro: 0 de 0"
	End If
End If


end event

event ue_inicio();parent.triggerevent('ue_tofirst')
This.triggerevent('ue_showboton')

end event

event ue_anterior();parent.triggerevent('ue_toprior')
This.triggerevent('ue_showboton')

end event

event ue_siguiente();parent.triggerevent('ue_tonext')
This.triggerevent('ue_showboton')


end event

event ue_final();parent.triggerevent('ue_tolast')
This.triggerevent('ue_showboton')

end event

public subroutine uf_dw (u_dw a_dw);dwnav=a_dw
end subroutine

on uo_navegacion.create
this.pb_primero=create pb_primero
this.pb_anterior=create pb_anterior
this.pb_siguiente=create pb_siguiente
this.pb_final=create pb_final
this.sle_record=create sle_record
this.Control[]={this.pb_primero,&
this.pb_anterior,&
this.pb_siguiente,&
this.pb_final,&
this.sle_record}
end on

on uo_navegacion.destroy
destroy(this.pb_primero)
destroy(this.pb_anterior)
destroy(this.pb_siguiente)
destroy(this.pb_final)
destroy(this.sle_record)
end on

type pb_primero from u_pb within uo_navegacion
integer width = 174
integer height = 152
integer taborder = 10
string text = ""
string picturename = "Imagenes\Gif32\M4.gif"
end type

event clicked;call super::clicked;parent.triggerevent('ue_inicio')


end event

type pb_anterior from u_pb within uo_navegacion
integer x = 174
integer width = 174
integer height = 152
integer taborder = 10
string text = ""
string picturename = "Imagenes\Gif32\M2.gif"
end type

event clicked;call super::clicked;parent.triggerevent('ue_anterior')
end event

type pb_siguiente from u_pb within uo_navegacion
integer x = 1125
integer width = 174
integer height = 152
integer taborder = 10
string text = ""
boolean originalsize = false
string picturename = "Imagenes\Gif32\M1.gif"
end type

event clicked;call super::clicked;parent.triggerevent('ue_siguiente')
end event

type pb_final from u_pb within uo_navegacion
integer x = 1298
integer width = 174
integer height = 152
integer taborder = 10
string text = ""
string picturename = "Imagenes\Gif32\M3.gif"
end type

event clicked;call super::clicked;parent.triggerevent('ue_final')
end event

type sle_record from u_sle within uo_navegacion
integer x = 347
integer y = 40
integer width = 777
integer height = 72
integer textsize = -9
string facename = "Tahoma"
string text = "Registro: "
boolean displayonly = true
end type

