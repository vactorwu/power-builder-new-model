HA$PBExportHeader$u_cb_cancel.sru
$PBExportComments$Ancestor Cancel button class
forward
global type u_cb_cancel from u_cb
end type
end forward

global type u_cb_cancel from u_cb
string text = "Cancel"
boolean cancel = true
event ue_postclicked ( )
end type
global u_cb_cancel u_cb_cancel

event ue_postclicked;Close(of_parent())
end event

event clicked;This.EVENT POST ue_postclicked()
end event

