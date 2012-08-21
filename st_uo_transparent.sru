HA$PBExportHeader$st_uo_transparent.sru
forward
global type st_uo_transparent from statictext
end type
end forward

global type st_uo_transparent from statictext
integer width = 384
integer height = 92
fontcharset fontcharset = ansi!
string facename = "System"
alignment alignment = center!
event ue_paint pbm_paint
end type
global st_uo_transparent st_uo_transparent

type variables
boolean ib_Painting
end variables

event ue_paint;if IsValid(this) then
      if ib_Painting then return 0
      ib_Painting = TRUE
      this.visible = false
      do while yield() ; loop
	if IsValid(this) then		
			this.visible = true
			ib_painting=false
	End If
end if

return 0
end event

event constructor;this.BackColor = 2^29
end event

on st_uo_transparent.create
end on

on st_uo_transparent.destroy
end on

