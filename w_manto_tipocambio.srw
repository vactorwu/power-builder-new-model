HA$PBExportHeader$w_manto_tipocambio.srw
forward
global type w_manto_tipocambio from w_manto
end type
end forward

global type w_manto_tipocambio from w_manto
integer width = 3186
integer height = 2224
string title = "Cat$$HEX1$$e100$$ENDHEX$$logo de Tipo de Cambio"
string is_tabla = "TIPOCAMBIO"
string is_campocod = "CodTipoCambio"
string is_campoid = "IdTipoCambio"
integer ii_largocod = 10
string is_campofinal = "estado"
end type
global w_manto_tipocambio w_manto_tipocambio

type variables

end variables

forward prototypes
public subroutine wf_datos_adicionales ()
end prototypes

public subroutine wf_datos_adicionales ();
dwItemStatus l_status

l_status = idw_activa.GetItemStatus( idw_activa.getrow() , 0, Primary!)

choose case l_status
	case New!, NewModified!
		idw_activa.Object.IdMonedaNacional[idw_activa.getrow()]= gn_config.is_work.IdMonedaNacional
		idw_activa.Object.IdMonedaExtranjera[idw_activa.getrow()]= gn_config.is_work.IdMonedaExtranjera		
end choose
end subroutine

on w_manto_tipocambio.create
int iCurrent
call super::create
end on

on w_manto_tipocambio.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type gb_comandos from w_manto`gb_comandos within w_manto_tipocambio
integer x = 530
integer y = 1512
integer width = 2048
integer height = 528
end type

type tab_todo from w_manto`tab_todo within w_manto_tipocambio
integer x = 0
integer width = 3145
integer height = 2052
end type

type tp_manto from w_manto`tp_manto within tab_todo
integer width = 3109
integer height = 1924
string text = "Datos de Tipo de Cambio"
end type

type dw_manto from w_manto`dw_manto within tp_manto
event lbuttondown pbm_dwnlbuttonup
integer x = 101
integer y = 88
integer width = 2761
integer height = 1292
string dataobject = "d_tipocambio_manto"
end type

event dw_manto::ue_saveprevious;call super::ue_saveprevious;dwItemStatus	le_status
String ls_Actual, ls_Original,ls_Codigo

this.accepttext( )

le_status = this.GetItemStatus (this.GetRow(), 0, primary!)

ls_Actual   = String(this.Object.fecha.Primary.Current[this.GetRow()],"YYYYMMDD")
ls_Original = String(this.Object.fecha.Primary.Original[this.GetRow()],"YYYYMMDD")

il_Fila = idw_lista.find( " FechaString = '"+ls_Actual+"'",1,idw_lista.rowcount())

choose case le_status	
	case new!,newmodified!
			If il_Fila > 0 then
				ls_Codigo = idw_lista.Object.codmoneda[il_Fila]
				messagebox("Advertecia " + Gn_Config.Is_Work.Aplicacion  ,"Fecha ya existe......!!!"+char(13)+"Fila : "+String(il_Fila)+"  C$$HEX1$$f300$$ENDHEX$$digo : "+ls_Codigo,Exclamation!)
				this.setcolumn('fecha')
				this.SelectText(1, Len(this.GetText()))
				this.setfocus( )
				Return 0
			Else
//				Return 1
			End If
		
	case	datamodified!
		If ls_Actual = ls_Original Then
//			Return 1
		Else
			If il_Fila > 0 then
				ls_Codigo = idw_lista.Object.codmoneda[il_Fila]
				messagebox("Advertecia " + Gn_Config.Is_Work.Aplicacion  ,"Fecha ya existe......!!!"+char(13)+"Fila : "+String(il_Fila)+"  C$$HEX1$$f300$$ENDHEX$$digo : "+ls_Codigo,Exclamation!)
				this.setcolumn('fecha')
				this.SelectText(1, Len(this.GetText()))
				this.setfocus( )
				Return 0
			Else
//				Return 1
			End If
		End If
	case else 
//		Return 1
end choose

Return 1
wf_datos()


end event

event dw_manto::ue_refresh;call super::ue_refresh;idw_activa.retrieve(id_Codigo)

end event

event dw_manto::constructor;call super::constructor;of_setregistrarcalendario(True)
of_setcampocalendario("fecha")
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
integer width = 3109
integer height = 1924
string text = "Lista de Tipos de Cambio"
end type

type dw_lista from w_manto`dw_lista within tp_lista
integer width = 3109
integer height = 1068
string dataobject = "d_tipocambio_lista"
end type

event dw_lista::ue_refresh;call super::ue_refresh;	idw_lista.retrieve(	Long(gn_config.is_work.IdMonedaNacional) , Long(gn_config.is_work.IdMonedaExtranjera)  )
//idw_lista.retrieve(	1 , 2  )
end event

event dw_lista::ue_getid;call super::ue_getid;	id_Codigo=this.object.IdTipoCambio [this.getrow()]	
	

end event

type am_1 from w_manto`am_1 within tp_lista
end type

type st_2 from w_manto`st_2 within tp_lista
end type

type st_1 from w_manto`st_1 within tp_lista
end type

type rb_filtro from w_manto`rb_filtro within tp_lista
integer x = 1390
end type

type rb_seleccion from w_manto`rb_seleccion within tp_lista
integer x = 974
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

type shl_cerrar from w_manto`shl_cerrar within w_manto_tipocambio
integer x = 2176
integer y = 1728
end type

type shl_grabar from w_manto`shl_grabar within w_manto_tipocambio
integer x = 1554
integer y = 1728
end type

type shl_eliminar from w_manto`shl_eliminar within w_manto_tipocambio
integer x = 1243
integer y = 1728
end type

type shl_modificar from w_manto`shl_modificar within w_manto_tipocambio
integer x = 933
integer y = 1728
end type

type shl_nuevo from w_manto`shl_nuevo within w_manto_tipocambio
integer x = 622
integer y = 1728
end type

type uo_nav from w_manto`uo_nav within w_manto_tipocambio
integer x = 823
integer y = 1868
end type

type pb_cancelar from w_manto`pb_cancelar within w_manto_tipocambio
integer x = 1934
integer y = 1576
end type

type pb_grabar from w_manto`pb_grabar within w_manto_tipocambio
integer x = 1623
integer y = 1576
end type

type pb_eliminar from w_manto`pb_eliminar within w_manto_tipocambio
integer x = 1312
integer y = 1576
end type

type pb_nuevo from w_manto`pb_nuevo within w_manto_tipocambio
integer x = 690
integer y = 1576
end type

type pb_cerrar from w_manto`pb_cerrar within w_manto_tipocambio
integer x = 2245
integer y = 1576
end type

type shl_cancelar from w_manto`shl_cancelar within w_manto_tipocambio
integer x = 1865
integer y = 1728
end type

type pb_modificar from w_manto`pb_modificar within w_manto_tipocambio
integer x = 1001
integer y = 1576
end type

type pb_ventana_y_libreria from w_manto`pb_ventana_y_libreria within w_manto_tipocambio
end type

