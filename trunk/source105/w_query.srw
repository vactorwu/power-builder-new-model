HA$PBExportHeader$w_query.srw
forward
global type w_query from window
end type
type cb_rollback from commandbutton within w_query
end type
type cb_commit from commandbutton within w_query
end type
type st_filas from statictext within w_query
end type
type pb_cancel from picturebutton within w_query
end type
type pb_saveas from picturebutton within w_query
end type
type pb_retrieve from picturebutton within w_query
end type
type dw_query from datawindow within w_query
end type
type mle_1 from multilineedit within w_query
end type
end forward

global type w_query from window
integer width = 2821
integer height = 2228
boolean titlebar = true
string title = "PR0666 - Ventana de Ejecucion de Querys"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "Query5!"
boolean center = true
cb_rollback cb_rollback
cb_commit cb_commit
st_filas st_filas
pb_cancel pb_cancel
pb_saveas pb_saveas
pb_retrieve pb_retrieve
dw_query dw_query
mle_1 mle_1
end type
global w_query w_query

type variables
String  is_OrderCol , is_SortType
Boolean ib_cancelar=false
end variables

on w_query.create
this.cb_rollback=create cb_rollback
this.cb_commit=create cb_commit
this.st_filas=create st_filas
this.pb_cancel=create pb_cancel
this.pb_saveas=create pb_saveas
this.pb_retrieve=create pb_retrieve
this.dw_query=create dw_query
this.mle_1=create mle_1
this.Control[]={this.cb_rollback,&
this.cb_commit,&
this.st_filas,&
this.pb_cancel,&
this.pb_saveas,&
this.pb_retrieve,&
this.dw_query,&
this.mle_1}
end on

on w_query.destroy
destroy(this.cb_rollback)
destroy(this.cb_commit)
destroy(this.st_filas)
destroy(this.pb_cancel)
destroy(this.pb_saveas)
destroy(this.pb_retrieve)
destroy(this.dw_query)
destroy(this.mle_1)
end on

event open;/*****************************************************************************
Motivo                   	: PR0666 - EJECUCION DE CONSULTAS EN QA
Especificado por    : JUAN VALVERDE
Creado por      		: JUAN LAM
Descripci$$HEX1$$f300$$ENDHEX$$n           	: VENTANA DE EJECUCION DE CONSULTAS
Fecha                   	: 18/07/2007
******************************************************************************/
end event

type cb_rollback from commandbutton within w_query
integer x = 1353
integer y = 448
integer width = 283
integer height = 96
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Rollback"
end type

event clicked;rollback;

IF SQLCA.SQLCODE < 0 THEN
				messagebox("Error",Sqlca.SqlerrText,StopSign!)
ELSE
  messagebox("Aviso","Reversi$$HEX1$$f300$$ENDHEX$$n Exitosa")
END IF

end event

type cb_commit from commandbutton within w_query
integer x = 1829
integer y = 448
integer width = 256
integer height = 96
integer taborder = 30
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Commit"
end type

event clicked;String 	ls_sql_syntax, ls_style, ls_dw_syntax, ls_dw_err

ls_sql_syntax = mle_1.text

EXECUTE IMMEDIATE :ls_sql_syntax USING sqlca;

IF SQLCA.SQLCODE < 0 THEN
				messagebox("Error",Sqlca.SqlerrText,StopSign!)
				rollback;
ELSE
	COMMIT;
	messagebox("Aviso","Actualizaci$$HEX1$$f300$$ENDHEX$$n Exitosa")
END IF


end event

type st_filas from statictext within w_query
integer x = 416
integer y = 452
integer width = 887
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Filas recuperadas: "
boolean focusrectangle = false
end type

type pb_cancel from picturebutton within w_query
integer x = 146
integer y = 440
integer width = 101
integer height = 88
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "RetrieveCancel!"
alignment htextalign = left!
string powertiptext = "Cancelar Consulta"
end type

event clicked; ib_cancelar=True
end event

type pb_saveas from picturebutton within w_query
integer x = 270
integer y = 440
integer width = 101
integer height = 88
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "SaveAs!"
alignment htextalign = left!
string powertiptext = "Guardar Como ...?"
end type

event clicked;dw_query.saveas()
end event

type pb_retrieve from picturebutton within w_query
integer x = 23
integer y = 444
integer width = 101
integer height = 88
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "Retrieve5!"
alignment htextalign = left!
string powertiptext = "Ejecutar Consulta"
end type

event clicked;String 	ls_sql_syntax, ls_style, ls_dw_syntax, ls_dw_err

ib_cancelar = FALSE
st_filas.text = "Filas recuperadas: 0" 
	
IF mle_1.text = "" THEN
	MessageBox("Lo Sentimos!", "No existe sintaxis.Ingrese una sentencia SQL Valida ")
	RETURN
END IF

ls_style = "style(type=grid) Text(Border=6 Font.Weight=700 Font.Face='Courier New' Font.Family=0 Font.Height=-8  Alignment=2)"

ls_sql_syntax = mle_1.text
ls_dw_err = ""
ls_dw_syntax = SyntaxFromSQL(sqlca, ls_sql_syntax, ls_style, ls_dw_err)
IF ls_dw_err <> "" THEN
	MessageBox("Lo Sentimos!", ls_dw_err)
	Return
END IF

dw_query.CREATE(ls_dw_syntax)

dw_query.SetTransObject(sqlca)

dw_query.Object.DataWindow.Header.Color = PARENT.Backcolor

dw_query.Retrieve( )

end event

type dw_query from datawindow within w_query
integer x = 32
integer y = 540
integer width = 2665
integer height = 1564
integer taborder = 20
string title = "none"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;string ls_AddPict, ls_CurObj, ls_Picture, ls_CurCol , ls_Protegida , ls_Eval
integer li_PictPos,li_i
Long ll_Row

		ls_CurObj = String(dwo.Name)
		IF Row = 0 AND THIS.DESCRIBE(ls_CurObj + ".Text") <> "!" AND THIS.DESCRIBE(ls_CurObj + ".Band") = "header" THEN // Valid header object?
		ls_CurCol = Left(ls_CurObj,Len(ls_CurObj) - 2)
		IF is_OrderCol <> ls_CurCol THEN // DIFferent Column
			THIS.ModIFy("DESTROY p_" + is_OrderCol)
			is_OrderCol = Left(ls_CurObj,Len(ls_CurObj) - 2)
			//segun sistema operativo
			//ls_Picture = "ORDERUP.BMP"
			ls_Picture = "UP.BMP"
			is_SortType = "A" // AscENDing sort
			li_PictPos = Integer(THIS.DESCRIBE(ls_CurObj + ".X"))+ (Integer(THIS.DESCRIBE(ls_CurObj + ".Width")) - 70)
			ls_AddPict ='create bitmap(band=FOReground filename="' + ls_Picture + '" ' + &
							' x="' + String(li_PictPos) + "~tInteger(DESCRIBE('" + is_OrderCol + & 
							".X')) + (Integer(DESCRIBE('" + is_OrderCol + ".Width'))" + ' - 70)" y="24" ' + &
							' height="33" width="51" border="0" name=p_' + is_OrderCol + ' visible="1")'
			THIS.ModIFy(ls_AddPict)
			THIS.SetSort(is_OrderCol + " " + is_SortType)
			THIS.Sort()
		ELSE
			IF is_SortType = "A" THEN
				//segun sistema orerativo
				//ls_Picture = "ORDERDW.BMP"
				ls_Picture = "Down.BMP"
				is_SortType = "D"
			ELSE
				//segun sistema orerativo
				//ls_Picture = "ORDERUP.BMP"
				ls_Picture = "UP.BMP"
				is_SortType = "A"
			END IF
			THIS.ModIFy('p_' + is_OrderCol + '.filename = "' + ls_Picture + '"')
			THIS.SetSort(is_OrderCol + " " + is_SortType)
			THIS.Sort()
		END IF
		END IF

	


end event

event retrieverow;this.ScrollNextRow( )

// Display a running count of rows retrieved
if Not ib_cancelar then	
	st_filas.text = "Filas recuperadas: " +String(This.RowCount( ))
end if

If  ib_cancelar Then
	ib_cancelar = false
	Return 1
End If
end event

type mle_1 from multilineedit within w_query
integer x = 18
integer y = 28
integer width = 2651
integer height = 408
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "Courier New"
long textcolor = 8388608
string text = "SELECT SYSDATE AS FECHA, USER AS USUARIO FROM DUAL "
boolean hscrollbar = true
boolean vscrollbar = true
boolean autohscroll = true
boolean autovscroll = true
textcase textcase = upper!
borderstyle borderstyle = stylelowered!
end type

