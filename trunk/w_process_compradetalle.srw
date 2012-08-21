HA$PBExportHeader$w_process_compradetalle.srw
forward
global type w_process_compradetalle from w_response
end type
type cb_cancelar from commandbutton within w_process_compradetalle
end type
type cb_aceptar from commandbutton within w_process_compradetalle
end type
type dw_compradetalle from u_dw within w_process_compradetalle
end type
end forward

global type w_process_compradetalle from w_response
integer width = 4091
integer height = 1672
string title = "Ingreso de Detalle de Compras"
cb_cancelar cb_cancelar
cb_aceptar cb_aceptar
dw_compradetalle dw_compradetalle
end type
global w_process_compradetalle w_process_compradetalle

type variables
Long Il_Fila ,  Il_FilaHistoria,  Il_FilaModificada

st_datos Is_Datos , Is_DatosNull , Is_DatosParam

DataWindowChild   idwc_Impuesto , idwc_Impuesto2 , idwc_Impuesto3 , idwc_Impuesto4 , idwc_Fraccion
end variables

forward prototypes
public subroutine wf_producto_buscar (string as_campo)
public subroutine wf_producto_llenar_datos (st_datos ast_datos)
public subroutine wf_abrir ()
public subroutine wf_aceptar ()
public subroutine wf_cancelar ()
end prototypes

public subroutine wf_producto_buscar (string as_campo);//ld_Id = idw_activa.Object.IdEntidad.Primary.Current[idw_activa.GetRow()]

Is_DatosParam.ParamS[1] = as_campo
Is_DatosParam.ParamS[2] = dw_compradetalle.GetItemString( Il_Fila,as_campo)

OpenWithParm(w_buscar_producto, Is_DatosParam, THIS)
Is_DatosParam = Is_DatosNull
Is_Datos= Message.PowerObjectParm

IF IsValid(Is_Datos)  THEN
  	Wf_Producto_Llenar_Datos(Is_Datos)
	Is_Datos = Is_DatosNull
ELSE
//	Wf_Entidad_Borrar_datos( )
END IF


end subroutine

public subroutine wf_producto_llenar_datos (st_datos ast_datos);Long Ll_Fila

dw_compradetalle.Object.IdProducto[Il_Fila]  			= 	ast_Datos.idcodigo
dw_compradetalle.Object.CodProducto[Il_Fila] 		=  	ast_Datos.codigo 

dw_compradetalle.Object.Nombre [Il_Fila]	 			=	ast_Datos.paramS[1] 
//dw_compradetalle.Object.NombreCorto [Il_Fila]		= 	ast_Datos.paramS[2]

dw_compradetalle.Object.ImpuestoEstado[Il_Fila]	= 	ast_Datos.paramN[1]
dw_compradetalle.Object.IdImpuesto[Il_Fila]			=  	ast_Datos.paramD[1]
dw_compradetalle.Object.Impuesto2Estado[Il_Fila]	=  	ast_Datos.paramN[2]
dw_compradetalle.Object.IdImpuesto2[Il_Fila]			= 	ast_Datos.paramD[2]
dw_compradetalle.Object.Impuesto3Estado[Il_Fila]	= 	ast_Datos.paramN[3]
dw_compradetalle.Object.IdImpuesto3[Il_Fila]			=  	ast_Datos.paramD[3]
dw_compradetalle.Object.Impuesto4Estado[Il_Fila]	=  	ast_Datos.paramN[4]
dw_compradetalle.Object.IdImpuesto4[Il_Fila]			=  	ast_Datos.paramD[4]

dw_compradetalle.Object.IdUnidadMinima[Il_Fila]		=  	ast_Datos.paramD[5]

If idwc_Fraccion.Retrieve(ast_Datos.idcodigo) > 0 Then
		idwc_Fraccion.accepttext( )
		dw_compradetalle.Object.IdUnidad[Il_Fila]	= idwc_Fraccion.GetItemNumber(1,'IdFraccion')
		dw_compradetalle.Object.IdUnidadFraccion[Il_Fila]	  	= idwc_Fraccion.GetItemNumber(1,'IdUnidad')		
		dw_compradetalle.Object.Abreviacion[Il_Fila]	= idwc_Fraccion.GetItemString(1,'Abreviacion')				
		dw_compradetalle.Object.Fracciones[Il_Fila]	= idwc_Fraccion.GetItemNumber(1,'Cantidad')		
End IF

Is_Datos = Is_DatosNull





end subroutine

public subroutine wf_abrir ();
Is_Datos= Message.PowerObjectParm

IF IsValid(Is_Datos)  THEN
	IF UpperBound (Is_Datos.paramL)>0  THEN
		Il_FilaModificada = Is_Datos.paramL[1]	
		dw_CompraDetalle.Object.Data[Il_Fila]  = Is_Datos.paramA[1]
		dw_CompraDetalle.SetFocus( )
	END IF
END IF	
end subroutine

public subroutine wf_aceptar ();
dw_compradetalle.event ue_getid( )
CloseWithReturn(this, is_datos)
end subroutine

public subroutine wf_cancelar ();CloseWithReturn(THIS, Is_DatosNull)
end subroutine

on w_process_compradetalle.create
int iCurrent
call super::create
this.cb_cancelar=create cb_cancelar
this.cb_aceptar=create cb_aceptar
this.dw_compradetalle=create dw_compradetalle
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_cancelar
this.Control[iCurrent+2]=this.cb_aceptar
this.Control[iCurrent+3]=this.dw_compradetalle
end on

on w_process_compradetalle.destroy
call super::destroy
destroy(this.cb_cancelar)
destroy(this.cb_aceptar)
destroy(this.dw_compradetalle)
end on

event open;call super::open;Wf_Abrir( )
end event

type cb_cancelar from commandbutton within w_process_compradetalle
integer x = 2222
integer y = 1444
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Cancelar"
end type

event clicked;Wf_Cancelar()
end event

type cb_aceptar from commandbutton within w_process_compradetalle
integer x = 1577
integer y = 1440
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Aceptar"
end type

event clicked;Wf_Aceptar()
end event

type dw_compradetalle from u_dw within w_process_compradetalle
integer width = 3909
integer height = 1416
string dataobject = "d_compradetalle_fila"
end type

event constructor;call super::constructor;Il_Fila = This.InsertRow( 0 )

String ls_Fecha
ls_Fecha = String(DateTime(gn_config.is_work.FechaTrabajo,Time(0,0,0)) , "DD/MM/YYYY HH:MM:SS")

IF THIS.GetChild('IdImpuesto', idwc_Impuesto) = -1 THEN MessageBox(  "Error", "IdImpuesto Not a DataWindowChild")
idwc_Impuesto.SetTransObject(SQLCA)
idwc_Impuesto.Retrieve(ls_Fecha)

IF THIS.GetChild('IdImpuesto2', idwc_Impuesto2) = -1 THEN MessageBox(  "Error", "IdImpuesto2 Not a DataWindowChild")
idwc_Impuesto2.SetTransObject(SQLCA)
idwc_Impuesto2.Retrieve(ls_Fecha)

IF THIS.GetChild('IdImpuesto3', idwc_Impuesto3) = -1 THEN MessageBox(  "Error", "IdImpuesto3 Not a DataWindowChild")
idwc_Impuesto3.SetTransObject(SQLCA)
idwc_Impuesto3.Retrieve(ls_Fecha)

IF THIS.GetChild('IdImpuesto4', idwc_Impuesto4) = -1 THEN MessageBox(  "Error", "IdImpuesto4 Not a DataWindowChild")
idwc_Impuesto4.SetTransObject(SQLCA)
idwc_Impuesto4.Retrieve(ls_Fecha)

IF THIS.GetChild('IdUnidad', idwc_Fraccion) = -1 THEN MessageBox(  "Error", "IdFraccion Not a DataWindowChild")
idwc_Fraccion.SetTransObject(SQLCA)



end event

event ue_dwnkey;call super::ue_dwnkey;String Ls_Campo
Ls_Campo = THIS.GetColumnName( )
THIS.accepttext( )	
	
IF key = keyenter! THEN  

	IF Upper(THIS.getcolumnname( )) =Upper("A") THEN
		cb_aceptar.event clicked( )
	ELSE 
		IF Ls_Campo = 'codproducto' OR Ls_Campo = 'nombre' THEN Wf_Producto_Buscar(Ls_Campo)
		
  		Send(Handle(THIS), 256, 9, long(0,0))
		THIS.SelectText(1, Len(THIS.GetText()))
		THIS.setfocus( )
	END IF
END IF

end event

event ue_getid;call super::ue_getid;IF THIS.RowCount() > 0  THEN
	THIS.AcceptText( )
	Is_Datos.idcodigo 		= THIS.Object.IdProducto [THIS.GetRow()]	
	Is_Datos.codigo 		= THIS.Object.CodProducto[THIS.GetRow()]	
	Is_Datos.paramL[1] 	= Il_FilaModificada	
	Is_Datos.paramA[1] 	= THIS.Object.Data[THIS.GetRow()] 
END IF
end event

