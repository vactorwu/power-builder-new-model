HA$PBExportHeader$uo_cb_transparent.sru
forward
global type uo_cb_transparent from commandbutton
end type
end forward

global type uo_cb_transparent from commandbutton
integer width = 384
integer height = 92
fontcharset fontcharset = ansi!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "Courier New"
string text = "None"
event ue_paint pbm_paint
end type
global uo_cb_transparent uo_cb_transparent

type variables
boolean ib_Painting
end variables

event ue_paint;if IsValid(this) then
      if ib_Painting then return 0
      ib_Painting = TRUE
      this.visible = false
      do while yield() ; loop
      this.visible = true
      ib_painting=false
end if

return 0
end event

event constructor;//this.BackColor = 2^29

end event

on uo_cb_transparent.create
end on

on uo_cb_transparent.destroy
end on

