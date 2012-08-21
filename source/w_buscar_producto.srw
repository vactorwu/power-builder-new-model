HA$PBExportHeader$w_buscar_producto.srw
forward
global type w_buscar_producto from w_buscar
end type
end forward

global type w_buscar_producto from w_buscar
integer width = 2555
integer height = 1584
string title = "Busqueda de Entidades"
string is_cpcampoid = "idunidad"
string is_cpcodigo = "codigo"
string is_cpdescripccion = "descripcion"
end type
global w_buscar_producto w_buscar_producto

forward prototypes
public subroutine wf_aceptar ()
public subroutine wf_cancelar ()
public subroutine wf_abrir ()
end prototypes

public subroutine wf_aceptar ();Idw_lista.event ue_getid( )
CloseWithReturn(this, is_datos)
end subroutine

public subroutine wf_cancelar ();CloseWithReturn(this, is_datosnull)
end subroutine

public subroutine wf_abrir ();Is_Datos= Message.PowerObjectParm

IF IsValid(Is_Datos)  THEN
	IF UpperBound (Is_Datos.ParamS)>0  THEN
		is_campo = Is_Datos.ParamS[1]
		is_campotag =wf_iscampotag(is_campo)
		ddlb_campo.selectitem(ddlb_campo.Finditem(is_campotag,1))
		wf_tipodato( is_campo )
		em_buscar.text = Is_Datos.ParamS[2]
		em_buscar.SelectText(Len(em_buscar.Text) + 1 , 0)
		em_buscar.triggerevent('ue_keyup')
		em_buscar.setfocus( )
	END IF
END IF	
end subroutine

on w_buscar_producto.create
call super::create
end on

on w_buscar_producto.destroy
call super::destroy
end on

event open;call super::open;//is_CPcampoid 		='identidad'	// Nombre del Campo Id para devolver el Valor
//is_CPCodigo			='codigo'			// Nombre del Campo del Codigo para Buscar
//is_CPDescripccion	='razonsocial'	// Nombre del Campo de Descripcion para Buscar

end event

type cb_aceptar from w_buscar`cb_aceptar within w_buscar_producto
integer x = 658
end type

type cb_cerrar from w_buscar`cb_cerrar within w_buscar_producto
end type

type pb_refresh from w_buscar`pb_refresh within w_buscar_producto
end type

type pb_orden from w_buscar`pb_orden within w_buscar_producto
end type

type pb_filtro from w_buscar`pb_filtro within w_buscar_producto
end type

type em_buscar from w_buscar`em_buscar within w_buscar_producto
end type

type rb_filtro from w_buscar`rb_filtro within w_buscar_producto
end type

type rb_seleccion from w_buscar`rb_seleccion within w_buscar_producto
end type

type dw_lista from w_buscar`dw_lista within w_buscar_producto
string dataobject = "d_producto_lista"
end type

event dw_lista::constructor;call super::constructor;THIS.retrieve(gn_config.is_work.idempresa )
end event

event dw_lista::ue_getid;call super::ue_getid;If THIS.RowCount() > 0  Then
	id_Codigo=THIS.Object.IdProducto [THIS.getrow()]	
	Codigo=THIS.Object.CodProducto [THIS.getrow()]	
	Is_Datos.idcodigo = id_Codigo
	Is_Datos.codigo = Codigo
	
	Is_Datos.paramS[1] = THIS.Object.Nombre [THIS.getrow()]	 
	Is_Datos.paramS[2] = THIS.Object.NombreCorto [THIS.getrow()]	

	Is_Datos.paramN[1] = THIS.Object.ImpuestoEstado[THIS.getrow()]			
	Is_Datos.paramD[1] = THIS.Object.IdImpuesto[THIS.getrow()]
	Is_Datos.paramN[2] = THIS.Object.Impuesto2Estado[THIS.getrow()]	
	Is_Datos.paramD[2] = THIS.Object.IdImpuesto2[THIS.getrow()]
	Is_Datos.paramN[3] = THIS.Object.Impuesto3Estado[THIS.getrow()]	
	Is_Datos.paramD[3] = THIS.Object.IdImpuesto3[THIS.getrow()]
	Is_Datos.paramN[4] = THIS.Object.Impuesto4Estado[THIS.getrow()]	
	Is_Datos.paramD[4] = THIS.Object.IdImpuesto4[THIS.getrow()]

	Is_Datos.paramD[5] = THIS.Object.IdUnidadMinima[THIS.getrow()]

End If
end event

type st_2 from w_buscar`st_2 within w_buscar_producto
end type

type st_1 from w_buscar`st_1 within w_buscar_producto
end type

type am_1 from w_buscar`am_1 within w_buscar_producto
integer y = 76
end type

type gb_tipo from w_buscar`gb_tipo within w_buscar_producto
end type

type ddlb_campo from w_buscar`ddlb_campo within w_buscar_producto
end type

type gb_busqueda from w_buscar`gb_busqueda within w_buscar_producto
end type

