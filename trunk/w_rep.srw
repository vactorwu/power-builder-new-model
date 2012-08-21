HA$PBExportHeader$w_rep.srw
forward
global type w_rep from w_reporte
end type
end forward

global type w_rep from w_reporte
end type
global w_rep w_rep

forward prototypes
public subroutine wf_retrieve ()
end prototypes

public subroutine wf_retrieve ();dw_reporte.retrieve()
end subroutine

on w_rep.create
call super::create
end on

on w_rep.destroy
call super::destroy
end on

type pb_mail from w_reporte`pb_mail within w_rep
end type

type pb_1 from w_reporte`pb_1 within w_rep
end type

type pb_saveas from w_reporte`pb_saveas within w_rep
end type

type pb_actualizar from w_reporte`pb_actualizar within w_rep
end type

type pb_ordenar from w_reporte`pb_ordenar within w_rep
end type

type pb_filtrar from w_reporte`pb_filtrar within w_rep
end type

type pb_final from w_reporte`pb_final within w_rep
end type

type pb_siguiente from w_reporte`pb_siguiente within w_rep
end type

type pb_anterior from w_reporte`pb_anterior within w_rep
end type

type pb_inicio from w_reporte`pb_inicio within w_rep
end type

type pb_print from w_reporte`pb_print within w_rep
end type

type pb_scala from w_reporte`pb_scala within w_rep
end type

type pb_zoom from w_reporte`pb_zoom within w_rep
end type

type dw_reporte from w_reporte`dw_reporte within w_rep
string dataobject = "d_reporte_kardex1"
end type

