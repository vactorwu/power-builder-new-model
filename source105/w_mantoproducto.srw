HA$PBExportHeader$w_mantoproducto.srw
forward
global type w_mantoproducto from w_manto
end type
type dw_fraciones from u_dw within w_mantoproducto
end type
end forward

global type w_mantoproducto from w_manto
integer width = 3854
integer height = 2088
long deact = 35649656
dw_fraciones dw_fraciones
end type
global w_mantoproducto w_mantoproducto

type variables
String is_guid 
Int li_contfrac
dwItemStatus il_status,iis_Status_unidadmedida,iis_Status_unidadmin, iis_Status_fraccion, iis_Status_fracciones
String is_Actual_unidadmedida,is_Original_unidadmedida, is_Actual_unidadmin,is_Original_unidadmin
Int ii_Actual_fraccion, ii_Original_fraccion, ii_Actual_fracciones, ii_Original_fracciones
end variables

forward prototypes
public subroutine wf_primarykey ()
public subroutine wf_datos ()
public subroutine wf_dwchild ()
public subroutine wf_fracciones (dwitemstatus as_status)
end prototypes

public subroutine wf_primarykey ();LONG LL_CODIGO,ll_maxlen
String ls_codigo,ls_aux,ls_pk
//***************************************************************************************************************************************************************************************
// Genero el primary key.
//***************************************************************************************************************************************************************************************
  SELECT Max(producto.codproducto)   INTO :ls_codigo   FROM producto   WHERE producto.idempresa = :gn_config.is_config.empresa Using   SQLCA  ;


ll_maxlen = 8

If IsNull(ls_codigo) or ls_codigo="" then
	ls_codigo = Mid('0000000000',1,ll_maxlen)
End If

ls_aux = Mid('0000000000',1,ll_maxlen)
ls_pk = String(Long(ls_codigo) + 1)
ls_codigo = Mid(ls_aux,1,ll_maxlen - len(ls_pk)) + ls_pk

idw_activa.setitem( idw_activa.getrow() ,'codigo', LS_CODIGO  )
idw_activa.setitem( idw_activa.getrow() ,'idproducto', is_guid )

idw_activa.setitem( idw_activa.getrow() ,'codbar', uf_bar_to_ean13(LS_CODIGO))




end subroutine

public subroutine wf_datos ();dwItemStatus l_status
String ls_fecha,ls_hora
DateTime ldt_FechaSys
l_status = idw_activa.GetItemStatus( idw_activa.getrow() , 0, Primary!)

ldt_FechaSys = gn_config.of_datetime()

choose case l_status
	case New!, NewModified!
			idw_activa.setitem(idw_activa.getrow(),'idempresa',gn_config.is_config.empresa)
			idw_activa.setitem(idw_activa.getrow(),'fecharegistro',ldt_FechaSys)
			idw_activa.setitem(idw_activa.getrow(),'ultimamodificacion',ldt_FechaSys)
			idw_activa.setitem(idw_activa.getrow(),'usuario',gn_config.of_user())
			idw_activa.setitem(idw_activa.getrow(),'terminal',gn_config.of_terminal())
	case DataModified!
			idw_activa.setitem(idw_activa.getrow(),'ultimamodificacion',ldt_FechaSys)
			idw_activa.setitem(idw_activa.getrow(),'usuario',gn_config.of_user())
			idw_activa.setitem(idw_activa.getrow(),'terminal',gn_config.of_terminal())
end choose


end subroutine

public subroutine wf_dwchild ();DatawindowChild ldwch_Hija
String ls_codigo
IF idw_activa.getchild( 'idlinea',ldwch_Hija)  = -1 THEN MessageBox(   "Error", "Not a DataWindowChild")
ldwch_Hija.SetTransObject(SQLCA)
ldwch_Hija.Retrieve(gn_config.is_config.empresa )

IF idw_activa.getchild( 'idmarca',ldwch_Hija)  = -1 THEN MessageBox(   "Error", "Not a DataWindowChild")
ldwch_Hija.SetTransObject(SQLCA)
ldwch_Hija.Retrieve(gn_config.is_config.empresa )

IF idw_activa.getchild( 'unidadmedida',ldwch_Hija)  = -1 THEN MessageBox(   "Error", "Not a DataWindowChild")
ldwch_Hija.SetTransObject(SQLCA)
ldwch_Hija.Retrieve(gn_config.is_config.empresa )

IF idw_activa.getchild( 'unidadmin',ldwch_Hija)  = -1 THEN MessageBox(   "Error", "Not a DataWindowChild")
ldwch_Hija.SetTransObject(SQLCA)
ldwch_Hija.Retrieve(gn_config.is_config.empresa )

If idw_lista.rowcount( ) > 0 Then
	ls_Codigo=idw_lista.getitemString(idw_lista.getrow(),1)
	If li_contfrac <= 0 then dw_fraciones.settransobject( SQLCA )
	dw_fraciones .retrieve(gn_config.is_config.empresa ,ls_Codigo)
End If




end subroutine

public subroutine wf_fracciones (dwitemstatus as_status);
DatawindowChild ldwch_Hija

String ls_fecha,ls_hora
DateTime ldt_FechaSys
String ls_Unidad,ls_UnidadMin
Int li_fracciones,li_fraccion
Long ll_oldrow,ll_newrow,ll_filafraccionuni, ll_filafraccionmin
// Insertar Las Fracciones 
ldt_FechaSys = gn_config.of_datetime()

li_fraccion							= idw_activa.object.fraccion[idw_activa.getrow()]
li_fracciones							= idw_activa.object.fracciones[idw_activa.getrow()]
ls_Unidad							= idw_activa.object.unidadmedida[idw_activa.getrow()]
ls_UnidadMin						= idw_activa.object.unidadmin[idw_activa.getrow()]

choose case as_status	
	case new!,newmodified!
		Messagebox("","NEW")
		dw_fraciones.reset()
		ll_oldrow = ll_newrow
		ll_newrow = dw_fraciones.insertrow(0)
		dw_fraciones.scrolltorow(ll_newrow)
		
		// Datos Comunes
		dw_fraciones.setitem(ll_newrow,'fecharegistro',ldt_FechaSys)
		dw_fraciones.setitem(ll_newrow,'ultimamodificacion',ldt_FechaSys)
		dw_fraciones.setitem(ll_newrow,'usuario',gn_config.of_user())
		dw_fraciones.setitem(ll_newrow,'terminal',gn_config.of_terminal())
		
		//Datos de Fraccion
		dw_fraciones.object.idempresa[ll_newrow] 				= gn_config.is_config.empresa
 	     dw_fraciones.object.idproducto[ll_newrow] 				= is_guid
          dw_fraciones.object.codigo[ll_newrow] 						= ls_Unidad
			 
		IF idw_activa.getchild( 'unidadmedida',ldwch_Hija)  = -1 THEN MessageBox(   "Error", "Not a DataWindowChild")			 
          dw_fraciones.object.descripcion[ll_newrow] 				=  ldwch_Hija.getitemstring(ldwch_Hija.getrow(),'descripcion')
          dw_fraciones.object.cantidad[ll_newrow] 					= li_fracciones
          dw_fraciones.object.preciocosto[ll_newrow] 				= idw_activa.object.preciocosto[idw_activa.getrow()]
          dw_fraciones.object.precioventaporc[ll_newrow] 			= idw_activa.object.utilidadporcentaje[idw_activa.getrow()]
          dw_fraciones.object.precioventa[ll_newrow] 				= idw_activa.object.utilidad[idw_activa.getrow()]
          dw_fraciones.object.descuentoventaporc[ll_newrow] 	= idw_activa.object.descuentoventaporcentaje[idw_activa.getrow()]
          dw_fraciones.object.descuentoventa[ll_newrow]			= idw_activa.object.descuentoventa[idw_activa.getrow()]
          dw_fraciones.object.precioxmenor[ll_newrow] 			= idw_activa.object.precioventapublico[idw_activa.getrow()]
          dw_fraciones.object.deorigen[ll_newrow]					= 1

		If li_fraccion = 1 Then
			ll_oldrow = ll_newrow
			ll_newrow = dw_fraciones.insertrow(0)
			dw_fraciones.scrolltorow(ll_newrow)
			// Datos Comunes
			dw_fraciones.setitem(ll_newrow,'fecharegistro',ldt_FechaSys)
			dw_fraciones.setitem(ll_newrow,'ultimamodificacion',ldt_FechaSys)
			dw_fraciones.setitem(ll_newrow,'usuario',gn_config.of_user())
			dw_fraciones.setitem(ll_newrow,'terminal',gn_config.of_terminal())
			//Datos de Fraccion Minima 
			dw_fraciones.object.idempresa[ll_newrow] 				= gn_config.is_config.empresa
			dw_fraciones.object.idproducto[ll_newrow] 				= is_guid
			dw_fraciones.object.codigo[ll_newrow] 						= ls_UnidadMin
				 
			IF idw_activa.getchild( 'unidadmin',ldwch_Hija)  = -1 THEN MessageBox(   "Error", "Not a DataWindowChild")			 
			 dw_fraciones.object.descripcion[ll_newrow] 				=  ldwch_Hija.getitemstring(ldwch_Hija.getrow(),'descripcion')
			 dw_fraciones.object.cantidad[ll_newrow] 					= 1
			 dw_fraciones.object.preciocosto[ll_newrow] 				= idw_activa.object.preciocosto[idw_activa.getrow()] / li_fracciones
			 dw_fraciones.object.precioventaporc[ll_newrow] 		= idw_activa.object.utilidadporcentaje[idw_activa.getrow()]
			 dw_fraciones.object.precioventa[ll_newrow] 				= idw_activa.object.utilidad[idw_activa.getrow()] / li_fracciones
			 dw_fraciones.object.descuentoventaporc[ll_newrow] 	= idw_activa.object.descuentoventaporcentaje[idw_activa.getrow()]
			 dw_fraciones.object.descuentoventa[ll_newrow]			= idw_activa.object.descuentoventa[idw_activa.getrow()] / li_fracciones
			 dw_fraciones.object.precioxmenor[ll_newrow] 			= idw_activa.object.precioventapublico[idw_activa.getrow()] / li_fracciones
			 dw_fraciones.object.deorigen[ll_newrow]					= 1
		End If
		
case	datamodified!
		//  Si unidad ha sido modificada
		if iis_Status_unidadmedida = datamodified! Then
			If is_Original_unidadmedida <> is_Actual_unidadmedida Then
				ll_filafraccionuni = dw_fraciones.find( " codigo = '"+is_Original_unidadmedida+"'",1,dw_fraciones.rowcount())
				dw_fraciones.ScrollToRow(ll_filafraccionuni)
				dw_fraciones.object.codigo[ll_filafraccionuni] 			= is_Actual_unidadmedida	
				
				IF idw_activa.getchild( 'unidadmedida',ldwch_Hija)= -1 THEN MessageBox(   "Error", "Not a DataWindowChild")			 
				dw_fraciones.object.descripcion[ll_filafraccionuni] 	=  ldwch_Hija.getitemstring(ldwch_Hija.getrow(),'descripcion')
			End If
		End If
		
		// Si Fraccion ha sido modificada
		If iis_Status_fraccion	 = datamodified! Then
			If ii_Original_fraccion <> ii_Actual_fraccion Then // y los valores son diferentes
				If ii_Actual_fraccion = 0 Then //Si el estado Actual en no Fraccionado
					// Eliminar las Fraciones si el valor original es diferente de Nulo y Poner Unidad con fracciones  = 1
					If Not IsNull(is_Original_unidadmin) Then 
						//Unidad
						ll_filafraccionuni = dw_fraciones.find( " codigo = '"+is_Original_unidadmedida+"'",1,dw_fraciones.rowcount())
						dw_fraciones.ScrollToRow(ll_filafraccionuni)
						dw_fraciones.object.cantidad[ll_filafraccionuni] 		= 1
						//Unidad Minima
						ll_filafraccionmin = dw_fraciones.find( " codigo = '"+is_Original_unidadmin+"'",1,dw_fraciones.rowcount())
						dw_fraciones.ScrollToRow(ll_filafraccionmin)
						dw_fraciones.deleterow(ll_filafraccionmin )
					End If
				Else // si el estado Actual es Fraccionado
					// Actualizar fraciones en Unidad
					ll_filafraccionuni = dw_fraciones.find( " codigo = '"+is_Original_unidadmedida+"'",1,dw_fraciones.rowcount())
					dw_fraciones.ScrollToRow(ll_filafraccionuni)
					dw_fraciones.object.cantidad[ll_filafraccionuni] 		= ii_Actual_fracciones
					// Insertar la Fraccion con el nuevo Valor
					ll_oldrow = ll_newrow
					ll_newrow = dw_fraciones.insertrow(0)
					dw_fraciones.scrolltorow(ll_newrow)
					// Datos Comunes
					dw_fraciones.setitem(ll_newrow,'fecharegistro',ldt_FechaSys)
					dw_fraciones.setitem(ll_newrow,'ultimamodificacion',ldt_FechaSys)
					dw_fraciones.setitem(ll_newrow,'usuario',gn_config.of_user())
					dw_fraciones.setitem(ll_newrow,'terminal',gn_config.of_terminal())
					//Datos de Fraccion Minima 
					dw_fraciones.object.idempresa[ll_newrow] 				= gn_config.is_config.empresa
					dw_fraciones.object.idproducto[ll_newrow] 				= idw_activa.object.idproducto[idw_activa.getrow()]
					dw_fraciones.object.codigo[ll_newrow] 						= ls_UnidadMin
						 
					IF idw_activa.getchild( 'unidadmin',ldwch_Hija)  = -1 THEN MessageBox(   "Error", "Not a DataWindowChild")			 
					dw_fraciones.object.descripcion[ll_newrow] 				=  ldwch_Hija.getitemstring(ldwch_Hija.getrow(),'descripcion')
					dw_fraciones.object.cantidad[ll_newrow] 					= 1
					dw_fraciones.object.preciocosto[ll_newrow] 				= idw_activa.object.preciocosto[idw_activa.getrow()] / li_fracciones
					dw_fraciones.object.precioventaporc[ll_newrow] 		= idw_activa.object.utilidadporcentaje[idw_activa.getrow()]
					dw_fraciones.object.precioventa[ll_newrow] 				= idw_activa.object.utilidad[idw_activa.getrow()] / li_fracciones
					dw_fraciones.object.descuentoventaporc[ll_newrow] 	= idw_activa.object.descuentoventaporcentaje[idw_activa.getrow()]
					dw_fraciones.object.descuentoventa[ll_newrow]			= idw_activa.object.descuentoventa[idw_activa.getrow()] / li_fracciones
					dw_fraciones.object.precioxmenor[ll_newrow] 			= idw_activa.object.precioventapublico[idw_activa.getrow()] / li_fracciones
					dw_fraciones.object.deorigen[ll_newrow]					= 1
				End If				
			End If
		End If
		
		// Si Unidad Minima ha sido Modificada
		If iis_Status_unidadmin = datamodified! Then
			If ii_Actual_fraccion = ii_Original_Fraccion Then // si el valor original  de Fracion es igual al valor actual de Fracion
				If ii_Actual_fraccion = 1 Then  // y si el valor actual esta activo = 1
					ll_filafraccionmin = dw_fraciones.find( " codigo = '"+is_Original_unidadmin+"'",1,dw_fraciones.rowcount())
					dw_fraciones.ScrollToRow(ll_filafraccionmin)
					dw_fraciones.object.codigo[ll_filafraccionmin] 		= is_Actual_unidadmin			
					IF idw_activa.getchild( 'unidadmin',ldwch_Hija)	= -1 THEN MessageBox(   "Error", "Not a DataWindowChild")			 
					dw_fraciones.object.descripcion[ll_filafraccionmin] 	=  ldwch_Hija.getitemstring(ldwch_Hija.getrow(),'descripcion')
				End If
			End If
		End If
		
		// Si Cantidad de Fracciones ha Sido Modificada
		If iis_Status_fracciones = datamodified! Then
			If ii_Actual_fraccion = ii_Original_Fraccion Then
				If ii_Actual_fraccion = 1 Then 
					If ii_Original_fracciones<>ii_Actual_fracciones Then
						ll_filafraccionuni = dw_fraciones.find( " codigo = '"+is_Original_unidadmedida+"'",1,dw_fraciones.rowcount())
						dw_fraciones.ScrollToRow(ll_filafraccionuni)
						dw_fraciones.object.cantidad[ll_filafraccionuni] 		= ii_Actual_fracciones
					End If
				End If
			End If
		End If
	
		
					
End Choose
dw_fraciones.accepttext( )
dw_fraciones.update( )
commit using SQLCA;

end subroutine

on w_mantoproducto.create
int iCurrent
call super::create
this.dw_fraciones=create dw_fraciones
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_fraciones
end on

on w_mantoproducto.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_fraciones)
end on

event open;call super::open; is_campofinal = 'estado'
end event

type gb_comandos from w_manto`gb_comandos within w_mantoproducto
end type

type tab_todo from w_manto`tab_todo within w_mantoproducto
integer x = 9
integer width = 3707
end type

type tp_lista from w_manto`tp_lista within tab_todo
integer width = 3671
string text = "Lista de Productos"
end type

type dw_lista from w_manto`dw_lista within tp_lista
string dataobject = "d_producto_lista"
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
integer width = 3671
string text = "Datos de Producto"
end type

type dw_manto from w_manto`dw_manto within tp_manto
event ue_enter pbm_dwnprocessenter
integer y = 0
integer width = 3602
integer height = 1388
string dataobject = "d_producto_manto_bak"
boolean ib_sort = false
end type

event dw_manto::ue_saveprevious;call super::ue_saveprevious;dwItemStatus	le_status
DatawindowChild ldwch_Hija
String ls_Actual, ls_Original,ls_Codigo,ls_Unidad,ls_UnidadMin
Decimal ld_preciocosto,ld_utilidad, ld_precioventa,ld_descuentoventa,ld_precioventapublico
Int li_fraccion,li_fracciones
wf_datos()

this.accepttext( )

//validar si Fracciones esta activado
li_fraccion							= this.object.fraccion[this.getrow()]
li_fracciones							= this.object.fracciones[this.getrow()]
ls_Unidad							= this.object.unidadmedida[this.getrow()]
ls_UnidadMin						= this.object.unidadmin[this.getrow()]

If li_fraccion = 1 Then
	If ls_Unidad = ls_UnidadMin  Then
		messagebox("Advertecia " + Gn_Config.Is_Work.Aplicacion  ,"Unidad no puede ser igual que Fraccion......!!!",Exclamation!)
		this.setcolumn('unidadmedida')
		this.SelectText(1, Len(this.GetText()))
		this.setfocus( )
		Return 0
	End If
	If li_fracciones <=1 Then 
		messagebox("Advertecia " + Gn_Config.Is_Work.Aplicacion  ,"Fracciones tienen que ser Mayor que 1 ......!!!",Exclamation!)
		this.setcolumn('fracciones')
		this.SelectText(1, Len(this.GetText()))
		this.setfocus( )
		Return 0
	End If
Else
	If this.object.fracciones[this.getrow()] <> 1 and Not IsNull(this.object.unidadmin[this.getrow()]) Then
		this.object.fracciones[this.getrow()] = 1
		SetNull(ls_UnidadMin)
		this.object.unidadmin[this.getrow()] = ls_UnidadMin
	End If
End If


// Validar Precios
 ld_preciocosto						= this.object.preciocosto[this.getrow()]
 ld_utilidad 							= this.object.utilidad[this.getrow()]
 ld_precioventa 					= this.object.precioventa[this.getrow()]
 ld_descuentoventa 				= this.object.descuentoventa[this.getrow()]
 ld_precioventapublico 			= this.object.precioventapublico[this.getrow()]

If ld_utilidad < 0 Then
	messagebox("Advertecia " + Gn_Config.Is_Work.Aplicacion  ,"Utilidad no puede ser Negativa......!!!",Exclamation!)
	this.setcolumn('utilidad')
	this.SelectText(1, Len(this.GetText()))
	this.setfocus( )
	Return 0
End If
If ld_precioventa < ld_preciocosto Then
	messagebox("Advertecia " + Gn_Config.Is_Work.Aplicacion  ,"Precio de Venta no puede ser Menor que Precio de Costo......!!!",Exclamation!)
	this.setcolumn('precioventa')
	this.SelectText(1, Len(this.GetText()))
	this.setfocus( )
	Return 0
End If
If ld_descuentoventa < 0 Then
	messagebox("Advertecia " + Gn_Config.Is_Work.Aplicacion  ,"Descuento de Venta no puede ser Negativo......!!!",Exclamation!)
	this.setcolumn('descuentoventa')
	this.SelectText(1, Len(this.GetText()))
	this.setfocus( )
	Return 0
End If
If ld_precioventapublico < ld_preciocosto Then
	messagebox("Advertecia " + Gn_Config.Is_Work.Aplicacion  ,"Precio de Venta al Publico no puede ser Menor que Precio de Costo......!!!",Exclamation!)
	this.setcolumn('precioventapublico')
	this.SelectText(1, Len(this.GetText()))	
	this.setfocus( )
	Return 0
End If

//Validar Duplicacion de Nombres
le_status = this.GetItemStatus (this.GetRow(), 0, primary!)
// Igualo el il_statuspara pasarlo despues de grabar 
il_status = le_status

choose case le_status	
	case	datamodified!
		iis_Status_unidadmedida	= this.GetItemStatus (this.GetRow(), 'unidadmedida', primary!)
		iis_Status_unidadmin		= this.GetItemStatus (this.GetRow(), 'unidadmin', primary!)
		iis_Status_fraccion		= this.GetItemStatus (this.GetRow(), 'fraccion', primary!)
		iis_Status_fracciones		= this.GetItemStatus (this.GetRow(), 'fracciones', primary!)
		
		is_Actual_unidadmedida	= this.Object.unidadmedida.Primary.Current[this.GetRow()]
		is_Original_unidadmedida= this.Object.unidadmedida.Primary.Original[this.GetRow()]
		is_Actual_unidadmin		= this.Object.unidadmin.Primary.Current[this.GetRow()]
		is_Original_unidadmin		= this.Object.unidadmin.Primary.Original[this.GetRow()]
		ii_Actual_fraccion			= this.Object.fraccion.Primary.Current[this.GetRow()]
		ii_Original_fraccion		= this.Object.fraccion.Primary.Original[this.GetRow()]
		ii_Actual_fracciones		= this.Object.fracciones.Primary.Current[this.GetRow()]
		ii_Original_fracciones		= this.Object.fracciones.Primary.Original[this.GetRow()]	 
End Choose

ls_Actual = this.Object.descripcion.Primary.Current[this.GetRow()]
ls_Original = this.Object.descripcion.Primary.Original[this.GetRow()]

il_Fila = idw_lista.find( " descripcion = '"+ls_Actual+"'",1,idw_lista.rowcount())

choose case le_status	
	case new!,newmodified!
			If il_Fila > 0 then
				ls_Codigo = idw_lista.Object.codigo[il_Fila]
				this.setcolumn('descripcion')
				this.SelectText(1, Len(this.GetText()))
				this.setfocus( )
				messagebox("Advertecia " + Gn_Config.Is_Work.Aplicacion  ,"Descripci$$HEX1$$f300$$ENDHEX$$n  ya existe......!!!"+char(13)+"Fila : "+String(il_Fila)+"  C$$HEX1$$f300$$ENDHEX$$digo : "+ls_Codigo,Exclamation!)
				Return 0
			Else
				// Insertar Fraciones 
				//wf_fracciones()
				Messagebox("","")
				Return 1
			End If
		
	case	datamodified!
		If ls_Actual = ls_Original Then
			Return 1
		Else
			If il_Fila > 0 then
				ls_Codigo = idw_lista.Object.codigo[il_Fila]
				this.setcolumn('descripcion')
				this.SelectText(1, Len(this.GetText()))
				this.setfocus( )
				messagebox("Advertecia " + Gn_Config.Is_Work.Aplicacion  ,"Descripci$$HEX1$$f300$$ENDHEX$$n  ya existe......!!!"+char(13)+"Fila : "+String(il_Fila)+"  C$$HEX1$$f300$$ENDHEX$$digo : "+ls_Codigo,Exclamation!)
				Return 0
			Else
				Return 1
			End If
		End If
	case else 
		Return 1
end choose




end event

event dw_manto::ue_newprevious;call super::ue_newprevious;wf_dwchild( )
is_guid = uf_newid()
Return 1
end event

event dw_manto::editchanged;call super::editchanged;dwItemStatus	le_status
decimal  ld_fraccion, ld_fracciones,ld_preciocosto,ld_utilidad,ld_utilidadporcentaje,ld_precioventa,ld_precioventauni,ld_descuentoventa,ld_descuentoventaporcentaje,ld_precioventapublico,ld_precioventapublicouni	
string ls_codigo,  ls_descripcion, ls_codbar,ls_Actual,ls_Original

If dwo.name <> 'fechavencimiento' or dwo.name <>  'ofertaini' or dwo.name <> 'ofertafin' Then
	This.accepttext( )	
	Choose case dwo.name
		case 'utilidad','utilidadporcentaje','precioventa','precioventauni','descuentoventa','descuentoventaporcentaje','precioventapublico','precioventapublicouni'	
		 ld_fraccion							= this.object.fraccion[this.getrow()]
 		 ld_fracciones						= this.object.fracciones[this.getrow()]
		 ld_preciocosto						= this.object.preciocosto[this.getrow()]
		 ld_utilidad 							= this.object.utilidad[this.getrow()]
		 ld_utilidadporcentaje 			= this.object.utilidadporcentaje[this.getrow()]
		 ld_precioventa 					= this.object.precioventa[this.getrow()]
		 ld_precioventauni 				= this.object.precioventauni[this.getrow()]
		 ld_descuentoventa 				= this.object.descuentoventa[this.getrow()]
		 ld_descuentoventaporcentaje = this.object.descuentoventaporcentaje[this.getrow()]
		 ld_precioventapublico 			= this.object.precioventapublico[this.getrow()]
		 ld_precioventapublicouni		= this.object.precioventapublicouni[this.getrow()]
			If       dwo.name = 'utilidad' Then
				If ld_preciocosto = 0 then Return
				ld_utilidadporcentaje 				=  (ld_utilidad / ld_preciocosto) *100
				ld_precioventa						=   ld_utilidad + ld_preciocosto
				ld_precioventauni					=   ld_precioventa / ld_fracciones
				ld_descuentoventaporcentaje	=  (ld_descuentoventa / ld_precioventa) *100
				ld_precioventapublico				=   ld_precioventa - ld_descuentoventa
				ld_precioventapublicouni			=   ld_precioventapublico / ld_fracciones
		
			ElseIf dwo.name = 'utilidadporcentaje' Then
				If ld_preciocosto = 0 then Return		
				ld_utilidad			 				=  ( ld_preciocosto / 100) * ld_utilidadporcentaje
				ld_precioventa						=   ld_utilidad + ld_preciocosto
				ld_precioventauni					=   ld_precioventa / ld_fracciones
				ld_descuentoventaporcentaje	=  (ld_descuentoventa / ld_precioventa) *100
				ld_precioventapublico				=   ld_precioventa - ld_descuentoventa
				ld_precioventapublicouni			=   ld_precioventapublico / ld_fracciones
		
				
			ElseIf dwo.name = 'precioventa' Then

				ld_utilidad 							=  ld_precioventa - ld_preciocosto 
				ld_utilidadporcentaje 				=  (ld_utilidad / ld_preciocosto) *100
				ld_precioventauni					=   ld_precioventa / ld_fracciones
				ld_descuentoventaporcentaje	=  (ld_descuentoventa / ld_precioventa) *100
				ld_precioventapublico				=   ld_precioventa - ld_descuentoventa
				ld_precioventapublicouni			=   ld_precioventapublico / ld_fracciones
				
			ElseIf dwo.name = 'precioventauni' Then
			ElseIf dwo.name = 'descuentoventa' Then
			
				ld_descuentoventaporcentaje	=  (ld_descuentoventa / ld_precioventa) *100
				ld_precioventapublico				=   ld_precioventa - ld_descuentoventa
				ld_precioventapublicouni			=   ld_precioventapublico / ld_fracciones
				
			ElseIf dwo.name = 'descuentoventaporcentaje' Then
				ld_descuentoventa				=  ( ld_precioventa / 100 ) * ld_descuentoventaporcentaje
				ld_precioventapublico				=   ld_precioventa - ld_descuentoventa
				ld_precioventapublicouni			=   ld_precioventapublico / ld_fracciones
				
			ElseIf dwo.name = 'precioventapublico' Then
				ld_descuentoventa				=  ld_precioventa - ld_precioventapublico 
				ld_descuentoventaporcentaje	=  (ld_descuentoventa / ld_precioventa) *100
				ld_precioventapublicouni			=   ld_precioventapublico / ld_fracciones
				
			ElseIf dwo.name = 'precioventapublicouni' Then
			End If
			
			If dwo.name <> 'utilidad' 							Then		this.object.utilidad[this.getrow()] 							=	ld_utilidad
			If dwo.name <> 'utilidadporcentaje' 				Then		this.object.utilidadporcentaje[this.getrow()]	 		=	ld_utilidadporcentaje
			If dwo.name <> 'precioventa' 						Then		this.object.precioventa[this.getrow()]		 			=	ld_precioventa
			If dwo.name <> 'precioventauni' 					Then		this.object.precioventauni[this.getrow()]		 		=	ld_precioventauni
			If dwo.name <> 'descuentoventa' 				Then		this.object.descuentoventa[this.getrow()]		 		=	ld_descuentoventa
			If dwo.name <> 'descuentoventaporcentaje' 	Then		this.object.descuentoventaporcentaje[this.getrow()]=	ld_descuentoventaporcentaje
			If dwo.name <> 'precioventapublico' 			Then		this.object.precioventapublico[this.getrow()]		 	=	ld_precioventapublico
			If dwo.name <> 'precioventapublicouni' 			Then		this.object.precioventapublicouni[this.getrow()]		=	ld_precioventapublicouni
		
		this.accepttext( )	
		case 'codbar','codbar1','codbar2'
			this.accepttext( )	
			If len(data) = 12 Then
				le_status = this.GetItemStatus (row, 0, primary!)
				
				ls_Actual =this.GetItemString(row,String(dwo.name), Primary!, FALSE)
				ls_Original =this.GetItemString(row,String(dwo.name), Primary!, TRUE)
				
				If IsNull(ls_Actual) Then ls_Actual = ""
				If IsNull(ls_Original) Then ls_Original = ""
				
				ls_codbar = data
				
				SELECT producto.codproducto, producto.descripcion  INTO :ls_codigo,  :ls_descripcion  FROM producto  
				WHERE ( producto.idempresa = :gn_config.is_config.empresa ) AND  (producto.codbar = :ls_codbar OR 
							producto.codbar1 = :ls_codbar OR  producto.codbar2 = :ls_codbar)  Using SQLCA ;

				il_Fila = idw_lista.find( " codigo = '"+ls_codigo+"'",1,idw_lista.rowcount())
				
				choose case le_status	
					case new!,newmodified!
							If il_Fila > 0 then
								MessageBox("Advertencia "+Gn_Config.Is_Work.Aplicacion ,"C$$HEX1$$f300$$ENDHEX$$digo de Barras ya fue registrado por otro producto"+char(13)+"C$$HEX1$$f300$$ENDHEX$$digo   : "+ls_codigo+char(13)+"Descripci$$HEX1$$f300$$ENDHEX$$n : "+ls_descripcion+char(13)+"C$$HEX1$$f300$$ENDHEX$$digo de Barras no puede volver a ser registrado!!!......",Exclamation!)
								this.setitem( row, dwo.name,"")
							End If
					case	datamodified!
						If ls_Actual <> ls_Original Then
							If il_Fila > 0 then
								MessageBox("Advertencia "+Gn_Config.Is_Work.Aplicacion ,"C$$HEX1$$f300$$ENDHEX$$digo de Barras ya fue registrado por otro producto"+char(13)+"C$$HEX1$$f300$$ENDHEX$$digo   : "+ls_codigo+char(13)+"Descripci$$HEX1$$f300$$ENDHEX$$n : "+ls_descripcion+char(13)+"C$$HEX1$$f300$$ENDHEX$$digo de Barras no puede volver a ser registrado!!!......",Exclamation!)
								this.setitem( row, dwo.name,"")
							End If
						End If
				end choose
		
				this.accepttext( )	
			End If
		//case else
			/*statementblock*/
	End Choose
End If
end event

event dw_manto::ue_saveafter;call super::ue_saveafter;wf_fracciones( il_status )
end event

type pb_borrar from w_manto`pb_borrar within tp_manto
boolean visible = true
integer x = 1385
integer y = 1252
boolean originalsize = true
string picturename = "Custom094!"
end type

event pb_borrar::clicked;call super::clicked;String Codigo
	blob lb_object
	SETNULL(lb_object)
	Codigo=idw_activa.getitemString(idw_activa.getrow(),1)

	SQLCA.autocommit = TRUE
	
	  UPDATE producto   SET foto = :lb_object   WHERE ( producto.idempresa = :gn_config.is_config.empresa ) AND  
         ( producto.idproducto = :codigo )   using SQLCA;


	if SQLCA.SQLCode = -1 then
		MessageBox("SQL error",SQLCA.SQLErrText,Information!)
		return -1
	end if
	commit using SQLCA;
	SQLCA.autocommit = FALSE
	
	idw_lista.triggerevent( rowfocuschanged!)
end event

type pb_abrir from w_manto`pb_abrir within tp_manto
boolean visible = true
integer x = 731
integer y = 1252
boolean originalsize = true
end type

event pb_abrir::clicked;call super::clicked;if idw_activa.getitemstatus(idw_activa.getrow(),0,primary!) = newmodified! or idw_activa.getitemstatus(idw_activa.getrow(),0,primary!) = New! then
	if  messagebox("Advertecia " + Gn_Config.Is_Work.Aplicacion  ,"Primero se debe guardar los Cambios para Abrir una Foto " +char(13)+ "Desea Guardar los cambios y Asignar una Imagen al Producto registrado ......???",StopSign!,YesNo!)= 1 then
		pb_grabar.triggerevent(Clicked!)
			return
	else
			return
	end if
end if
	
	string titulo,ls_path,ls_filename, defaulf, tipos,Codigo
	blob lb_object
	
	Titulo=Gn_Config.Is_Work.Aplicacion+": Seleccionar una Foto en Mapa de Bits"
//	defaulf ="JPG"
//	tipos = "Fotos e Imagenes JPG (*.JPG),*.JPG,Fotos e Imagenes BMP (*.BMP),*.BMP,Fotos e Imagenes GIF (*.GIF),*.GIF"
	defaulf ="BMP"
	tipos = "Fotos e Imagenes BMP (*.BMP),*.BMP"
	
	GetFileOpenName(Titulo, ls_path,ls_filename,defaulf,tipos)
	If ls_filename ="" Then return
	tab_todo.tp_manto.ole_1.insertfile(ls_path)
	
	/////////////////////////////////////////
	
	Codigo=idw_activa.getitemString(idw_activa.getrow(),1)
	lb_object = tab_todo.tp_manto.ole_1.objectdata
	SQLCA.autocommit = TRUE
	
	  UPDATEBLOB producto   SET foto = :lb_object   WHERE ( producto.idempresa = :gn_config.is_config.empresa ) AND  
         ( producto.idproducto = :codigo )   using SQLCA;

	if SQLCA.SQLCode = -1 then
		MessageBox("SQL error",SQLCA.SQLErrText,Information!)
		return -1
	end if
	commit using SQLCA;
	SQLCA.autocommit = FALSE
	idw_lista.triggerevent( rowfocuschanged!)
end event

type ole_1 from w_manto`ole_1 within tp_manto
integer x = 855
integer y = 932
integer width = 389
integer height = 348
end type

type shl_cerrar from w_manto`shl_cerrar within w_mantoproducto
end type

type shl_grabar from w_manto`shl_grabar within w_mantoproducto
end type

type shl_eliminar from w_manto`shl_eliminar within w_mantoproducto
end type

type shl_modificar from w_manto`shl_modificar within w_mantoproducto
end type

type shl_nuevo from w_manto`shl_nuevo within w_mantoproducto
end type

type uo_nav from w_manto`uo_nav within w_mantoproducto
end type

type pb_cancelar from w_manto`pb_cancelar within w_mantoproducto
end type

type pb_grabar from w_manto`pb_grabar within w_mantoproducto
end type

type pb_eliminar from w_manto`pb_eliminar within w_mantoproducto
end type

type pb_nuevo from w_manto`pb_nuevo within w_mantoproducto
end type

type pb_cerrar from w_manto`pb_cerrar within w_mantoproducto
end type

type shl_cancelar from w_manto`shl_cancelar within w_mantoproducto
end type

type pb_modificar from w_manto`pb_modificar within w_mantoproducto
end type

type dw_fraciones from u_dw within w_mantoproducto
boolean visible = false
integer y = 568
integer width = 3195
integer height = 1312
integer taborder = 20
boolean bringtotop = true
boolean titlebar = true
string dataobject = "d_fraccion_manto"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
end type

