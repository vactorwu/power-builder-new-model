HA$PBExportHeader$w_manto_entidadparametros.srw
forward
global type w_manto_entidadparametros from w_manto
end type
type dw_empresa from datawindow within tp_manto
end type
end forward

global type w_manto_entidadparametros from w_manto
integer width = 3630
integer height = 2740
string title = "Cat$$HEX1$$e100$$ENDHEX$$logo de Entidades"
string is_tabla = "ENTIDADPARAMETROS"
string is_campocod = "CodEntidadParametros"
string is_campoid = "IdEntidadParametros"
integer ii_largocod = 10
decimal id_codigo = 0.00
string is_campofinal = "Estado"
end type
global w_manto_entidadparametros w_manto_entidadparametros

type variables
DataWindowChild  idwc_Empresa

String &
is_CodEntidad, &
is_NombreEntidad, &
is_RucEntidad, &
is_EntidadCreditoTipo, &
is_CampoCodAnt, &
is_CampoCodOri

Integer &
ii_EntidadCredito, &
ii_EntidadEstado

Decimal id_Empresa_Seleccionada , &
id_EntidadCreditoLinea, &
id_EntidadCreditoDistribuido, &
id_EntidadCreditoSinDistribuir, &
id_EntidadCreditoUtilizado, &
id_EntidadCreditoSaldo, &
id_EntidadCreditoInteres

end variables

forward prototypes
public subroutine wf_datos_adicionales ()
public function long wf_dwkeyenter (keycode key, unsignedlong keyflags)
end prototypes

public subroutine wf_datos_adicionales ();
dwItemStatus l_status
l_status = idw_activa.GetItemStatus( idw_activa.getrow() , 0, Primary!)

choose case l_status
	case New!, NewModified!
			idw_activa.Object.IdEmpresa[idw_activa.getrow()]= id_Empresa_Seleccionada
			idw_activa.Object.IdEntidad[idw_activa.getrow()]=  id_Codigo		
end choose


end subroutine

public function long wf_dwkeyenter (keycode key, unsignedlong keyflags);String ls_columna , ls_Tipo , ls_Ruc


ls_columna = idw_activa.getcolumnname( )
ls_Tipo = idw_activa.Object.tipo.Primary.Current[idw_activa.GetRow()]
ls_Ruc =  idw_activa.Object.ruc.Primary.Current[idw_activa.GetRow()]
IF key = keyenter! then  
	idw_activa.accepttext( )
	choose case ls_columna
	case 'ruc'
		//Valido que sea Tipo juridica o que sea Natural y tenga Ruc
		IF (ls_Tipo = 'J') OR (ls_Tipo = 'N' AND Len(Trim(ls_Ruc)) > 0 ) THEN
			//Valido que el Numero de Ruc sea Valido
			If  Not uf_validaruc(String(ls_Ruc)) Then
				Messagebox("Advertencia","Ingrese un N$$HEX1$$fa00$$ENDHEX$$mero de Ruc Valido por favor verifique sus Datos",StopSign!)
				idw_activa.setcolumn( 'Ruc')
				idw_activa.SelectText(1, Len(idw_activa.GetText()))
				idw_activa.setfocus( )
				Return 0
			End If
		END IF
	case 'telefono'
			String ls_Id
			OpenWithParm(w_buscar_ubigeo_lista, "")
			ls_Id = Message.StringParm
			If Trim(ls_Id) = "" Then Return 0
			idw_activa.Object.IdUbigeo[idw_activa.GetRow()] = ls_Id
			idw_activa.Object.Ubigeo[idw_activa.GetRow()] =uf_get_ubigeo( ls_Id )
			idw_activa.Accepttext( )
			idw_activa.SelectText(1, Len(idw_activa.GetText()))
			idw_activa.setfocus( )	
	end choose
END IF

Return 1
end function

on w_manto_entidadparametros.create
int iCurrent
call super::create
end on

on w_manto_entidadparametros.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_save;call super::ue_save;
	is_CampoCod = is_CampoCodOri

end event

type gb_comandos from w_manto`gb_comandos within w_manto_entidadparametros
integer x = 55
integer y = 2192
integer width = 3470
end type

type tab_todo from w_manto`tab_todo within w_manto_entidadparametros
integer x = 0
integer width = 3607
integer height = 2564
end type

type tp_lista from w_manto`tp_lista within tab_todo
integer width = 3570
integer height = 2436
string text = "Lista de Entidades "
end type

type dw_lista from w_manto`dw_lista within tp_lista
integer y = 448
integer width = 3552
integer height = 1616
string dataobject = "d_entidad_lista"
end type

event dw_lista::ue_refresh;call super::ue_refresh;idw_lista.Retrieve()
//idw_lista.retrieve(gn_config.is_work.empresa)
end event

event dw_lista::ue_getid;call super::ue_getid;	id_Codigo= idw_lista.object.IdEntidad [this.getrow()]	
end event

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
integer width = 3570
integer height = 2436
string text = "Parametros de Entidad por Empresa"
dw_empresa dw_empresa
end type

on tp_manto.create
this.dw_empresa=create dw_empresa
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_empresa
end on

on tp_manto.destroy
call super::destroy
destroy(this.dw_empresa)
end on

type dw_manto from w_manto`dw_manto within tp_manto
integer x = 69
integer y = 80
integer width = 3250
integer height = 1920
string dataobject = "d_entidadparametros_manto"
boolean vscrollbar = false
boolean livescroll = false
end type

event dw_manto::buttonclicked;call super::buttonclicked;string ls_Id//1
If dwo.name = "b_ubigeo" Then
			OpenWithParm(w_buscar_ubigeo_lista, "")
			ls_Id = Message.StringParm
			If Trim(ls_Id) = "" Then Return 
			This.Object.IdUbigeo[This.GetRow()] = ls_Id
			This.Object.Ubigeo[This.GetRow()] =uf_get_ubigeo( ls_Id )
			This.Accepttext( )
			This.setcolumn( 'Direccion')
			This.SelectText(1, Len(This.GetText()))
			This.setfocus( )	
End If



end event

event dw_manto::ue_refresh;call super::ue_refresh;If idw_activa.retrieve(id_Empresa_Seleccionada ,  id_Codigo ) > 0 Then

End If
end event

event dw_manto::editchanged;call super::editchanged;dwItemStatus	le_status

String &
ls_Data , &
ls_Columna

Decimal &
ld_Data , & 
ld_CreditoLinea, & 
ld_CreditoLinea_Original, & 
ld_CreditoUtilizado, & 
ld_CreditoSinDistribuir_Original, & 
ld_CreditoDistribuido_Original

ls_Columna = Upper(String(dwo.name))

le_status = this.GetItemStatus (this.GetRow(), 0, primary!)

IF ls_Columna = Upper('CreditoLinea') OR ls_Columna = Upper('Credito') OR  ls_Columna = Upper('CreditoInteres') OR   ls_Columna = Upper('CreditoCiclo') OR  ls_Columna = Upper('CreditoDiasPago') THEN
	This.Accepttext( )
	ld_Data = Dec(DATA)
	ld_CreditoLinea 		= idw_activa.Object.CreditoLinea[row] 
	ld_CreditoUtilizado 	=  idw_activa.Object.CreditoUtilizado[row] 
		If ( le_status =new! or le_status = newmodified!) Then
			ld_CreditoLinea_Original 	 			= 0.00
			ld_CreditoDistribuido_Original		= id_EntidadCreditoDistribuido
			ld_CreditoSinDistribuir_Original		= id_EntidadCreditoSinDistribuir
		ElseIf ( le_status = DataModified!	) Then	
			ld_CreditoLinea_Original 	 			= Dec(idw_activa.Object.CreditoLinea.Primary.Original[idw_activa.GetRow()] )
			ld_CreditoDistribuido_Original		= Dec(idw_activa.Object.EntidadCreditoDistribuido.Primary.Original[idw_activa.GetRow()] )	
			ld_CreditoSinDistribuir_Original		= Dec(idw_activa.Object.EntidadCreditoSinDistribuir.Primary.Original[idw_activa.GetRow()] )
		End If
	
	IF ls_Columna = Upper('CreditoLinea')  Then
		 idw_activa.Object.CreditoSaldo[row]  =  ld_CreditoLinea - ld_CreditoUtilizado
		 idw_activa.Object.EntidadCreditoDistribuido[row]  = ld_CreditoDistribuido_Original  + ld_CreditoLinea - ld_CreditoLinea_Original
		 idw_activa.Object.EntidadCreditoSinDistribuir[row]  =  ld_CreditoSinDistribuir_Original  - ld_CreditoLinea + ld_CreditoLinea_Original		  
	End If
	
END IF
end event

event dw_manto::ue_newprevious;call super::ue_newprevious;String ls_Codigo

If idw_activa.GetRow( ) > 0 Then
	ls_Codigo = idw_activa.object.CodEntidadParametros[ idw_activa.GetRow( )]

	If IsNull(ls_Codigo) or ls_Codigo = "" Then
		is_CodEntidad						= idw_activa.object.CodEntidad[ idw_activa.GetRow( )]
		is_NombreEntidad					= idw_activa.object.NombreEntidad[ idw_activa.GetRow( )]
		is_RucEntidad						= idw_activa.object.RucEntidad[ idw_activa.GetRow( )]
		ii_EntidadCredito					= idw_activa.object.EntidadCredito[ idw_activa.GetRow( )]
		is_EntidadCreditoTipo				= idw_activa.object.EntidadCreditoTipo[ idw_activa.GetRow( )]
		id_EntidadCreditoLinea			= idw_activa.object.EntidadCreditoLinea[ idw_activa.GetRow( )]
		id_EntidadCreditoDistribuido	= idw_activa.object.EntidadCreditoDistribuido[ idw_activa.GetRow( )]
		id_EntidadCreditoSinDistribuir	= idw_activa.object.EntidadCreditoSinDistribuir[ idw_activa.GetRow( )]
		id_EntidadCreditoUtilizado		= idw_activa.object.EntidadCreditoUtilizado[ idw_activa.GetRow( )]
		id_EntidadCreditoSaldo			= idw_activa.object.EntidadCreditoSaldo[ idw_activa.GetRow( )]
		id_EntidadCreditoInteres		= idw_activa.object.EntidadCreditoInteres[ idw_activa.GetRow( )]
		ii_EntidadEstado					= idw_activa.object.EntidadEstado[ idw_activa.GetRow( )]
		
		If ii_EntidadEstado = 0 Then 
			Messagebox("Advertencia","No se puede generar parametro por que la entidad esta en estado INACTIVO",StopSign!)
			Return 0
		End If		

		Return 1
	Else
		Messagebox("Advertencia","No se puede generar parametro por que ya existe",StopSign!)
		Return 0
	End If
End If
end event

event dw_manto::ue_newafter;call super::ue_newafter;  idw_activa.object.CodEntidad[ idw_activa.GetRow( )]		=		is_CodEntidad	
  idw_activa.object.NombreEntidad[ il_newrow]              		=		is_NombreEntidad												
  idw_activa.object.RucEntidad[ il_newrow]                      	=		is_RucEntidad														
  idw_activa.object.EntidadCredito[ il_newrow]               	= 	     ii_EntidadCredito												
  idw_activa.object.EntidadCreditoTipo[ il_newrow]          	=		is_EntidadCreditoTipo										
  idw_activa.object.EntidadCreditoLinea[ il_newrow]         	=		id_EntidadCreditoLinea									
  idw_activa.object.EntidadCreditoDistribuido[ il_newrow]  	=		id_EntidadCreditoDistribuido						
  idw_activa.object.EntidadCreditoSinDistribuir[ il_newrow]	=		id_EntidadCreditoSinDistribuir					
  idw_activa.object.EntidadCreditoUtilizado[ il_newrow]    	=		id_EntidadCreditoUtilizado							
  idw_activa.object.EntidadCreditoSaldo[ il_newrow]        	=		id_EntidadCreditoSaldo									
  idw_activa.object.EntidadCreditoInteres[ il_newrow]      	=		id_EntidadCreditoInteres								
  idw_activa.object.EntidadEstado[ il_newrow]              		=		ii_EntidadEstado				
  
  tab_todo.tp_manto.dw_empresa.enabled = False
  Return 1
end event

event dw_manto::ue_saveafter;call super::ue_saveafter;tab_todo.tp_manto.dw_empresa.enabled = True
If ii_Save = 0 Then
	is_CampoCodAnt = is_CampoCod
	is_CampoCod = "CodEntidad"	
End If
Return 1

end event

event dw_manto::ue_undoafter;call super::ue_undoafter;		tab_todo.tp_manto.dw_empresa.enabled = True
		Return 1
end event

event dw_manto::ue_modifyprevious;call super::ue_modifyprevious;String ls_Codigo

If idw_activa.GetRow( ) > 0 Then
	ls_Codigo = idw_activa.object.CodEntidadParametros[ idw_activa.GetRow( )]

	If IsNull(ls_Codigo) or Trim(ls_Codigo) = "" Then
		Messagebox("Advertencia","No se puede modificar  parametro por que no existe",StopSign!)
		Return 0	
	Else
		ii_EntidadEstado  = idw_activa.object.EntidadEstado[ idw_activa.GetRow( )]
			
		If ii_EntidadEstado = 0 Then 
			Messagebox("Advertencia","No se puede modificar parametro por que la entidad esta en estado INACTIVO",StopSign!)
			Return 0
		End If		
		
		Return 1

	End If
End If
end event

event dw_manto::constructor;call super::constructor;is_CampoCodOri = Is_CampoCod
end event

event dw_manto::ue_deleteafter;call super::ue_deleteafter;  		tab_todo.tp_manto.dw_empresa.enabled = True
		Return 1
end event

event dw_manto::ue_deleteprevious;call super::ue_deleteprevious;String ls_Codigo , ls_Mensaje
Decimal &
ld_CreditoLinea, &
ld_CreditoUtilizado, &
ld_CreditoSaldo
Integer li_Estado , li_Credito

If idw_activa.GetRow( ) > 0 Then
	ls_Codigo = idw_activa.object.CodEntidadParametros[ idw_activa.GetRow( )]

	If IsNull(ls_Codigo) or Trim(ls_Codigo) = "" Then
		Messagebox("Advertencia","No se puede eliminar parametro por que no existe",StopSign!)
		Return 0	
	Else
		li_Credito= idw_activa.object.Credito[ idw_activa.GetRow( )]
		li_Estado  = idw_activa.object.Estado[ idw_activa.GetRow( )]
		ld_CreditoLinea = idw_activa.object.CreditoLinea[ idw_activa.GetRow( )]
		ld_CreditoUtilizado= idw_activa.object.CreditoUtilizado[ idw_activa.GetRow( )]
		ld_CreditoSaldo= idw_activa.object.CreditoSaldo[ idw_activa.GetRow( )]
		
		If ld_CreditoUtilizado > 0.00 THEN
			ls_Mensaje  = " No se puede eliminar parametro por que tiene saldos en creditos"
			If li_Credito = 1 Then ls_Mensaje  = ls_Mensaje  +" se recomienda desmarcar el Parametro Credito "
			Messagebox("Advertencia",ls_Mensaje,StopSign!)
			Return 0		
		End If

		ls_Mensaje  =  "Se procedera a Eliminar el siguiente parametro y con ello la configuraci$$HEX1$$f300$$ENDHEX$$n de parametros para esta Entidad - Empresa "+Char(13)
		If li_Estado = 1  Then ls_Mensaje  = ls_Mensaje  + "Se recomienda poner el Parametro en estado INACTIVO"+Char(13)
		ls_Mensaje  = ls_Mensaje  +"Realmente desea Eliminar el registro...?"
		
		If	Messagebox("Advertencia",ls_Mensaje,Exclamation!, YesNo!) = 2 Then
			Return 0
		End If				
	
		Return 1

	End If
End If
end event

event dw_manto::itemchanged;call super::itemchanged;dwItemStatus	le_status
Int  li_Credito_Original, li_Credito_Actual, li_EntidadCredito
String ls_EntidadCreditotipo
This.Accepttext( )

le_status = this.GetItemStatus (this.GetRow(), 0, primary!)

choose case dwo.name
	case 'credito'
		li_EntidadCredito   = Integer(idw_activa.Object.EntidadCredito[idw_activa.GetRow()] )
		li_Credito_Original	= Integer(idw_activa.Object.Credito.Primary.Original[idw_activa.GetRow()] )
		li_Credito_Actual 	= Integer(data)
		
		If ( le_status =new! or le_status = newmodified!) Then
		     	If li_Credito_Actual = 1 Then
					idw_activa.Object.Cliente[idw_activa.GetRow()] = 1
					IF idw_activa.Object.EntidadCreditoTipo[idw_activa.GetRow()] <> 'M' Then
						idw_activa.Object.CreditoTipo[idw_activa.GetRow()]  =  idw_activa.Object.EntidadCreditoTipo[idw_activa.GetRow()]
					End If
				Else
				     idw_activa.Object.Cliente[idw_activa.GetRow()]        = 0						
					idw_activa.Object.CreditoTipo[idw_activa.GetRow()]        = ''
					idw_activa.Object.CreditoLinea[idw_activa.GetRow()]       =  0.00
					idw_activa.Object.CreditoUtilizado[idw_activa.GetRow()]  =  0.00
					idw_activa.Object.CreditoSaldo[idw_activa.GetRow()]       =  0.00	
					idw_activa.Object.EntidadCreditoDistribuido[idw_activa.GetRow()]     = id_EntidadCreditoDistribuido
					idw_activa.Object.EntidadCreditoSinDistribuir[idw_activa.GetRow()]    =  id_EntidadCreditoSinDistribuir
					
				End If
			ElseIf ( le_status = DataModified!	) Then
				If li_Credito_Actual = 1 Then
					If li_Credito_Original = 0 Then
						idw_activa.Object.Cliente[idw_activa.GetRow()] = 1
						IF idw_activa.Object.EntidadCreditoTipo[idw_activa.GetRow()] <> 'M' Then
							idw_activa.Object.CreditoTipo[idw_activa.GetRow()]  =  idw_activa.Object.EntidadCreditoTipo[idw_activa.GetRow()]
						End If
					Else
					     idw_activa.Object.Cliente[idw_activa.GetRow()]        =  idw_activa.Object.Cliente.Primary.Original[idw_activa.GetRow()]								
						idw_activa.Object.CreditoTipo[idw_activa.GetRow()]        =  idw_activa.Object.CreditoTipo.Primary.Original[idw_activa.GetRow()]
						idw_activa.Object.CreditoLinea[idw_activa.GetRow()]       =  idw_activa.Object.CreditoLinea.Primary.Original[idw_activa.GetRow()]
						idw_activa.Object.CreditoUtilizado[idw_activa.GetRow()]  =  idw_activa.Object.CreditoUtilizado.Primary.Original[idw_activa.GetRow()]					
						idw_activa.Object.CreditoSaldo[idw_activa.GetRow()]       =  idw_activa.Object.CreditoSaldo.Primary.Original[idw_activa.GetRow()]						
						idw_activa.Object.EntidadCreditoDistribuido[idw_activa.GetRow()]       =  idw_activa.Object.EntidadCreditoDistribuido.Primary.Original[idw_activa.GetRow()]			
						idw_activa.Object.EntidadCreditoSinDistribuir[idw_activa.GetRow()]        =  idw_activa.Object.EntidadCreditoSinDistribuir.Primar						
					End If
				Else

					idw_activa.Object.Cliente[idw_activa.GetRow()]        =  idw_activa.Object.Cliente.Primary.Original[idw_activa.GetRow()]				
					idw_activa.Object.CreditoLinea[idw_activa.GetRow()]       =  idw_activa.Object.CreditoLinea.Primary.Original[idw_activa.GetRow()]
					idw_activa.Object.CreditoUtilizado[idw_activa.GetRow()]  =  idw_activa.Object.CreditoUtilizado.Primary.Original[idw_activa.GetRow()]					
					idw_activa.Object.CreditoSaldo[idw_activa.GetRow()]       =  idw_activa.Object.CreditoSaldo.Primary.Original[idw_activa.GetRow()]			
					idw_activa.Object.CreditoTipo[idw_activa.GetRow()]        =  idw_activa.Object.CreditoTipo.Primary.Original[idw_activa.GetRow()] 					
					idw_activa.Object.EntidadCreditoDistribuido[idw_activa.GetRow()]       =  idw_activa.Object.EntidadCreditoDistribuido.Primary.Original[idw_activa.GetRow()]			
					idw_activa.Object.EntidadCreditoSinDistribuir[idw_activa.GetRow()]        =  idw_activa.Object.EntidadCreditoSinDistribuir.Primary.Original[idw_activa.GetRow()] 

					
//					If Not ( idw_activa.Object.CreditoLinea[idw_activa.GetRow()]  =  0.00  AND idw_activa.Object.CreditoTipo[idw_activa.GetRow()]  = "" ) Then
//						idw_activa.Object.CreditoTipo[idw_activa.GetRow()]        =  idw_activa.Object.CreditoTipo.Primary.Original[idw_activa.GetRow()] 
//					End If

				End If
		End If
		
	case 'creditotipo'
		If String(data) = "G" Then
			idw_activa.Object.CreditoLinea[idw_activa.GetRow()]   = 0.00
			idw_activa.Object.CreditoSaldo[idw_activa.GetRow()]   = 0.00			
		Else
			idw_activa.Object.CreditoLinea[idw_activa.GetRow()]       =  idw_activa.Object.CreditoLinea.Primary.Original[idw_activa.GetRow()]
			idw_activa.Object.CreditoSaldo[idw_activa.GetRow()]       =  idw_activa.Object.CreditoSaldo.Primary.Original[idw_activa.GetRow()]					
		End If
end choose

end event

event dw_manto::ue_saveprevious;call super::ue_saveprevious;// Validar la Parte de Creditos y Parametros
Int &
li_Credito_Original,& 
li_Credito_Actual

String &
ls_CreditoTipo_Original,& 
ls_CreditoTipo_Actual

Decimal &
ld_CreditoLinea_Original,& 
ld_CreditoUtilizado_Original,& 
ld_CreditoSaldo_Original,& 
ld_CreditoSinDistribuir_Original,& 
ld_CreditoLinea_Actual,& 
ld_CreditoUtilizado_Actual,& 
ld_CreditoSaldo_Actual,& 
ld_CreditoLimite_Actual

DateTime &
ldt_CreditoFecha_Original,& 
ldt_CreditoFechaInicio_Original,& 
ldt_CreditoFechaFin_Original,& 
ldt_CreditoFechaProceso_Original,& 
ldt_CreditoFecha_Actual,& 
ldt_CreditoFechaInicio_Actual,& 
ldt_CreditoFechaFin_Actual,& 
ldt_CreditoFechaProceso_Actual

This.accepttext( )

li_Credito_Original 					= Integer(idw_activa.Object.Credito.Primary.Original[idw_activa.GetRow()] )
li_Credito_Actual 						= Integer(idw_activa.Object.Credito.Primary.Current[idw_activa.GetRow()] )


ls_CreditoTipo_Original 				= String(idw_activa.Object.CreditoTipo.Primary.Original[idw_activa.GetRow()] )
ls_CreditoTipo_Actual 				= String(idw_activa.Object.CreditoTipo.Primary.Current[idw_activa.GetRow()] )

ld_CreditoLinea_Original 				= Dec(idw_activa.Object.CreditoLinea.Primary.Original[idw_activa.GetRow()] )
ld_CreditoUtilizado_Original 			= Dec(idw_activa.Object.CreditoUtilizado.Primary.Original[idw_activa.GetRow()] )
ld_CreditoSaldo_Original 			= Dec(idw_activa.Object.CreditoSaldo.Primary.Original[idw_activa.GetRow()] )
ld_CreditoSinDistribuir_Original		= Dec(idw_activa.Object.EntidadCreditoSinDistribuir.Primary.Original[idw_activa.GetRow()] )

ld_CreditoLinea_Actual 				= Dec(idw_activa.Object.CreditoLinea.Primary.Current[idw_activa.GetRow()] )
ld_CreditoUtilizado_Actual			= Dec(idw_activa.Object.CreditoUtilizado.Primary.Current[idw_activa.GetRow()] )
ld_CreditoSaldo_Actual				= Dec(idw_activa.Object.CreditoSaldo.Primary.Current[idw_activa.GetRow()] )

ld_CreditoLimite_Actual 	= ld_CreditoSinDistribuir_Original + ld_CreditoLinea_Original

		IF  li_Credito_Actual  = 1 Then
			IF ls_CreditoTipo_Actual = ""  or IsNull(ls_CreditoTipo_Actual) THEN 
				messagebox("Advertecia " + Gn_Config.Is_Work.Aplicacion  ,"Selecciones un Tipo de Credito  Diferente de NINGUNO",StopSign!)
				this.setcolumn('CreditoTipo')
				this.SelectText(1, Len(this.GetText()))
				this.setfocus( )
				Return 0		
			END IF
			IF ld_CreditoLinea_Actual <= 0.00  or IsNull(ld_CreditoLinea_Actual)  THEN 
				IF ls_CreditoTipo_Actual = 'L' THEN
					messagebox("Advertecia " + Gn_Config.Is_Work.Aplicacion  ,"La Linea de Credito debe ser mayor a Cero",StopSign!)
					this.setcolumn('CreditoLinea')
					this.SelectText(1, Len(this.GetText()))
					this.setfocus( )
					Return 0		
				END IF			
			END IF	
			IF ld_CreditoSaldo_Actual < 0.00  or IsNull(ld_CreditoSaldo_Actual) THEN 
				messagebox("Advertecia " + Gn_Config.Is_Work.Aplicacion  ,"El Saldo debe ser mayor o Igual a Cero",StopSign!)
				this.setcolumn('CreditoLinea')
				this.SelectText(1, Len(this.GetText()))
				this.setfocus( )
				Return 0		
			END IF				
			IF ld_CreditoLimite_Actual < ld_CreditoLinea_Actual THEN 
				messagebox("Advertecia " + Gn_Config.Is_Work.Aplicacion  ,"La Linea de Credito exede en "+String(ld_CreditoLinea_Actual - ld_CreditoLimite_Actual , "###,###,###.00")+" a lo permitido",StopSign!)
				this.setcolumn('CreditoLinea')
				this.SelectText(1, Len(this.GetText()))
				this.setfocus( )
				Return 0		
			END IF				
		END IF	
Return 1		
end event

type pb_borrar from w_manto`pb_borrar within tp_manto
end type

type pb_abrir from w_manto`pb_abrir within tp_manto
end type

type ole_1 from w_manto`ole_1 within tp_manto
integer x = 2171
integer y = 612
end type

type shl_cerrar from w_manto`shl_cerrar within w_manto_entidadparametros
integer x = 3099
integer y = 2404
end type

type shl_grabar from w_manto`shl_grabar within w_manto_entidadparametros
integer x = 1015
integer y = 2404
end type

type shl_eliminar from w_manto`shl_eliminar within w_manto_entidadparametros
integer x = 704
integer y = 2404
end type

type shl_modificar from w_manto`shl_modificar within w_manto_entidadparametros
integer x = 393
integer y = 2404
end type

type shl_nuevo from w_manto`shl_nuevo within w_manto_entidadparametros
integer x = 82
integer y = 2404
end type

type uo_nav from w_manto`uo_nav within w_manto_entidadparametros
integer x = 1632
integer y = 2300
end type

type pb_cancelar from w_manto`pb_cancelar within w_manto_entidadparametros
integer x = 1394
integer y = 2252
end type

type pb_grabar from w_manto`pb_grabar within w_manto_entidadparametros
integer x = 1083
integer y = 2252
end type

type pb_eliminar from w_manto`pb_eliminar within w_manto_entidadparametros
integer x = 773
integer y = 2252
end type

type pb_nuevo from w_manto`pb_nuevo within w_manto_entidadparametros
integer x = 151
integer y = 2252
end type

type pb_cerrar from w_manto`pb_cerrar within w_manto_entidadparametros
integer x = 3168
integer y = 2252
end type

type shl_cancelar from w_manto`shl_cancelar within w_manto_entidadparametros
integer x = 1326
integer y = 2404
end type

type pb_modificar from w_manto`pb_modificar within w_manto_entidadparametros
integer x = 462
integer y = 2252
end type

type dw_empresa from datawindow within tp_manto
integer x = 46
integer y = 20
integer width = 2935
integer height = 84
integer taborder = 60
boolean bringtotop = true
string title = "none"
string dataobject = "d_empresa_ddlbdw"
boolean border = false
boolean livescroll = true
end type

event constructor;Long ll_Filas ,  ll_Fila
IF dw_empresa.GetChild('IdEmpresa', idwc_Empresa) = -1 THEN MessageBox(  "Error", "CreditoCiclo Not a DataWindowChild")
idwc_Empresa.SetTransObject(SQLCA)
 ll_Filas = idwc_Empresa.Retrieve() 
 ll_Fila = This.InsertRow( 0 )
This.ScrollToRow(ll_Fila )
id_Empresa_Seleccionada = 0
If ll_Filas > 0 Then 
	id_Empresa_Seleccionada =  idwc_Empresa.GetItemDecimal( 1,'IdEmpresa' ) 
	dw_empresa.object.IdEmpresa[ll_Fila] = id_Empresa_Seleccionada
End If

This.Accepttext( )
end event

event itemchanged;This.accepttext( )
If row > 0 Then 
	 id_Empresa_Seleccionada = dw_empresa.object.IdEmpresa[row] 
	 idw_activa.event ue_refresh( )
End If
end event

event editchanged;This.accepttext( )
If row > 0 Then 
	 id_Empresa_Seleccionada = dw_empresa.object.IdEmpresa[row] 
	 idw_activa.event ue_refresh( )
End If
end event

event rowfocuschanged;This.accepttext( )
If currentrow > 0 Then 
	 id_Empresa_Seleccionada = dw_empresa.object.IdEmpresa[currentrow] 
	 idw_activa.event ue_refresh( )
End If
end event

