HA$PBExportHeader$w_buscar_entidad.srw
forward
global type w_buscar_entidad from w_buscar
end type
end forward

global type w_buscar_entidad from w_buscar
integer width = 2555
integer height = 1584
string title = "Busqueda de Entidades"
string is_cpcampoid = "idunidad"
string is_cpcodigo = "codigo"
string is_cpdescripccion = "descripcion"
end type
global w_buscar_entidad w_buscar_entidad

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

public subroutine wf_abrir ();Long lo_p

Is_Datos= Message.PowerObjectParm

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

on w_buscar_entidad.create
call super::create
end on

on w_buscar_entidad.destroy
call super::destroy
end on

event open;call super::open;//is_CPcampoid 		='identidad'	// Nombre del Campo Id para devolver el Valor
//is_CPCodigo			='codigo'			// Nombre del Campo del Codigo para Buscar
//is_CPDescripccion	='razonsocial'	// Nombre del Campo de Descripcion para Buscar

end event

type cb_aceptar from w_buscar`cb_aceptar within w_buscar_entidad
integer x = 658
end type

type cb_cerrar from w_buscar`cb_cerrar within w_buscar_entidad
end type

type pb_refresh from w_buscar`pb_refresh within w_buscar_entidad
end type

type pb_orden from w_buscar`pb_orden within w_buscar_entidad
end type

type pb_filtro from w_buscar`pb_filtro within w_buscar_entidad
end type

type em_buscar from w_buscar`em_buscar within w_buscar_entidad
end type

type rb_filtro from w_buscar`rb_filtro within w_buscar_entidad
end type

type rb_seleccion from w_buscar`rb_seleccion within w_buscar_entidad
end type

type dw_lista from w_buscar`dw_lista within w_buscar_entidad
string dataobject = "d_entidad_lista"
end type

event dw_lista::constructor;call super::constructor;THIS.Retrieve( )
end event

event dw_lista::ue_getid;call super::ue_getid;IF THIS.RowCount() > 0  THEN
	id_Codigo=THIS.Object.IdEntidad [THIS.GetRow()]	
	Codigo=THIS.Object.CodEntidad [THIS.GetRow()]	
	Is_Datos.idcodigo = id_Codigo
	Is_Datos.codigo = Codigo
	
	
	Is_Datos.paramS[1] = THIS.Object.Tipo [THIS.GetRow()]	 
	Is_Datos.paramS[2] = THIS.Object.RazonSocial[THIS.GetRow()]	
	
	IF IsNull(THIS.Object.Ruc[THIS.GetRow()]) OR THIS.Object.Ruc[THIS.GetRow()]	= "" THEN
		Is_Datos.paramS[3] = "DNI"
		Is_Datos.paramD[1] = THIS.Object.DocumentoIdentidad[THIS.GetRow()]
		Is_Datos.paramS[5] = THIS.Object.DocumentoIdentidadNumero [THIS.GetRow()]	
	ELSE
		Is_Datos.paramS[3] = "RUC"
		Is_Datos.paramD[1] = 2
		Is_Datos.paramS[5] = THIS.Object.Ruc[THIS.GetRow()]	
	END IF
	Is_Datos.paramS[6] = THIS.Object.Direccion [THIS.GetRow()]	
	Is_Datos.paramS[7] = THIS.Object.IdUbigeo [THIS.GetRow()]	
	Is_Datos.paramS[8] = THIS.Object.Ubigeo [THIS.GetRow()]	
END IF
end event

type st_2 from w_buscar`st_2 within w_buscar_entidad
end type

type st_1 from w_buscar`st_1 within w_buscar_entidad
end type

type am_1 from w_buscar`am_1 within w_buscar_entidad
integer y = 76
string animationname = "monitor.avi"
end type

type gb_tipo from w_buscar`gb_tipo within w_buscar_entidad
end type

type ddlb_campo from w_buscar`ddlb_campo within w_buscar_entidad
end type

type gb_busqueda from w_buscar`gb_busqueda within w_buscar_entidad
end type

