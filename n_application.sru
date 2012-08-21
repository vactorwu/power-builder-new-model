HA$PBExportHeader$n_application.sru
$PBExportComments$userobject con servicios generales de la aplicaci$$HEX1$$f300$$ENDHEX$$n.
forward
global type n_application from nonvisualobject
end type
end forward

global type n_application from nonvisualobject
end type
global n_application n_application

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

on n_application.create
TriggerEvent( this, "constructor" )
end on

on n_application.destroy
TriggerEvent( this, "destructor" )
end on

