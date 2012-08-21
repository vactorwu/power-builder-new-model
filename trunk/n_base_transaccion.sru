HA$PBExportHeader$n_base_transaccion.sru
forward
global type n_base_transaccion from transaction
end type
end forward

global type n_base_transaccion from transaction
end type
global n_base_transaccion n_base_transaccion

on n_base_transaccion.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_base_transaccion.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

