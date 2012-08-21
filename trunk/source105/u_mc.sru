HA$PBExportHeader$u_mc.sru
forward
global type u_mc from monthcalendar
end type
end forward

global type u_mc from monthcalendar
integer width = 859
integer height = 624
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long titletextcolor = 134217742
long trailingtextcolor = 134217745
long monthbackcolor = 1073741824
long titlebackcolor = 134217741
integer maxselectcount = 31
integer scrollrate = 1
boolean todaysection = true
boolean todaycircle = true
boolean weeknumbers = true
boolean border = true
borderstyle borderstyle = stylelowered!
boolean autosize = true
event buttonup pbm_lbuttonup
end type
global u_mc u_mc

type variables
String is_Fecha , is_Campo
Date  id_Fecha
Datawindow idw_Pariente
end variables

forward prototypes
public subroutine of_setdatawindow (datawindow a_dw)
public subroutine of_seleccionarfecha ()
end prototypes

event buttonup;This.GetSelectedDate(id_Fecha)

If IsValid(idw_pariente) then
if left(idw_pariente.describe(is_Campo+ ".coltype"),4) = 'date' then		
	if left(idw_pariente.describe(is_Campo+ ".coltype"),8) = 'datetime' then
		idw_pariente.setitem(idw_pariente.getrow(), is_Campo, DateTime(id_Fecha) )
		idw_pariente.accepttext( )
		idw_pariente.Dynamic event ue_Seleccion_Calendario(is_Campo,DateTime(id_Fecha) )
	else 
		idw_pariente.setitem(idw_pariente.getrow(), is_Campo ,Date(id_Fecha) )
		idw_pariente.accepttext( )
		idw_pariente.Dynamic event ue_Seleccion_Calendario(is_Campo,DateTime(id_Fecha, Time(0,0,0)) )
	end if		
end if	
End If
end event

public subroutine of_setdatawindow (datawindow a_dw);idw_Pariente = a_dw
end subroutine

public subroutine of_seleccionarfecha ();IF IsValid(idw_pariente) THEN
	idw_pariente.accepttext( )
	IF left(idw_pariente.describe(is_Campo+ ".coltype"),4) = 'date' THEN		
		IF left(idw_pariente.describe(is_Campo+ ".coltype"),8) = 'datetime' THEN
			is_Fecha = String(idw_pariente.getitemdatetime(idw_pariente.getrow(), is_Campo,Primary!, false  ),"DD/MM/YYYY")
		ELSE 
			is_Fecha = String(idw_pariente.getitemdate(idw_pariente.getrow(), is_Campo,Primary!, false  ),"DD/MM/YYYY")
		END IF		
	END IF	
END IF

IF IsDate( is_Fecha)  AND is_Fecha <> '01/01/1900'THEN
	id_Fecha = Date(is_Fecha)
ELSE
	id_Fecha = gn_config.is_work.FechaTrabajo
END IF

THIS.SetSelectedDate (id_Fecha)
THIS.SetToday ( gn_config.is_work.fechasistema )

end subroutine

on u_mc.create
end on

on u_mc.destroy
end on

event constructor;// 

This.visible = True
This.show( )

is_Campo = message.StringParm

end event

event doubleclicked; idw_Pariente.Dynamic Post of_CerrarCalendario()
end event

