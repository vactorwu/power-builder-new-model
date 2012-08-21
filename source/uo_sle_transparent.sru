HA$PBExportHeader$uo_sle_transparent.sru
forward
global type uo_sle_transparent from singlelineedit
end type
end forward

global type uo_sle_transparent from singlelineedit
integer width = 384
integer height = 92
fontcharset fontcharset = ansi!
string facename = "System"
string text = "None"
alignment alignment = center!
event ue_paint pbm_paint
end type
global uo_sle_transparent uo_sle_transparent

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

event constructor;this.BackColor = 2^29
end event

on uo_sle_transparent.create
end on

on uo_sle_transparent.destroy
end on

