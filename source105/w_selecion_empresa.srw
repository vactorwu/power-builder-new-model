HA$PBExportHeader$w_selecion_empresa.srw
forward
global type w_selecion_empresa from w_center
end type
type cb_cancelar from commandbutton within w_selecion_empresa
end type
type cb_aceptar from commandbutton within w_selecion_empresa
end type
type dw_empresa from datawindow within w_selecion_empresa
end type
type gb_1 from groupbox within w_selecion_empresa
end type
end forward

global type w_selecion_empresa from w_center
string tag = " "
integer width = 2939
integer height = 1048
string title = "Seleccione su Empresa"
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
boolean center = true
cb_cancelar cb_cancelar
cb_aceptar cb_aceptar
dw_empresa dw_empresa
gb_1 gb_1
end type
global w_selecion_empresa w_selecion_empresa

type variables

end variables

on w_selecion_empresa.create
int iCurrent
call super::create
this.cb_cancelar=create cb_cancelar
this.cb_aceptar=create cb_aceptar
this.dw_empresa=create dw_empresa
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_cancelar
this.Control[iCurrent+2]=this.cb_aceptar
this.Control[iCurrent+3]=this.dw_empresa
this.Control[iCurrent+4]=this.gb_1
end on

on w_selecion_empresa.destroy
call super::destroy
destroy(this.cb_cancelar)
destroy(this.cb_aceptar)
destroy(this.dw_empresa)
destroy(this.gb_1)
end on

event open;call super::open;

THIS.title = gn_config.is_work.aplicacion + " :  "+THIS.title
gb_AbrirCatalogos =  FALSE

IF dw_empresa.RowCount( )<1 THEN
	MessageBox(Gn_Config.Is_Work.Aplicacion ,"No Existe Empresas Registradas... Debe registrar una empresa para trabajar",StopSign!) 
	IF NOT IsValid(w_manto_empresa) THEN OpenSheet(w_manto_empresa,w_frame,1,Original!) 
	cb_cancelar.EVENT clicked( ) 
END IF



end event

type cb_cancelar from commandbutton within w_selecion_empresa
integer x = 1568
integer y = 812
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

event clicked;

If IsNull( gn_config.is_work.idempresa ) OR   gn_config.is_work.idempresa = 0 THEN
  gb_AbrirCatalogos =  FALSE
Else
	IF  gn_config.is_work.EstadoOperacion THEN
 	 	gb_AbrirCatalogos =  TRUE 
	ELSE
 	 	gb_AbrirCatalogos =  FALSE 		
	END IF
END IF

Close(Parent)
end event

type cb_aceptar from commandbutton within w_selecion_empresa
integer x = 763
integer y = 812
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
boolean default = true
end type

event clicked;String ls_Fecha ,ls_Codigo
Integer li_Empresas
dw_empresa.accepttext( )

IF dw_empresa.rowcount( ) > 0 THEN
	gn_config.is_work.empresa 	  		= String(dw_empresa.object.codempresa[dw_empresa.getrow()])
	gn_config.is_work.idempresa 	  		= dw_empresa.object.idempresa[dw_empresa.getrow()]
	gn_config.is_work.empresades 		= dw_empresa.object.RazonSocial[dw_empresa.getrow()]
	ls_Codigo							  		= dw_empresa.object.codempresa[dw_empresa.getrow()]
	gn_config.is_work.ruc 			  		= dw_empresa.object.ruc[dw_empresa.getrow()]
	gn_config.is_work.idmonedaNacional	= dw_empresa.object.idmonedaNacional[dw_empresa.getrow()]
	gn_config.is_work.idmonedaExtranjera = dw_empresa.object.idmonedaExtranjera[dw_empresa.getrow()]
	
	li_Empresas = SQLCA.Usf_get_estadooperacion_count( gn_config.is_work.idempresa ,Long(gs_nulo))
	IF li_Empresas > 0 THEN
		IF NOT isvalid(w_selecion_fecha) THEN opensheet(w_selecion_fecha,w_frame,1,original!)
	ELSE
	     MessageBox(Gn_Config.Is_Work.Aplicacion ,"No Existe Registro de Operaciones... Debe crear un Registro de Operaciones para trabajar",StopSign!) 
		IF NOT isvalid(w_manto_estadooperacion) THEN opensheet(w_manto_estadooperacion,w_frame,1,original!)
	END IF
	
ELSE
	MessageBox(Gn_Config.Is_Work.Aplicacion ,"No exiten empresas registradas  por favor registre una empresa y reinice la aplicaci$$HEX1$$f300$$ENDHEX$$n",StopSign!)
	gb_AbrirCatalogos = FALSE 
	IF NOT isvalid(w_manto_empresa) THEN opensheet(w_manto_empresa,w_frame,1,original!)
END IF
CLOSE(PARENT)
end event

type dw_empresa from datawindow within w_selecion_empresa
integer x = 37
integer y = 40
integer width = 2866
integer height = 740
integer taborder = 10
string dataobject = "d_seleccion_empresa"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;THIS.SetTransObject( SQLCA )
Integer li_Filas

li_Filas = THIS.Retrieve()
IF li_Filas <1 THEN
	SetNull(gn_config.is_work.empresa)
ELSE
	THIS.AcceptText( )
END IF

gn_config.is_work.FechaSistema =  Date(gn_config.of_datetime( ) )
IF gn_config.is_work.FechaTrabajo = Date(1900,1,1) OR IsNull(gn_config.is_work.FechaTrabajo) THEN
	gn_config.is_work.FechaTrabajo = gn_config.is_work.FechaSistema
END IF

THIS.SetFocus( )

IF li_Filas = 1 AND	Gn_Config.Is_Config.Licencias = 1 THEN
	THIS.ScrollToRow( 1)
	cb_aceptar.TriggerEvent( Clicked!)
END IF
end event

event rowfocuschanged;if this.rowcount() > 0  then
	THIS.selectrow(0,false)
	THIS.selectrow(THIS.getrow(),true)
End If
end event

type gb_1 from groupbox within w_selecion_empresa
integer x = 37
integer y = 760
integer width = 2866
integer height = 188
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

