HA$PBExportHeader$uo_calendario.sru
forward
global type uo_calendario from userobject
end type
type em_hora from editmask within uo_calendario
end type
type em_anio from editmask within uo_calendario
end type
type ddlb_mes from dropdownlistbox within uo_calendario
end type
type mc_calendario from monthcalendar within uo_calendario
end type
end forward

global type uo_calendario from userobject
integer width = 905
integer height = 732
boolean border = true
long backcolor = 67108864
string text = "none"
borderstyle borderstyle = styleraised!
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event ue_fecha ( date ad_fecha )
event ue_hora ( time at_hora )
event ue_fechahora ( datetime adt_fechahora )
em_hora em_hora
em_anio em_anio
ddlb_mes ddlb_mes
mc_calendario mc_calendario
end type
global uo_calendario uo_calendario

type variables
String is_Campo, is_Tipo , is_Fecha , is_Formato
DateTime idt_FechaHora
Date id_Fecha
Time it_Hora
Datawindow idw_Pariente
end variables

forward prototypes
public subroutine set_campo (string as_campo)
public function string get_campo ()
public subroutine set_fecha (date ad_fecha)
public subroutine set_hora (time ad_hora)
public function date get_fecha ()
public subroutine set_fechahora (datetime adt_fechahora)
public function datetime get_fechahora ()
public function time get_hora ()
public function integer settoday (date ad_fecha)
public function integer setselecteddate (date ad_fecha)
public function date gettoday ()
public function Time getselectedtime ()
public function integer getselecteddate (ref date ad_fecha)
public subroutine setselectedtime (time at_hora)
public subroutine set_calendario ()
public subroutine of_seleccionarfecha ()
public subroutine of_setdatawindow (datawindow a_dw)
public subroutine set_tipo (string as_tipo)
public subroutine set_formato (string as_formato)
public function string get_formato ()
public function string get_tipo ()
public subroutine set_datos ()
end prototypes

event ue_fecha(date ad_fecha);//
end event

event ue_hora(time at_hora);//
end event

event ue_fechahora(datetime adt_fechahora);//
end event

public subroutine set_campo (string as_campo);is_Campo = as_Campo

IF IsValid(idw_Pariente) THEN
Set_Tipo(UPPER(idw_Pariente.DESCRIBE(is_Campo+".Coltype")))
Set_Formato(UPPER( idw_Pariente.DESCRIBE(is_Campo+".EditMask.Mask")))
END IF
end subroutine

public function string get_campo ();Return is_Campo
end function

public subroutine set_fecha (date ad_fecha);id_Fecha = ad_Fecha
idt_FechaHora = DateTime(id_Fecha ,  it_Hora )
event ue_fecha(id_Fecha)
event ue_fechahora( idt_FechaHora )
end subroutine

public subroutine set_hora (time ad_hora);it_Hora = ad_hora
idt_FechaHora = DateTime(id_Fecha ,  it_Hora )

event ue_hora(it_Hora)
event ue_fechahora( idt_FechaHora )
end subroutine

public function date get_fecha ();Return id_Fecha 
end function

public subroutine set_fechahora (datetime adt_fechahora);idt_FechaHora = adt_FechaHora
id_Fecha   = Date(adt_FechaHora)
it_Hora   = Time(adt_FechaHora)

event ue_fechahora( idt_FechaHora )
end subroutine

public function datetime get_fechahora ();RETURN idt_FechaHora
end function

public function time get_hora ();RETURN it_Hora
end function

public function integer settoday (date ad_fecha);RETURN mc_calendario.SetToday (ad_Fecha )
end function

public function integer setselecteddate (date ad_fecha);RETURN mc_calendario.SetSelectedDate (ad_Fecha)
end function

public function date gettoday ();RETURN mc_calendario.GetToday ( )
end function

public function Time getselectedtime ();RETURN TIME(em_hora.text)
end function

public function integer getselecteddate (ref date ad_fecha);RETURN mc_calendario.GetSelectedDate (ad_Fecha)
end function

public subroutine setselectedtime (time at_hora); em_hora.Text = String(em_hora , "HH:MM:SS")
end subroutine

public subroutine set_calendario ();ddlb_mes.selectitem( MONTH(id_Fecha) )
em_anio.text =  String(YEAR(id_Fecha))
mc_calendario.SetSelectedDate( id_Fecha)
//mc_calendario.Settoday(id_Fecha)
em_hora.text = String(it_Hora, "HH:MM:SS")

end subroutine

public subroutine of_seleccionarfecha ();IF IsValid(idw_pariente) THEN
	idw_pariente.accepttext( )
	IF left(idw_pariente.describe(is_Campo+ ".coltype"),4) = 'date' THEN		
		IF left(idw_pariente.describe(is_Campo+ ".coltype"),8) = 'datetime' THEN
			is_Fecha = String(idw_pariente.getitemdatetime(idw_pariente.getrow(), is_Campo,Primary!, false  ),"DD/MM/YYYY")
			THIS.Set_Hora(Time(idw_pariente.getitemdatetime(idw_pariente.getrow(), is_Campo,Primary!, false  )))
		ELSE 
			is_Fecha = String(idw_pariente.getitemdate(idw_pariente.getrow(), is_Campo,Primary!, false  ),"DD/MM/YYYY")
		END IF		
		
	END IF	
END IF

IF IsDate( is_Fecha)  AND is_Fecha <> '01/01/1900'THEN
	Set_Fecha(Date(is_Fecha))
ELSE
	Set_Fecha(gn_config.is_work.FechaTrabajo)
END IF



THIS.SetSelectedDate (id_Fecha)
THIS.SetToday ( gn_config.is_work.fechasistema )


end subroutine

public subroutine of_setdatawindow (datawindow a_dw);idw_Pariente = a_dw
end subroutine

public subroutine set_tipo (string as_tipo);is_Tipo = as_Tipo

choose case is_Tipo
	case "DATE"
		em_hora.enabled = FALSE
	case "TIME"
		em_hora.enabled = TRUE
	case "DATETIME"
		em_hora.enabled = TRUE
end choose

end subroutine

public subroutine set_formato (string as_formato);is_Formato = as_Formato

choose case is_Tipo
	case "DATE"
		em_hora.enabled = FALSE
	case "TIME"
		em_hora.enabled = TRUE
	case "DATETIME"
		IF Right(is_Formato, 8) = "HH:MM:SS" THEN
			em_hora.enabled = TRUE
		ELSE
			em_hora.enabled = FALSE
		END IF
end choose

end subroutine

public function string get_formato ();Return is_Formato
end function

public function string get_tipo ();Return is_Tipo
end function

public subroutine set_datos ();If IsValid(idw_pariente) then
choose case is_Tipo
	case "DATE"
		idw_pariente.setitem(idw_pariente.getrow(), is_Campo,Id_Fecha )
		event ue_fecha( Id_Fecha )
	case "TIME"
		idw_pariente.setitem(idw_pariente.getrow(), is_Campo,It_Hora )
		event ue_hora(It_Hora)
	case "DATETIME"
		idw_pariente.setitem(idw_pariente.getrow(), is_Campo,Idt_FechaHora )
end choose
		event ue_fechahora(Idt_FechaHora )
		idw_pariente.accepttext( )
		idw_pariente.Dynamic event ue_Seleccion_Calendario(is_Campo,Idt_FechaHora)
End If



end subroutine

on uo_calendario.create
this.em_hora=create em_hora
this.em_anio=create em_anio
this.ddlb_mes=create ddlb_mes
this.mc_calendario=create mc_calendario
this.Control[]={this.em_hora,&
this.em_anio,&
this.ddlb_mes,&
this.mc_calendario}
end on

on uo_calendario.destroy
destroy(this.em_hora)
destroy(this.em_anio)
destroy(this.ddlb_mes)
destroy(this.mc_calendario)
end on

event constructor;
THIS.visible = TRUE
THIS.Show( )

end event

type em_hora from editmask within uo_calendario
event ue_cambio pbm_enchange
integer x = 576
integer y = 4
integer width = 306
integer height = 84
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datetimemask!
string mask = "HH:MM:SS"
boolean autoskip = true
boolean spin = true
double increment = 1
string minmax = "~~"
end type

event ue_cambio;Set_Hora(Time(THIS.TEXT))
Set_datos( )
end event

type em_anio from editmask within uo_calendario
event ue_cambioa$$HEX1$$f100$$ENDHEX$$o pbm_enchange
integer x = 357
integer y = 4
integer width = 224
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
string mask = "####"
boolean autoskip = true
boolean spin = true
double increment = 1
string minmax = "1900~~3000"
end type

event ue_cambioa$$HEX1$$f100$$ENDHEX$$o;Int li_Dia , li_Mes , li_Anio , li_Pasos
Date ld_Fecha
li_Dia = Day(id_Fecha)
li_Mes = Month(id_Fecha)
li_Anio = INTEGER(THIS.TEXT)

IF li_Anio > 1900 THEN
	DO
		IF (li_Pasos > 0 ) THEN li_Dia --
		ld_Fecha = Date(li_Anio, li_Mes ,li_Dia )
		li_Pasos ++
	LOOP UNTIL ld_Fecha > Date(1900,1,1)
	
	Set_fecha(ld_Fecha)
	SetSelectedDate( ld_Fecha)
	Set_datos( )
END IF
end event

type ddlb_mes from dropdownlistbox within uo_calendario
integer y = 4
integer width = 361
integer height = 724
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
boolean sorted = false
boolean hscrollbar = true
boolean vscrollbar = true
string item[] = {"Enero","Febrero","Marzo","Abril","Mayo","Junio","Julio","Agosto","Septiembre","Octubre","Noviembre","Diciembre"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;Int li_Dia , li_Mes , li_Anio , li_Pasos
Date ld_Fecha
li_Dia = Day(id_Fecha)
li_Mes = Month(id_Fecha)
li_Anio = Year(id_Fecha)

DO
	IF (li_Pasos > 0 ) THEN li_Dia --
	ld_Fecha = Date(li_Anio, index ,li_Dia )
	li_Pasos ++
LOOP UNTIL ld_Fecha > Date(1900,1,1)

Set_fecha(ld_Fecha)
SetSelectedDate( ld_Fecha)
Set_datos( )
end event

type mc_calendario from monthcalendar within uo_calendario
event buttonup pbm_lbuttonup
integer y = 92
integer width = 882
integer height = 628
integer taborder = 30
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
weekday firstdayofweek = sunday!
integer maxselectcount = 31
integer scrollrate = 1
boolean todaysection = true
boolean todaycircle = true
boolean weeknumbers = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event buttonup;This.GetSelectedDate(id_Fecha)

Set_datos( )
end event

event datechanged;DATE ld_Fecha
THIS.GetSelectedDate(ld_Fecha)
Set_Fecha(ld_Fecha)
ddlb_mes.selectitem( MONTH(ld_Fecha) )
em_anio.text =  String(YEAR(ld_Fecha))

end event

event doubleclicked;If IsValid(idw_pariente) then
	idw_Pariente.Dynamic Post of_CerrarCalendario()
END IF
end event

