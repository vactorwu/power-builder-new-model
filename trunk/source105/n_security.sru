HA$PBExportHeader$n_security.sru
$PBExportComments$userobject de seguridad.
forward
global type n_security from nonvisualobject
end type
end forward

global type n_security from nonvisualobject
end type
global n_security n_security

type variables

ds_articulos                    ids_articulos
s_security                   is_security
end variables

forward prototypes
public subroutine of_usuario (string as_login)
end prototypes

public subroutine of_usuario (string as_login);//
//long ll_row
//string ls_indicador
//
////****************************************************************************************************************************************************************************************
//// Creo instancias de los userobjects.
////****************************************************************************************************************************************************************************************
//
//ids_roles = create ds_roles
//ids_roles_areas = create ds_roles_areas
//ids_areas = create ds_areas
//ids_areas_adicionales = create ds_areas_adicionales
//ids_areas.settransobject(SQLCA)
//ids_roles.settransobject(SQLCA)
//ids_roles_areas.settransobject(SQLCA)
//ids_areas_adicionales.settransobject(SQLCA)
//
////****************************************************************************************************************************************************************************************
//// Datos generales del usuario.
////****************************************************************************************************************************************************************************************
//
//SELECT GEN_USUARIO.COD_USUARIO, GEN_USUARIO.COD_REPRESENTACION, GEN_REPRESENTACION.DES_REPRESENTACION, GEN_USUARIO.COD_SEDE, GEN_SUBAREA_DETALLE.DES_SUBAREA_DETALLE, GEN_USUARIO.NOM_COMPLETO, GEN_USUARIO.NOM_LOGIN, GEN_USUARIO.IND_USUARIO
//  INTO :is_security.cod_usuario, :is_security.cod_representacion, :is_security.des_representacion, :is_security.cod_sede,  :is_security.des_subarea_detalle, :is_security.des_usuario, :is_security.des_login, :ls_indicador
//    FROM GEN_USUARIO_AREA, GEN_USUARIO, GEN_SUBAREA_DETALLE, GEN_REPRESENTACION
//      WHERE GEN_USUARIO.NOM_LOGIN = :as_login AND GEN_USUARIO.COD_REPRESENTACION = GEN_REPRESENTACION.COD_REPRESENTACION AND GEN_USUARIO.COD_USUARIO = GEN_USUARIO_AREA.COD_USUARIO AND GEN_USUARIO_AREA.COD_SUBAREA_DETALLE = GEN_SUBAREA_DETALLE.COD_SUBAREA_DETALLE USING SQLCA;
//
////****************************************************************************************************************************************************************************************
//// Indicador del usuario.
////****************************************************************************************************************************************************************************************
//
//if ls_indicador = 'N' then
//  messagebox(gn_application.is_application.des_aplicativo,'El usuario se encuentra deshabilitado.')
//  return
//end if
//
////****************************************************************************************************************************************************************************************
//// Roles del usuario.
////****************************************************************************************************************************************************************************************
//
//if ids_roles.retrieve(gn_application.is_application.cod_aplicacion,is_security.cod_usuario) <= 0 then
//  messagebox(gn_application.is_application.des_aplicativo,'El usuario no tiene un rol asignado.')
//  halt
//else
//  gn_application.is_application.des_version = ids_roles.getitemstring(ids_roles.getrow(),'descripcion_aplicacion')	
//end if
//
////****************************************************************************************************************************************************************************************
//// Area activa del usuario.
////****************************************************************************************************************************************************************************************
//
//if ids_areas.retrieve(gn_application.is_application.cod_aplicacion,is_security.cod_usuario) <= 0 then
//  messagebox(gn_application.is_application.des_aplicativo,'El usuario no tiene area asignada.')
//  halt
//else
//  is_security.cod_area = ids_areas.getitemstring(ids_areas.getrow(),'codigo_area')
//  is_security.cod_subarea = ids_areas.getitemstring(ids_areas.getrow(),'codigo_subarea')
//  is_security.cod_usuario_area = ids_areas.getitemstring(ids_areas.getrow(),'codigo_usuario_area')
//  is_security.cod_subarea_detalle = ids_areas.getitemstring(ids_areas.getrow(),'codigo_subarea_detalle')	
//end if
//
////****************************************************************************************************************************************************************************************
//// Areas del rol.
////****************************************************************************************************************************************************************************************
//
//if ids_roles_areas.retrieve(ids_roles.is_roles[]) <= 0 then
//  messagebox(gn_application.is_application.des_aplicativo,'El rol no tiene asignada ningun area.')
//  halt
//else
//  ids_roles_areas.rowscopy(1,ids_roles_areas.rowcount(),primary!,ids_areas_usuario,ids_areas_usuario.rowcount() + 1,primary!)	
//end if
//
////****************************************************************************************************************************************************************************************
//// Areas activa.
////****************************************************************************************************************************************************************************************
//
//ll_row = ids_areas_usuario.insertrow(0)
//
//ids_areas_usuario.setitem(ll_row,'codigo_area',is_security.cod_area)
//ids_areas_usuario.setitem(ll_row,'codigo_subarea',is_security.cod_subarea)
//ids_areas_usuario.setitem(ll_row,'codigo_subarea_detalle',is_security.cod_subarea_detalle)
//
////****************************************************************************************************************************************************************************************
//// Otras areas del usuario
////****************************************************************************************************************************************************************************************
//
//if ids_areas_adicionales.retrieve(is_security.cod_usuario) > 0 then
//  ids_roles_areas.rowscopy(1,ids_roles_areas.rowcount(),primary!,ids_areas_adicionales,ids_areas_adicionales.rowcount() + 1,primary!)
//end if
end subroutine

on n_security.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_security.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;
//****************************************************************************************************************************************************************************************
// Creo instancias de los userobjects.
//****************************************************************************************************************************************************************************************

//ids_areas_usuario = create datastore
//ids_areas_usuario.dataobject = 'dw_areas_usuario'

//****************************************************************************************************************************************************************************************
// Aplicaci$$HEX1$$f300$$ENDHEX$$n.
//****************************************************************************************************************************************************************************************

//gn_application.is_application.cod_aplicacion = '01'
end event

