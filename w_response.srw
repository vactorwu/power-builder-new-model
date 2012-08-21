HA$PBExportHeader$w_response.srw
forward
global type w_response from w_base
end type
end forward

global type w_response from w_base
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
end type
global w_response w_response

forward prototypes
public function integer wf_centrar ()
end prototypes

public function integer wf_centrar ();int li_screenheight, li_screenwidth, li_rc, li_x=1, li_y=1
environment	lenv_obj

If IsNull ( this ) Or Not IsValid ( this ) Then Return -1

If GetEnvironment ( lenv_obj ) = -1 Then Return -1

li_screenheight = PixelsToUnits ( lenv_obj.ScreenHeight, YPixelsToUnits! )
li_screenwidth  = PixelsToUnits ( lenv_obj.ScreenWidth, XPixelsToUnits! )
If Not ( li_screenheight > 0 ) Or Not ( li_screenwidth > 0 ) Then Return -1

If li_screenwidth > this.Width Then
	li_x = ( li_screenwidth/ 2 ) - ( this.Width / 2 )
End If
If li_screenheight > this.Height Then
	li_y = ( (li_screenheight - 400)/ 2 ) - ( this.Height / 2 )
End If

li_rc = this.Move ( li_x, li_y )

If li_rc <> 1 Then Return -1

Return 1
end function

on w_response.create
call super::create
end on

on w_response.destroy
call super::destroy
end on

event open;call super::open;wf_centrar()
end event

