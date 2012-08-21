HA$PBExportHeader$w_manto_almacen.srw
forward
global type w_manto_almacen from w_manto
end type
end forward

global type w_manto_almacen from w_manto
integer width = 2711
integer height = 2232
string title = "Cat$$HEX1$$e100$$ENDHEX$$logo de Almacenes"
string is_tabla = "ALMACEN"
string is_campocod = "CodAlmacen"
string is_campoid = "IdAlmacen"
integer ii_largocod = 3
string is_campofinal = "estado"
end type
global w_manto_almacen w_manto_almacen

forward prototypes
public subroutine wf_datos_adicionales ()
end prototypes

public subroutine wf_datos_adicionales ();
dwItemStatus l_status

l_status = idw_activa.GetItemStatus( idw_activa.getrow() , 0, Primary!)

choose case l_status
	case New!, NewModified!
			idw_activa.Object.idEmpresa[idw_activa.getrow()]= gn_config.is_work.idempresa
end choose



end subroutine

on w_manto_almacen.create
int iCurrent
call super::create
end on

on w_manto_almacen.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type gb_comandos from w_manto`gb_comandos within w_manto_almacen
integer x = 311
integer y = 1512
integer width = 2048
integer height = 528
end type

type tab_todo from w_manto`tab_todo within w_manto_almacen
integer x = 0
integer width = 2674
integer height = 2052
integer selectedtab = 1
end type

type tp_manto from w_manto`tp_manto within tab_todo
integer width = 2638
integer height = 1924
string text = "Datos de Almacen"
end type

type dw_manto from w_manto`dw_manto within tp_manto
integer y = 24
integer width = 2638
integer height = 1368
string dataobject = "d_almacen_manto"
end type

event dw_manto::ue_saveprevious;call super::ue_saveprevious;dwItemStatus	le_status
String ls_Actual, ls_Original,ls_Codigo

this.accepttext( )

le_status = this.GetItemStatus (this.GetRow(), 0, primary!)

ls_Actual = this.Object.nombre.Primary.Current[this.GetRow()]
ls_Original = this.Object.nombre.Primary.Original[this.GetRow()]

il_Fila = idw_lista.find( " nombre = '"+ls_Actual+"'",1,idw_lista.rowcount())

If il_Fila > 0 then	
	ls_Codigo = idw_lista.GetItemString(il_Fila , is_campocod)
End If

choose case le_status	
	case new!,newmodified!
			If il_Fila > 0 then				
				messagebox("Advertecia " + Gn_Config.Is_Work.Aplicacion  ,"Color ya existe......!!!"+char(13)+"Fila : "+String(il_Fila)+"  C$$HEX1$$f300$$ENDHEX$$digo : "+ls_Codigo,Exclamation!)
				this.setcolumn('nombre')
				this.SelectText(1, Len(this.GetText()))
				this.setfocus( )
				Return 0
//			Else
//				Return 1
			End If
		
	case	datamodified!
		If ls_Actual = ls_Original Then
			Return 1
		Else
			If il_Fila > 0 then
				messagebox("Advertecia " + Gn_Config.Is_Work.Aplicacion  ,"Color ya existe......!!!"+char(13)+"Fila : "+String(il_Fila)+"  C$$HEX1$$f300$$ENDHEX$$digo : "+ls_Codigo,Exclamation!)
				this.setcolumn('nombre')
				this.SelectText(1, Len(this.GetText()))
				this.setfocus( )
				Return 0
//			Else
//				Return 1
			End If
		End If
//	case else 
//		Return 1
end choose

wf_datos()

this.accepttext( )

Return 1






end event

event dw_manto::ue_refresh;call super::ue_refresh;idw_activa.retrieve(id_Codigo)

end event

type pb_borrar from w_manto`pb_borrar within tp_manto
integer x = 3360
integer y = 324
end type

type pb_abrir from w_manto`pb_abrir within tp_manto
integer x = 3145
integer y = 248
end type

type ole_1 from w_manto`ole_1 within tp_manto
integer x = 3040
integer y = 476
end type

type tp_lista from w_manto`tp_lista within tab_todo
integer width = 2638
integer height = 1924
string text = "Lista de Almacenes"
end type

type dw_lista from w_manto`dw_lista within tp_lista
integer x = 9
integer width = 2560
integer height = 1068
string dataobject = "d_almacen_lista"
end type

event dw_lista::ue_refresh;call super::ue_refresh;	idw_lista.retrieve(gn_config.is_work.idempresa )
end event

event dw_lista::ue_getid;call super::ue_getid;	id_Codigo=this.object.idalmacen [this.getrow()]	
end event

type am_1 from w_manto`am_1 within tp_lista
end type

type st_2 from w_manto`st_2 within tp_lista
end type

type st_1 from w_manto`st_1 within tp_lista
end type

type rb_filtro from w_manto`rb_filtro within tp_lista
integer x = 1413
end type

type rb_seleccion from w_manto`rb_seleccion within tp_lista
integer x = 969
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
integer x = 9
integer width = 2560
end type

type shl_cerrar from w_manto`shl_cerrar within w_manto_almacen
integer x = 1957
integer y = 1728
end type

type shl_grabar from w_manto`shl_grabar within w_manto_almacen
integer x = 1335
integer y = 1728
end type

type shl_eliminar from w_manto`shl_eliminar within w_manto_almacen
integer x = 1024
integer y = 1728
end type

type shl_modificar from w_manto`shl_modificar within w_manto_almacen
integer x = 713
integer y = 1728
end type

type shl_nuevo from w_manto`shl_nuevo within w_manto_almacen
integer x = 402
integer y = 1728
end type

type uo_nav from w_manto`uo_nav within w_manto_almacen
integer x = 603
integer y = 1868
end type

type pb_cancelar from w_manto`pb_cancelar within w_manto_almacen
integer x = 1714
integer y = 1576
end type

type pb_grabar from w_manto`pb_grabar within w_manto_almacen
integer x = 1403
integer y = 1576
end type

type pb_eliminar from w_manto`pb_eliminar within w_manto_almacen
integer x = 1093
integer y = 1576
end type

type pb_nuevo from w_manto`pb_nuevo within w_manto_almacen
integer x = 471
integer y = 1576
end type

type pb_cerrar from w_manto`pb_cerrar within w_manto_almacen
integer x = 2025
integer y = 1576
end type

type shl_cancelar from w_manto`shl_cancelar within w_manto_almacen
integer x = 1646
integer y = 1728
end type

type pb_modificar from w_manto`pb_modificar within w_manto_almacen
integer x = 782
integer y = 1576
end type

type pb_ventana_y_libreria from w_manto`pb_ventana_y_libreria within w_manto_almacen
end type

