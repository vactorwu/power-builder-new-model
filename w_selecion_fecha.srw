HA$PBExportHeader$w_selecion_fecha.srw
forward
global type w_selecion_fecha from w_center
end type
type dw_manto from u_dw within w_selecion_fecha
end type
type cb_cancelar from commandbutton within w_selecion_fecha
end type
type cb_aceptar from commandbutton within w_selecion_fecha
end type
type dw_fechatrabajo from u_dw within w_selecion_fecha
end type
end forward

global type w_selecion_fecha from w_center
string tag = " "
integer width = 3561
integer height = 1404
string title = "Fecha de Trabajo"
boolean maxbox = false
boolean resizable = false
boolean center = true
dw_manto dw_manto
cb_cancelar cb_cancelar
cb_aceptar cb_aceptar
dw_fechatrabajo dw_fechatrabajo
end type
global w_selecion_fecha w_selecion_fecha

type variables

end variables

on w_selecion_fecha.create
int iCurrent
call super::create
this.dw_manto=create dw_manto
this.cb_cancelar=create cb_cancelar
this.cb_aceptar=create cb_aceptar
this.dw_fechatrabajo=create dw_fechatrabajo
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_manto
this.Control[iCurrent+2]=this.cb_cancelar
this.Control[iCurrent+3]=this.cb_aceptar
this.Control[iCurrent+4]=this.dw_fechatrabajo
end on

on w_selecion_fecha.destroy
call super::destroy
destroy(this.dw_manto)
destroy(this.cb_cancelar)
destroy(this.cb_aceptar)
destroy(this.dw_fechatrabajo)
end on

event open;call super::open;
gn_config.is_work.FechaSistema =  Date(gn_config.of_datetime( ) )

IF gn_config.is_work.FechaTrabajo = Date(1900,1,1) OR IsNull(gn_config.is_work.FechaTrabajo) THEN
	gn_config.is_work.FechaTrabajo = gn_config.is_work.FechaSistema
END IF
THIS.title = gn_config.is_work.aplicacion + " :  "+THIS.title

gb_AbrirCatalogos =  FALSE
gn_config.is_work.FechasIguales = FALSE

This.Y = 0
end event

type dw_manto from u_dw within w_selecion_fecha
integer x = 1056
integer y = 12
integer width = 1902
integer height = 1268
integer taborder = 40
string dataobject = "d_tipocambio_manto"
end type

type cb_cancelar from commandbutton within w_selecion_fecha
integer x = 475
integer y = 1104
integer width = 402
integer height = 112
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cancelar"
boolean cancel = true
end type

event clicked;String ls_Fecha

If IsNull( gn_config.is_work.idempresa ) Then
  gb_AbrirCatalogos =  FALSE
Else
	
  gb_AbrirCatalogos =  TRUE 
End If 

ls_Fecha = uf_diafecha("DIAFECHA","WORK")
w_frame.title =Gn_Config.Is_Work.Aplicacion+" :  "+gn_config.is_work.empresades+" - RUC: "+gn_config.is_work.ruc+" --- USUARIO: "+gn_config.is_config.usuario +" ---  "+ls_Fecha 
//w_frame.title =Gn_Config.Is_Work.Aplicacion+" :  "+gn_config.is_work.empresa +" "+gn_config.is_work.empresades+" - RUC: "+gn_config.is_work.ruc+" --- USUARIO: "+gn_config.is_config.usuario +" ---  "+ls_Fecha 


Close(Parent)
end event

type cb_aceptar from commandbutton within w_selecion_fecha
integer x = 37
integer y = 1104
integer width = 402
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Aceptar"
end type

event clicked;String ls_Fecha ,ls_Codigo

Decimal {4} ld_compra , ld_venta, ld_nulo , ld_TipoCambioCompra,  ld_TipoCambioVenta
LongLong  ll_IdEstadoMensualOperacion
LongLong ll_IdTipoCambio
Date ld_FechaTrabajo , ld_FechaNulo , ld_FechaSistema
DateTime ldt_Nulo
Int li_Mes , li_Anio , li_Nulo , li_Empresas

dw_fechatrabajo.accepttext( )
SetNull(li_Nulo)
SetNull(ldt_Nulo)

ld_compra = dw_fechatrabajo.Object.TipoCambio[dw_fechatrabajo.GetRow()]
ld_venta = dw_fechatrabajo.Object.TipoCambioVenta[dw_fechatrabajo.GetRow()]

ld_FechaTrabajo = dw_fechatrabajo.Object.FechaTrabajo[dw_fechatrabajo.GetRow()]
ld_FechaSistema = dw_fechatrabajo.Object.FechaSistema[dw_fechatrabajo.GetRow()]

IF String(ld_FechaTrabajo,"YYYYMMDD") = String(ld_FechaSistema,"YYYYMMDD") THEN 
	Gn_Config.Is_Work.FechasIguales = TRUE
ELSE
	Gn_Config.Is_Work.FechasIguales = FALSE
END IF

li_Empresas = SQLCA.Usf_Get_EstadoOperacion_Count( gn_config.is_work.idempresa ,Year(ld_fechaTrabajo))
IF li_Empresas <= 0 THEN
     MessageBox(Gn_Config.Is_Work.Aplicacion ,"No Existe Registro de Operaciones para el a$$HEX1$$f100$$ENDHEX$$o en que desea trabajar... Debe crear un Registro de Operaciones para trabajar en el a$$HEX1$$f100$$ENDHEX$$o " + String(Year(ld_fechaTrabajo)),StopSign!) 
	IF NOT isvalid(w_manto_estadooperacion) THEN opensheet(w_manto_estadooperacion,w_frame,1,original!)
	RETURN 	
END IF
	

SQLCA.Usp_TipoCambio( gn_config.is_work.IdMonedaNacional , gn_config.is_work.IdMonedaExtranjera,String(ld_FechaTrabajo,"DD/MM/YYYY") , ll_IdTipoCambio, ld_TipoCambioCompra,  ld_TipoCambioVenta)


ll_IdEstadoMensualOperacion = dw_fechatrabajo.Object.IdEstadoMensualOperacion[dw_fechatrabajo.GetRow()] 

IF ll_IdEstadoMensualOperacion = -1  THEN
	IF ld_compra =ld_TipoCambioCompra THEN
		IF ld_TipoCambioCompra = 0 THEN 
			IF MessageBox(Gn_Config.Is_Work.Aplicacion ,"El Tipo de cambio no ha sido ingresado Desea Continuar ",Question!,YESNO!) = 2 THEN
				RETURN 
			END IF
		END IF
	ELSE
		IF ll_IdTipoCambio <> 0 THEN
			IF MessageBox(Gn_Config.Is_Work.Aplicacion ,"Desea actualizar el Tipo de Cambio de la Fecha "+String(ld_FechaTrabajo,"DD/MM/YYYY") + " de " + String(ld_TipoCambioCompra , "###.000")+ " a "+String( ld_compra ,"###.000") +" y continuar...?",Question!,YESNO!) = 1 THEN
					dw_manto.Object.compra[dw_manto.GetRow()] = ld_compra
					dw_manto.Object.venta[dw_manto.GetRow()] = ld_venta					
					dw_manto.Update( )
					  COMMIT  USING SQLCA ;
				ELSE
					RETURN 
			END IF
		ELSE
			IF MessageBox(Gn_Config.Is_Work.Aplicacion ,"Desea Registrar el Tipo de Cambio de la Fecha "+String(ld_FechaTrabajo,"DD/MM/YYYY") + " de " + String( ld_compra ,"###.000")+" y continuar...?",Question!,YESNO!) = 1 THEN								
				Long ll_Fila
				String ls_CodTipoCambio = Space(10)
				ll_Fila = dw_manto.InsertRow(0)
				dw_manto.Object.compra[ll_Fila] = ld_compra
				dw_manto.Object.venta[ll_Fila] = ld_venta
				dw_manto.Object.fecha[ll_Fila] = DateTime(ld_FechaTrabajo, Time(0,0,0) )
				dw_manto.Object.IdMonedaNacional[ll_Fila] 	= gn_config.is_work.IdMonedaNacional
				dw_manto.Object.IdMonedaExtranjera[ll_Fila] = gn_config.is_work.IdMonedaExtranjera
				SQLCA.Usp_TipoCambio_Cod(ls_CodTipoCambio , 10 )
				COMMIT  USING SQLCA ;
				dw_manto.Object.CodTipoCambio[ll_Fila] = ls_CodTipoCambio							
				dw_manto.Update( )
				COMMIT  USING SQLCA ;
			END IF
		END IF					
	END IF
END IF

gn_config.is_work.FechaTrabajo = ld_fechaTrabajo
gn_config.is_work.IdTipoCambio = ll_IdTipoCambio
gn_config.is_work.TipoCambioCompra = ld_TipoCambioCompra
gn_config.is_work.TipoCambioVenta = ld_TipoCambioVenta

IF ll_IdEstadoMensualOperacion = -1  THEN
	gn_config.is_work.Anio = YEAR(ld_FechaTrabajo)
	gn_config.is_work.Mes = MONTH(ld_FechaTrabajo)
	SQLCA.Usp_EstadoMensualOperacion( gn_config.is_work.idempresa,DateTime(ld_FechaTrabajo,Time(0,0,0)) ,li_Nulo,li_Nulo,gn_config.is_work.IdEstadoMensualOperacion, gn_config.is_work.EstadoOperacion , gn_config.is_work.EstadoMensualOperacion )
	ls_Fecha =  "FECHA TRABAJO : "+ uf_diafecha("DIAFECHA","WORK") 
ELSE
	gn_config.is_work.Anio = YEAR(ld_FechaTrabajo)
	gn_config.is_work.Mes = ll_IdEstadoMensualOperacion
	li_Mes =  gn_config.is_work.Mes
	li_Anio = gn_config.is_work.Anio 
	SQLCA.Usp_EstadoMensualOperacion( gn_config.is_work.idempresa,ldt_Nulo ,li_Anio,li_Mes,gn_config.is_work.IdEstadoMensualOperacion, gn_config.is_work.EstadoOperacion , gn_config.is_work.EstadoMensualOperacion )
	CHOOSE CASE li_Mes
	CASE 0
		ls_Fecha = " - APERTURA"
	CASE 13
		ls_Fecha = " - CIERRE"
	CASE 14
		ls_Fecha = " - BALANCE"		
	END CHOOSE
	ls_Fecha = "FECHA TRABAJO : "+ uf_diafecha("DIAFECHA","WORK")  + ls_Fecha
     //ls_Fecha = "FECHA TRABAJO:"+uf_diafecha("DD/MM/YYYY","WORK") + ls_Fecha + " --- FECHA SISTEMA:"+uf_diafecha("DD/MM/YYYY","SISTEMA") 
END IF


	
	IF gn_config.is_work.IdEstadoMensualOperacion < 0 Then
		MessageBox(Gn_Config.Is_Work.Aplicacion ,"El mes no corresponde a sus operaciones No se puede Realizar Operaciones"+CHAR(13)+"Verifique el Estado mensual de la Operaci$$HEX1$$f300$$ENDHEX$$n",StopSign!)
		gb_AbrirCatalogos =  FALSE
		RETURN
	END IF
	
	IF  gn_config.is_work.EstadoOperacion AND gn_config.is_work.EstadoMensualOperacion THEN
		gb_AbrirCatalogos =  TRUE 
	END IF
	
	IF  NOT gn_config.is_work.EstadoOperacion AND NOT gn_config.is_work.EstadoMensualOperacion THEN	
		MessageBox(Gn_Config.Is_Work.Aplicacion ,"El mes no esta activo para su uso correspondiente "+CHAR(13)+"Verifique el Estado Mensual de la Operaci$$HEX1$$f300$$ENDHEX$$n",StopSign!)
		gb_AbrirCatalogos =  FALSE
	END IF
	
	IF  NOT gn_config.is_work.EstadoOperacion AND gn_config.is_work.EstadoMensualOperacion THEN	
		MessageBox(Gn_Config.Is_Work.Aplicacion ,"El mes esta cerrado y no se puede Trabajar en el Presente mes ",StopSign!)
		gb_AbrirCatalogos =  FALSE
	END IF
	
	IF  gn_config.is_work.EstadoOperacion AND NOT gn_config.is_work.EstadoMensualOperacion THEN	
		MessageBox(Gn_Config.Is_Work.Aplicacion ,"El mes esta inabilitado y no se puede Trabajar en el Presente mes ",StopSign!)
		gb_AbrirCatalogos =  FALSE
	END IF


		w_frame.title =Gn_Config.Is_Work.Aplicacion+" :  "+gn_config.is_work.empresades+" - RUC: "+gn_config.is_work.ruc+" --- USUARIO: "+gn_config.is_config.usuario +" ---  "+ls_Fecha 
//		w_frame.title =Gn_Config.Is_Work.Aplicacion+" :  "+gn_config.is_work.empresa +" "+gn_config.is_work.empresades+" - RUC: "+gn_config.is_work.ruc+" --- USUARIO: "+gn_config.is_config.usuario +" ---  "+ls_Fecha 


Close(parent)
end event

type dw_fechatrabajo from u_dw within w_selecion_fecha
integer width = 992
integer height = 1024
string dataobject = "d_fechatrabajo"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;
long ll_newrow
DateTime ldt_Fecha
Date ld_FechaTrabajo
of_setregistrarcalendario(TRUE)
of_setcampocalendario("fechasistema") 
of_setcampocalendario("fechatrabajo")

ll_newrow = THIS.InsertRow(0)
THIS.Object.FechaSistema[ll_newrow] = gn_config.is_work.FechaSistema
THIS.Object.FechaTrabajo[ll_newrow] = gn_config.is_work.FechaTrabajo
ld_FechaTrabajo = gn_config.is_work.FechaTrabajo

SQLCA.Usp_TipoCambio( gn_config.is_work.IdMonedaNacional , gn_config.is_work.IdMonedaExtranjera,String(gn_config.is_work.FechaTrabajo,"DD/MM/YYYY") , gn_config.is_work.IdTipoCambio, gn_config.is_work.TipoCambioCompra,  gn_config.is_work.TipoCambioVenta)

THIS.Object.TipoCambio[ll_newrow] =gn_config.is_work.TipoCambioCompra
THIS.Object.TipoCambioVenta[ll_newrow] =gn_config.is_work.TipoCambioVenta

IF STRING(ld_FechaTrabajo,"MMDD") = "0101" THEN
	 dw_fechatrabajo.Object.IdEstadoMensualOperacion[dw_fechatrabajo.GetRow()] = 0
ELSEIF STRING(ld_FechaTrabajo,"MMDD") = "1231" THEN
	dw_fechatrabajo.Object.IdEstadoMensualOperacion[dw_fechatrabajo.GetRow()] = 13
  ELSE
	IF gn_config.is_work.TipoCambioCompra > 0.00 AND gn_config.is_work.TipoCambioVenta > 0.00 THEN
		dw_fechatrabajo.Object.IdEstadoMensualOperacion[dw_fechatrabajo.GetRow()] = -1	
		cb_aceptar.TriggerEvent(Clicked!)
	ELSE
     	dw_fechatrabajo.Object.IdEstadoMensualOperacion[dw_fechatrabajo.GetRow()] = -1	
     END IF
END IF
end event

event ue_seleccion_calendario;call super::ue_seleccion_calendario;LongLong ll_IdTipoCambio 
Decimal {4} ld_TipoCambioCompra  , ld_TipoCambioVenta
Date ld_Fecha
ld_Fecha = Date(adt_valor)

dw_fechatrabajo.Object.FechaTrabajo[dw_fechatrabajo.GetRow()] = ld_Fecha

SQLCA.Usp_TipoCambio( gn_config.is_work.IdMonedaNacional , gn_config.is_work.IdMonedaExtranjera,String(ld_Fecha,"DD/MM/YYYY") , ll_IdTipoCambio ,ld_TipoCambioCompra, ld_TipoCambioVenta)

dw_fechatrabajo.Object.TipoCambio[dw_fechatrabajo.GetRow()] =ld_TipoCambioCompra
end event

event ue_dwnkey;call super::ue_dwnkey;Decimal {4} ld_compra ,ld_venta, ld_nulo , ld_TipoCambioCompra , ld_TipoCambioVenta
LongLong ll_IdTipoCambio
Date ld_FechaTrabajo
SetNull(ld_nulo)

IF key = keyenter! THEN  
	THIS.accepttext( )	 
	ld_FechaTrabajo = dw_fechatrabajo.Object.FechaTrabajo[dw_fechatrabajo.GetRow()] 
	ld_compra = dw_fechatrabajo.Object.TipoCambio[dw_fechatrabajo.GetRow()]
    ld_venta = dw_fechatrabajo.Object.TipoCambioVenta[dw_fechatrabajo.GetRow()]	

	CHOOSE CASE Upper(THIS.getcolumnname( )) 
		CASE Upper('fechatrabajo')					
			IF STRING(ld_FechaTrabajo,"MMDD") = "0101" THEN
				 dw_fechatrabajo.Object.IdEstadoMensualOperacion[dw_fechatrabajo.GetRow()] = 0
			ELSEIF STRING(ld_FechaTrabajo,"MMDD") = "1231" THEN
				dw_fechatrabajo.Object.IdEstadoMensualOperacion[dw_fechatrabajo.GetRow()] = 13
			  ELSE
				dw_fechatrabajo.Object.IdEstadoMensualOperacion[dw_fechatrabajo.GetRow()] = -1	
			END IF			
			
			ll_IdTipoCambio = 0
			ld_TipoCambioCompra = 0.000
			ld_TipoCambioVenta = 0.000
			
			SQLCA.Usp_TipoCambio( gn_config.is_work.IdMonedaNacional , gn_config.is_work.IdMonedaExtranjera,String(ld_FechaTrabajo,"DD/MM/YYYY") , ll_IdTipoCambio, ld_TipoCambioCompra,  ld_TipoCambioVenta)
			dw_fechatrabajo.Object.TipoCambio[dw_fechatrabajo.GetRow()] =ld_TipoCambioCompra
			dw_manto.Reset()
			dw_manto.Retrieve(Dec(  ll_IdTipoCambio ))
			send(handle(this), 256, 9, long(0,0))
			THIS.SelectText(1, Len(THIS.GetText()))
			THIS.setfocus( )
		CASE Upper('TIPOCAMBIOVENTA')	
			send(handle(this), 256, 9, long(0,0))
			THIS.SelectText(1, Len(THIS.GetText()))
			THIS.setfocus( )			
		CASE Upper('TIPOCAMBIO')
			ll_IdTipoCambio = 0
			ld_TipoCambioCompra = 0.000
			ld_TipoCambioVenta = 0.000
			SQLCA.Usp_TipoCambio( gn_config.is_work.IdMonedaNacional , gn_config.is_work.IdMonedaExtranjera,String(ld_FechaTrabajo,"DD/MM/YYYY") , ll_IdTipoCambio, ld_TipoCambioCompra,  ld_TipoCambioVenta)
				IF ld_compra =ld_TipoCambioCompra THEN
					  cb_aceptar.triggerevent( "Clicked")				
				ELSE
					IF ll_IdTipoCambio <> 0 THEN
						IF MessageBox(Gn_Config.Is_Work.Aplicacion ,"Desea actualizar el Tipo de Cambio Compra  de la Fecha "+String(ld_FechaTrabajo,"DD/MM/YYYY") + " de " + String(ld_TipoCambioCompra , "###.000")+ " a "+String( ld_compra ,"###.000"),Question!,YESNO!) = 1 THEN
								dw_manto.Object.compra[dw_manto.GetRow()] = ld_compra
								dw_manto.Object.venta[dw_manto.GetRow()] = ld_venta			
								dw_manto.Update( )
							     COMMIT  USING SQLCA ;
								  send(handle(this), 256, 9, long(0,0))
								cb_aceptar.triggerevent( "Clicked")
							ELSE
								RETURN 
						END IF
					ELSE
							IF MessageBox(Gn_Config.Is_Work.Aplicacion ,"Desea Registrar el Tipo de Cambio Compra de la Fecha "+String(ld_FechaTrabajo,"DD/MM/YYYY") + " de " + String( ld_compra ,"###.000"),Question!,YESNO!) = 1 THEN								
								Long ll_Fila
								String ls_CodTipoCambio = Space(10)
								ll_Fila = dw_manto.InsertRow(0)
								dw_manto.Object.compra[ll_Fila] = ld_compra
								dw_manto.Object.venta[dw_manto.GetRow()] = ld_venta			
								dw_manto.Object.fecha[ll_Fila] = DateTime(ld_FechaTrabajo, Time(0,0,0) )
								dw_manto.Object.IdMonedaNacional[ll_Fila] 	= gn_config.is_work.IdMonedaNacional
								dw_manto.Object.IdMonedaExtranjera[ll_Fila] = gn_config.is_work.IdMonedaExtranjera
								SQLCA.Usp_TipoCambio_Cod(ls_CodTipoCambio , 10 )
								COMMIT  USING SQLCA ;
								dw_manto.Object.CodTipoCambio[ll_Fila] = ls_CodTipoCambio							
								dw_manto.Update( )
							     COMMIT  USING SQLCA ;
								  send(handle(this), 256, 9, long(0,0))
								cb_aceptar.triggerevent( "Clicked")
							ELSE
								RETURN 
						END IF
					END IF					
				END IF
		
	END CHOOSE
END IF
end event

