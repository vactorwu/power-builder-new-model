HA$PBExportHeader$ds_articulos.sru
$PBExportComments$datastore de areas del usuario.
forward
global type ds_articulos from datastore
end type
end forward

global type ds_articulos from datastore
end type
global ds_articulos ds_articulos

on ds_articulos.create
call super::create
TriggerEvent( this, "constructor" )
end on

on ds_articulos.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

