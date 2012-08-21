HA$PBExportHeader$n_applicacion.sru
$PBExportComments$userobject con servicios generales de la aplicaci$$HEX1$$f300$$ENDHEX$$n.
forward
global type n_applicacion from nonvisualobject
end type
end forward

global type n_applicacion from nonvisualobject
end type
global n_applicacion n_applicacion

type variables

s_application is_application
end variables

forward prototypes
public function datetime of_datetime ()
end prototypes

public function datetime of_datetime ();
datetime ldt_fecha

//***************************************************************************************************************************************************************************************
// Fecha de servidor.
//***************************************************************************************************************************************************************************************

select distinct getdate() into :ldt_fecha from sysusers;

//***************************************************************************************************************************************************************************************
// Retorno.
//***************************************************************************************************************************************************************************************

return ldt_fecha 
end function

on n_applicacion.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_applicacion.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

