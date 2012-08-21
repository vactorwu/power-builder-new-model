HA$PBExportHeader$w_mantotarjetatipo.srw
forward
global type w_mantotarjetatipo from w_manto
end type
end forward

global type w_mantotarjetatipo from w_manto
end type
global w_mantotarjetatipo w_mantotarjetatipo

forward prototypes
public subroutine wf_primarykey ()
public subroutine wf_datos ()
end prototypes

public subroutine wf_primarykey ();LONG LL_CODIGO,ll_maxlen
String ls_codigo,ls_aux,ls_pk
//***************************************************************************************************************************************************************************************
// Genero el primary key.
//***************************************************************************************************************************************************************************************
SELECT Max(tarjetatipo.codtarjetatipo)   INTO :ls_codigo  FROM tarjetatipo WHERE tarjetatipo.idempresa = :gn_config.is_config.empresa Using SQLCA  ;

ll_maxlen = 2

If IsNull(ls_codigo) or ls_codigo="" then
	ls_codigo = Mid('0000000000',1,ll_maxlen)
End If

ls_aux = Mid('0000000000',1,ll_maxlen)
ls_pk = String(Long(ls_codigo) + 1)
ls_codigo = Mid(ls_aux,1,ll_maxlen - len(ls_pk)) + ls_pk

idw_activa.setitem( idw_activa.getrow() ,'codigo', LS_CODIGO  )
end subroutine

public subroutine wf_datos ();dwItemStatus l_status
String ls_fecha,ls_hora
DateTime ldt_FechaSys
l_status = idw_activa.GetItemStatus( idw_activa.getrow() , 0, Primary!)

ldt_FechaSys = gn_config.of_datetime()

choose case l_status
	case New!, NewModified!
			idw_activa.setitem(idw_activa.getrow(),'fecharegistro',ldt_FechaSys)
			idw_activa.setitem(idw_activa.getrow(),'ultimamodificacion',ldt_FechaSys)
			idw_activa.setitem(idw_activa.getrow(),'usuario',gn_config.of_user())
			idw_activa.setitem(idw_activa.getrow(),'terminal',gn_config.of_terminal())
			idw_activa.setitem(idw_activa.getrow(),'idempresa',gn_config.is_config.empresa)
	case DataModified!
			idw_activa.setitem(idw_activa.getrow(),'ultimamodificacion',ldt_FechaSys)
			idw_activa.setitem(idw_activa.getrow(),'usuario',gn_config.of_user())
			idw_activa.setitem(idw_activa.getrow(),'terminal',gn_config.of_terminal())
end choose
end subroutine

on w_mantotarjetatipo.create
int iCurrent
call super::create
end on

on w_mantotarjetatipo.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event open;call super::open;is_campofinal = "estado"
end event

type gb_comandos from w_manto`gb_comandos within w_mantotarjetatipo
end type

type tab_todo from w_manto`tab_todo within w_mantotarjetatipo
end type

type tp_manto from w_manto`tp_manto within tab_todo
string text = "Datos de Tipo de Tarjeta"
end type

type dw_manto from w_manto`dw_manto within tp_manto
string dataobject = "d_tarjetatipo_manto"
end type

event dw_manto::ue_saveprevious;call super::ue_saveprevious;dwItemStatus	le_status
String ls_Actual, ls_Original,ls_Codigo

wf_datos()

this.accepttext( )

le_status = this.GetItemStatus (this.GetRow(), 0, primary!)

ls_Actual = this.Object.nombre.Primary.Current[this.GetRow()]
ls_Original = this.Object.nombre.Primary.Original[this.GetRow()]

il_Fila = idw_lista.find( " nombre = '"+ls_Actual+"'",1,idw_lista.rowcount())

choose case le_status	
	case new!,newmodified!
			If il_Fila > 0 then
				ls_Codigo = idw_lista.Object.codigo[il_Fila]
				messagebox("Advertecia " + Gn_Config.Is_Work.Aplicacion  ,"Nombre de Tipo de Tarjeta  ya existe......!!!"+char(13)+"Fila : "+String(il_Fila)+"  C$$HEX1$$f300$$ENDHEX$$digo : "+ls_Codigo,Exclamation!)
				this.setcolumn('nombre')
				this.SelectText(1, Len(this.GetText()))
				this.setfocus( )
				Return 0
			Else
				Return 1
			End If
		
	case	datamodified!
		If ls_Actual = ls_Original Then
			Return 1
		Else
			If il_Fila > 0 then
				ls_Codigo = idw_lista.Object.codigo[il_Fila]
				messagebox("Advertecia " + Gn_Config.Is_Work.Aplicacion  ,"Nombre de Tipo de Tarjeta  ya existe......!!!"+char(13)+"Fila : "+String(il_Fila)+"  C$$HEX1$$f300$$ENDHEX$$digo : "+ls_Codigo,Exclamation!)
				this.setcolumn('nombre')
				this.SelectText(1, Len(this.GetText()))
				this.setfocus( )
				Return 0
			Else
				Return 1
			End If
		End If
	case else 
		Return 1
end choose
end event

type pb_borrar from w_manto`pb_borrar within tp_manto
end type

type pb_abrir from w_manto`pb_abrir within tp_manto
end type

type ole_1 from w_manto`ole_1 within tp_manto
end type

type tp_lista from w_manto`tp_lista within tab_todo
string text = "Lista de Tipos de Tarjeta"
end type

type dw_lista from w_manto`dw_lista within tp_lista
string dataobject = "d_tarjetatipo_lista"
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

type shl_cerrar from w_manto`shl_cerrar within w_mantotarjetatipo
end type

type shl_grabar from w_manto`shl_grabar within w_mantotarjetatipo
end type

type shl_eliminar from w_manto`shl_eliminar within w_mantotarjetatipo
end type

type shl_modificar from w_manto`shl_modificar within w_mantotarjetatipo
end type

type shl_nuevo from w_manto`shl_nuevo within w_mantotarjetatipo
end type

type uo_nav from w_manto`uo_nav within w_mantotarjetatipo
end type

type pb_cancelar from w_manto`pb_cancelar within w_mantotarjetatipo
end type

type pb_grabar from w_manto`pb_grabar within w_mantotarjetatipo
end type

type pb_eliminar from w_manto`pb_eliminar within w_mantotarjetatipo
end type

type pb_nuevo from w_manto`pb_nuevo within w_mantotarjetatipo
end type

type pb_cerrar from w_manto`pb_cerrar within w_mantotarjetatipo
end type

type shl_cancelar from w_manto`shl_cancelar within w_mantotarjetatipo
end type

type pb_modificar from w_manto`pb_modificar within w_mantotarjetatipo
end type

