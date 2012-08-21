HA$PBExportHeader$w_manto_producto.srw
forward
global type w_manto_producto from w_manto
end type
type dw_fraccion from datawindow within w_manto_producto
end type
end forward

global type w_manto_producto from w_manto
integer width = 3794
integer height = 2748
string title = "Cat$$HEX1$$e100$$ENDHEX$$logo de Productos"
string is_tabla = "PRODUCTO"
string is_campocod = "CodProducto"
string is_campoid = "IdProducto"
integer ii_largocod = 10
string is_campofinal = "Estado"
dw_fraccion dw_fraccion
end type
global w_manto_producto w_manto_producto

type variables
DataWindowChild idwc_Linea, idwc_Talla, idwc_Marca, idwc_Color,   idwc_EstadoMensualOperacion , idwc_Mes , idwc_Impuesto

DwItemStatus iIS_status,iIS_IdUnidad,iIS_IdUnidadMinima, iIS_Fraccion, iIS_Fracciones
Decimal &
id_IdUnidad_Original, &
id_IdUnidadMinima_Original, &
id_IdUnidad_Actual, &
id_IdUnidadMinima_Actual


Int &
ii_Fraccion_Original, &
ii_Fraccion_Actual


Long &
il_Fracciones_Original, &
il_Fracciones_Actual
end variables

forward prototypes
public subroutine wf_datos_adicionales ()
public subroutine wf_fracciones (dwitemstatus as_status)
end prototypes

public subroutine wf_datos_adicionales ();
dwItemStatus l_status

l_status = idw_activa.GetItemStatus( idw_activa.getrow() , 0, Primary!)

choose case l_status
	case New!, NewModified!
			idw_activa.Object.idEmpresa[idw_activa.getrow()]= gn_config.is_work.idempresa
end choose



end subroutine

public subroutine wf_fracciones (dwitemstatus as_status);
DatawindowChild ldwch_Hija

String ls_fecha,ls_hora

Long ll_oldrow,ll_NewRow,ll_FilaUni

CHOOSE CASE as_status	
	CASE New!,NewModified!
		dw_fraccion.Reset()
		ll_oldrow = ll_NewRow
		ll_NewRow = dw_fraccion.InsertRow(0)
		dw_fraccion.ScrollToRow(ll_NewRow)
					
		//Datos de Pk_Fraccion
 	     dw_fraccion.Object.IdProducto[ll_NewRow] 		= id_codigo
          dw_fraccion.Object.IdUnidad[ll_NewRow] 			= id_IdUnidad_Actual
			 
		IF idw_activa.GetChild( 'IdUnidad',ldwch_Hija)  = -1 THEN MessageBox(   "Error", "Not a DataWindowChild")		
		ldwch_Hija.AcceptText( )
          dw_fraccion.Object.CodUnidad[ll_NewRow] 		=  ldwch_Hija.GetItemString(ldwch_Hija.GetRow(),'CodUnidad')
          dw_fraccion.Object.Abreviacion[ll_NewRow] 		=  ldwch_Hija.GetItemString(ldwch_Hija.GetRow(),'Abreviacion')
          dw_fraccion.Object.Nombre[ll_NewRow] 			=  ldwch_Hija.GetItemString(ldwch_Hija.GetRow(),'Nombre')
          dw_fraccion.Object.Cantidad[ll_NewRow] 			= il_Fracciones_Actual

		IF ii_Fraccion_Actual = 1 THEN
			ll_oldrow = ll_NewRow
			ll_NewRow = dw_fraccion.InsertRow(0)
			dw_fraccion.ScrollToRow(ll_NewRow)
			
			//Datos de Pk_Fraccion Minima 
			 dw_fraccion.Object.IdProducto[ll_NewRow] 		= id_codigo
			 dw_fraccion.Object.IdUnidad[ll_NewRow] 			= id_IdUnidadMinima_Actual
				 
			IF idw_activa.GetChild( 'IdUnidadMinima',ldwch_Hija)  = -1 THEN MessageBox(   "Error", "Not a DataWindowChild")			 
			dw_fraccion.Object.CodUnidad[ll_NewRow] 		=  ldwch_Hija.GetItemString(ldwch_Hija.GetRow(),'CodUnidad')
			dw_fraccion.Object.Abreviacion[ll_NewRow] 		=  ldwch_Hija.GetItemString(ldwch_Hija.GetRow(),'Abreviacion')
			dw_fraccion.Object.Nombre[ll_NewRow] 			=  ldwch_Hija.GetItemString(ldwch_Hija.GetRow(),'Nombre')
			dw_fraccion.Object.Cantidad[ll_NewRow] 			= 1
		END IF
		
CASE	DataModified!
		//  Si unidad ha sido modificada
		IF iIS_IdUnidad = DataModified! THEN
			IF id_IdUnidad_Original <> id_IdUnidad_Actual THEN
				ll_FilaUni = dw_fraccion.find( " IdUnidad = "+String(id_IdUnidad_Original)+" ",1,dw_fraccion.RowCount())
				IF ll_FilaUni > 0 THEN
					dw_fraccion.ScrollToRow(ll_FilaUni)		
					IF idw_activa.GetChild( 'IdUnidad',ldwch_Hija)  = -1 THEN MessageBox(   "Error", "Not a DataWindowChild")						
					ldwch_Hija.AcceptText( )
					dw_fraccion.Object.IdUnidad[ll_FilaUni] 			=  	id_IdUnidad_Actual	
					dw_fraccion.Object.CodUnidad[ll_FilaUni] 		=  	ldwch_Hija.GetItemString(ldwch_Hija.GetRow(),'CodUnidad')
					dw_fraccion.Object.Abreviacion[ll_FilaUni] 		=  	ldwch_Hija.GetItemString(ldwch_Hija.GetRow(),'Abreviacion')
					dw_fraccion.Object.Nombre[ll_FilaUni] 			=  	ldwch_Hija.GetItemString(ldwch_Hija.GetRow(),'Nombre')
					dw_fraccion.Object.Cantidad[ll_FilaUni] 			=	il_Fracciones_Actual
				END IF				
			END IF
		END IF
		
		// Si Fraccion ha sido modIFicada
		IF iIS_Fraccion	 = DataModified! THEN
			IF ii_Fraccion_Original <> ii_Fraccion_Actual THEN // y los valores son dIFerentes
				IF ii_Fraccion_Actual = 0 THEN //Si el estado Actual en no Fraccionado
					// Eliminar las Fraciones si el valor original es dIFerente de Nulo y Poner Unidad con fracciones  = 1
					IF NOT IsNull(id_IdUnidadMinima_Original) THEN 
						//Unidad
						ll_FilaUni = dw_fraccion.find( " IdUnidad = "+String(id_IdUnidad_Original)+" ",1,dw_fraccion.RowCount())
						IF ll_FilaUni > 0 THEN
							dw_fraccion.ScrollToRow(ll_FilaUni)
							dw_fraccion.Object.Cantidad[ll_FilaUni] 		= 1
						END IF
						//Unidad Minima
						ll_FilaUni = 0
						ll_FilaUni = dw_fraccion.find( " IdUnidad = "+String(id_IdUnidadMinima_Original)+" ",1,dw_fraccion.RowCount())
						IF ll_FilaUni > 0 THEN
							dw_fraccion.ScrollToRow(ll_FilaUni)
							dw_fraccion.DeleteRow(ll_FilaUni )
						END IF
					END IF
				ELSE // si el estado Actual es Fraccionado
					// Actualizar fraciones en Unidad
					ll_FilaUni = dw_fraccion.find( " IdUnidad = "+String(id_IdUnidad_Original)+" ",1,dw_fraccion.RowCount())										
					IF ll_FilaUni > 0 THEN
						dw_fraccion.ScrollToRow(ll_FilaUni)
						dw_fraccion.Object.Cantidad[ll_FilaUni] 		= il_Fracciones_Actual
					END IF
		
					// Insertar la Fraccion con el nuevo Valor
					ll_oldrow = ll_NewRow
					ll_NewRow = dw_fraccion.InsertRow(0)
					dw_fraccion.ScrollToRow(ll_NewRow)
			
					//Datos de Pk_Fraccion Minima 
					 dw_fraccion.Object.IdProducto[ll_NewRow] 		= id_codigo
					 dw_fraccion.Object.IdUnidad[ll_NewRow] 			= id_IdUnidadMinima_Actual
						 
					IF idw_activa.GetChild( 'IdUnidadMinima',ldwch_Hija)  = -1 THEN MessageBox(   "Error", "Not a DataWindowChild")			 
					dw_fraccion.Object.CodUnidad[ll_NewRow] 		=  ldwch_Hija.GetItemString(ldwch_Hija.GetRow(),'CodUnidad')
					dw_fraccion.Object.Abreviacion[ll_NewRow] 		=  ldwch_Hija.GetItemString(ldwch_Hija.GetRow(),'Abreviacion')
					dw_fraccion.Object.Nombre[ll_NewRow] 			=  ldwch_Hija.GetItemString(ldwch_Hija.GetRow(),'Nombre')
					dw_fraccion.Object.Cantidad[ll_NewRow] 			= 1
			
				END IF				
			END IF
		END IF
		
		// Si Unidad Minima ha sido ModIFicada
		IF iIS_IdUnidadMinima = DataModified! THEN
			IF ii_Fraccion_Actual = ii_Fraccion_Original THEN // si el valor original  de Fracion es igual al valor actual de Fracion
				IF ii_Fraccion_Actual = 1 THEN  // y si el valor actual esta activo = 1
					ll_FilaUni = dw_fraccion.find( " IdUnidad = "+String(id_IdUnidadMinima_Original)+" ",1,dw_fraccion.RowCount())
					IF ll_FilaUni > 0 THEN
						dw_fraccion.Object.IdUnidad[ll_FilaUni] 			= id_IdUnidadMinima_Actual							 
						IF idw_activa.GetChild( 'IdUnidadMinima',ldwch_Hija)  = -1 THEN MessageBox(   "Error", "Not a DataWindowChild")			 
						dw_fraccion.Object.CodUnidad[ll_FilaUni] 		=  ldwch_Hija.GetItemString(ldwch_Hija.GetRow(),'CodUnidad')
						dw_fraccion.Object.Abreviacion[ll_FilaUni] 		=  ldwch_Hija.GetItemString(ldwch_Hija.GetRow(),'Abreviacion')
						dw_fraccion.Object.Nombre[ll_FilaUni] 			=  ldwch_Hija.GetItemString(ldwch_Hija.GetRow(),'Nombre')
						dw_fraccion.Object.Cantidad[ll_FilaUni] 			= 1
					END IF
				END IF
			END IF
		END IF
		
		// Si Cantidad de Fracciones ha Sido ModIFicada
		IF iIS_Fracciones = DataModified! THEN
			IF ii_Fraccion_Actual = ii_Fraccion_Original THEN
				IF ii_Fraccion_Actual = 1 THEN 
					IF il_Fracciones_Original<>il_Fracciones_Actual THEN
						ll_FilaUni = dw_fraccion.find( " IdUnidad = "+String(id_IdUnidad_Original)+" ",1,dw_fraccion.RowCount())
						IF ll_FilaUni > 0 THEN
							dw_fraccion.ScrollToRow(ll_FilaUni)
							dw_fraccion.Object.Cantidad[ll_FilaUni] 		= il_Fracciones_Actual
						END IF
					END IF
				END IF
			END IF
		END IF
	
		
					
END CHOOSE
dw_fraccion.accepttext( )
dw_fraccion.update( )
commit using SQLCA;

end subroutine

on w_manto_producto.create
int iCurrent
call super::create
this.dw_fraccion=create dw_fraccion
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_fraccion
end on

on w_manto_producto.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_fraccion)
end on

type gb_comandos from w_manto`gb_comandos within w_manto_producto
integer x = 55
integer y = 2192
integer width = 3470
end type

type tab_todo from w_manto`tab_todo within w_manto_producto
integer x = 0
integer width = 3767
integer height = 2564
end type

type tp_manto from w_manto`tp_manto within tab_todo
integer width = 3730
integer height = 2436
string text = "Datos de Producto"
end type

type dw_manto from w_manto`dw_manto within tp_manto
integer y = 0
integer width = 3730
integer height = 2028
string dataobject = "d_productohistorico_manto"
boolean hscrollbar = true
end type

event dw_manto::ue_saveprevious;call super::ue_saveprevious;DwItemStatus	le_status
String &
ls_Mensaje, &
ls_Data, &
ls_TipoProducto_Original, &
ls_Nombre_Original, &
ls_NombreCorto_Original, &
ls_CodBar_Original, &
ls_CodBar1_Original, &
ls_CodBar2_Original, &
ls_TipoProducto_Actual, &
ls_Nombre_Actual, &
ls_NombreCorto_Actual, &
ls_CodBar_Actual, &
ls_CodBar1_Actual, &
ls_CodBar2_Actual

Int &
li_Fraccion, &
li_ImpuestoEstado, &
li_Impuesto2Estado, &
li_Impuesto3Estado, &
li_Impuesto4Estado

Long &
ll_Fracciones, &
ll_Fila_Busqueda, &
ll_Filas_Encontradas

Decimal &
ld_StockMin, &          
ld_StockMax, &                 
ld_StockMaxUnidad, &     
ld_StockMinUnidad


Decimal {0} &
ld_Nulo, &   
ld_IdUnidad, &     
ld_IdUnidadMinima, &
ld_IdImpuesto, &
ld_IdImpuesto2, &
ld_IdImpuesto3, &
ld_IdImpuesto4


le_status = THIS.GetItemStatus (THIS.GetRow(), 0, Primary!)

THIS.Accepttext( )
SetNull(ld_Nulo)

ls_TipoProducto_Original	=Trim(idw_activa.Object.TipoProducto.Primary.Original[idw_activa.GetRow()])
ls_Nombre_Original		=Trim(idw_activa.Object.Nombre.Primary.Original[idw_activa.GetRow()])
ls_NombreCorto_Original=Trim(idw_activa.Object.NombreCorto.Primary.Original[idw_activa.GetRow()])
ls_CodBar_Original		=Trim(idw_activa.Object.CodBar.Primary.Original[idw_activa.GetRow()])
ls_CodBar1_Original		=Trim(idw_activa.Object.CodBar1.Primary.Original[idw_activa.GetRow()])
ls_CodBar2_Original		=Trim(idw_activa.Object.CodBar2.Primary.Original[idw_activa.GetRow()])
ls_TipoProducto_Actual	=Trim(idw_activa.Object.TipoProducto.Primary.Current[idw_activa.GetRow()])
ls_Nombre_Actual			=Trim(idw_activa.Object.Nombre.Primary.Current[idw_activa.GetRow()])
ls_NombreCorto_Actual	=Trim(idw_activa.Object.NombreCorto.Primary.Current[idw_activa.GetRow()])
ls_CodBar_Actual			=Trim(idw_activa.Object.CodBar.Primary.Current[idw_activa.GetRow()])
ls_CodBar1_Actual		=Trim(idw_activa.Object.CodBar1.Primary.Current[idw_activa.GetRow()])
ls_CodBar2_Actual		=Trim(idw_activa.Object.CodBar2.Primary.Current[idw_activa.GetRow()])

ld_IdUnidad					= idw_activa.Object.IdUnidad	[idw_activa.GetRow()] 
li_Fraccion 					= idw_activa.Object.Fraccion[idw_activa.GetRow()]     
ld_IdUnidadMinima			= idw_activa.Object.IdUnidadMinima	[idw_activa.GetRow()]     
ll_Fracciones 				= idw_activa.Object.Fracciones[idw_activa.GetRow()]     
ld_StockMin					= idw_activa.Object.StockMin[idw_activa.GetRow()]     
ld_StockMax 				= idw_activa.Object.StockMax[idw_activa.GetRow()]           
ld_StockMaxUnidad 		= idw_activa.Object.StockMaxUnidad[idw_activa.GetRow()]    
ld_StockMinUnidad 		= idw_activa.Object.StockMinUnidad[idw_activa.GetRow()]		

IF (Trim(ls_Nombre_Actual) = "" OR IsNull(ls_Nombre_Actual)) THEN
		MessageBox("Advertencia ... se necesitan datos","Nombre ",StopSign!)
		idw_activa.SetColumn( 'Nombre')
		idw_activa.SetFocus()
		RETURN 0
ELSEIF (Trim(ls_NombreCorto_Actual) = "" OR IsNull(ls_NombreCorto_Actual)) THEN
		MessageBox("Advertencia ... se necesitan datos","NombreCorto",StopSign!)
		idw_activa.SetColumn( 'NombreCorto')
		idw_activa.SetFocus()
		RETURN 0	
END IF

// Validacion de Duplicidad de Nombre 
ls_Mensaje = ""
ll_Fila_Busqueda = 1
ll_Filas_Encontradas = 0
ls_Data = " Nombre = '"+ls_Nombre_Actual+"'"

DO 
	il_Fila = idw_lista.find(ls_Data,ll_fila_busqueda,idw_lista.RowCount())
	IF il_Fila > 0 THEN
		ls_Mensaje = ls_Mensaje + char(13)+"Fila : "+String(il_Fila)+"  C$$HEX1$$f300$$ENDHEX$$digo : "+ idw_lista.Object.CodProducto[il_Fila]
		ll_fila_busqueda = il_Fila + 1
		ll_Filas_Encontradas ++
		IF ll_fila_busqueda > idw_lista.RowCount() THEN EXIT
	END IF
LOOP WHILE il_Fila <> 0

CHOOSE CASE le_status	
	CASE New!,NewModified!
			IF ll_Filas_Encontradas > 0 THEN
				MessageBox("Advertecia " + Gn_Config.Is_Work.Aplicacion  ,"Nombre  ya existe......!!!"+ls_Mensaje,StopSign!)
				THIS.SetColumn('Nombre')
				//THIS.SelectText(1, Len(THIS.GetText()))
				THIS.SetFocus( )
				RETURN 0
			END IF		
	CASE	DataModified!
		IF ls_Nombre_Actual <>ls_Nombre_Original THEN
			IF ll_Filas_Encontradas > 0 THEN
				MessageBox("Advertecia " + Gn_Config.Is_Work.Aplicacion  ,"Nombre  ya existe......!!!"+ls_Mensaje,StopSign!)
				THIS.SetColumn('Nombre')
				//THIS.SelectText(1, Len(THIS.GetText()))
				THIS.SetFocus( )
				RETURN 0
			END IF
		END IF
END CHOOSE

// Validacion de Duplicidad de NombreCorto 
ls_Mensaje = ""
ll_Fila_Busqueda = 1
ll_Filas_Encontradas = 0
ls_Data = " NombreCorto = '"+ls_NombreCorto_Actual+"'"

DO 
	il_Fila = idw_lista.find(ls_Data,ll_fila_busqueda,idw_lista.RowCount())
	IF il_Fila > 0 THEN
		ls_Mensaje = ls_Mensaje + char(13)+"Fila : "+String(il_Fila)+"  C$$HEX1$$f300$$ENDHEX$$digo : "+ idw_lista.Object.CodProducto[il_Fila]
		ll_fila_busqueda = il_Fila + 1
		ll_Filas_Encontradas ++
		IF ll_fila_busqueda > idw_lista.RowCount() THEN EXIT
	END IF
LOOP WHILE il_Fila <> 0

CHOOSE CASE le_status	
	CASE New!,NewModified!
			IF ll_Filas_Encontradas > 0 THEN
				MessageBox("Advertecia " + Gn_Config.Is_Work.Aplicacion  ,"Nombre Corto  ya existe......!!!"+ls_Mensaje,StopSign!)
				THIS.SetColumn('NombreCorto')
				//THIS.SelectText(1, Len(THIS.GetText()))
				THIS.SetFocus( )
				RETURN 0
			END IF		
	CASE	DataModified!
		IF ls_NombreCorto_Actual <>ls_NombreCorto_Original THEN
			IF ll_Filas_Encontradas > 0 THEN
				MessageBox("Advertecia " + Gn_Config.Is_Work.Aplicacion  ,"Nombre Corto  ya existe......!!!"+ls_Mensaje,StopSign!)
				THIS.SetColumn('NombreCorto')
				//THIS.SelectText(1, Len(THIS.GetText()))
				THIS.SetFocus( )
				RETURN 0
			END IF
		END IF
END CHOOSE

// Validacion de Unidades y Fracciones

IF ls_TipoProducto_Actual ="B" THEN
	IF ld_IdUnidad = 0 THEN 
		MessageBox("Advertecia " + Gn_Config.Is_Work.Aplicacion  ,"Unidad no puede ser tipo SERVICIO para un BIEN......!!!",StopSign!)
		THIS.SetColumn('IdUnidad')
		//THIS.SelectText(1, Len(THIS.GetText()))
		THIS.SetFocus( )
		RETURN 0
	END IF
	IF	li_Fraccion = 0 THEN
		idw_activa.Object.IdUnidadMinima[idw_activa.GetRow()] = idw_activa.Object.IdUnidad[idw_activa.GetRow()] 
		idw_activa.Object.Fracciones[idw_activa.GetRow()]  = 1
	ELSE
		IF ld_IdUnidadMinima = 0 THEN 
			MessageBox("Advertecia " + Gn_Config.Is_Work.Aplicacion  ,"Fracci$$HEX1$$f300$$ENDHEX$$n no puede ser tipo SERVICIO para un BIEN......!!!",StopSign!)
			THIS.SetColumn('IdUnidadMinima')
			//THIS.SelectText(1, Len(THIS.GetText()))
			THIS.SetFocus( )
			RETURN 0
		END IF
		IF ld_IdUnidadMinima = ld_IdUnidad THEN 
			MessageBox("Advertecia " + Gn_Config.Is_Work.Aplicacion  ,"Unidad y Fracci$$HEX1$$f300$$ENDHEX$$n deben ser distintas......!!!",StopSign!)
			THIS.SetColumn('IdUnidadMinima')
			//THIS.SelectText(1, Len(THIS.GetText()))
			THIS.SetFocus( )
			RETURN 0
		END IF			
		IF ll_Fracciones <= 1 THEN 
			MessageBox("Advertecia " + Gn_Config.Is_Work.Aplicacion  ,"Fracciones deben ser mayores a 1 ......!!!",StopSign!)
			THIS.SetColumn('Fracciones')
			//THIS.SelectText(1, Len(THIS.GetText()))
			THIS.SetFocus( )
			RETURN 0
		END IF	
	END IF
END IF


// Igualo el il_statuspara pasarlo despues de grabar 
iIS_status = le_status

iIS_IdUnidad			= THIS.GetItemStatus (THIS.GetRow(), 'IdUnidad', Primary!)
iIS_IdUnidadMinima	= THIS.GetItemStatus (THIS.GetRow(), 'IdUnidadMinima', Primary!)
iIS_Fraccion				= THIS.GetItemStatus (THIS.GetRow(), 'Fraccion', Primary!)
iIS_Fracciones			= THIS.GetItemStatus (THIS.GetRow(), 'Fracciones', Primary!)

id_IdUnidad_Original			= THIS.Object.IdUnidad.Primary.Original[THIS.GetRow()]
id_IdUnidadMinima_Original	= THIS.Object.IdUnidadMinima.Primary.Original[THIS.GetRow()]
ii_Fraccion_Original			= THIS.Object.Fraccion.Primary.Original[THIS.GetRow()]
il_Fracciones_Original			= THIS.Object.Fracciones.Primary.Original[THIS.GetRow()]

id_IdUnidad_Actual			=	THIS.Object.IdUnidad.Primary.Current[THIS.GetRow()]
id_IdUnidadMinima_Actual	=	THIS.Object.IdUnidadMinima.Primary.Current[THIS.GetRow()]
ii_Fraccion_Actual				=	THIS.Object.Fraccion.Primary.Current[THIS.GetRow()]
il_Fracciones_Actual			=	THIS.Object.Fracciones.Primary.Current[THIS.GetRow()]


// Validacion de Duplicidad de  Codigo de Barras 
ls_Mensaje = ""
ll_Fila_Busqueda = 1
ll_Filas_Encontradas = 0
ls_Data = ""
IF ls_CodBar_Actual <> ""   AND NOT IsNull(ls_CodBar_Actual)   THEN    
	
	ls_Data = " CodBar = '"+ls_CodBar_Actual+ "' OR  CodBar1 = '"+ls_CodBar_Actual+  "' OR  CodBar2 = '"+ls_CodBar_Actual+  "'" 

	DO 
		il_Fila = idw_lista.Find(ls_Data,ll_fila_busqueda,idw_lista.RowCount())
		IF il_Fila > 0 THEN
			ls_Mensaje = ls_Mensaje + char(13)+"Fila : "+String(il_Fila)+"  C$$HEX1$$f300$$ENDHEX$$digo : "+ idw_lista.Object.CodProducto[il_Fila]
			ll_Fila_Busqueda = il_Fila + 1
			ll_Filas_Encontradas ++
			IF ll_Fila_Busqueda > idw_lista.RowCount() THEN EXIT
		END IF
	LOOP WHILE il_Fila <> 0
	
	CHOOSE CASE le_Status	
		CASE New!,NewModified!
				IF ll_Filas_Encontradas > 0 THEN
					MessageBox("Advertecia " + Gn_Config.Is_Work.Aplicacion  ,"C$$HEX1$$f300$$ENDHEX$$digo de Barras  ya existe......!!!"+ls_Mensaje,StopSign!)
					THIS.SetColumn('CodBar')
					//THIS.SelectText(1, Len(THIS.GetText()))
					THIS.SetFocus( )
					RETURN 0
				END IF		
		CASE	DataModified!
			IF ls_CodBar_Actual <>ls_CodBar_Original  AND  ls_CodBar_Actual <>ls_CodBar1_Original AND  ls_CodBar_Actual <>ls_CodBar2_Original THEN
				IF ll_Filas_Encontradas > 0 THEN
					MessageBox("Advertecia " + Gn_Config.Is_Work.Aplicacion  ,"C$$HEX1$$f300$$ENDHEX$$digo de Barras  ya existe......!!!"+ls_Mensaje,StopSign!)
					THIS.SetColumn('CodBar')
					//THIS.SelectText(1, Len(THIS.GetText()))
					THIS.SetFocus( )
					RETURN 0
				END IF
			END IF
	END CHOOSE
END IF

// Validacion de Duplicidad de  Codigo de Barras 1
ls_Mensaje = ""
ll_Fila_Busqueda = 1
ll_Filas_Encontradas = 0
ls_Data = ""
IF ls_CodBar1_Actual <> ""   AND NOT IsNull(ls_CodBar1_Actual)   THEN    
	
	ls_Data = " CodBar = '"+ls_CodBar1_Actual+ "' OR  CodBar1 = '"+ls_CodBar1_Actual+  "' OR  CodBar2 = '"+ls_CodBar1_Actual+  "'" 

	DO 
		il_Fila = idw_lista.Find(ls_Data,ll_fila_busqueda,idw_lista.RowCount())
		IF il_Fila > 0 THEN
			ls_Mensaje = ls_Mensaje + char(13)+"Fila : "+String(il_Fila)+"  C$$HEX1$$f300$$ENDHEX$$digo : "+ idw_lista.Object.CodProducto[il_Fila]
			ll_Fila_Busqueda = il_Fila + 1
			ll_Filas_Encontradas ++
			IF ll_Fila_Busqueda > idw_lista.RowCount() THEN EXIT
		END IF
	LOOP WHILE il_Fila <> 0
	
	CHOOSE CASE le_Status	
		CASE New!,NewModified!
				IF ll_Filas_Encontradas > 0 THEN
					MessageBox("Advertecia " + Gn_Config.Is_Work.Aplicacion  ,"C$$HEX1$$f300$$ENDHEX$$digo de Barras  ya existe......!!!"+ls_Mensaje,StopSign!)
					THIS.SetColumn('CodBar1')
					//THIS.SelectText(1, Len(THIS.GetText()))
					THIS.SetFocus( )
					RETURN 0
				END IF		
		CASE	DataModified!
			IF ls_CodBar1_Actual <>ls_CodBar1_Original   AND  ls_CodBar1_Actual <>ls_CodBar_Original AND  ls_CodBar1_Actual <>ls_CodBar2_Original THEN
				IF ll_Filas_Encontradas > 0 THEN
					MessageBox("Advertecia " + Gn_Config.Is_Work.Aplicacion  ,"C$$HEX1$$f300$$ENDHEX$$digo de Barras  ya existe......!!!"+ls_Mensaje,StopSign!)
					THIS.SetColumn('CodBar1')
					//THIS.SelectText(1, Len(THIS.GetText()))
					THIS.SetFocus( )
					RETURN 0
				END IF
			END IF
	END CHOOSE
END IF

// Validacion de Duplicidad de  Codigo de Barras 2
ls_Mensaje = ""
ll_Fila_Busqueda = 1
ll_Filas_Encontradas = 0
ls_Data = ""
IF ls_CodBar2_Actual <> ""   AND NOT IsNull(ls_CodBar2_Actual)   THEN    
	
	ls_Data = " CodBar = '"+ls_CodBar2_Actual+ "' OR  CodBar1 = '"+ls_CodBar2_Actual+  "' OR  CodBar2 = '"+ls_CodBar2_Actual+  "'" 

	DO 
		il_Fila = idw_lista.Find(ls_Data,ll_fila_busqueda,idw_lista.RowCount())
		IF il_Fila > 0 THEN
			ls_Mensaje = ls_Mensaje + char(13)+"Fila : "+String(il_Fila)+"  C$$HEX1$$f300$$ENDHEX$$digo : "+ idw_lista.Object.CodProducto[il_Fila]
			ll_Fila_Busqueda = il_Fila + 1
			ll_Filas_Encontradas ++
			IF ll_Fila_Busqueda > idw_lista.RowCount() THEN EXIT
		END IF
	LOOP WHILE il_Fila <> 0
	
	CHOOSE CASE le_Status	
		CASE New!,NewModified!
				IF ll_Filas_Encontradas > 0 THEN
					MessageBox("Advertecia " + Gn_Config.Is_Work.Aplicacion  ,"C$$HEX1$$f300$$ENDHEX$$digo de Barras  ya existe......!!!"+ls_Mensaje,StopSign!)
					THIS.SetColumn('CodBar2')
					//THIS.SelectText(1, Len(THIS.GetText()))
					THIS.SetFocus( )
					RETURN 0
				END IF		
		CASE	DataModified!
			IF ls_CodBar2_Actual <>ls_CodBar2_Original   AND  ls_CodBar2_Actual <>ls_CodBar_Original AND  ls_CodBar2_Actual <>ls_CodBar1_Original  THEN
				IF ll_Filas_Encontradas > 0 THEN
					MessageBox("Advertecia " + Gn_Config.Is_Work.Aplicacion  ,"C$$HEX1$$f300$$ENDHEX$$digo de Barras  ya existe......!!!"+ls_Mensaje,StopSign!)
					THIS.SetColumn('CodBar2')
					//THIS.SelectText(1, Len(THIS.GetText()))
					THIS.SetFocus( )
					RETURN 0
				END IF
			END IF
	END CHOOSE
END IF

THIS.Object.IdDescuento[THIS.GetRow()] = ld_Nulo
THIS.Object.IdDescuento2[THIS.GetRow()] = ld_Nulo
THIS.Object.IdDescuento3[THIS.GetRow()] = ld_Nulo
THIS.Object.IdDescuento4[THIS.GetRow()] = ld_Nulo

li_ImpuestoEstado 	= THIS.Object.ImpuestoEstado[THIS.GetRow()]
li_Impuesto2Estado	= THIS.Object.Impuesto2Estado[THIS.GetRow()]
li_Impuesto3Estado	= THIS.Object.Impuesto3Estado[THIS.GetRow()]
li_Impuesto4Estado	= THIS.Object.Impuesto4Estado[THIS.GetRow()]

IF li_ImpuestoEstado 		= 0 THEN THIS.Object.IdImpuesto[THIS.GetRow()] = ld_Nulo
IF li_Impuesto2Estado	= 0 THEN THIS.Object.IdImpuesto2[THIS.GetRow()] = ld_Nulo
IF li_Impuesto3Estado	= 0 THEN THIS.Object.IdImpuesto3[THIS.GetRow()] = ld_Nulo
IF li_Impuesto4Estado	= 0 THEN THIS.Object.IdImpuesto4[THIS.GetRow()] = ld_Nulo

THIS.Accepttext( )

ld_IdImpuesto		= Dec(THIS.Object.IdImpuesto[THIS.GetRow()])
ld_IdImpuesto2	= Dec(THIS.Object.IdImpuesto2[THIS.GetRow()])
ld_IdImpuesto3	= Dec(THIS.Object.IdImpuesto3[THIS.GetRow()])
ld_IdImpuesto4	= Dec(THIS.Object.IdImpuesto4[THIS.GetRow()])



IF li_ImpuestoEstado = 1 AND (ld_IdImpuesto = 0  OR IsNull(ld_IdImpuesto) )THEN 
	MessageBox("Advertecia " + Gn_Config.Is_Work.Aplicacion  ,"Impuesto No Seleccionado......!!!"+ls_Mensaje,StopSign!)
	THIS.SetColumn('IdImpuesto')
	//THIS.SelectText(1, Len(THIS.GetText()))
	THIS.SetFocus( )
	RETURN 0
END IF	

IF li_Impuesto2Estado = 1 AND ( ld_IdImpuesto2 = 0 OR IsNull(ld_IdImpuesto2) ) THEN 
	MessageBox("Advertecia " + Gn_Config.Is_Work.Aplicacion  ,"Impuesto No Seleccionado......!!!"+ls_Mensaje,StopSign!)
	THIS.SetColumn('IdImpuesto2')
	//THIS.SelectText(1, Len(THIS.GetText()))
	THIS.SetFocus( )
	RETURN 0
END IF	
IF li_Impuesto3Estado = 1 AND ( ld_IdImpuesto3 = 0 OR IsNull(ld_IdImpuesto3) ) THEN 
	MessageBox("Advertecia " + Gn_Config.Is_Work.Aplicacion  ,"Impuesto No Seleccionado......!!!"+ls_Mensaje,StopSign!)
	THIS.SetColumn('IdImpuesto3')
	//THIS.SelectText(1, Len(THIS.GetText()))
	THIS.SetFocus( )
	RETURN 0
END IF	
IF li_Impuesto4Estado = 1 AND ( ld_IdImpuesto4 = 0 OR IsNull(ld_IdImpuesto4) ) THEN 
	MessageBox("Advertecia " + Gn_Config.Is_Work.Aplicacion  ,"Impuesto No Seleccionado......!!!"+ls_Mensaje,StopSign!)
	THIS.SetColumn('IdImpuesto4')
	//THIS.SelectText(1, Len(THIS.GetText()))
	THIS.SetFocus( )
	RETURN 0
END IF	

IF li_ImpuestoEstado = 1 THEN
	IF NOT IsNull(ld_IdImpuesto2) Then
		IF ld_IdImpuesto = ld_IdImpuesto2 THEN
			MessageBox("Advertecia " + Gn_Config.Is_Work.Aplicacion  ,"Impuesto duplicado......!!!"+ls_Mensaje,StopSign!)
			THIS.SetColumn('IdImpuesto2')
			//THIS.SelectText(1, Len(THIS.GetText()))
			THIS.SetFocus( )
			RETURN 0
		END IF
	END IF
	IF NOT IsNull(ld_IdImpuesto3) Then
		IF ld_IdImpuesto = ld_IdImpuesto3 THEN
			MessageBox("Advertecia " + Gn_Config.Is_Work.Aplicacion  ,"Impuesto duplicado......!!!"+ls_Mensaje,StopSign!)
			THIS.SetColumn('IdImpuesto3')
			//THIS.SelectText(1, Len(THIS.GetText()))
			THIS.SetFocus( )
			RETURN 0
		END IF
	END IF	
	IF NOT IsNull(ld_IdImpuesto4) Then
		IF ld_IdImpuesto = ld_IdImpuesto4 THEN
			MessageBox("Advertecia " + Gn_Config.Is_Work.Aplicacion  ,"Impuesto duplicado......!!!"+ls_Mensaje,StopSign!)
			THIS.SetColumn('IdImpuesto4')
			//THIS.SelectText(1, Len(THIS.GetText()))
			THIS.SetFocus( )
			RETURN 0
		END IF
	END IF
END IF

IF li_Impuesto2Estado = 1 THEN
	IF NOT IsNull(ld_IdImpuesto) Then
		IF ld_IdImpuesto2 = ld_IdImpuesto THEN
			MessageBox("Advertecia " + Gn_Config.Is_Work.Aplicacion  ,"Impuesto duplicado......!!!"+ls_Mensaje,StopSign!)
			THIS.SetColumn('IdImpuesto')
			//THIS.SelectText(1, Len(THIS.GetText()))
			THIS.SetFocus( )
			RETURN 0
		END IF
	END IF
	IF NOT IsNull(ld_IdImpuesto3) Then
		IF ld_IdImpuesto2 = ld_IdImpuesto3 THEN
			MessageBox("Advertecia " + Gn_Config.Is_Work.Aplicacion  ,"Impuesto duplicado......!!!"+ls_Mensaje,StopSign!)
			THIS.SetColumn('IdImpuesto3')
			//THIS.SelectText(1, Len(THIS.GetText()))
			THIS.SetFocus( )
			RETURN 0
		END IF
	END IF	
	IF NOT IsNull(ld_IdImpuesto4) Then
		IF ld_IdImpuesto2 = ld_IdImpuesto4 THEN
			MessageBox("Advertecia " + Gn_Config.Is_Work.Aplicacion  ,"Impuesto duplicado......!!!"+ls_Mensaje,StopSign!)
			THIS.SetColumn('IdImpuesto4')
			//THIS.SelectText(1, Len(THIS.GetText()))
			THIS.SetFocus( )
			RETURN 0
		END IF
	END IF
END IF

IF li_Impuesto3Estado = 1 THEN
	IF NOT IsNull(ld_IdImpuesto2) Then
		IF ld_IdImpuesto3 = ld_IdImpuesto2 THEN
			MessageBox("Advertecia " + Gn_Config.Is_Work.Aplicacion  ,"Impuesto duplicado......!!!"+ls_Mensaje,StopSign!)
			THIS.SetColumn('IdImpuesto2')
			//THIS.SelectText(1, Len(THIS.GetText()))
			THIS.SetFocus( )
			RETURN 0
		END IF
	END IF
	IF NOT IsNull(ld_IdImpuesto) Then
		IF ld_IdImpuesto3 = ld_IdImpuesto THEN
			MessageBox("Advertecia " + Gn_Config.Is_Work.Aplicacion  ,"Impuesto duplicado......!!!"+ls_Mensaje,StopSign!)
			THIS.SetColumn('IdImpuesto')
			//THIS.SelectText(1, Len(THIS.GetText()))
			THIS.SetFocus( )
			RETURN 0
		END IF
	END IF	
	IF NOT IsNull(ld_IdImpuesto4) Then
		IF ld_IdImpuesto3 = ld_IdImpuesto4 THEN
			MessageBox("Advertecia " + Gn_Config.Is_Work.Aplicacion  ,"Impuesto duplicado......!!!"+ls_Mensaje,StopSign!)
			THIS.SetColumn('IdImpuesto4')
			//THIS.SelectText(1, Len(THIS.GetText()))
			THIS.SetFocus( )
			RETURN 0
		END IF
	END IF
END IF



IF li_Impuesto4Estado = 1 THEN
	IF NOT IsNull(ld_IdImpuesto2) Then
		IF ld_IdImpuesto4 = ld_IdImpuesto2 THEN
			MessageBox("Advertecia " + Gn_Config.Is_Work.Aplicacion  ,"Impuesto duplicado......!!!"+ls_Mensaje,StopSign!)
			THIS.SetColumn('IdImpuesto2')
			//THIS.SelectText(1, Len(THIS.GetText()))
			THIS.SetFocus( )
			RETURN 0
		END IF
	END IF
	IF NOT IsNull(ld_IdImpuesto3) Then
		IF ld_IdImpuesto4 = ld_IdImpuesto3 THEN
			MessageBox("Advertecia " + Gn_Config.Is_Work.Aplicacion  ,"Impuesto duplicado......!!!"+ls_Mensaje,StopSign!)
			THIS.SetColumn('IdImpuesto3')
			//THIS.SelectText(1, Len(THIS.GetText()))
			THIS.SetFocus( )
			RETURN 0
		END IF
	END IF	
	IF NOT IsNull(ld_IdImpuesto) Then
		IF ld_IdImpuesto4 = ld_IdImpuesto THEN
			MessageBox("Advertecia " + Gn_Config.Is_Work.Aplicacion  ,"Impuesto duplicado......!!!"+ls_Mensaje,StopSign!)
			THIS.SetColumn('IdImpuesto')
			//THIS.SelectText(1, Len(THIS.GetText()))
			THIS.SetFocus( )
			RETURN 0
		END IF
	END IF
END IF


RETURN 1



end event

event dw_manto::ue_refresh;call super::ue_refresh;String ls_Fecha
ls_Fecha = String(DateTime(gn_config.is_work.FechaTrabajo,Time(0,0,0)) , "DD/MM/YYYY HH:MM:SS")
If idw_activa.Retrieve(gn_config.is_work.idempresa, id_Codigo , ls_Fecha ) > 0 Then
	dw_fraccion.Retrieve(id_Codigo)	
End If
end event

event dw_manto::constructor;call super::constructor;of_setregistrarcalendario(True)
of_setcampocalendario("ofertaini") 
of_setcampocalendario("ofertafin")

String ls_Fecha
ls_Fecha = String(DateTime(gn_config.is_work.FechaTrabajo,Time(0,0,0)) , "DD/MM/YYYY HH:MM:SS")

IF idw_activa.GetChild('idLinea', idwc_Linea) = -1 THEN MessageBox(  "Error", "Linea Not a DataWindowChild")
idwc_Linea.SetTransObject(SQLCA)
idwc_Linea.Retrieve(gn_config.is_work.idempresa)


IF idw_activa.GetChild('idTalla', idwc_Talla) = -1 THEN MessageBox(  "Error", "Talla Not a DataWindowChild")
idwc_Talla.SetTransObject(SQLCA)
idwc_Talla.Retrieve(gn_config.is_work.idempresa)


IF idw_activa.GetChild('idMarca', idwc_Marca) = -1 THEN MessageBox(  "Error", "Marca Not a DataWindowChild")
idwc_Marca.SetTransObject(SQLCA)
idwc_Marca.Retrieve(gn_config.is_work.idempresa)


IF idw_activa.GetChild('idColor', idwc_Color) = -1 THEN MessageBox(  "Error", "Color Not a DataWindowChild")
idwc_Color.SetTransObject(SQLCA)
idwc_Color.Retrieve(gn_config.is_work.idempresa)


IF idw_activa.GetChild('idEstadoMensualOperacion', idwc_EstadoMensualOperacion) = -1 THEN MessageBox(  "Error", "EstadoMensualOperacion Not a DataWindowChild")
idwc_EstadoMensualOperacion.SetTransObject(SQLCA)
idwc_EstadoMensualOperacion.Retrieve(gn_config.is_work.idempresa)


IF idw_activa.GetChild('Mes', idwc_Mes) = -1 THEN MessageBox(  "Error", "Mes Not a DataWindowChild")
idwc_Mes.SetTransObject(SQLCA)
idwc_Mes.Retrieve("Mes")

IF idw_activa.GetChild('IdImpuesto', idwc_Impuesto) = -1 THEN MessageBox(  "Error", "Mes Not a DataWindowChild")
idwc_Impuesto.SetTransObject(SQLCA)
idwc_Impuesto.Retrieve(ls_Fecha)

IF idw_activa.GetChild('IdImpuesto2', idwc_Impuesto) = -1 THEN MessageBox(  "Error", "Mes Not a DataWindowChild")
idwc_Impuesto.SetTransObject(SQLCA)
idwc_Impuesto.Retrieve(ls_Fecha)

IF idw_activa.GetChild('IdImpuesto3', idwc_Impuesto) = -1 THEN MessageBox(  "Error", "Mes Not a DataWindowChild")
idwc_Impuesto.SetTransObject(SQLCA)
idwc_Impuesto.Retrieve(ls_Fecha)

IF idw_activa.GetChild('IdImpuesto4', idwc_Impuesto) = -1 THEN MessageBox(  "Error", "Mes Not a DataWindowChild")
idwc_Impuesto.SetTransObject(SQLCA)
idwc_Impuesto.Retrieve(ls_Fecha)

dw_fraccion.Settransobject( SQLCA)










end event

event dw_manto::itemchanged;call super::itemchanged;dwItemStatus	le_status

String ls_Data 
Decimal {0} ld_nulo
THIS.Accepttext( )
le_status = THIS.GetItemStatus (THIS.GetRow(), 0, primary!)

ls_Data = String(data)
SetNull(ld_nulo)
CHOOSE CASE dwo.name
CASE 'tipoproducto'
	
	CHOOSE CASE ls_Data
	CASE 'B'	
		IF ( le_status =new! or le_status = newmodIFied!) THEN
			idw_activa.Object.IdUnidad[idw_activa.GetRow()] = 1		
			idw_activa.Object.IdUnidadMinima[idw_activa.GetRow()] = 1		
			idw_activa.Object.Fraccion[idw_activa.GetRow()] = 0		
			idw_activa.Object.Fracciones[idw_activa.GetRow()] = 1		
					
		END IF
			
	CASE 'S'	
		IF ( le_status =new! or le_status = newmodIFied!) THEN
			idw_activa.Object.IdLinea[idw_activa.GetRow()] = 0		
			idw_activa.Object.IdTalla[idw_activa.GetRow()] = 0		
			idw_activa.Object.IdMarca[idw_activa.GetRow()] = 0		
			idw_activa.Object.IdColor[idw_activa.GetRow()] = 0	
			
			idw_activa.Object.IdUnidad[idw_activa.GetRow()] = 0		
			idw_activa.Object.IdUnidadMinima[idw_activa.GetRow()] = 0		
			idw_activa.Object.Fraccion[idw_activa.GetRow()] = 0		
			idw_activa.Object.Fracciones[idw_activa.GetRow()] = 1		
			
			idw_activa.Object.StockMin[idw_activa.GetRow()] = 0		
			idw_activa.Object.StockMax[idw_activa.GetRow()] = 0		
			idw_activa.Object.StockPed[idw_activa.GetRow()] = 0	
			idw_activa.Object.StockMinUnidad[idw_activa.GetRow()] = 0		
			idw_activa.Object.StockMaxUnidad[idw_activa.GetRow()] = 0		
			idw_activa.Object.StockPedUnidad[idw_activa.GetRow()] = 0	
			
			idw_activa.Object.ExoneradoImp[idw_activa.GetRow()] = 0		
			idw_activa.Object.Reintegrable[idw_activa.GetRow()] = 0		
			idw_activa.Object.Paquete[idw_activa.GetRow()] = 0	
			idw_activa.Object.Pesable[idw_activa.GetRow()] = 0		
			idw_activa.Object.Vencimiento[idw_activa.GetRow()] = 0		
			idw_activa.Object.Serie[idw_activa.GetRow()] = 0	
			idw_activa.Object.Lote[idw_activa.GetRow()] = 0					
		END IF
	END CHOOSE		
CASE 'idunidad'
		IF idw_activa.Object.Fraccion[idw_activa.GetRow()]  = 0 THEN
				idw_activa.Object.IdUnidadMinima[idw_activa.GetRow()] = idw_activa.Object.IdUnidad[idw_activa.GetRow()] 
				idw_activa.Object.Fracciones[idw_activa.GetRow()]  = 1
		END IF
CASE  'fraccion'
		IF Integer(data)  = 0 THEN
				idw_activa.Object.IdUnidadMinima[idw_activa.GetRow()] = idw_activa.Object.IdUnidad[idw_activa.GetRow()] 
				idw_activa.Object.Fracciones[idw_activa.GetRow()]  = 1
		END IF		
CASE  'descuentoestado','iddescuento','descuento2estado','iddescuento2','descuento3estado','iddescuento3','descuento4estado','iddescuento4','impuestoestado','impuesto2estado','impuesto3estado','impuesto4estado'
		IF Integer(data)  = 0 THEN
			CHOOSE CASE  dwo.name
			CASE	 'impuestoestado'
				idw_activa.Object.idimpuesto[idw_activa.GetRow()] =  ld_nulo
			CASE	'impuesto2estado'
				idw_activa.Object.idimpuesto2[idw_activa.GetRow()]  = ld_nulo
			CASE	'impuesto3estado'
				idw_activa.Object.idimpuesto3[idw_activa.GetRow()] = ld_nulo
			CASE	'impuesto4estado'
				idw_activa.Object.idimpuesto4[idw_activa.GetRow()] = ld_nulo			
			END CHOOSE
		END IF	

//	CASE  'idimpuesto','idimpuesto2','idimpuesto3','idimpuesto4'
//		Integer li_variableporproducto
//		Long Ll_Fila	
//		idwc_Impuesto.accepttext( )
//		Ll_Fila = idwc_Impuesto.Find( " IdImpuesto = "+String(data)+" ",1,idwc_Impuesto.RowCount())
//		li_variableporproducto = idwc_Impuesto.getitemnumber(Ll_Fila ,'variableporproducto')
//		Messagebox("",String(li_variableporproducto))			
//		IF li_variableporproducto = 1 THEN
//			CHOOSE CASE  dwo.name
//				CASE	 'idimpuesto'
//					idw_activa.Object.ImpuestoPorcentaje.Protect='0'
//					idw_activa.SetColumn('ImpuestoPorcentaje')
//					idw_activa.SetFocus( )
//				CASE	'idimpuesto2'
//					idw_activa.Object.Impuesto2Porcentaje.Protect='0'
//					idw_activa.SetColumn('Impuesto2Porcentaje')
//					idw_activa.SetFocus( )					
//				CASE	'idimpuesto3'
//					idw_activa.Object.Impuesto3Porcentaje.Protect='0'
//					idw_activa.SetColumn('Impuesto3Porcentaje')
//					idw_activa.SetFocus( )					
//				CASE	'idimpuesto4'
//					idw_activa.Object.Impuesto4Porcentaje.Protect='0'	
//					idw_activa.SetColumn('Impuesto4Porcentaje')
//					idw_activa.SetFocus( )					
//			END CHOOSE
//		ELSE
//			CHOOSE CASE  dwo.name
//				CASE	 'idimpuesto'
//					idw_activa.Object.ImpuestoPorcentaje.Protect='1'
//				CASE	'idimpuesto2'
//					idw_activa.Object.Impuesto2Porcentaje.Protect='1'
//				CASE	'idimpuesto3'
//					idw_activa.Object.Impuesto3Porcentaje.Protect='1'
//				CASE	'idimpuesto4'
//					idw_activa.Object.Impuesto4Porcentaje.Protect='1'			
//			END CHOOSE			
//		END IF
		
END CHOOSE

end event

event dw_manto::editchanged;call super::editchanged;DwItemStatus	le_status
String ls_Campo ,ls_Data
Int li_Fraccion
Long ll_Fracciones
Decimal &
ld_StockMin, &          
ld_StockMax, &                 
ld_StockMaxUnidad, &     
ld_StockMinUnidad


ls_Campo = String(dwo.name)
ls_Data 	= String(data)
CHOOSE CASE ls_Campo
	CASE 'stockmin','stockmax','stockmaxunidad','stockminunidad','fracciones'
	IF IsNumber(String(data)) THEN THIS.Accepttext( )
	li_Fraccion = THIS.Object.Fraccion[THIS.GetRow()]     
	ll_Fracciones = THIS.Object.Fracciones[THIS.GetRow()]     
	ld_StockMin	= THIS.Object.StockMin[THIS.GetRow()]     
	ld_StockMax 	= THIS.Object.StockMax[THIS.GetRow()]           
	ld_StockMaxUnidad = THIS.Object.StockMaxUnidad[THIS.GetRow()]    
	ld_StockMinUnidad = THIS.Object.StockMinUnidad[THIS.GetRow()]		

	IF li_Fraccion = 1 THEN
		IF ll_Fracciones < 1  THEN
			Messagebox("Advertencia","Fracciones debe ser mayor que 1", Exclamation!)
			RETURN
		Else 
			CHOOSE CASE ls_Campo
				CASE 'fracciones'
					THIS.Object.StockMinUnidad[THIS.GetRow()]   = ll_Fracciones * ld_StockMin
					THIS.Object.StockMaxUnidad[THIS.GetRow()]   = ll_Fracciones * ld_StockMax
				CASE 'stockmin'
					THIS.Object.StockMinUnidad[THIS.GetRow()]   = ll_Fracciones * ld_StockMin
				CASE 'stockmax'
					THIS.Object.StockMaxUnidad[THIS.GetRow()]   = ll_Fracciones * ld_StockMax		
				CASE 'stockminunidad'
					THIS.Object.StockMin[THIS.GetRow()]  =  ld_StockMinUnidad / ll_Fracciones
				CASE 'stockmaxunidad'
					THIS.Object.StockMax[THIS.GetRow()]    = ld_StockMaxUnidad / ll_Fracciones
			END CHOOSE
		END IF
	Else
		THIS.Object.StockPedUnidad[THIS.GetRow()]	= ld_StockMin
		THIS.Object.StockMaxUnidad[THIS.GetRow()]  	= ld_StockMax
	END IF
	

END CHOOSE

end event

event dw_manto::ue_saveafter;call super::ue_saveafter;id_Codigo=THIS.object.IdProducto [THIS.getrow()]	
wf_fracciones( iIS_status )

RETURN 1
end event

event dw_manto::ue_getid;call super::ue_getid;	id_Codigo=this.object.IdProducto [this.getrow()]	
end event

type pb_borrar from w_manto`pb_borrar within tp_manto
end type

type pb_abrir from w_manto`pb_abrir within tp_manto
end type

type ole_1 from w_manto`ole_1 within tp_manto
integer x = 2149
integer y = 308
end type

type tp_lista from w_manto`tp_lista within tab_todo
integer width = 3730
integer height = 2436
string text = "Lista de Productos"
end type

type dw_lista from w_manto`dw_lista within tp_lista
integer y = 324
integer width = 3721
integer height = 1736
string dataobject = "d_producto_lista"
end type

event dw_lista::ue_refresh;call super::ue_refresh;//idw_lista.Retrieve()
idw_lista.retrieve(gn_config.is_work.idempresa)
end event

event dw_lista::ue_getid;call super::ue_getid;	id_Codigo=this.object.IdProducto [this.getrow()]	
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

type shl_cerrar from w_manto`shl_cerrar within w_manto_producto
integer x = 3099
integer y = 2404
end type

type shl_grabar from w_manto`shl_grabar within w_manto_producto
integer x = 1015
integer y = 2404
end type

type shl_eliminar from w_manto`shl_eliminar within w_manto_producto
integer x = 704
integer y = 2404
end type

type shl_modificar from w_manto`shl_modificar within w_manto_producto
integer x = 393
integer y = 2404
end type

type shl_nuevo from w_manto`shl_nuevo within w_manto_producto
integer x = 82
integer y = 2404
end type

type uo_nav from w_manto`uo_nav within w_manto_producto
integer x = 1632
integer y = 2256
end type

type pb_cancelar from w_manto`pb_cancelar within w_manto_producto
integer x = 1394
integer y = 2252
integer width = 183
integer height = 160
end type

type pb_grabar from w_manto`pb_grabar within w_manto_producto
integer x = 1083
integer y = 2252
integer width = 183
integer height = 160
end type

type pb_eliminar from w_manto`pb_eliminar within w_manto_producto
integer x = 773
integer y = 2252
integer width = 183
integer height = 160
end type

type pb_nuevo from w_manto`pb_nuevo within w_manto_producto
integer x = 151
integer y = 2252
integer width = 183
integer height = 160
end type

type pb_cerrar from w_manto`pb_cerrar within w_manto_producto
integer x = 3168
integer y = 2252
integer width = 183
integer height = 160
end type

type shl_cancelar from w_manto`shl_cancelar within w_manto_producto
integer x = 1326
integer y = 2404
end type

type pb_modificar from w_manto`pb_modificar within w_manto_producto
integer x = 462
integer y = 2252
integer width = 183
integer height = 160
end type

type pb_ventana_y_libreria from w_manto`pb_ventana_y_libreria within w_manto_producto
end type

type dw_fraccion from datawindow within w_manto_producto
boolean visible = false
integer x = 46
integer y = 1268
integer width = 3730
integer height = 1012
integer taborder = 60
boolean bringtotop = true
string dataobject = "d_fraccion_lista"
borderstyle borderstyle = stylelowered!
end type

