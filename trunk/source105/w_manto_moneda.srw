HA$PBExportHeader$w_manto_moneda.srw
forward
global type w_manto_moneda from w_manto
end type
end forward

global type w_manto_moneda from w_manto
integer width = 2711
integer height = 2232
string title = "Cat$$HEX1$$e100$$ENDHEX$$logo de Monedas"
string is_tabla = "MONEDA"
string is_campocod = "CodMoneda"
string is_campoid = "IdMoneda"
integer ii_largocod = 3
string is_campofinal = "estado"
end type
global w_manto_moneda w_manto_moneda

on w_manto_moneda.create
int iCurrent
call super::create
end on

on w_manto_moneda.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type gb_comandos from w_manto`gb_comandos within w_manto_moneda
integer x = 311
integer y = 1512
integer width = 2048
integer height = 528
end type

type tab_todo from w_manto`tab_todo within w_manto_moneda
integer x = 0
integer width = 2674
integer height = 2052
end type

type tp_lista from w_manto`tp_lista within tab_todo
integer width = 2638
integer height = 1924
string text = "Lista de Monedas"
end type

type dw_lista from w_manto`dw_lista within tp_lista
integer width = 2642
integer height = 1068
string dataobject = "d_moneda_lista"
end type

event dw_lista::ue_refresh;call super::ue_refresh;idw_lista.retrieve( )
end event

event dw_lista::ue_getid;call super::ue_getid;id_Codigo=this.object.IdMoneda [this.getrow()]	
end event

type am_1 from w_manto`am_1 within tp_lista
end type

type st_2 from w_manto`st_2 within tp_lista
end type

type st_1 from w_manto`st_1 within tp_lista
end type

type rb_filtro from w_manto`rb_filtro within tp_lista
integer x = 1408
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

type tp_manto from w_manto`tp_manto within tab_todo
integer width = 2638
integer height = 1924
string text = "Datos de Moneda"
end type

type dw_manto from w_manto`dw_manto within tp_manto
integer y = 24
integer width = 2638
integer height = 1076
string dataobject = "d_moneda_manto"
end type

event dw_manto::ue_saveprevious;call super::ue_saveprevious;dwItemStatus	le_status
String ls_Actual, ls_Original,ls_Codigo

this.accepttext( )

le_status = this.GetItemStatus (this.GetRow(), 0, primary!)

ls_Actual   = this.Object.nombre.Primary.Current[this.GetRow()]
ls_Original = this.Object.nombre.Primary.Original[this.GetRow()]

il_Fila = idw_lista.find( " nombre = '"+ls_Actual+"'",1,idw_lista.rowcount())

choose case le_status	
	case new!,newmodified!
			If il_Fila > 0 then
				ls_Codigo = idw_lista.Object.codmoneda[il_Fila]
				messagebox("Advertecia " + Gn_Config.Is_Work.Aplicacion  ,"Nombre ya existe......!!!"+char(13)+"Fila : "+String(il_Fila)+"  C$$HEX1$$f300$$ENDHEX$$digo : "+ls_Codigo,Exclamation!)
				this.setcolumn('nombre')
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
				messagebox("Advertecia " + Gn_Config.Is_Work.Aplicacion  ,"Nombre ya existe......!!!"+char(13)+"Fila : "+String(il_Fila)+"  C$$HEX1$$f300$$ENDHEX$$digo : "+ls_Codigo,Exclamation!)
				this.setcolumn('nombre')
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

event dw_manto::ue_saveafter;call super::ue_saveafter;	if (idw_activa.enabled = false) then
		string Codigo
		if idw_activa.rowcount( ) > 0 then
			id_Codigo = idw_activa.GetItemDecimal(idw_activa.getrow(),Is_CampoId)
			Codigo = idw_activa.GetItemString(idw_activa.getrow(),Is_CampoCod)
			idw_activa.setredraw(false )
			idw_lista.setredraw( false )
			If modificado then
				idw_lista.reselectrow(idw_lista.getrow())
			Else
				idw_lista.event ue_refresh( )
				//idw_lista.retrieve(gn_config.is_work.empresa)
			End If
			idw_lista.ScrollToRow(idw_lista.find( Is_CampoCod+" = '"+Codigo+"'",1,idw_lista.rowcount()))
			idw_activa.setredraw(true)
			idw_lista.setredraw(true)
			wf_botones ('Save')
			idw_lista.enabled =  true
		End IF
	end if
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

type shl_cerrar from w_manto`shl_cerrar within w_manto_moneda
integer x = 1957
integer y = 1728
end type

type shl_grabar from w_manto`shl_grabar within w_manto_moneda
integer x = 1335
integer y = 1728
end type

type shl_eliminar from w_manto`shl_eliminar within w_manto_moneda
integer x = 1024
integer y = 1728
end type

type shl_modificar from w_manto`shl_modificar within w_manto_moneda
integer x = 713
integer y = 1728
end type

type shl_nuevo from w_manto`shl_nuevo within w_manto_moneda
integer x = 402
integer y = 1728
end type

type uo_nav from w_manto`uo_nav within w_manto_moneda
integer x = 603
integer y = 1868
end type

type pb_cancelar from w_manto`pb_cancelar within w_manto_moneda
integer x = 1714
integer y = 1576
end type

type pb_grabar from w_manto`pb_grabar within w_manto_moneda
integer x = 1403
integer y = 1576
end type

type pb_eliminar from w_manto`pb_eliminar within w_manto_moneda
integer x = 1093
integer y = 1576
end type

type pb_nuevo from w_manto`pb_nuevo within w_manto_moneda
integer x = 471
integer y = 1576
end type

type pb_cerrar from w_manto`pb_cerrar within w_manto_moneda
integer x = 2025
integer y = 1576
end type

type shl_cancelar from w_manto`shl_cancelar within w_manto_moneda
integer x = 1646
integer y = 1728
end type

type pb_modificar from w_manto`pb_modificar within w_manto_moneda
integer x = 782
integer y = 1576
end type

