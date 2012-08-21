HA$PBExportHeader$n_coneccion_seguridad.sru
forward
global type n_coneccion_seguridad from n_base_coneccion
end type
end forward

global type n_coneccion_seguridad from n_base_coneccion autoinstantiate
end type

type variables
//protected:
    string  is_userid, is_password
	 boolean ib_borrar, ib_insertar, ib_modificar
end variables

forward prototypes
public function boolean of_getborrar ()
public function boolean of_getinsertar ()
public function boolean of_getmodificar ()
public function integer of_setseguridad (string as_userid, string as_password)
end prototypes

public function boolean of_getmodificar ();return ib_modificar
end function

public function integer of_setseguridad (string as_userid, string as_password);

is_userid = as_userid
is_password = as_password

ib_borrar = TRUE
ib_insertar = TRUE
ib_modificar = TRUE

Return 1
end function

on n_coneccion_seguridad.create
call super::create
end on

on n_coneccion_seguridad.destroy
call super::destroy
end on

