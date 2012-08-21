HA$PBExportHeader$w_print.srw
$PBExportComments$opciones de impresi$$HEX1$$f300$$ENDHEX$$n
forward
global type w_print from window
end type
type em_copies from editmask within w_print
end type
type p_intercalar from picture within w_print
end type
type st_drivers from statictext within w_print
end type
type st_driver from statictext within w_print
end type
type cb_1 from commandbutton within w_print
end type
type st_puerto from statictext within w_print
end type
type st_impresora from statictext within w_print
end type
type st_ubicacion from statictext within w_print
end type
type st_tipo from statictext within w_print
end type
type st_1 from statictext within w_print
end type
type ddplb_impresoras from dropdownpicturelistbox within w_print
end type
type cb_file from commandbutton within w_print
end type
type st_print_file from statictext within w_print
end type
type st_pf from statictext within w_print
end type
type ddlb_range from dropdownlistbox within w_print
end type
type st_4 from statictext within w_print
end type
type cb_printer from commandbutton within w_print
end type
type cb_cancel from commandbutton within w_print
end type
type cbx_collate from checkbox within w_print
end type
type cbx_print_to_file from checkbox within w_print
end type
type st_3 from statictext within w_print
end type
type sle_page_range from singlelineedit within w_print
end type
type rb_pages from radiobutton within w_print
end type
type rb_current_page from radiobutton within w_print
end type
type rb_all from radiobutton within w_print
end type
type st_2 from statictext within w_print
end type
type sle_printer from singlelineedit within w_print
end type
type cb_ok from commandbutton within w_print
end type
type gb_impresora from groupbox within w_print
end type
type gb_copias from groupbox within w_print
end type
type gb_intervalo from groupbox within w_print
end type
end forward

global type w_print from window
integer x = 453
integer y = 540
integer width = 2688
integer height = 2476
boolean titlebar = true
string title = "Opciones de Impresi$$HEX1$$f300$$ENDHEX$$n"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
em_copies em_copies
p_intercalar p_intercalar
st_drivers st_drivers
st_driver st_driver
cb_1 cb_1
st_puerto st_puerto
st_impresora st_impresora
st_ubicacion st_ubicacion
st_tipo st_tipo
st_1 st_1
ddplb_impresoras ddplb_impresoras
cb_file cb_file
st_print_file st_print_file
st_pf st_pf
ddlb_range ddlb_range
st_4 st_4
cb_printer cb_printer
cb_cancel cb_cancel
cbx_collate cbx_collate
cbx_print_to_file cbx_print_to_file
st_3 st_3
sle_page_range sle_page_range
rb_pages rb_pages
rb_current_page rb_current_page
rb_all rb_all
st_2 st_2
sle_printer sle_printer
cb_ok cb_ok
gb_impresora gb_impresora
gb_copias gb_copias
gb_intervalo gb_intervalo
end type
global w_print w_print

type variables
string is_page_range
datawindow idw_dw
s_printer is_printer
protected:
n_printer inv_printUtilities
string    is_selectedPrinter  // current selected printer
string    is_originalPrinter  // original printer 
                              // (saved in case user cancels dialog)
end variables

forward prototypes
private subroutine wf_page_range (radiobutton who)
public subroutine wf_enable_printfile ()
public subroutine wf_disable_printfile ()
end prototypes

private subroutine wf_page_range (radiobutton who);choose case who
	case rb_all
		sle_page_range.text = ''
		sle_page_range.enabled = false
		is_page_range = 'a'
	case rb_current_page
		sle_page_range.text = ''
		sle_page_range.enabled = false
		is_page_range = 'c'
	case rb_pages		
		sle_page_range.enabled = true
		is_page_range = 'p'
end choose
end subroutine

public subroutine wf_enable_printfile ();//show all items related to choosing a file
st_pf.visible = true
st_print_file.visible = true
cb_file.visible = true
end subroutine

public subroutine wf_disable_printfile ();//hide all items related to choosing a file
st_pf.visible = false
st_print_file.visible = false
cb_file.visible = false
st_print_file.text = ''
end subroutine

event open;

// we assume that this window will be opened using openwitparm and that
// a datawindow control will be passed to it

string ls_rc

idw_dw = message.powerobjectparm
sle_printer.text = idw_dw.describe('datawindow.printer')

//set the page print include (all,even,odd)

ls_rc = idw_dw.Describe('datawindow.print.page.rangeinclude')

choose case Left(ls_rc,1)  // determine rangeinclude (all,even,odd)
	case '0' // all
		ddlb_range.SelectItem(1) 
		is_page_range = 'a'
	case '1' // even
		ddlb_range.SelectItem(2) 
		is_page_range = 'e'
	case '2' //odd
		ddlb_range.SelectItem(3) 
		is_page_range = 'o'
end choose


//if cbx_collate.checked then // collate output

ls_rc = idw_dw.describe('datawindow.print.collate')

If ls_rc = "yes" Then
	cbx_collate.checked = True
ElseIf ls_rc = "no" Then
	cbx_collate.checked = False
End If


//page_range 
ls_rc = idw_dw.describe('datawindow.print.page.range')
If ls_rc = "" Then
	is_page_range = "a"
	rb_all.checked = true
Else
	is_page_range = "p"
	rb_pages.checked =true
	sle_page_range.text = ls_rc
End If

//// number of copies ?
ls_rc = idw_dw.describe('datawindow.print.copies')

//copies = 0 is actually 1 copy.....

If ls_rc = "0" Then ls_rc = "1"
em_copies.text = ls_rc

//print to file ?
ls_rc = idw_dw.describe('datawindow.print.filename')
If ls_rc <> "" and ls_rc <>"!"Then 
	cbx_print_to_file.checked = True
	wf_enable_printfile()
	//strip the ~'s out of the file name to display properly
	ls_rc = af_global_replace(ls_rc,"~~","")
	st_print_file.text = ls_rc
Else
	cbx_print_to_file.checked = False
	wf_disable_printfile()
End If


end event

on w_print.create
this.em_copies=create em_copies
this.p_intercalar=create p_intercalar
this.st_drivers=create st_drivers
this.st_driver=create st_driver
this.cb_1=create cb_1
this.st_puerto=create st_puerto
this.st_impresora=create st_impresora
this.st_ubicacion=create st_ubicacion
this.st_tipo=create st_tipo
this.st_1=create st_1
this.ddplb_impresoras=create ddplb_impresoras
this.cb_file=create cb_file
this.st_print_file=create st_print_file
this.st_pf=create st_pf
this.ddlb_range=create ddlb_range
this.st_4=create st_4
this.cb_printer=create cb_printer
this.cb_cancel=create cb_cancel
this.cbx_collate=create cbx_collate
this.cbx_print_to_file=create cbx_print_to_file
this.st_3=create st_3
this.sle_page_range=create sle_page_range
this.rb_pages=create rb_pages
this.rb_current_page=create rb_current_page
this.rb_all=create rb_all
this.st_2=create st_2
this.sle_printer=create sle_printer
this.cb_ok=create cb_ok
this.gb_impresora=create gb_impresora
this.gb_copias=create gb_copias
this.gb_intervalo=create gb_intervalo
this.Control[]={this.em_copies,&
this.p_intercalar,&
this.st_drivers,&
this.st_driver,&
this.cb_1,&
this.st_puerto,&
this.st_impresora,&
this.st_ubicacion,&
this.st_tipo,&
this.st_1,&
this.ddplb_impresoras,&
this.cb_file,&
this.st_print_file,&
this.st_pf,&
this.ddlb_range,&
this.st_4,&
this.cb_printer,&
this.cb_cancel,&
this.cbx_collate,&
this.cbx_print_to_file,&
this.st_3,&
this.sle_page_range,&
this.rb_pages,&
this.rb_current_page,&
this.rb_all,&
this.st_2,&
this.sle_printer,&
this.cb_ok,&
this.gb_impresora,&
this.gb_copias,&
this.gb_intervalo}
end on

on w_print.destroy
destroy(this.em_copies)
destroy(this.p_intercalar)
destroy(this.st_drivers)
destroy(this.st_driver)
destroy(this.cb_1)
destroy(this.st_puerto)
destroy(this.st_impresora)
destroy(this.st_ubicacion)
destroy(this.st_tipo)
destroy(this.st_1)
destroy(this.ddplb_impresoras)
destroy(this.cb_file)
destroy(this.st_print_file)
destroy(this.st_pf)
destroy(this.ddlb_range)
destroy(this.st_4)
destroy(this.cb_printer)
destroy(this.cb_cancel)
destroy(this.cbx_collate)
destroy(this.cbx_print_to_file)
destroy(this.st_3)
destroy(this.sle_page_range)
destroy(this.rb_pages)
destroy(this.rb_current_page)
destroy(this.rb_all)
destroy(this.st_2)
destroy(this.sle_printer)
destroy(this.cb_ok)
destroy(this.gb_impresora)
destroy(this.gb_copias)
destroy(this.gb_intervalo)
end on

type em_copies from editmask within w_print
integer x = 2130
integer y = 672
integer width = 443
integer height = 88
integer taborder = 90
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Trebuchet MS"
long textcolor = 33554432
long backcolor = 16777215
string text = "1"
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "####"
boolean spin = true
double increment = 1
string minmax = "1~~"
end type

type p_intercalar from picture within w_print
integer x = 1399
integer y = 756
integer width = 517
integer height = 300
boolean originalsize = true
string picturename = "IntercalarSi.bmp"
boolean focusrectangle = false
end type

type st_drivers from statictext within w_print
integer x = 370
integer y = 404
integer width = 1632
integer height = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Trebuchet MS"
long textcolor = 33554432
long backcolor = 67108864
boolean focusrectangle = false
end type

type st_driver from statictext within w_print
integer x = 69
integer y = 404
integer width = 293
integer height = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Trebuchet MS"
long textcolor = 33554432
long backcolor = 67108864
string text = "Driver:"
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_print
integer x = 2071
integer y = 80
integer width = 530
integer height = 92
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Trebuchet MS"
string text = "&Propiedades"
end type

event clicked;inv_printUtilities.setupPrinter(is_selectedPrinter)
end event

type st_puerto from statictext within w_print
integer x = 370
integer y = 304
integer width = 1632
integer height = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Trebuchet MS"
long textcolor = 33554432
long backcolor = 67108864
boolean focusrectangle = false
end type

type st_impresora from statictext within w_print
integer x = 370
integer y = 208
integer width = 1632
integer height = 64
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Trebuchet MS"
long textcolor = 33554432
long backcolor = 67108864
boolean focusrectangle = false
end type

type st_ubicacion from statictext within w_print
integer x = 69
integer y = 304
integer width = 293
integer height = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Trebuchet MS"
long textcolor = 33554432
long backcolor = 67108864
string text = "Ubicaci$$HEX1$$f300$$ENDHEX$$n:"
boolean focusrectangle = false
end type

type st_tipo from statictext within w_print
integer x = 69
integer y = 208
integer width = 293
integer height = 64
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Trebuchet MS"
long textcolor = 33554432
long backcolor = 67108864
string text = "Tipo:"
boolean focusrectangle = false
end type

type st_1 from statictext within w_print
integer x = 69
integer y = 92
integer width = 293
integer height = 52
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Trebuchet MS"
long textcolor = 33554432
long backcolor = 67108864
string text = "&Nombre:"
boolean focusrectangle = false
end type

type ddplb_impresoras from dropdownpicturelistbox within w_print
integer x = 370
integer y = 80
integer width = 1632
integer height = 400
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Trebuchet MS"
long textcolor = 33554432
boolean sorted = false
boolean hscrollbar = true
boolean vscrollbar = true
integer accelerator = 110
borderstyle borderstyle = stylelowered!
string picturename[] = {"Print!","Custom074!","Report!","Report5!"}
long picturemaskcolor = 536870912
end type

event constructor;long   ll_numPrinters
Int    li
long   ll_currentPrinterIndex

// coge la  alctual impresora ( y lo guarda para despues)
is_originalPrinter = inv_printUtilities.getCurrentPrinter(FALSE)

inv_printUtilities.getPrinters(is_printer)

If is_printer.d_impresoras > 0 Then

 For li=1 to is_printer.d_impresoras
	ddplb_impresoras.additem (is_printer.s_impresora[li],1)
 Next
ll_currentPrinterIndex = ddplb_impresoras.FindItem(is_originalPrinter,1)
ddplb_impresoras.selectitem(ll_currentPrinterIndex)
st_impresora.text = is_printer.s_impresora[ll_currentPrinterIndex]
st_puerto.text = is_printer.s_puerto[ll_currentPrinterIndex]
st_drivers.text = is_printer.s_driver[ll_currentPrinterIndex]
is_selectedPrinter = is_originalPrinter
End IF
end event

event selectionchanged;is_selectedPrinter =  this.text
st_impresora.text = is_printer.s_impresora[index]
st_puerto.text    = is_printer.s_puerto[index]
st_drivers.text   = is_printer.s_driver[index]
//Messagebox("",is_selectedPrinter)
inv_printUtilities.setCurrentPrinter(is_selectedPrinter)



end event

type cb_file from commandbutton within w_print
integer x = 1618
integer y = 1892
integer width = 297
integer height = 92
integer taborder = 130
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Trebuchet MS"
string text = "Archivo..."
end type

on clicked;string ls_temp 
string ls_file
int li_rc
li_rc = GetFileSaveName("Print To File", ls_file, ls_temp, "PRN", "Print (*.PRN),*.PRN")

If li_rc = 1 Then	st_print_file.text = ls_file
end on

type st_print_file from statictext within w_print
integer x = 549
integer y = 1900
integer width = 1006
integer height = 80
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Trebuchet MS"
long textcolor = 33554432
long backcolor = 16777215
boolean enabled = false
boolean border = true
boolean focusrectangle = false
end type

type st_pf from statictext within w_print
integer x = 87
integer y = 1912
integer width = 425
integer height = 72
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Trebuchet MS"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Imprimir a archivo:"
alignment alignment = right!
boolean focusrectangle = false
end type

type ddlb_range from dropdownlistbox within w_print
integer x = 398
integer y = 1180
integer width = 937
integer height = 352
integer taborder = 120
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Trebuchet MS"
long textcolor = 33554432
long backcolor = 16777215
string text = "Todas las p$$HEX1$$e100$$ENDHEX$$ginas en el rango"
boolean sorted = false
boolean vscrollbar = true
string item[] = {"Todo las p$$HEX1$$e100$$ENDHEX$$ginas del intervalo","P$$HEX1$$e100$$ENDHEX$$ginas pares","P$$HEX1$$e100$$ENDHEX$$ginas impares"}
borderstyle borderstyle = stylelowered!
end type

event constructor;ddlb_range.selectitem(1)
end event

type st_4 from statictext within w_print
integer x = 32
integer y = 1196
integer width = 407
integer height = 72
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Trebuchet MS"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Imprimi&r s$$HEX1$$f300$$ENDHEX$$lo:"
boolean focusrectangle = false
end type

type cb_printer from commandbutton within w_print
integer x = 2030
integer y = 1752
integer width = 443
integer height = 92
integer taborder = 110
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Trebuchet MS"
string text = "&Impresora..."
end type

event clicked;printsetup()
sle_printer.text = idw_dw.describe('datawindow.printer')
end event

type cb_cancel from commandbutton within w_print
integer x = 2194
integer y = 1212
integer width = 443
integer height = 92
integer taborder = 100
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Trebuchet MS"
string text = "&Cancelar"
boolean cancel = true
end type

on clicked;closewithreturn(parent,-1)
end on

type cbx_collate from checkbox within w_print
integer x = 2203
integer y = 876
integer width = 398
integer height = 72
integer taborder = 80
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Trebuchet MS"
long textcolor = 33554432
long backcolor = 67108864
string text = "Int&ercalar"
boolean checked = true
end type

event clicked;If this.checked =  true then
	p_intercalar.picturename = "IntercalarSi.bmp"
Else
	p_intercalar.picturename = "IntercalarNo.bmp"	
End If
end event

type cbx_print_to_file from checkbox within w_print
integer x = 2066
integer y = 440
integer width = 553
integer height = 72
integer taborder = 70
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Trebuchet MS"
long textcolor = 33554432
long backcolor = 67108864
string text = "I&mprimir a archivo"
end type

on clicked;If this.checked Then
	wf_enable_printfile()
Else
	wf_disable_printfile()
End If
end on

type st_3 from statictext within w_print
integer x = 73
integer y = 984
integer width = 1221
integer height = 144
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Trebuchet MS"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Escriba n$$HEX1$$fa00$$ENDHEX$$meros de p$$HEX1$$e100$$ENDHEX$$ginas e intervalos separados por comas. Por ejemplo,  1,3,5-12,14"
boolean focusrectangle = false
end type

type sle_page_range from singlelineedit within w_print
integer x = 434
integer y = 872
integer width = 832
integer height = 80
integer taborder = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Trebuchet MS"
long textcolor = 33554432
long backcolor = 16777215
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type rb_pages from radiobutton within w_print
integer x = 69
integer y = 876
integer width = 411
integer height = 72
integer taborder = 50
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Trebuchet MS"
long textcolor = 33554432
long backcolor = 67108864
string text = "P$$HEX1$$e100$$ENDHEX$$gin&as:"
end type

on clicked;wf_page_range(this)
end on

type rb_current_page from radiobutton within w_print
integer x = 69
integer y = 772
integer width = 475
integer height = 72
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Trebuchet MS"
long textcolor = 33554432
long backcolor = 67108864
string text = "P$$HEX1$$e100$$ENDHEX$$gina actua&l"
end type

on clicked;wf_page_range(this)
end on

type rb_all from radiobutton within w_print
integer x = 69
integer y = 672
integer width = 251
integer height = 72
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Trebuchet MS"
long textcolor = 33554432
long backcolor = 67108864
string text = "&Todo"
boolean checked = true
end type

on clicked;wf_page_range(this)
end on

type st_2 from statictext within w_print
integer x = 1399
integer y = 672
integer width = 521
integer height = 72
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Trebuchet MS"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "N$$HEX1$$fa00$$ENDHEX$$mero de &copias:"
boolean focusrectangle = false
end type

type sle_printer from singlelineedit within w_print
integer x = 133
integer y = 2176
integer width = 1001
integer height = 84
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Trebuchet MS"
long backcolor = 67108864
boolean border = false
boolean autohscroll = false
boolean displayonly = true
end type

type cb_ok from commandbutton within w_print
integer x = 1728
integer y = 1212
integer width = 443
integer height = 92
integer taborder = 90
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Trebuchet MS"
string text = "&Aceptar"
boolean default = true
end type

event clicked;string tmp, command
long row 
string	docname, named
int	value


choose case lower(left(ddlb_range.text,1)) // determine rangeinclude (all,even,odd)
	case 't' // all
		tmp = '0'
	case 'p' // even
		tmp = '1'
	case 'i' //odd
		tmp = '2'
end choose
command = 'datawindow.print.page.rangeinclude = '+tmp

if cbx_collate.checked then // collate output ?
	command = command +  " datawindow.print.collate = yes"
else
	command = command +  " datawindow.print.collate = no"
end if
choose case is_page_range // did they pick a page range?
	case 'a'  // all
		tmp = ''
	case 'c' // current page?
		row = idw_dw.getrow()
		tmp = idw_dw.describe("evaluate('page()',"+string(row)+")")
	case 'p' // a range?
		tmp = sle_page_range.text
end choose		
command = command +  " datawindow.print.page.range = '"+tmp+"'"

// number of copies ?
if len(em_copies.text) > 0 then command = command +  " datawindow.print.copies = "+em_copies.text

If cbx_print_to_file.checked  and st_print_file.text = "" Then // print to file and no file seleted yet?
	value = GetFileSaveName("Print To File", docname, named, "PRN", "Print (*.PRN),*.PRN")
	if value = 1 then 
		st_print_file.text= docname
	else // they canceled out of the dialog so quit completely
		return
	end if
end if

If cbx_print_to_file.checked Then
	command = command + " datawindow.print.filename = '"+st_print_file.text+"'"
Else
	command = command + " datawindow.print.filename = '' "
End If

// now alter the datawindow
tmp = idw_dw.modify(command)
if len(tmp) > 0 then // if error the display the 
	messagebox('Error Setting Print Options','Error message = ' + tmp + '~r~nCommand = ' + command)
	return
end if
closewithreturn(parent,1)

end event

type gb_impresora from groupbox within w_print
integer x = 27
integer y = 24
integer width = 2629
integer height = 532
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Trebuchet MS"
long textcolor = 33554432
long backcolor = 67108864
string text = "Impresora"
end type

type gb_copias from groupbox within w_print
integer x = 1353
integer y = 556
integer width = 1303
integer height = 600
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Trebuchet MS"
long textcolor = 33554432
long backcolor = 67108864
string text = "Intervalo de p$$HEX1$$e100$$ENDHEX$$ginas"
end type

type gb_intervalo from groupbox within w_print
integer x = 32
integer y = 556
integer width = 1303
integer height = 600
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Trebuchet MS"
long textcolor = 33554432
long backcolor = 67108864
string text = "Intervalo de p$$HEX1$$e100$$ENDHEX$$ginas"
end type

