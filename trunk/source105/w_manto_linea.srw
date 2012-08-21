HA$PBExportHeader$w_manto_linea.srw
forward
global type w_manto_linea from w_manto
end type
type pb_antes from picturebutton within tp_lista
end type
end forward

global type w_manto_linea from w_manto
integer width = 2747
integer height = 2404
string title = "Cat$$HEX1$$e100$$ENDHEX$$logo de Lineas"
string is_tabla = "LINEA"
string is_campocod = "CodLinea"
string is_campoid = "IdLinea"
integer ii_largocod = 3
string is_campofinal = "estado"
end type
global w_manto_linea w_manto_linea

type variables
Decimal  id_idlinea[], id_idlinea_ant[] ,   id_idSub 
String is_codlinea[] 
int ii_nivel
end variables

forward prototypes
public subroutine wf_datos_adicionales ()
end prototypes

public subroutine wf_datos_adicionales ();
dwItemStatus l_status

l_status = idw_activa.GetItemStatus( idw_activa.getrow() , 0, Primary!)

choose case l_status
	case New!, NewModified!
		     
			If ii_nivel>0 then 
				idw_activa.setitem(idw_activa.getrow(),'idsublinea',id_idlinea[ii_nivel] )
				idw_activa.setitem(idw_activa.getrow(),'codsublinea',is_codlinea[ii_nivel] )				
			ElseIf ii_nivel<=0 then 
				SetNull(id_idSub)
				idw_activa.setitem(idw_activa.getrow(),'idsublinea',id_idSub )
				idw_activa.setitem(idw_activa.getrow(),'codsublinea',id_idSub )
			End If
			idw_activa.Object.idEmpresa[idw_activa.getrow()]= gn_config.is_work.idempresa
end choose
end subroutine

on w_manto_linea.create
int iCurrent
call super::create
end on

on w_manto_linea.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type gb_comandos from w_manto`gb_comandos within w_manto_linea
integer x = 311
integer y = 1512
integer width = 2048
integer height = 528
end type

type tab_todo from w_manto`tab_todo within w_manto_linea
integer x = 0
integer width = 2674
integer height = 2052
end type

type tp_lista from w_manto`tp_lista within tab_todo
integer width = 2638
integer height = 1924
string text = "Lista de Lineas"
pb_antes pb_antes
end type

on tp_lista.create
this.pb_antes=create pb_antes
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_antes
end on

on tp_lista.destroy
call super::destroy
destroy(this.pb_antes)
end on

type dw_lista from w_manto`dw_lista within tp_lista
integer x = 9
integer width = 2560
integer height = 1068
string dataobject = "d_linea_lista"
end type

type am_1 from w_manto`am_1 within tp_lista
integer x = 2194
integer y = 44
end type

type st_2 from w_manto`st_2 within tp_lista
end type

type st_1 from w_manto`st_1 within tp_lista
end type

type rb_filtro from w_manto`rb_filtro within tp_lista
integer x = 1426
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

type tp_manto from w_manto`tp_manto within tab_todo
integer width = 2638
integer height = 1924
string text = "Datos de Linea"
end type

type dw_manto from w_manto`dw_manto within tp_manto
integer x = 9
integer y = 24
integer width = 2638
integer height = 876
string dataobject = "d_linea_manto"
end type

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

type shl_cerrar from w_manto`shl_cerrar within w_manto_linea
integer x = 1957
integer y = 1728
end type

type shl_grabar from w_manto`shl_grabar within w_manto_linea
integer x = 1335
integer y = 1728
end type

type shl_eliminar from w_manto`shl_eliminar within w_manto_linea
integer x = 1024
integer y = 1728
end type

type shl_modificar from w_manto`shl_modificar within w_manto_linea
integer x = 713
integer y = 1728
end type

type shl_nuevo from w_manto`shl_nuevo within w_manto_linea
integer x = 402
integer y = 1728
end type

type uo_nav from w_manto`uo_nav within w_manto_linea
integer x = 603
integer y = 1868
end type

type pb_cancelar from w_manto`pb_cancelar within w_manto_linea
integer x = 1714
integer y = 1576
end type

type pb_grabar from w_manto`pb_grabar within w_manto_linea
integer x = 1403
integer y = 1576
end type

type pb_eliminar from w_manto`pb_eliminar within w_manto_linea
integer x = 1093
integer y = 1576
end type

type pb_nuevo from w_manto`pb_nuevo within w_manto_linea
integer x = 471
integer y = 1576
end type

type pb_cerrar from w_manto`pb_cerrar within w_manto_linea
integer x = 2025
integer y = 1576
end type

type shl_cancelar from w_manto`shl_cancelar within w_manto_linea
integer x = 1646
integer y = 1728
end type

type pb_modificar from w_manto`pb_modificar within w_manto_linea
integer x = 782
integer y = 1576
end type

type pb_ventana_y_libreria from w_manto`pb_ventana_y_libreria within w_manto_linea
end type

type pb_antes from picturebutton within tp_lista
boolean visible = false
integer x = 2231
integer y = 196
integer width = 101
integer height = 88
integer taborder = 80
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "Courier New"
string picturename = "Custom036!"
end type

