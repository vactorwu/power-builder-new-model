HA$PBExportHeader$w_manto_documento.srw
forward
global type w_manto_documento from w_manto
end type
end forward

global type w_manto_documento from w_manto
integer width = 3794
integer height = 2748
string title = "Cat$$HEX1$$e100$$ENDHEX$$logo de Documentos"
string is_tabla = "DOCUMENTO"
string is_campocod = "CodDocumento"
string is_campoid = "IdDocumento"
integer ii_largocod = 6
decimal id_codigo = 0.00
string is_campofinal = "estado"
end type
global w_manto_documento w_manto_documento

type variables
DataWindowChild idwc_TipoDocumento

end variables

forward prototypes
public subroutine wf_datos_adicionales ()
public subroutine wf_abreviacion ()
end prototypes

public subroutine wf_datos_adicionales ();
dwItemStatus l_status

l_status = idw_activa.GetItemStatus( idw_activa.getrow() , 0, Primary!)

choose case l_status
	case New!, NewModified!
			idw_activa.Object.idEmpresa[idw_activa.getrow()]= gn_config.is_work.idempresa
end choose



end subroutine

public subroutine wf_abreviacion ();Long ll_fila
String ls_abreviacion , ls_serie, ls_dato

ls_dato = String(idw_activa.object.idtipodocumento[idw_activa.GetRow()])
ll_fila = idwc_TipoDocumento.Find("idtipodocumento = "+String(ls_dato), 1, idwc_TipoDocumento.RowCount())

If ll_fila > 0 Then
	ls_abreviacion = idwc_TipoDocumento.GetItemstring(ll_fila, "abreviacion") 
	ls_serie = idw_activa.object.serie[idw_activa.GetRow()]
	idw_activa.object.abreviacion[idw_activa.GetRow()]= ls_abreviacion + ls_serie
End If
end subroutine

on w_manto_documento.create
int iCurrent
call super::create
end on

on w_manto_documento.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type gb_comandos from w_manto`gb_comandos within w_manto_documento
integer x = 55
integer y = 2192
integer width = 3470
end type

type tab_todo from w_manto`tab_todo within w_manto_documento
integer x = 0
integer width = 3767
integer height = 2564
end type

type tp_manto from w_manto`tp_manto within tab_todo
integer width = 3730
integer height = 2436
string text = "Datos de Documento"
end type

type dw_manto from w_manto`dw_manto within tp_manto
integer x = 302
integer y = 156
integer width = 3045
integer height = 1760
string dataobject = "d_documento_manto"
boolean hscrollbar = true
end type

event dw_manto::ue_saveprevious;call super::ue_saveprevious;

RETURN 1



end event

event dw_manto::ue_refresh;call super::ue_refresh;idw_activa.Retrieve( id_Codigo ) 


end event

event dw_manto::ue_saveafter;call super::ue_saveafter;RETURN 1
end event

event dw_manto::ue_getid;call super::ue_getid;	id_Codigo=this.object.IdDocumento[this.getrow()]	
end event

event dw_manto::constructor;call super::constructor;IF idw_activa.GetChild('idTipoDocumento', idwc_TipoDocumento) = -1 THEN MessageBox(  "Error", "Linea Not a DataWindowChild")
idwc_TipoDocumento.SetTransObject(SQLCA)
idwc_TipoDocumento.Retrieve(gn_config.is_work.idempresa)

end event

event dw_manto::itemchanged;call super::itemchanged;If dwo.name  = 'idtipodocumento' Then
	This.accepttext( )
	wf_abreviacion()
End If
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
integer width = 3730
integer height = 2436
string text = "Lista de Documentos"
end type

type dw_lista from w_manto`dw_lista within tp_lista
integer y = 324
integer width = 3721
integer height = 1736
string dataobject = "d_documento_lista"
end type

event dw_lista::ue_refresh;call super::ue_refresh;//idw_lista.Retrieve()
idw_lista.retrieve(gn_config.is_work.idempresa)
end event

event dw_lista::ue_getid;call super::ue_getid;	id_Codigo=this.object.IdDocumento[this.getrow()]	
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

type shl_cerrar from w_manto`shl_cerrar within w_manto_documento
integer x = 3099
integer y = 2404
end type

type shl_grabar from w_manto`shl_grabar within w_manto_documento
integer x = 1015
integer y = 2404
end type

type shl_eliminar from w_manto`shl_eliminar within w_manto_documento
integer x = 704
integer y = 2404
end type

type shl_modificar from w_manto`shl_modificar within w_manto_documento
integer x = 393
integer y = 2404
end type

type shl_nuevo from w_manto`shl_nuevo within w_manto_documento
integer x = 82
integer y = 2404
end type

type uo_nav from w_manto`uo_nav within w_manto_documento
integer x = 1632
integer y = 2256
end type

type pb_cancelar from w_manto`pb_cancelar within w_manto_documento
integer x = 1394
integer y = 2252
end type

type pb_grabar from w_manto`pb_grabar within w_manto_documento
integer x = 1083
integer y = 2252
end type

type pb_eliminar from w_manto`pb_eliminar within w_manto_documento
integer x = 773
integer y = 2252
end type

type pb_nuevo from w_manto`pb_nuevo within w_manto_documento
integer x = 151
integer y = 2252
end type

type pb_cerrar from w_manto`pb_cerrar within w_manto_documento
integer x = 3168
integer y = 2252
end type

type shl_cancelar from w_manto`shl_cancelar within w_manto_documento
integer x = 1326
integer y = 2404
end type

type pb_modificar from w_manto`pb_modificar within w_manto_documento
integer x = 462
integer y = 2252
end type

