HA$PBExportHeader$w_buscarprueba.srw
forward
global type w_buscarprueba from w_buscar
end type
end forward

global type w_buscarprueba from w_buscar
integer width = 2555
integer height = 1584
string is_cpcampoid = "idunidad"
string is_cpcodigo = "codigo"
string is_cpdescripccion = "descripcion"
end type
global w_buscarprueba w_buscarprueba

on w_buscarprueba.create
call super::create
end on

on w_buscarprueba.destroy
call super::destroy
end on

type cb_aceptar from w_buscar`cb_aceptar within w_buscarprueba
end type

type cb_cerrar from w_buscar`cb_cerrar within w_buscarprueba
end type

type pb_refresh from w_buscar`pb_refresh within w_buscarprueba
end type

type pb_orden from w_buscar`pb_orden within w_buscarprueba
end type

type pb_filtro from w_buscar`pb_filtro within w_buscarprueba
end type

type em_buscar from w_buscar`em_buscar within w_buscarprueba
end type

type rb_filtro from w_buscar`rb_filtro within w_buscarprueba
end type

type rb_seleccion from w_buscar`rb_seleccion within w_buscarprueba
end type

type dw_lista from w_buscar`dw_lista within w_buscarprueba
string dataobject = "d_unidad_lista"
end type

event dw_lista::constructor;call super::constructor;this.retrieve(gn_config.is_config.empresa )
end event

type st_2 from w_buscar`st_2 within w_buscarprueba
end type

type st_1 from w_buscar`st_1 within w_buscarprueba
end type

type am_1 from w_buscar`am_1 within w_buscarprueba
integer y = 76
end type

type gb_tipo from w_buscar`gb_tipo within w_buscarprueba
end type

type ddlb_campo from w_buscar`ddlb_campo within w_buscarprueba
end type

type gb_busqueda from w_buscar`gb_busqueda within w_buscarprueba
end type

