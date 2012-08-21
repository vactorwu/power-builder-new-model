HA$PBExportHeader$w_manto_empresa.srw
forward
global type w_manto_empresa from w_manto
end type
end forward

global type w_manto_empresa from w_manto
integer width = 3735
integer height = 2528
string title = "Cat$$HEX1$$e100$$ENDHEX$$logo de Empresas"
string is_tabla = "EMPRESA"
string is_campocod = "codempresa"
string is_campoid = "idempresa"
integer ii_largocod = 2
decimal id_codigo = 0.00
string is_campofinal = "Estado"
end type
global w_manto_empresa w_manto_empresa

type variables


end variables

forward prototypes
public subroutine wf_datos_adicionales ()
public subroutine wf_setear_ubigeo ()
end prototypes

public subroutine wf_datos_adicionales ();
dwItemStatus l_status
DateTime ldt_FechaSys 
l_status = idw_activa.GetItemStatus( idw_activa.getrow() , 0, Primary!)

ldt_FechaSys = gn_config.of_datetime()

choose case l_status
	case New!, NewModified!
			idw_activa.Object.mesactivo[idw_activa.getrow()] = Month(Date(ldt_FechaSys))
			idw_activa.Object.anioactivo[idw_activa.getrow()] = Year(Date(ldt_FechaSys))

end choose


end subroutine

public subroutine wf_setear_ubigeo ();String ls_Id

OpenWithParm(w_buscar_ubigeo_lista, "")
ls_Id = Message.StringParm
IF IsNull(ls_Id) OR ls_Id = "" THEN RETURN
Idw_activa.Object.IdUbigeo[Idw_activa.GetRow()] = ls_Id
Idw_activa.Object.Ubigeo[Idw_activa.GetRow()] =uf_get_ubigeo( ls_Id )
Idw_activa.Accepttext( )

end subroutine

on w_manto_empresa.create
int iCurrent
call super::create
end on

on w_manto_empresa.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type gb_comandos from w_manto`gb_comandos within w_manto_empresa
integer x = 18
integer y = 1956
integer width = 3470
end type

type tab_todo from w_manto`tab_todo within w_manto_empresa
integer height = 2340
end type

type tp_lista from w_manto`tp_lista within tab_todo
integer height = 2212
string text = "Lista de Empresas"
end type

type dw_lista from w_manto`dw_lista within tp_lista
integer height = 1496
string dataobject = "d_empresa_lista"
end type

type am_1 from w_manto`am_1 within tp_lista
end type

type st_2 from w_manto`st_2 within tp_lista
end type

type st_1 from w_manto`st_1 within tp_lista
end type

type rb_filtro from w_manto`rb_filtro within tp_lista
end type

type rb_seleccion from w_manto`rb_seleccion within tp_lista
end type

type pb_refresh from w_manto`pb_refresh within tp_lista
end type

type pb_orden from w_manto`pb_orden within tp_lista
end type

type pb_filtro from w_manto`pb_filtro within tp_lista
end type

type gb_tipo from w_manto`gb_tipo within tp_lista
end type

type ddlb_campo from w_manto`ddlb_campo within tp_lista
end type

type em_buscar from w_manto`em_buscar within tp_lista
end type

type sle_buscar from w_manto`sle_buscar within tp_lista
end type

type gb_busqueda from w_manto`gb_busqueda within tp_lista
end type

type tp_manto from w_manto`tp_manto within tab_todo
integer height = 2212
string text = "Datos de Empresa"
end type

type dw_manto from w_manto`dw_manto within tp_manto
integer width = 3653
integer height = 1772
string dataobject = "d_empresa_manto"
boolean hscrollbar = true
end type

event dw_manto::buttonclicked;call super::buttonclicked;
IF dwo.name = "b_ubigeo" THEN
   wf_setear_ubigeo()
END IF
end event

event dw_manto::itemchanged;call super::itemchanged;choose case dwo.name
	case 'tipo'
			choose case data
				case 'J'
					idw_activa.Object.ApellidoPaterno.Background.Color = gl_colorboton
					idw_activa.Object.ApellidoMaterno.Background.Color = gl_colorboton
					idw_activa.Object.Nombre.Background.Color = gl_colorboton
					idw_activa.Object.RazonSocial.Background.Color = RGB(255,255,255)
					
//					idw_activa.Object.ApellidoPaterno.Tag = 'No'					
//					idw_activa.Object.ApellidoMaterno.Tag = 'No'
//					idw_activa.Object.Nombre.Tag = 'No'
//					idw_activa.Object.RazonSocial.Tag = 'Razon Social'	
					idw_activa.Modify("ApellidoPaterno.Tag='No'")
					idw_activa.Modify("ApellidoMaterno.Tag='No'")
					idw_activa.Modify("Nombre.Tag='No'")
					idw_activa.Modify("RazonSocial.Tag='Razon Social'")
					this.setcolumn('razonsocial')
				case 'N'

					idw_activa.Object.ApellidoPaterno.Background.Color =  RGB(255,255,255)		
					idw_activa.Object.ApellidoMaterno.Background.Color =  RGB(255,255,255)		
					idw_activa.Object.Nombre.Background.Color =  RGB(255,255,255)		
					idw_activa.Object.RazonSocial.Background.Color = gl_colorboton
					
//					idw_activa.Object.ApellidoPaterno.Tag = 'Apellido Paterno'
//					idw_activa.Object.ApellidoMaterno.Tag = 'Apellido Materno'
//					idw_activa.Object.Nombre.Tag = 'Nombre'
//					idw_activa.Object.RazonSocial.Tag = 'No'
					idw_activa.Modify("ApellidoPaterno.Tag='Apellido Paterno'")
					idw_activa.Modify("ApellidoMaterno.Tag='Apellido Materno'")
					idw_activa.Modify("Nombre.Tag='Nombre'")
					idw_activa.Modify("RazonSocial.Tag='No'")
					idw_activa.setcolumn('apellidopaterno')
			end choose

end choose

end event

type pb_borrar from w_manto`pb_borrar within tp_manto
end type

type pb_abrir from w_manto`pb_abrir within tp_manto
end type

type ole_1 from w_manto`ole_1 within tp_manto
end type

type shl_cerrar from w_manto`shl_cerrar within w_manto_empresa
integer x = 3063
integer y = 2168
end type

type shl_grabar from w_manto`shl_grabar within w_manto_empresa
integer x = 978
integer y = 2168
end type

type shl_eliminar from w_manto`shl_eliminar within w_manto_empresa
integer x = 667
integer y = 2168
end type

type shl_modificar from w_manto`shl_modificar within w_manto_empresa
integer x = 357
integer y = 2168
end type

type shl_nuevo from w_manto`shl_nuevo within w_manto_empresa
integer x = 46
integer y = 2168
end type

type uo_nav from w_manto`uo_nav within w_manto_empresa
integer x = 1595
integer y = 2064
end type

type pb_cancelar from w_manto`pb_cancelar within w_manto_empresa
integer x = 1358
integer y = 2016
end type

type pb_grabar from w_manto`pb_grabar within w_manto_empresa
integer x = 1047
integer y = 2016
end type

type pb_eliminar from w_manto`pb_eliminar within w_manto_empresa
integer x = 736
integer y = 2016
end type

type pb_nuevo from w_manto`pb_nuevo within w_manto_empresa
integer x = 114
integer y = 2016
end type

type pb_cerrar from w_manto`pb_cerrar within w_manto_empresa
integer x = 3131
integer y = 2016
end type

type shl_cancelar from w_manto`shl_cancelar within w_manto_empresa
integer x = 1289
integer y = 2168
end type

type pb_modificar from w_manto`pb_modificar within w_manto_empresa
integer x = 425
integer y = 2016
end type

type pb_ventana_y_libreria from w_manto`pb_ventana_y_libreria within w_manto_empresa
end type

