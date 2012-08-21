HA$PBExportHeader$w_buscar_ubigeo_lista.srw
forward
global type w_buscar_ubigeo_lista from w_buscar
end type
type dw_grupo from datawindow within w_buscar_ubigeo_lista
end type
end forward

global type w_buscar_ubigeo_lista from w_buscar
integer width = 2043
integer height = 1968
string title = "Busqueda de Ubicaci$$HEX1$$f300$$ENDHEX$$n Geografiaca"
string is_cpcampoid = "IdUbigeo"
string is_cpcodigo = "IdUbigeo"
string is_cpdescripccion = "Nombre"
integer il_campobusqueda = 2
dw_grupo dw_grupo
end type
global w_buscar_ubigeo_lista w_buscar_ubigeo_lista

type variables
DataWindowChild idwc_dep,idwc_pro,idwc_dis
String is_dep,is_pro, is_dis
DataStore lds_Ubigeo
end variables

forward prototypes
public subroutine wf_seleccion ()
public subroutine wf_accion ()
public subroutine wf_aceptar ()
public subroutine wf_cancelar ()
public subroutine wf_abrir ()
end prototypes

public subroutine wf_seleccion ();Int li_ret
String ls_IdUbigeo, ls_dep, ls_pro , ls_dis
If idw_lista.getrow() > 0 Then
	
	ls_IdUbigeo = idw_lista.object.IdUbigeo[idw_lista.getrow()]
	 ls_dep = Mid(ls_IdUbigeo,1, 2)
	 ls_pro = Mid(ls_IdUbigeo,3, 2)
	 ls_dis  = Mid(ls_IdUbigeo,5, 2)
	
	dw_grupo.object.dep[dw_grupo.GetRow()] = ls_dep
	
	li_ret = idwc_pro.SetFilter(" coddepartamento ='"+ls_dep+"' and codprovincia <>'00' and coddistrito = '00' ")
	li_ret = idwc_pro.Filter( )	
	
	If ls_pro = "00" Then
		dw_grupo.object.pro[dw_grupo.GetRow()] = ""	
	Else
		  dw_grupo.object.pro[dw_grupo.GetRow()] = ls_pro		
	End If
	
	If  ls_pro = "00" and  ls_dis = "00" Then
		li_ret = idwc_dis.SetFilter(" coddepartamento ='00' and codprovincia ='00' and coddistrito = '00' ")
		li_ret = idwc_dis.Filter( )	
		dw_grupo.object.dis[dw_grupo.GetRow()] = ""	
	Else 
			li_ret = idwc_dis.SetFilter(" coddepartamento ='"+ls_dep+"' and codprovincia ='"+ls_pro+"'  and coddistrito <> '00'  ")
			li_ret = idwc_dis.Filter( )	
		If  ls_dis = "00" Then
			dw_grupo.object.dis[dw_grupo.GetRow()] = ""	
		Else
			dw_grupo.object.dis[dw_grupo.GetRow()] = ls_dis		
		End If
	End If

End If
end subroutine

public subroutine wf_accion ();String ls_filtro

ls_Filtro = " coddepartamento <>'00' and codprovincia <>'00' and coddistrito <> '00' "
il_Fila = idw_lista.find( ls_Filtro,1,idw_lista.rowcount())

If il_Fila> 0 Then
	idw_lista.setredraw(False)	
	If Not  rb_seleccion.Checked Then idw_lista.ScrollToRow(il_Fila)			
	wf_Seleccion()
	idw_lista.setredraw(True)
End If
end subroutine

public subroutine wf_aceptar ();IF idw_lista.rowcount( ) > 0 THEN 
	idw_lista.AcceptText( )
	is_id = idw_lista.getitemstring( idw_lista.getrow(),is_CPCampoId )
	IF Mid(is_id , 1 ,2 ) = '00' OR Mid(is_id , 3 ,2 ) = '00' OR Mid(is_id , 5 ,2 ) = '00' THEN 
		Messagebox("Advertencia Ubicaci$$HEX1$$f300$$ENDHEX$$n Incorrecta "+ Gn_Config.Is_Work.Aplicacion , "No se puede asignar la ubicaci$$HEX1$$f300$$ENDHEX$$n pOR ser provincia o departamento" , Exclamation!)
		em_buscar.SetFocus( )
		is_id = ""
		RETURN	
	END IF
END IF

CloseWithReturn(THIS, is_id)
end subroutine

public subroutine wf_cancelar ();CloseWithReturn(THIS, "")
end subroutine

public subroutine wf_abrir ();

end subroutine

on w_buscar_ubigeo_lista.create
int iCurrent
call super::create
this.dw_grupo=create dw_grupo
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_grupo
end on

on w_buscar_ubigeo_lista.destroy
call super::destroy
destroy(this.dw_grupo)
end on

event open;call super::open;/*
is_CPcampoid 		='IdUbigeo'	 Nombre del Campo Id para devolver el Valor
is_CPCodigo			='IdUbigeo'	 Nombre del Campo del Codigo para Buscar
is_CPDescripccion	='Nombre'	 Nombre del Campo de Descripcion para Buscar
*/
Int li_ret
lds_Ubigeo =  Create DataStore
lds_Ubigeo.DataObject = "d_ubigeo_lista"
lds_Ubigeo.SetTransObject( SQLCA)
lds_Ubigeo.retrieve(gs_nulo,gs_nulo,gs_nulo,gs_nulo )

lds_Ubigeo.RowsCopy(lds_Ubigeo.GetRow(), lds_Ubigeo.RowCount(), Primary!, Idw_lista, 1, Primary!)
Idw_lista.ResetUpdate ( ) 
lds_Ubigeo.RowsCopy(lds_Ubigeo.GetRow(), lds_Ubigeo.RowCount(), Primary!, idwc_dep, 1, Primary!)
idwc_dep.ResetUpdate ( ) 
lds_Ubigeo.RowsCopy(lds_Ubigeo.GetRow(), lds_Ubigeo.RowCount(), Primary!, idwc_pro, 1, Primary!)
idwc_pro.ResetUpdate ( ) 
lds_Ubigeo.RowsCopy(lds_Ubigeo.GetRow(), lds_Ubigeo.RowCount(), Primary!, idwc_dis, 1, Primary!)
idwc_dis.ResetUpdate ( ) 

li_ret = idwc_dep.SetFilter(" codprovincia ='00' and coddistrito = '00' ")
li_ret = idwc_dep.Filter( )

li_ret = idwc_pro.SetFilter(" coddepartamento ='00' and codprovincia ='00' and coddistrito = '00' ")
li_ret = idwc_pro.Filter( )

li_ret = idwc_dis.SetFilter(" coddepartamento ='00' and codprovincia ='00' and coddistrito = '00' ")
li_ret = idwc_dis.Filter( )



String ls_Id
ls_Id = Message.StringParm
IF Trim(ls_Id) <> ""  OR NOT IsNull(ls_Id) THEN
	idw_lista.ScrollToRow( idw_lista.Find( "IdUbigeo = '"+ls_Id+"'", 1, idw_lista.RowCount()))
	wf_seleccion( )
END IF
end event

event close;call super::close;Destroy lds_Ubigeo
end event

type cb_aceptar from w_buscar`cb_aceptar within w_buscar_ubigeo_lista
integer x = 398
integer y = 1724
end type

type cb_cerrar from w_buscar`cb_cerrar within w_buscar_ubigeo_lista
integer x = 1289
integer y = 1724
end type

type pb_refresh from w_buscar`pb_refresh within w_buscar_ubigeo_lista
integer x = 1705
end type

type pb_orden from w_buscar`pb_orden within w_buscar_ubigeo_lista
integer x = 1591
end type

type pb_filtro from w_buscar`pb_filtro within w_buscar_ubigeo_lista
integer x = 1472
end type

type em_buscar from w_buscar`em_buscar within w_buscar_ubigeo_lista
integer width = 1664
end type

type rb_filtro from w_buscar`rb_filtro within w_buscar_ubigeo_lista
integer x = 1179
integer y = 88
end type

type rb_seleccion from w_buscar`rb_seleccion within w_buscar_ubigeo_lista
integer x = 805
integer y = 88
end type

type dw_lista from w_buscar`dw_lista within w_buscar_ubigeo_lista
integer y = 724
integer width = 2016
integer height = 984
string dataobject = "d_ubigeo_lista"
borderstyle borderstyle = stylelowered!
end type

event dw_lista::rowfocuschanged;call super::rowfocuschanged;If currentrow> 0 Then
	wf_Seleccion()
End If
end event

type st_2 from w_buscar`st_2 within w_buscar_ubigeo_lista
end type

type st_1 from w_buscar`st_1 within w_buscar_ubigeo_lista
end type

type am_1 from w_buscar`am_1 within w_buscar_ubigeo_lista
integer x = 1833
integer y = 44
string animationname = "monitor.avi"
end type

type gb_tipo from w_buscar`gb_tipo within w_buscar_ubigeo_lista
integer x = 795
integer y = 32
integer width = 1029
integer height = 140
end type

type ddlb_campo from w_buscar`ddlb_campo within w_buscar_ubigeo_lista
integer width = 494
end type

type gb_busqueda from w_buscar`gb_busqueda within w_buscar_ubigeo_lista
integer x = 0
integer width = 2025
end type

type dw_grupo from datawindow within w_buscar_ubigeo_lista
integer y = 324
integer width = 2016
integer height = 372
integer taborder = 30
boolean bringtotop = true
string title = "none"
string dataobject = "d_dddw_grupo"
boolean border = false
boolean livescroll = true
end type

event constructor;this.insertrow(0)
// Estableciendo los DW Chlids
IF  dw_grupo.GetChild('dep', idwc_dep) = -1 THEN MessageBox( "Error", "Not a DataWindowChild DEP ")
IF  dw_grupo.GetChild('pro', idwc_pro) = -1 THEN MessageBox( "Error", "Not a DataWindowChild PRO ")
IF  dw_grupo.GetChild('dis', idwc_dis) = -1 THEN MessageBox( "Error", "Not a DataWindowChild DIS ")

// Establish the connection

 idwc_dep.SetTransObject(SQLCA)
 idwc_pro.SetTransObject(SQLCA)
 idwc_dis.SetTransObject(SQLCA)
 
//idwc_dep.Retrieve("","00","00")


end event

event itemchanged;Int li_ret
This.AcceptText()
choose case dwo.name
	case "dep"
		li_ret = idwc_pro.SetFilter(" coddepartamento ='00' and codprovincia ='00' and coddistrito = '00' ")
		li_ret = idwc_pro.Filter( )
		
		li_ret = idwc_dis.SetFilter(" coddepartamento ='00' and codprovincia ='00' and coddistrito = '00' ")
		li_ret = idwc_dis.Filter( )

		This.Object.pro[This.GetRow()] = ""
		This.Object.dis[This.GetRow()] = ""
		 is_dep =  data
		 is_pro = ""
		 is_dis = ""
          
		li_ret = idwc_pro.SetFilter(" coddepartamento ='"+is_dep+"' and codprovincia <>'00' and coddistrito = '00' ")
		li_ret = idwc_pro.Filter( )
		li_ret = idw_lista.SetFilter(" coddepartamento ='"+is_dep+"' ")
		li_ret = idw_lista.Filter( )
	case "pro"
		li_ret = idwc_dis.SetFilter(" coddepartamento ='00' and codprovincia ='00' and coddistrito = '00' ")
		li_ret = idwc_dis.Filter( )

		This.Object.dis[This.GetRow()] = ""
		 is_pro =  data
		 is_dis = ""
		  idwc_dis.Retrieve(is_dep,is_pro,"")
		  li_ret = idwc_dis.SetFilter(" coddepartamento ='"+is_dep+"' and codprovincia ='"+is_pro+"'  and coddistrito <> '00'  ")
		  li_ret = idwc_dis.Filter( )
		  li_ret = idw_lista.SetFilter(" coddepartamento ='"+is_dep+"' and codprovincia ='"+is_pro+"'  ")
		  li_ret = idw_lista.Filter( )
	case "dis"
		 is_dis = data
		 is_id = is_dep + is_pro + is_dis
		  li_ret = idw_lista.SetFilter(" coddepartamento ='"+is_dep+"' and codprovincia ='"+is_pro+"'  and coddistrito = '"+is_dis+"'  ")
		  li_ret = idw_lista.Filter( )
end choose

end event

