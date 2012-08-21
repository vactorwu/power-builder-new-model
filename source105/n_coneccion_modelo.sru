HA$PBExportHeader$n_coneccion_modelo.sru
forward
global type n_coneccion_modelo from n_base_coneccion
end type
end forward

global type n_coneccion_modelo from n_base_coneccion autoinstantiate
end type
global n_coneccion_modelo n_coneccion_modelo

type variables
protected  n_ds		 ids_compartido
protected  u_dw       idw_trayecto


end variables

forward prototypes
public function integer of_inicio (string as_dataobjectname)
public function integer of_resetdatastore ()
public function long of_compartido (u_dw adw_target)
public function integer of_grabar ()
end prototypes

public function integer of_inicio (string as_dataobjectname);IF NOT IsValid (ids_compartido) THEN
	ids_compartido = CREATE n_ds
END IF

IF IsValid(ids_compartido) THEN
	ids_compartido.dataobject = as_dataobjectname
	ids_compartido.SetTransObject(SQLCA)
	RETURN 1
ELSE
	RETURN -1
END IF

end function

public function integer of_resetdatastore ();IF IsValid(ids_compartido) THEN
	ids_compartido.Reset()
	RETURN 1
ELSE
	RETURN -1
END IF
end function

public function long of_compartido (u_dw adw_target);return 1
end function

public function integer of_grabar ();Return -1
end function

on n_coneccion_modelo.create
call super::create
end on

on n_coneccion_modelo.destroy
call super::destroy
end on

