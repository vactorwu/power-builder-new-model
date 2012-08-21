HA$PBExportHeader$w_process_compra.srw
forward
global type w_process_compra from w_process
end type
end forward

global type w_process_compra from w_process
integer width = 4073
string title = "Registro de Compras"
string is_tabla = "COMPRA"
string is_campocod = "CodCompra"
string is_campoid = "IdCompra"
integer ii_largocod = 10
end type
global w_process_compra w_process_compra

type variables
DataWindowChild idwc_Moneda, idwc_Documento , idwc_DocumentoIdentidad
St_datos Ist_Datos , Ist_DatosNull , Ist_DatosParam
end variables

forward prototypes
public subroutine wf_datos_adicionales ()
public function long wf_dwkeyenter (keycode key, unsignedlong keyflags)
public subroutine wf_entidad_buscar (st_datos ast_datos)
public subroutine wf_entidad_borrar_datos ()
public subroutine wf_entidad_llenar_datos (st_datos ast_datos)
public subroutine wf_producto_llenar_datos (st_datos ast_datos)
public subroutine wf_producto_insertar ()
public subroutine wf_producto_modificar ()
public subroutine wf_entidad_nueva ()
end prototypes

public subroutine wf_datos_adicionales ();dwItemStatus l_status

l_status = idw_activa.GetItemStatus( idw_activa.getrow() , 0, Primary!)

choose case l_status
	case New!, NewModified!
			idw_activa.Object.idEmpresa[idw_activa.getrow()]= gn_config.is_work.idempresa
			idw_activa.Object.codEmpresa[idw_activa.getrow()]= gn_config.is_work.empresa
end choose


end subroutine

public function long wf_dwkeyenter (keycode key, unsignedlong keyflags);String ls_columna
Decimal ld_Id

ls_columna = idw_activa.getcolumnname( )

IF key = keyenter! then  
	idw_activa.accepttext( )
	ld_Id = idw_activa.Object.IdEntidad.Primary.Current[idw_activa.GetRow()]
	IF IsNull(ld_Id) THEN
		CHOOSE case ls_columna
			CASE 'codentidad'
				Ist_DatosParam.ParamS[1] = "codentidad"
				Ist_DatosParam.ParamS[2] = idw_activa.Object.CodEntidad.Primary.Current[idw_activa.GetRow()]
				Wf_Entidad_Buscar(Ist_DatosParam)		
			CASE 'razonsocial'
				Ist_DatosParam.ParamS[1] = "razonsocial"
				Ist_DatosParam.ParamS[2] = idw_activa.Object.RazonSocial.Primary.Current[idw_activa.GetRow()]		
				Wf_Entidad_Buscar(Ist_DatosParam)					
			CASE 'documentoidentidadnumero'		
				IF  idw_activa.Object.DocumentoIdentidad.Primary.Current[idw_activa.GetRow()] = 1 THEN
						Ist_DatosParam.ParamS[1] = "documentoidentidadnumero"
				ELSE
						Ist_DatosParam.ParamS[1] = "ruc"
				END IF
				Ist_DatosParam.ParamS[2] = idw_activa.Object.DocumentoIdentidadNumero.Primary.Current[idw_activa.GetRow()]	
				Wf_Entidad_Buscar(Ist_DatosParam)					
		END CHOOSE
	END IF
END IF


			
Return 1
end function

public subroutine wf_entidad_buscar (st_datos ast_datos);OpenWithParm(w_buscar_entidad, ast_Datos, THIS)

Ist_Datos= Message.PowerObjectParm

IF IsValid(Ist_Datos)  THEN
	Wf_entidad_llenar_datos(Ist_Datos)
	Ist_Datos = Ist_DatosNull
ELSE
	Wf_Entidad_Borrar_datos( )
END IF


end subroutine

public subroutine wf_entidad_borrar_datos ();
String Ls_Nulo
Decimal Ld_Nulo
SetNull(Ls_Nulo)
SetNull(Ld_Nulo)

Idw_Activa.object.IdEntidad [Idw_Activa.getrow()] 							= Ld_Nulo
Idw_Activa.object.CodEntidad [Idw_Activa.getrow()] 						= Ls_Nulo
Idw_Activa.object.Tipo [Idw_Activa.getrow()]	 								= Ls_Nulo
Idw_Activa.object.RazonSocial[Idw_Activa.getrow()]	 					= Ls_Nulo
Idw_Activa.object.DocumentoIdentidad[Idw_Activa.getrow()] 			= Ld_Nulo
Idw_Activa.object.DocumentoIdentidadNumero [Idw_Activa.getrow()]	= Ls_Nulo
Idw_Activa.object.Direccion [Idw_Activa.getrow()]	 						= Ls_Nulo
Idw_Activa.object.IdUbigeo [Idw_Activa.getrow()]	 						= Ls_Nulo 
Idw_Activa.object.Ubigeo [Idw_Activa.getrow()]	 							= Ls_Nulo


end subroutine

public subroutine wf_entidad_llenar_datos (st_datos ast_datos);
		Idw_Activa.object.IdEntidad [Idw_Activa.getrow()] 							= ast_datos.idcodigo 
		Idw_Activa.object.CodEntidad [Idw_Activa.getrow()] 						= ast_datos.codigo
	  	Idw_Activa.object.Tipo [Idw_Activa.getrow()]	 								= ast_datos.paramS[1] 
		Idw_Activa.object.RazonSocial[Idw_Activa.getrow()]	 					= ast_datos.paramS[2] 
		Idw_Activa.object.DocumentoIdentidad[Idw_Activa.getrow()] 			= ast_datos.paramD[1] 
		Idw_Activa.object.DocumentoIdentidadNumero [Idw_Activa.getrow()]	= ast_datos.paramS[5] 
		Idw_Activa.object.Direccion [Idw_Activa.getrow()]	 						= ast_datos.paramS[6] 
		Idw_Activa.object.IdUbigeo [Idw_Activa.getrow()]	 						= ast_datos.paramS[7] 
		Idw_Activa.object.Ubigeo [Idw_Activa.getrow()]	 							= ast_datos.paramS[8] 


end subroutine

public subroutine wf_producto_llenar_datos (st_datos ast_datos);Idw_Detalle.Object.Data[ast_datos.paramL[1] ] = ast_datos.paramA[1]
Idw_Detalle.ScrollTorow(ast_datos.paramL[1])
end subroutine

public subroutine wf_producto_insertar ();OpenWithParm(w_process_compradetalle,Ist_DatosParam,  THIS) 
Ist_Datos= Message.PowerObjectParm

IF IsValid(Ist_Datos)  THEN
	Ist_Datos.paramL[1] = Idw_Detalle.InsertRow(0)
	Wf_producto_llenar_datos(Ist_Datos)
	Ist_Datos = Ist_DatosNull
END IF


end subroutine

public subroutine wf_producto_modificar ();Ist_DatosParam.paramL[1]  = Idw_Detalle.GetRow()

IF Ist_DatosParam.paramL[1] > 0  THEN
	Ist_DatosParam.IdCodigo 	=  Idw_Detalle.Object.IdProducto[Ist_DatosParam.paramL[1] ] 
	Ist_DatosParam.Codigo 		=  Idw_Detalle.Object.CodProducto[Ist_DatosParam.paramL[1] ] 
	Ist_DatosParam.paramA[1] 	= Idw_Detalle.Object.Data[Ist_DatosParam.paramL[1] ] 
	OpenWithParm(w_process_compradetalle,Ist_DatosParam,  THIS) 
	Ist_Datos= Message.PowerObjectParm
	Ist_DatosParam = Ist_DatosNull
	IF IsValid(Ist_Datos)  THEN
		Wf_producto_llenar_datos(Ist_Datos)
		Ist_Datos = Ist_DatosNull
	END IF
END IF


end subroutine

public subroutine wf_entidad_nueva ();//OpenWithParm(w_buscar_entidad, THIS)
OpenWithParm(w_manto_entidad_mini, THIS)

Ist_Datos= Message.PowerObjectParm

IF IsValid(Ist_Datos)  THEN
	Wf_entidad_llenar_datos(Ist_Datos)
	Ist_Datos = Ist_DatosNull
ELSE
	Wf_Entidad_Borrar_datos( )
END IF


end subroutine

on w_process_compra.create
int iCurrent
call super::create
end on

on w_process_compra.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type gb_comandos from w_process`gb_comandos within w_process_compra
integer y = 1684
end type

type tab_todo from w_process`tab_todo within w_process_compra
integer x = 0
integer y = 4
integer width = 3909
integer height = 2072
end type

type tp_cabecera from w_process`tp_cabecera within tab_todo
integer width = 3872
integer height = 1944
string text = "Datos de Compra"
end type

type dw_cabecera from w_process`dw_cabecera within tp_cabecera
integer y = 0
integer width = 3872
integer height = 1572
string dataobject = "d_compra"
end type

event dw_cabecera::constructor;call super::constructor;IF idw_activa.GetChild('idMoneda', idwc_Moneda) = -1 THEN MessageBox(  "Error", "Linea Not a DataWindowChild")
idwc_Moneda.SetTransObject(SQLCA)
idwc_Moneda.Retrieve()
idwc_Moneda.SetFilter(" idMoneda in ("+ String(gn_config.is_work.idmonedanacional) + " , " + String(gn_config.is_work.idmonedaextranjera)+ " )")
idwc_Moneda.Filter()



IF idw_activa.GetChild('DocumentoIdentidad', idwc_DocumentoIdentidad) = -1 THEN MessageBox(  "Error", "Linea Not a DataWindowChild")
idwc_DocumentoIdentidad.SetTransObject(SQLCA)
idwc_DocumentoIdentidad.Retrieve("DocumentoIdentidad")
idwc_DocumentoIdentidad.SetFilter(" idColumna in ( 1, 2 )")
idwc_DocumentoIdentidad.Filter()

IF idw_activa.GetChild('IdDocumento', idwc_Documento) = -1 THEN MessageBox(  "Error", "Linea Not a DataWindowChild")
idwc_Documento.SetTransObject(SQLCA)
idwc_Documento.Retrieve(gn_config.is_work.idempresa )
end event

event dw_cabecera::buttonclicking;call super::buttonclicking;String ls_boton

ls_boton = dwo.name

CHOOSE CASE ls_boton
	CASE 'b_entidad_buscar' 
		wf_entidad_buscar(Ist_Datos)
	CASE 'b_entidad_nueva' 
		wf_entidad_Nueva()
	CASE 'b_entidad_limpiar' 
		wf_entidad_borrar_datos( )
	END CHOOSE

end event

type pb_borrar from w_process`pb_borrar within tp_cabecera
end type

type pb_abrir from w_process`pb_abrir within tp_cabecera
end type

type tp_detalle from w_process`tp_detalle within tab_todo
integer width = 3872
integer height = 1944
string text = "Detalle de Compra"
end type

type dw_detalle from w_process`dw_detalle within tp_detalle
integer y = 0
integer width = 3785
integer height = 1552
string dataobject = "d_compradetalle"
boolean minbox = true
boolean maxbox = true
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
end type

event dw_detalle::ue_itemnew;call super::ue_itemnew;Wf_Producto_Insertar( )
RETURN 1
end event

event dw_detalle::rowfocuschanged;call super::rowfocuschanged;IF CurrentRow <= 0  THEN RETURN
	THIS.selectrow(0,FALSE)
	THIS.selectrow(THIS.getrow(),TRUE)
end event

event dw_detalle::ue_itemmodify;call super::ue_itemmodify;Wf_Producto_Modificar( )
RETURN 1
end event

type tp_lista from w_process`tp_lista within tab_todo
integer width = 3872
integer height = 1944
string text = "Lista de Compras"
end type

type dw_lista from w_process`dw_lista within tp_lista
integer width = 3726
integer height = 1200
end type

type am_1 from w_process`am_1 within tp_lista
end type

type st_2 from w_process`st_2 within tp_lista
end type

type st_1 from w_process`st_1 within tp_lista
end type

type rb_filtro from w_process`rb_filtro within tp_lista
end type

type rb_seleccion from w_process`rb_seleccion within tp_lista
end type

type pb_refresh from w_process`pb_refresh within tp_lista
end type

type pb_orden from w_process`pb_orden within tp_lista
end type

type pb_filtro from w_process`pb_filtro within tp_lista
end type

type gb_tipo from w_process`gb_tipo within tp_lista
end type

type ddlb_campo from w_process`ddlb_campo within tp_lista
end type

type em_buscar from w_process`em_buscar within tp_lista
end type

type sle_buscar from w_process`sle_buscar within tp_lista
end type

type gb_busqueda from w_process`gb_busqueda within tp_lista
end type

type shl_cerrar from w_process`shl_cerrar within w_process_compra
integer y = 1892
end type

type shl_grabar from w_process`shl_grabar within w_process_compra
integer y = 1892
end type

type shl_eliminar from w_process`shl_eliminar within w_process_compra
integer y = 1892
end type

type shl_modificar from w_process`shl_modificar within w_process_compra
integer y = 1892
end type

type shl_nuevo from w_process`shl_nuevo within w_process_compra
integer y = 1892
end type

type uo_nav from w_process`uo_nav within w_process_compra
integer x = 1646
integer y = 1760
end type

type pb_cancelar from w_process`pb_cancelar within w_process_compra
integer y = 1740
end type

type pb_grabar from w_process`pb_grabar within w_process_compra
integer y = 1740
end type

type pb_eliminar from w_process`pb_eliminar within w_process_compra
integer y = 1740
end type

type pb_nuevo from w_process`pb_nuevo within w_process_compra
integer y = 1740
end type

type pb_cerrar from w_process`pb_cerrar within w_process_compra
integer y = 1740
end type

type shl_cancelar from w_process`shl_cancelar within w_process_compra
integer y = 1892
end type

type pb_modificar from w_process`pb_modificar within w_process_compra
integer y = 1740
end type

