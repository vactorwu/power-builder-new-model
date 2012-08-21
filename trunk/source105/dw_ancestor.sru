HA$PBExportHeader$dw_ancestor.sru
forward
global type dw_ancestor from datawindow
end type
end forward

global type dw_ancestor from datawindow
integer width = 686
integer height = 400
string title = "none"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
event keydown pbm_keydown
event dwnkey pbm_dwnkey
event enter pbm_dwnprocessenter
end type
global dw_ancestor dw_ancestor

on dw_ancestor.create
end on

on dw_ancestor.destroy
end on

