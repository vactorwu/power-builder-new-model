HA$PBExportHeader$w_manto_entidad_mini.srw
forward
global type w_manto_entidad_mini from w_manto
end type
type cb_aceptar from commandbutton within w_manto_entidad_mini
end type
type cb_cancelar from commandbutton within w_manto_entidad_mini
end type
end forward

global type w_manto_entidad_mini from w_manto
integer width = 3607
integer height = 2192
string title = "Cat$$HEX1$$e100$$ENDHEX$$logo de Entidades"
string menuname = ""
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
boolean ib_preguntarsalir = false
string is_tabla = "ENTIDAD"
string is_campocod = "CodEntidad"
string is_campoid = "IdEntidad"
integer ii_largocod = 10
boolean ib_insertaralgrabar = false
decimal id_codigo = 0.00
string is_campofinal = "Estado"
cb_aceptar cb_aceptar
cb_cancelar cb_cancelar
end type
global w_manto_entidad_mini w_manto_entidad_mini

type variables
DataWindowChild idwc_DocumentoIdentidad 
St_Datos Ist_Datos , Ist_DatosNull
String Is_CodEntidad
end variables

forward prototypes
public subroutine wf_datos_adicionales ()
public function long wf_dwkeyenter (keycode key, unsignedlong keyflags)
public subroutine wf_validartipo (string as_tipo)
public subroutine wf_ubigeo ()
end prototypes

public subroutine wf_datos_adicionales ();//
//dwItemStatus l_status
//l_status = idw_activa.GetItemStatus( idw_activa.getrow() , 0, Primary!)
//
//choose case l_status
//	case New!, NewModified!
//			idw_activa.Object.IdEmpresa[idw_activa.getrow()]= gn_config.is_work.idempresa
//end choose
//
//
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
		Wf_Ubigeo()
	end choose
END IF

Return 1
end function

public subroutine wf_validartipo (string as_tipo);choose case as_tipo
	case 'J'
		idw_activa.Modify("ApellidoPaterno.Tag='No'")
		idw_activa.Modify("ApellidoMaterno.Tag='No'")
		idw_activa.Modify("Nombre.Tag='No'")
		idw_activa.Modify("DocumentoIdentidad.Tag='No'")
		idw_activa.Modify("DocumentoIdentidadNumero.Tag='No'")
		
		idw_activa.Modify("RazonSocial.Tag='Razon Social'")
		idw_activa.Modify("Ruc.Tag='Ruc'")
		idw_activa.setcolumn('razonsocial')
	case 'N'
		idw_activa.Modify("ApellidoPaterno.Tag='Apellido Paterno'")
		idw_activa.Modify("ApellidoMaterno.Tag='Apellido Materno'")
		idw_activa.Modify("Nombre.Tag='Nombre'")
		idw_activa.Modify("DocumentoIdentidad.Tag='Tipo de Documento de Identidad'")
		idw_activa.Modify("DocumentoIdentidadNumero.Tag='N$$HEX1$$fa00$$ENDHEX$$mero de Documento de Identidad'")
		
		idw_activa.Modify("RazonSocial.Tag='No'")
		idw_activa.Modify("Ruc.Tag='No'")
		idw_activa.setcolumn('apellidopaterno')
end choose
end subroutine

public subroutine wf_ubigeo ();
String ls_Id 

ls_Id = Idw_Activa.Object.IdUbigeo[Idw_Activa.GetRow()]
OpenWithParm(w_buscar_ubigeo_lista, ls_Id )
ls_Id = Message.StringParm
If Trim(ls_Id) = "" Then Return 
Idw_Activa.Object.IdUbigeo[Idw_Activa.GetRow()] = ls_Id
Idw_Activa.Object.Ubigeo[Idw_Activa.GetRow()] =uf_get_ubigeo( ls_Id )
Idw_Activa.Accepttext( )
Idw_Activa.setcolumn( 'Direccion')
Idw_Activa.SelectText(1, Len(Idw_Activa.GetText()))
Idw_Activa.setfocus( )	
end subroutine

on w_manto_entidad_mini.create
int iCurrent
call super::create
this.cb_aceptar=create cb_aceptar
this.cb_cancelar=create cb_cancelar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_aceptar
this.Control[iCurrent+2]=this.cb_cancelar
end on

on w_manto_entidad_mini.destroy
call super::destroy
destroy(this.cb_aceptar)
destroy(this.cb_cancelar)
end on

event ue_postopen;call super::ue_postopen;pb_nuevo.PostEvent(Clicked!)
end event

type gb_comandos from w_manto`gb_comandos within w_manto_entidad_mini
integer x = 55
integer y = 1704
integer width = 3470
end type

type tab_todo from w_manto`tab_todo within w_manto_entidad_mini
integer x = 0
integer width = 3607
integer height = 1400
end type

type tp_manto from w_manto`tp_manto within tab_todo
integer width = 3570
integer height = 1272
string text = "Datos de Entidad"
end type

type dw_manto from w_manto`dw_manto within tp_manto
integer y = 0
integer width = 3570
integer height = 1292
string dataobject = "d_entidad_manto_mini"
boolean hscrollbar = true
end type

event dw_manto::buttonclicked;call super::buttonclicked;string ls_Id//1
If dwo.name = "b_ubigeo" Then
	Wf_Ubigeo()
End If



end event

event dw_manto::itemchanged;call super::itemchanged;dwItemStatus	le_status
Int  li_Credito_Original, li_Credito_Actual
DateTime ldt_fecha , ldt_FechaCredito , ldt_FechaCredito_Original
String ls_CreditoCiclo, ls_CreditoTipo
This.Accepttext( )

le_status = this.GetItemStatus (this.GetRow(), 0, primary!)

choose case dwo.name
	case 'tipo'
		wf_ValidarTipo(String(data))
	case 'credito'
		ls_CreditoCiclo 		= idw_activa.Object.CreditoCiclo[row]
		
		ldt_FechaCredito 	= idw_activa.Object.creditofecha[row]
		ldt_FechaCredito_Original = idw_activa.Object.CreditoFecha.Primary.Original[idw_activa.GetRow()] 	
		
		li_Credito_Original	= Integer(idw_activa.Object.Credito.Primary.Original[idw_activa.GetRow()] )
		li_Credito_Actual 	= Integer(data)		
		
		If li_Credito_Actual = 1 Then
			ldt_fecha = DateTime(Date(gn_config.of_datetime( )) , Time(0,0,0))
			If ( le_status =new! or le_status = newmodified!) OR ( IsNull(ldt_FechaCredito_Original) or ( Date(1900,1,1)=Date(ldt_FechaCredito_Original)) )   Then  idw_activa.Object.creditofecha[row] = ldt_fecha

			idw_activa.Object.creditofechainicio[row] = ldt_fecha
			idw_activa.Object.creditofechafin[row] = Uf_fecha_Credito(idw_activa.Object.creditofechainicio[row], ls_CreditoCiclo)
			If li_Credito_Original = 0 Then 
				idw_activa.Object.creditofechainicio.Protect = 0
			Else
				idw_activa.Object.creditofechainicio.Protect = 1				
			End If 
		Else		
			idw_activa.Object.creditofechainicio.Protect = 1			
			If ( le_status =new! or le_status = newmodified!) OR ( IsNull(ldt_FechaCredito_Original) or ( Date(1900,1,1)=Date(ldt_FechaCredito_Original)) )   Then
				SetNull(ldt_fecha )
				SetNull(ls_CreditoTipo)
				idw_activa.Object.creditotipo[row] = ls_CreditoTipo
				idw_activa.Object.creditofecha[row] = ldt_fecha
				idw_activa.Object.creditofechainicio[row] = ldt_fecha
				idw_activa.Object.creditofechafin[row] = ldt_fecha
				
				idw_activa.Object.CreditoLinea[row] = 0.00		
				idw_activa.Object.CreditoDistribuido[row] = 0.00
				idw_activa.Object.CreditoSinDistribuir[row] = 0.00						
			End If
		End If
	case 'creditociclo'
		    ls_CreditoCiclo = String(data)
		    idw_activa.Object.creditofechafin[row] = Uf_fecha_Credito(idw_activa.Object.creditofechainicio[row], ls_CreditoCiclo)
		
end choose

end event

event dw_manto::ue_saveprevious;call super::ue_saveprevious;dwItemStatus	le_status
String ls_Codigo , ls_Tipo, ls_Data , ls_Mensaje
Decimal  ld_MonedaNacionalActual //,  ld_MonedaNacionalOriginal 
Decimal  ld_MonedaExtranjeraActual //,  ld_MonedaExtranjeraOriginal 
Long ll_fila_busqueda , ll_Filas_Encontradas
String &
ls_ApellidoPaterno_Original, &
ls_ApellidoMaterno_Original, &
ls_Nombre_Original, &
ls_DocumentoIdentidad_Original, &
ls_DocumentoIdentidadNumero_Original, &
ls_RazonSocial_Original, &
ls_Ruc_Original, &
ls_ApellidoPaterno_Actual, &
ls_ApellidoMaterno_Actual, &
ls_Nombre_Actual, &
ls_DocumentoIdentidad_Actual, &
ls_DocumentoIdentidadNumero_Actual, &
ls_RazonSocial_Actual, &
ls_Ruc_Actual

THIS.accepttext( )
le_status = THIS.GetItemStatus (THIS.GetRow(), 0, primary!)
ls_Tipo = THIS.Object.tipo.Primary.Current[THIS.GetRow()]


ls_ApellidoPaterno_Original					= idw_activa.Object.ApellidoPaterno.Primary.Original[idw_activa.GetRow()]
ls_ApellidoMaterno_Original					= idw_activa.Object.ApellidoMaterno.Primary.Original[idw_activa.GetRow()]
ls_Nombre_Original							= idw_activa.Object.Nombre.Primary.Original[idw_activa.GetRow()]
ls_DocumentoIdentidad_Original			= String(idw_activa.Object.DocumentoIdentidad.Primary.Original[idw_activa.GetRow()])
ls_DocumentoIdentidadNumero_Original	= idw_activa.Object.DocumentoIdentidadNumero.Primary.Original[idw_activa.GetRow()]
ls_RazonSocial_Original						= idw_activa.Object.RazonSocial.Primary.Original[idw_activa.GetRow()]
ls_Ruc_Original									= idw_activa.Object.Ruc.Primary.Original[idw_activa.GetRow()]
ls_ApellidoPaterno_Actual 					= idw_activa.Object.ApellidoPaterno.Primary.Current[idw_activa.GetRow()]
ls_ApellidoMaterno_Actual					= idw_activa.Object.ApellidoMaterno.Primary.Current[idw_activa.GetRow()]
ls_Nombre_Actual								= idw_activa.Object.Nombre.Primary.Current[idw_activa.GetRow()]
ls_DocumentoIdentidad_Actual				= String(idw_activa.Object.DocumentoIdentidad.Primary.Current[idw_activa.GetRow()])
ls_DocumentoIdentidadNumero_Actual	= idw_activa.Object.DocumentoIdentidadNumero.Primary.Current[idw_activa.GetRow()]
ls_RazonSocial_Actual						= idw_activa.Object.RazonSocial.Primary.Current[idw_activa.GetRow()]
ls_Ruc_Actual									= idw_activa.Object.Ruc.Primary.Current[idw_activa.GetRow()]


// Validacion de campos Requeridos
IF ls_Tipo = 'N' THEN //  Si la Persona es del tipo Natural
	IF (Trim(ls_ApellidoPaterno_Actual) = "" OR IsNull(ls_ApellidoPaterno_Actual)) Then
		Messagebox("Advertencia ... se necesitan datos","Apellido Paterno",StopSign!)
		idw_activa.setcolumn( 'ApellidoPaterno')
		idw_activa.SetFocus()
		Return 0
	ELSEIF (Trim(ls_ApellidoMaterno_Actual) = "" OR IsNull(ls_ApellidoMaterno_Actual)) Then
		Messagebox("Advertencia ... se necesitan datos","Apellido Materno",StopSign!)
		idw_activa.setcolumn( 'ApellidoMaterno')
		idw_activa.SetFocus()
		Return 0	
	ELSEIF (Trim(ls_Nombre_Actual) = "" OR IsNull(ls_Nombre_Actual)) Then
		Messagebox("Advertencia ... se necesitan datos","Nombre",StopSign!)
		idw_activa.setcolumn( 'Nombre')
		idw_activa.SetFocus()
		Return 0	
	ELSEIF (Trim(ls_DocumentoIdentidad_Actual) = "" OR IsNull(ls_DocumentoIdentidad_Actual)) Then
		Messagebox("Advertencia ... se necesitan datos","Documento de Identidad",StopSign!)
		idw_activa.setcolumn( 'DocumentoIdentidad')
		idw_activa.SetFocus()
		Return 0	
	ELSEIF (Trim(ls_DocumentoIdentidadNumero_Actual) = "" OR IsNull(ls_DocumentoIdentidadNumero_Actual)) Then
		Messagebox("Advertencia ... se necesitan datos","N$$HEX1$$fa00$$ENDHEX$$mero de Documento de Identidad",StopSign!)
		idw_activa.setcolumn( 'DocumentoIdentidadNumero')
		idw_activa.SetFocus()
		Return 0	
	ELSEIF (Trim(ls_RazonSocial_Actual) <> "" OR Trim(ls_Ruc_Actual) <> "" ) Then // Si se ingresa Razon social o Ruc se exige que tengan Ambos y que el Ruc Comience con 10
		IF (Trim(ls_RazonSocial_Actual) = "" OR IsNull(ls_RazonSocial_Actual)) Then
			ls_Data = ls_ApellidoPaterno_Actual+" "+ls_ApellidoMaterno_Actual+", "+ls_Nombre_Actual
			::Clipboard(ls_Data)
			If Messagebox("Advertencia ... se necesitan datos","Raz$$HEX1$$f300$$ENDHEX$$n Social : "+Char(13)+"En caso de no conocerlo se recomienda ingresar "+ls_Data+Char(13)+"Esta Raz$$HEX1$$f300$$ENDHEX$$n Social sera impresa en la Factura"+Char(13)+"Desea ingresarlo como Raz$$HEX1$$f300$$ENDHEX$$n Social",StopSign!,YesNo!, 1) = 1 Then
				idw_activa.Object.RazonSocial[idw_activa.GetRow()] = ls_Data
			End If
			idw_activa.setcolumn( 'RazonSocial')
			idw_activa.SetFocus()		
			Return 0	
		ELSEIF (Trim(ls_Ruc_Actual) = "" OR IsNull(ls_Ruc_Actual) OR (Mid(Trim(ls_Ruc_Actual), 1, 2)) <> '10' OR LEN(Trim(ls_Ruc_Actual)) <> 11 ) Then
			Messagebox("Advertencia ... se necesitan datos","Ruc"+char(13)+"Debe contener 11 Digitos Numericos"+char(13)+"Debe comenzar con Valor 10 + N$$HEX1$$fa00$$ENDHEX$$mero de DNI + Digito Final",StopSign!)
			idw_activa.setcolumn( 'Ruc')
			idw_activa.SetFocus()
			Return 0	
		ELSEIF  NOT uf_validaruc(String(ls_Ruc_Actual)) THEN
			Messagebox("Advertencia","Ingrese un N$$HEX1$$fa00$$ENDHEX$$mero de Ruc Valido por favor verifique sus Datos",StopSign!)
			idw_activa.setcolumn( 'Ruc')
			Return 0	
		END IF	
	END IF	
	
ELSEIF ls_Tipo = 'J' THEN // Si la Persona es del Tipo Juridica
	IF (Trim(ls_RazonSocial_Actual) = "" OR IsNull(ls_RazonSocial_Actual)) Then
		Messagebox("Advertencia ... se necesitan datos","Raz$$HEX1$$f300$$ENDHEX$$n Social",StopSign!)
		idw_activa.setcolumn( 'RazonSocial')
		idw_activa.SetFocus()		
		Return 0	
	ELSEIF (Trim(ls_Ruc_Actual) = "" OR IsNull(ls_Ruc_Actual) OR (Mid(Trim(ls_Ruc_Actual), 1, 2)) = '10' OR LEN(Trim(ls_Ruc_Actual)) <> 11 ) Then
		Messagebox("Advertencia ... se necesitan datos","Ruc"+char(13)+"Debe contener 11 Digitos Numericos"+char(13)+"Debe comenzar con Valor diferente de 10 ",StopSign!)
		idw_activa.setcolumn( 'Ruc')
		idw_activa.SetFocus()
		Return 0	
	ELSEIF  NOT uf_validaruc(String(ls_Ruc_Actual)) THEN
		Messagebox("Advertencia","Ingrese un N$$HEX1$$fa00$$ENDHEX$$mero de Ruc Valido por favor verifique sus Datos",StopSign!)
		idw_activa.setcolumn( 'Ruc')
		Return 0	
	END IF		
END IF


IF ls_Tipo = 'N' THEN //  Si la Persona es del tipo Natural

	// Validacion de Duplicidad de ApellidoPaterno ApellidoMaterno ,Nombre
	ls_Mensaje = ""
	ll_fila_busqueda = 1
	ll_Filas_Encontradas = 0
	ls_Data = " ApellidoPaterno = '"+ls_ApellidoPaterno_Actual+"' AND ApellidoMaterno = '"+ls_ApellidoMaterno_Actual+"' AND Nombre = '"+ls_Nombre_Actual+"' AND Tipo = 'N'"
	
	DO 
		il_Fila = idw_lista.find(ls_Data,ll_fila_busqueda,idw_lista.rowcount())
		IF il_Fila > 0 THEN
			ls_Mensaje = ls_Mensaje + char(13)+"Fila : "+String(il_Fila)+"  C$$HEX1$$f300$$ENDHEX$$digo : "+ idw_lista.Object.CodEntidad[il_Fila]
			ll_fila_busqueda = il_Fila + 1
			ll_Filas_Encontradas ++
			If ll_fila_busqueda > idw_lista.rowcount() Then Exit
		END IF
	LOOP WHILE il_Fila <> 0
	
	choose case le_status	
		case new!,newmodified!
				IF ll_Filas_Encontradas > 0 THEN
					messagebox("Advertecia " + Gn_Config.Is_Work.Aplicacion  ,"Apellidos y Nombres  ya existen......!!!"+ls_Mensaje,StopSign!)
					THIS.setcolumn('ApellidoPaterno')
					THIS.SelectText(1, Len(THIS.GetText()))
					THIS.setfocus( )
					Return 0
				End If		
		case	datamodified!
			If ls_ApellidoPaterno_Actual <>ls_ApellidoPaterno_Original OR ls_ApellidoMaterno_Actual <>ls_ApellidoMaterno_Original OR ls_Nombre_Actual <>ls_Nombre_Original Then
				IF ll_Filas_Encontradas > 0 THEN
					messagebox("Advertecia " + Gn_Config.Is_Work.Aplicacion  ,"Apellidos y Nombres  ya existen......!!!"+ls_Mensaje,StopSign!)
					THIS.setcolumn('ApellidoPaterno')
					THIS.SelectText(1, Len(THIS.GetText()))
					THIS.setfocus( )
					Return 0
				End If
			End If
	end choose

	// Validacion de Duplicidad de Docuemento de Identidad y N$$HEX1$$fa00$$ENDHEX$$mero
	ls_Mensaje = ""
	ll_fila_busqueda = 1
	ll_Filas_Encontradas = 0
	ls_Data = " DocumentoIdentidad = "+ls_DocumentoIdentidad_Actual+" AND DocumentoIdentidadNumero = '"+ls_DocumentoIdentidadNumero_Actual+"' AND Tipo = 'N'"
	
	DO 
		il_Fila = idw_lista.find(ls_Data,ll_fila_busqueda,idw_lista.rowcount())
		IF il_Fila > 0 THEN
			ls_Mensaje = ls_Mensaje + char(13)+"Fila : "+String(il_Fila)+"  C$$HEX1$$f300$$ENDHEX$$digo : "+ idw_lista.Object.CodEntidad[il_Fila]
			ll_fila_busqueda = il_Fila + 1
			ll_Filas_Encontradas ++
			If ll_fila_busqueda > idw_lista.rowcount() Then Exit
		END IF
	LOOP WHILE il_Fila <> 0
	
	choose case le_status	
		case new!,newmodified!
				IF ll_Filas_Encontradas > 0 THEN
					messagebox("Advertecia " + Gn_Config.Is_Work.Aplicacion  ,"Documento Identidad y N$$HEX1$$fa00$$ENDHEX$$mero de Documento de Identidad  ya existen......!!!"+ls_Mensaje,StopSign!)
					THIS.setcolumn('DocumentoIdentidadNumero')
					THIS.SelectText(1, Len(THIS.GetText()))
					THIS.setfocus( )
					Return 0
				End If		
		case	datamodified!
			If ls_DocumentoIdentidad_Actual <>ls_DocumentoIdentidad_Original OR ls_DocumentoIdentidadNumero_Actual <>ls_DocumentoIdentidadNumero_Original  Then
				IF ll_Filas_Encontradas > 0 THEN
					messagebox("Advertecia " + Gn_Config.Is_Work.Aplicacion  ,"Documento Identidad y N$$HEX1$$fa00$$ENDHEX$$mero de Documento de Identidad  ya existen......!!!"+ls_Mensaje,StopSign!)
					THIS.setcolumn('DocumentoIdentidadNumero')
					THIS.SelectText(1, Len(THIS.GetText()))
					THIS.setfocus( )
					Return 0
				End If
			End If
	end choose
	
	IF  ( (Trim(ls_RazonSocial_Actual) <> "") OR (Trim(ls_Ruc_Actual) <> "") ) THEN
		// Si se ingresa Razon social o Ruc se exige que tengan Ambos y que el Ruc Comience con 10
		// Validacion de Duplicidad de Raz$$HEX1$$f300$$ENDHEX$$n Social
		ls_Mensaje = ""
		ll_fila_busqueda = 1
		ll_Filas_Encontradas = 0		
		ls_Data = " RazonSocial = '"+ls_RazonSocial_Actual+"'"
		
		DO 
			il_Fila = idw_lista.find(ls_Data,ll_fila_busqueda,idw_lista.rowcount())
			IF il_Fila > 0 THEN
				ls_Mensaje = ls_Mensaje + char(13)+"Fila : "+String(il_Fila)+"  C$$HEX1$$f300$$ENDHEX$$digo : "+ idw_lista.Object.CodEntidad[il_Fila]
				ll_fila_busqueda = il_Fila + 1
				ll_Filas_Encontradas ++	
				If ll_fila_busqueda > idw_lista.rowcount() Then Exit
			END IF
		LOOP WHILE il_Fila <> 0
		
		choose case le_status	
			case new!,newmodified!
					IF ll_Filas_Encontradas > 0 THEN
						messagebox("Advertecia " + Gn_Config.Is_Work.Aplicacion  ,"Raz$$HEX1$$f300$$ENDHEX$$n Social ya existe......!!!"+ls_Mensaje,StopSign!)
						THIS.setcolumn('RazonSocial')
						THIS.SelectText(1, Len(THIS.GetText()))
						THIS.setfocus( )
						Return 0
					End If		
			case	datamodified!
				If ls_RazonSocial_Actual <>ls_RazonSocial_Original  Then
					IF ll_Filas_Encontradas > 0 THEN
						messagebox("Advertecia " + Gn_Config.Is_Work.Aplicacion  ,"Raz$$HEX1$$f300$$ENDHEX$$n Social ya existe......!!!"+ls_Mensaje,StopSign!)
						THIS.setcolumn('RazonSocial')
						THIS.SelectText(1, Len(THIS.GetText()))
						THIS.setfocus( )
						Return 0
					End If
				End If
		end choose
		
		// Validacion de Duplicidad de Ruc
		ls_Mensaje = ""
		ll_fila_busqueda = 1
		ll_Filas_Encontradas = 0	
		ls_Data = " Ruc = '"+ls_Ruc_Actual+"'"
		
		DO 
			il_Fila = idw_lista.find(ls_Data,ll_fila_busqueda,idw_lista.rowcount())
			IF il_Fila > 0 THEN
				ls_Mensaje = ls_Mensaje + char(13)+"Fila : "+String(il_Fila)+"  C$$HEX1$$f300$$ENDHEX$$digo : "+ idw_lista.Object.CodEntidad[il_Fila]
				ll_fila_busqueda = il_Fila + 1
				ll_Filas_Encontradas ++		
				If ll_fila_busqueda > idw_lista.rowcount() Then Exit
			END IF
		LOOP WHILE il_Fila <> 0
		
		choose case le_status	
			case new!,newmodified!
					IF ll_Filas_Encontradas > 0 THEN
						messagebox("Advertecia " + Gn_Config.Is_Work.Aplicacion  ,"Ruc ya existe......!!!"+ls_Mensaje,StopSign!)
						THIS.setcolumn('Ruc')
						THIS.SelectText(1, Len(THIS.GetText()))
						THIS.setfocus( )
						Return 0
					End If		
			case	datamodified!
				If ls_Ruc_Actual <>ls_Ruc_Original  Then
					IF ll_Filas_Encontradas > 0 THEN
						messagebox("Advertecia " + Gn_Config.Is_Work.Aplicacion  ,"Ruc ya existe......!!!"+ls_Mensaje,StopSign!)
						THIS.setcolumn('Ruc')
						THIS.SelectText(1, Len(THIS.GetText()))
						THIS.setfocus( )
						Return 0
					End If
				End If
		end choose
	END IF
	
ELSEIF (ls_Tipo = 'J') THEN 
		// Si la Persona es del Tipo Juridica  se ingresa Razon social y Ruc se exige que tengan Ambos 
		// Validacion de Duplicidad de Raz$$HEX1$$f300$$ENDHEX$$n Social
		ls_Mensaje = ""
		ll_fila_busqueda = 1
		ll_Filas_Encontradas = 0		
		ls_Data = " RazonSocial = '"+ls_RazonSocial_Actual+"'"
		
		DO 
			il_Fila = idw_lista.find(ls_Data,ll_fila_busqueda,idw_lista.rowcount())
			IF il_Fila > 0 THEN
				ls_Mensaje = ls_Mensaje + char(13)+"Fila : "+String(il_Fila)+"  C$$HEX1$$f300$$ENDHEX$$digo : "+ idw_lista.Object.CodEntidad[il_Fila]
				ll_fila_busqueda = il_Fila + 1
				ll_Filas_Encontradas ++	
				If ll_fila_busqueda > idw_lista.rowcount() Then Exit
			END IF
		LOOP WHILE il_Fila <> 0
		
		choose case le_status	
			case new!,newmodified!
					IF ll_Filas_Encontradas > 0 THEN
						messagebox("Advertecia " + Gn_Config.Is_Work.Aplicacion  ,"Raz$$HEX1$$f300$$ENDHEX$$n Social ya existe......!!!"+ls_Mensaje,StopSign!)
						THIS.setcolumn('RazonSocial')
						THIS.SelectText(1, Len(THIS.GetText()))
						THIS.setfocus( )
						Return 0
					End If		
			case	datamodified!
				If ls_RazonSocial_Actual <>ls_RazonSocial_Original  Then
					IF ll_Filas_Encontradas > 0 THEN
						messagebox("Advertecia " + Gn_Config.Is_Work.Aplicacion  ,"Raz$$HEX1$$f300$$ENDHEX$$n Social ya existe......!!!"+ls_Mensaje,StopSign!)
						THIS.setcolumn('RazonSocial')
						THIS.SelectText(1, Len(THIS.GetText()))
						THIS.setfocus( )
						Return 0
					End If
				End If
		end choose
		
		// Validacion de Duplicidad de Ruc
		ls_Mensaje = ""
		ll_fila_busqueda = 1
		ll_Filas_Encontradas = 0
		ls_Data = " Ruc = '"+ls_Ruc_Actual+"'"
		
		DO 
			il_Fila = idw_lista.find(ls_Data,ll_fila_busqueda,idw_lista.rowcount())
			IF il_Fila > 0 THEN
				ls_Mensaje = ls_Mensaje + char(13)+"Fila : "+String(il_Fila)+"  C$$HEX1$$f300$$ENDHEX$$digo : "+ idw_lista.Object.CodEntidad[il_Fila]
				ll_fila_busqueda = il_Fila + 1
				ll_Filas_Encontradas ++
				If ll_fila_busqueda > idw_lista.rowcount() Then Exit
			END IF
		LOOP WHILE il_Fila <> 0
		
		choose case le_status	
			case new!,newmodified!
					IF ll_Filas_Encontradas > 0 THEN
						messagebox("Advertecia " + Gn_Config.Is_Work.Aplicacion  ,"Ruc ya existe......!!!"+ls_Mensaje,StopSign!)
						THIS.setcolumn('Ruc')
						THIS.SelectText(1, Len(THIS.GetText()))
						THIS.setfocus( )
						Return 0
					End If		
			case	datamodified!
				If ls_Ruc_Actual <>ls_Ruc_Original  Then
					IF ll_Filas_Encontradas > 0 THEN
						messagebox("Advertecia " + Gn_Config.Is_Work.Aplicacion  ,"Ruc ya existe......!!!"+ls_Mensaje,StopSign!)
						THIS.setcolumn('Ruc')
						THIS.SelectText(1, Len(THIS.GetText()))
						THIS.setfocus( )
						Return 0
					End If
				End If
		end choose
END IF	

// Validar la Parte de Creditos y Parametros
Int &
li_Credito_Original,& 
li_CreditoDiasPago_Original,& 
li_Credito_Actual,& 
li_CreditoDiasPago_Actual

String &
ls_CreditoTipo_Original,& 
ls_CreditoCiclo_Original,& 
ls_CreditoTipo_Actual,& 
ls_CreditoCiclo_Actual

Decimal &
ld_CreditoLinea_Original,& 
ld_CreditoDistribuido_Original,&  
ld_CreditoSinDistribuir_Original,& 
ld_CreditoUtilizado_Original,& 
ld_CreditoSaldo_Original,& 
ld_CreditoInteres_Original,& 
ld_CreditoLinea_Actual,& 
ld_CreditoDistribuido_Actual,& 
ld_CreditoSinDistribuir_Actual,& 
ld_CreditoUtilizado_Actual,& 
ld_CreditoSaldo_Actual,& 
ld_CreditoInteres_Actual

DateTime &
ldt_CreditoFecha_Original,& 
ldt_CreditoFechaInicio_Original,& 
ldt_CreditoFechaFin_Original,& 
ldt_CreditoFechaProceso_Original,& 
ldt_CreditoFecha_Actual,& 
ldt_CreditoFechaInicio_Actual,& 
ldt_CreditoFechaFin_Actual,& 
ldt_CreditoFechaProceso_Actual


li_Credito_Original 					= Integer(idw_activa.Object.Credito.Primary.Original[idw_activa.GetRow()] )
li_CreditoDiasPago_Original 			= Integer(idw_activa.Object.CreditoDiasPago.Primary.Original[idw_activa.GetRow()] )

li_Credito_Actual 						= Integer(idw_activa.Object.Credito.Primary.Current[idw_activa.GetRow()] )
li_CreditoDiasPago_Actual 			= Integer(idw_activa.Object.CreditoDiasPago.Primary.Current[idw_activa.GetRow()] )


ls_CreditoTipo_Original 				= String(idw_activa.Object.CreditoTipo.Primary.Original[idw_activa.GetRow()] )
ls_CreditoCiclo_Original 				= String(idw_activa.Object.CreditoCiclo.Primary.Original[idw_activa.GetRow()] )

ls_CreditoTipo_Actual 				= String(idw_activa.Object.CreditoTipo.Primary.Current[idw_activa.GetRow()] )
ls_CreditoCiclo_Actual 				= String(idw_activa.Object.CreditoCiclo.Primary.Current[idw_activa.GetRow()] )


ld_CreditoLinea_Original 				= Dec(idw_activa.Object.CreditoLinea.Primary.Original[idw_activa.GetRow()] )
ld_CreditoDistribuido_Original 		= Dec(idw_activa.Object.CreditoDistribuido.Primary.Original[idw_activa.GetRow()] )
ld_CreditoSinDistribuir_Original 	= Dec(idw_activa.Object.CreditoSinDistribuir.Primary.Original[idw_activa.GetRow()] )
ld_CreditoUtilizado_Original 			= Dec(idw_activa.Object.CreditoUtilizado.Primary.Original[idw_activa.GetRow()] )
ld_CreditoSaldo_Original 			= Dec(idw_activa.Object.CreditoSaldo.Primary.Original[idw_activa.GetRow()] )
ld_CreditoInteres_Original			= Dec(idw_activa.Object.CreditoInteres.Primary.Original[idw_activa.GetRow()] )

ld_CreditoLinea_Actual 				= Dec(idw_activa.Object.CreditoLinea.Primary.Current[idw_activa.GetRow()] )
ld_CreditoDistribuido_Actual		= Dec(idw_activa.Object.CreditoDistribuido.Primary.Current[idw_activa.GetRow()] )
ld_CreditoSinDistribuir_Actual		= Dec(idw_activa.Object.CreditoSinDistribuir.Primary.Current[idw_activa.GetRow()] )
ld_CreditoUtilizado_Actual			= Dec(idw_activa.Object.CreditoUtilizado.Primary.Current[idw_activa.GetRow()] )
ld_CreditoSaldo_Actual				= Dec(idw_activa.Object.CreditoSaldo.Primary.Current[idw_activa.GetRow()] )
ld_CreditoInteres_Actual			= Dec(idw_activa.Object.CreditoInteres.Primary.Current[idw_activa.GetRow()] )



		IF  li_Credito_Actual  = 1 Then
			IF ls_CreditoTipo_Actual = ""  or IsNull(ls_CreditoTipo_Actual) THEN 
				messagebox("Advertecia " + Gn_Config.Is_Work.Aplicacion  ,"Selecciones un Tipo de Credito  Diferente de NINGUNO",StopSign!)
				THIS.setcolumn('CreditoTipo')
				THIS.SelectText(1, Len(THIS.GetText()))
				THIS.setfocus( )
				Return 0		
			END IF
			IF ld_CreditoLinea_Actual <= 0.00  or IsNull(ld_CreditoLinea_Actual) THEN 
				messagebox("Advertecia " + Gn_Config.Is_Work.Aplicacion  ,"La Linea de Credito debe ser mayor a Cero",StopSign!)
				THIS.setcolumn('CreditoLinea')
				THIS.SelectText(1, Len(THIS.GetText()))
				THIS.setfocus( )
				Return 0		
			END IF	
			IF ld_CreditoSinDistribuir_Actual < 0.00  or IsNull(ld_CreditoSinDistribuir_Actual) THEN 
				messagebox("Advertecia " + Gn_Config.Is_Work.Aplicacion  ,"La Linea de Credito Sin Distribuir  debe ser mayor o Igual a Cero",StopSign!)
				THIS.setcolumn('CreditoLinea')
				THIS.SelectText(1, Len(THIS.GetText()))
				THIS.setfocus( )
				Return 0		
			END IF
			IF ld_CreditoSaldo_Actual < 0.00  or IsNull(ld_CreditoSaldo_Actual) THEN 
				messagebox("Advertecia " + Gn_Config.Is_Work.Aplicacion  ,"El Saldo debe ser mayor o Igual a Cero",StopSign!)
				THIS.setcolumn('CreditoLinea')
				THIS.SelectText(1, Len(THIS.GetText()))
				THIS.setfocus( )
				Return 0		
			END IF				
			IF ld_CreditoInteres_Actual <= 0.00  or IsNull(ld_CreditoInteres_Actual) THEN 
				messagebox("Advertecia " + Gn_Config.Is_Work.Aplicacion  ,"El Interes de Credito debe ser mayor a Cero",StopSign!)
				THIS.setcolumn('CreditoInteres')
				THIS.SelectText(1, Len(THIS.GetText()))
				THIS.setfocus( )
				Return 0		
			END IF	
			IF li_CreditoDiasPago_Actual <= 1  or IsNull(li_CreditoDiasPago_Actual) THEN 
				messagebox("Advertecia " + Gn_Config.Is_Work.Aplicacion  ,"Dias de Pago Credito debe ser mayor a Uno",StopSign!)
				THIS.setcolumn('CreditoDiasPago')
				THIS.SelectText(1, Len(THIS.GetText()))
				THIS.setfocus( )
				Return 0		
			END IF		
		END IF
		
wf_datos()
Return 1



end event

event dw_manto::ue_refresh;call super::ue_refresh;//DocumentoIdentidad
If idw_activa.retrieve( id_Codigo ) > 0 Then
	wf_ValidarTipo(String(idw_activa.Object.tipo[idw_activa.GetRow()]))
End If
end event

event dw_manto::constructor;call super::constructor;//of_setregistrarcalendario(True)
//of_setcampocalendario("aniversario") 

IF idw_activa.GetChild('DocumentoIdentidad', idwc_DocumentoIdentidad) = -1 THEN MessageBox(  "Error", "DocumentoIdentidad Not a DataWindowChild")
idwc_DocumentoIdentidad.SetTransObject(SQLCA)
idwc_DocumentoIdentidad.Retrieve('DocumentoIdentidad')

end event

event dw_manto::ue_newafter;call super::ue_newafter;	Wf_ValidarTipo(String(idw_activa.Object.tipo[idw_activa.GetRow()]))
	Return 1
end event

event dw_manto::editchanged;call super::editchanged;Integer &
li_Credito, & 
li_Estado

String &
ls_Data , & 
ls_Columna , & 
ls_CreditoTipo

Decimal &
ld_Data , & 
ld_CreditoLinea, & 
ld_CreditoDistribuido, & 
ld_CreditoSinDistribuir, & 
ld_CreditoUtilizado, & 
ld_CreditoSaldo, & 
ld_CreditoInteres, & 
ld_CreditoDescuento, & 
ld_PorCobrar, & 
ld_PorPagar

ls_Columna = Upper(String(dwo.name))

IF ls_Columna = Upper('CreditoLinea') OR ls_Columna = Upper('Credito') OR  ls_Columna = Upper('CreditoInteres') OR   ls_Columna = Upper('CreditoCiclo') OR  ls_Columna = Upper('CreditoDiasPago') THEN
	This.Accepttext( )
	ld_Data = Dec(DATA)
	ld_CreditoLinea 		= idw_activa.Object.CreditoLinea[row] 
	ld_CreditoDistribuido	= idw_activa.Object.CreditoDistribuido[row]
	//ld_CreditoSinDistribuir= idw_activa.Object.CreditoSinDistribuir[row] 
	ld_CreditoUtilizado 	=  idw_activa.Object.CreditoUtilizado[row] 
	//ld_CreditoSaldo 		=  idw_activa.Object.CreditoSaldo[row] 
	IF ls_Columna = Upper('CreditoLinea')  Then
		idw_activa.Object.CreditoSinDistribuir[row] = ld_CreditoLinea - ld_CreditoDistribuido
		 idw_activa.Object.CreditoSaldo[row]  =  ld_CreditoLinea - ld_CreditoUtilizado
	End If
	

END IF



end event

event dw_manto::ue_seleccion_calendario;call super::ue_seleccion_calendario;
//If Upper(as_campo)= Upper("creditofechainicio")  Then      idw_activa.Object.creditofechafin[idw_activa.GetRow()] = Uf_fecha_Credito(idw_activa.Object.creditofechainicio[idw_activa.GetRow()], idw_activa.Object.CreditoCiclo[idw_activa.GetRow()] )

end event

event dw_manto::ue_saveafter;call super::ue_saveafter;cb_aceptar.PostEvent( Clicked!)
RETURN 1
end event

type pb_borrar from w_manto`pb_borrar within tp_manto
end type

type pb_abrir from w_manto`pb_abrir within tp_manto
end type

type ole_1 from w_manto`ole_1 within tp_manto
integer x = 2171
integer y = 640
end type

type tp_lista from w_manto`tp_lista within tab_todo
integer width = 3570
integer height = 1272
string text = "Lista de Entidades"
end type

type dw_lista from w_manto`dw_lista within tp_lista
integer y = 328
integer width = 3552
integer height = 940
string dataobject = "d_entidad_lista_mini"
end type

event dw_lista::ue_refresh;call super::ue_refresh;idw_lista.Retrieve()
//idw_lista.retrieve(gn_config.is_work.empresa)
end event

event dw_lista::ue_getid;call super::ue_getid;	IF THIS.RowCount() > 0  THEN
	id_Codigo=THIS.Object.IdEntidad [THIS.GetRow()]	
	Is_CodEntidad=THIS.Object.CodEntidad [THIS.GetRow()]	
	Ist_Datos.IdCodigo = id_Codigo
	Ist_Datos.Codigo = Is_CodEntidad
	
	
	Ist_Datos.paramS[1] = THIS.Object.Tipo [THIS.GetRow()]	 
	Ist_Datos.paramS[2] = THIS.Object.RazonSocial[THIS.GetRow()]	
	
	IF IsNull(THIS.Object.Ruc[THIS.GetRow()]) OR THIS.Object.Ruc[THIS.GetRow()]	= "" THEN
		Ist_Datos.paramS[3] = "DNI"
		Ist_Datos.paramD[1] = THIS.Object.DocumentoIdentidad[THIS.GetRow()]
		Ist_Datos.paramS[5] = THIS.Object.DocumentoIdentidadNumero [THIS.GetRow()]	
	ELSE
		Ist_Datos.paramS[3] = "RUC"
		Ist_Datos.paramD[1] = 2
		Ist_Datos.paramS[5] = THIS.Object.Ruc[THIS.GetRow()]	
	END IF
	Ist_Datos.paramS[6] = THIS.Object.Direccion [THIS.GetRow()]	
	Ist_Datos.paramS[7] = THIS.Object.IdUbigeo [THIS.GetRow()]	
	Ist_Datos.paramS[8] = THIS.Object.Ubigeo [THIS.GetRow()]	
END IF
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

type shl_cerrar from w_manto`shl_cerrar within w_manto_entidad_mini
integer x = 3099
integer y = 1916
end type

type shl_grabar from w_manto`shl_grabar within w_manto_entidad_mini
integer x = 1015
integer y = 1916
end type

type shl_eliminar from w_manto`shl_eliminar within w_manto_entidad_mini
integer x = 704
integer y = 1916
end type

type shl_modificar from w_manto`shl_modificar within w_manto_entidad_mini
integer x = 393
integer y = 1916
end type

type shl_nuevo from w_manto`shl_nuevo within w_manto_entidad_mini
integer x = 82
integer y = 1916
end type

type uo_nav from w_manto`uo_nav within w_manto_entidad_mini
integer x = 1632
integer y = 1764
end type

type pb_cancelar from w_manto`pb_cancelar within w_manto_entidad_mini
integer x = 1394
integer y = 1764
end type

type pb_grabar from w_manto`pb_grabar within w_manto_entidad_mini
integer x = 1083
integer y = 1764
end type

type pb_eliminar from w_manto`pb_eliminar within w_manto_entidad_mini
integer x = 773
integer y = 1764
end type

type pb_nuevo from w_manto`pb_nuevo within w_manto_entidad_mini
integer x = 151
integer y = 1764
end type

type pb_cerrar from w_manto`pb_cerrar within w_manto_entidad_mini
integer x = 3168
integer y = 1764
end type

type shl_cancelar from w_manto`shl_cancelar within w_manto_entidad_mini
integer x = 1326
integer y = 1916
end type

type pb_modificar from w_manto`pb_modificar within w_manto_entidad_mini
integer x = 462
integer y = 1764
end type

type cb_aceptar from commandbutton within w_manto_entidad_mini
integer x = 1138
integer y = 1460
integer width = 457
integer height = 104
integer taborder = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Aceptar"
end type

event clicked;Idw_lista.EVENT ue_GetId( )
CloseWithReturn(PARENT, Ist_Datos)
end event

type cb_cancelar from commandbutton within w_manto_entidad_mini
integer x = 2139
integer y = 1456
integer width = 402
integer height = 112
integer taborder = 90
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Cancelar"
end type

event clicked;CloseWithReturn(PARENT, Ist_DatosNull)
end event

