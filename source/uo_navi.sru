HA$PBExportHeader$uo_navi.sru
forward
global type uo_navi from userobject
end type
type pb_primero from u_pb within uo_navi
end type
type pb_anterior from u_pb within uo_navi
end type
type pb_siguiente from u_pb within uo_navi
end type
type pb_final from u_pb within uo_navi
end type
type sle_record from u_sle within uo_navi
end type
end forward

global type uo_navi from userobject
integer width = 1138
integer height = 84
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event ue_showboton ( )
event ue_inicio ( )
event ue_anterior ( )
event ue_siguiente ( )
event ue_final ( )
event ue_possconstr pbm_custom10
pb_primero pb_primero
pb_anterior pb_anterior
pb_siguiente pb_siguiente
pb_final pb_final
sle_record sle_record
end type
global uo_navi uo_navi

type variables
datawindow dwnav
end variables

forward prototypes
public subroutine uf_dw (datawindow a_dw)
end prototypes

event ue_showboton();if dwnav.rowcount( ) > 0 then
	this.sle_record.text = "Registro: "+String(dwnav.getrow())+" de "+String(dwnav.rowcount())
Else
	this.sle_record.text = "Registro: 0 de 0"
End If

end event

event ue_inicio();dwnav.scrolltorow( 1)
This.triggerevent('ue_showboton')

end event

event ue_anterior();dwnav.scrollpriorrow( )
This.triggerevent('ue_showboton')

end event

event ue_siguiente();dwnav.scrollnextrow( )
This.triggerevent('ue_showboton')


end event

event ue_final();dwnav.scrolltorow(dwnav.rowcount())
This.triggerevent('ue_showboton')

end event

event ue_possconstr;//
end event

public subroutine uf_dw (datawindow a_dw);dwnav=a_dw
end subroutine

on uo_navi.create
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

on uo_navi.destroy
destroy(this.pb_primero)
destroy(this.pb_anterior)
destroy(this.pb_siguiente)
destroy(this.pb_final)
destroy(this.sle_record)
end on

event constructor;this.postevent('ue_possconstr')
end event

type pb_primero from u_pb within uo_navi
integer width = 101
integer height = 84
integer taborder = 10
string text = ""
boolean originalsize = false
string picturename = "VCRFirst!"
end type

event clicked;call super::clicked;parent.triggerevent('ue_inicio')


end event

type pb_anterior from u_pb within uo_navi
integer x = 110
integer width = 101
integer height = 84
integer taborder = 10
string text = ""
boolean originalsize = false
string picturename = "VCRPrior!"
end type

event clicked;call super::clicked;parent.triggerevent('ue_anterior')
end event

type pb_siguiente from u_pb within uo_navi
integer x = 923
integer width = 101
integer height = 84
integer taborder = 10
string text = ""
boolean originalsize = false
string picturename = "VCRNext!"
end type

event clicked;call super::clicked;parent.triggerevent('ue_siguiente')
end event

type pb_final from u_pb within uo_navi
integer x = 1029
integer width = 101
integer height = 84
integer taborder = 10
string text = ""
boolean originalsize = false
string picturename = "VCRLast!"
end type

event clicked;call super::clicked;parent.triggerevent('ue_final')
end event

type sle_record from u_sle within uo_navi
integer x = 215
integer width = 690
integer height = 84
integer textsize = -9
string text = "Registro: "
boolean displayonly = true
end type

