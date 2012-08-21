HA$PBExportHeader$w_ingresoseguro.srw
forward
global type w_ingresoseguro from w_response
end type
type st_ip from st_uo_transparent within w_ingresoseguro
end type
type st_hostname from st_uo_transparent within w_ingresoseguro
end type
type cb_cancel from u_cb within w_ingresoseguro
end type
type sle_password from u_sle within w_ingresoseguro
end type
type sle_userid from u_sle within w_ingresoseguro
end type
type cb_ok from u_cb within w_ingresoseguro
end type
type p_ingreso from picture within w_ingresoseguro
end type
end forward

global type w_ingresoseguro from w_response
integer width = 1897
integer height = 1072
boolean titlebar = false
string title = ""
boolean controlmenu = false
boolean border = false
windowtype windowtype = child!
boolean clientedge = true
boolean center = true
integer transparency = 50
windowanimationstyle openanimation = centeranimation!
st_ip st_ip
st_hostname st_hostname
cb_cancel cb_cancel
sle_password sle_password
sle_userid sle_userid
cb_ok cb_ok
p_ingreso p_ingreso
end type
global w_ingresoseguro w_ingresoseguro

type prototypes
Public Function Long GetWindowRect (Long hWnd, Ref s_RECT lpRect) Library "user32.dll" alias for "GetWindowRect;Ansi"
Public Function Long GetClientRect (Long hWnd,	Ref s_RECT lpRect) Library "user32.dll" alias for "GetClientRect;Ansi"

Public Function Long CreateEllipticRgn(Long nLeftRect, Long nTopRect, Long nRightRect, Long nBottomRect) Library "gdi32"
Public Function Long CreatePolygonRgn(Long nLeftRect, Long nTopRect, Long nRightRect, Long nBottomRect) Library "gdi32"
Public Function Long SetWindowRgn (Long hWnd, Long hRgn, Boolean bRedraw) Library "user32.dll"

Public Function Long SetWindowPos (Long hWnd, Long hWndInsertAfter, Long xx, Long yy, Long cx, Long cy, Long wFlags) library "user32.dll"

Private Function Long GetCursorPos (Ref s_POINTAPI lpPoint) Library "user32.dll" alias for "GetCursorPos;Ansi" 

Private Function Long SetCapture(Long hWnd) Library "user32.dll"
Private Function Boolean ReleaseCapture () Library "user32.dll"


end prototypes

type variables
n_coneccion_entrar	inv_entrar // Declare autoinstantiating login service object
// Win API constants

Constant Long HWND_TOPMOST = -1
Constant Long HWND_NOTOPMOST = -2
Constant Long SWP_NOSIZE = 1
Constant Long SWP_NOMOVE = 2
Constant Long SWP_NOACTIVATE = 16
Constant Long SWP_SHOWWINDOW = 64

// Instance variables
s_RECT WindowRect, ClientRect
s_POINTAPI RelativeCenter, DragOffset
Long BorderSize, TitleSize, dX, dY, ScreenWidth, ScreenHeight


Boolean MouseNotMoved = true
Boolean ib_painting
end variables

on w_ingresoseguro.create
int iCurrent
call super::create
this.st_ip=create st_ip
this.st_hostname=create st_hostname
this.cb_cancel=create cb_cancel
this.sle_password=create sle_password
this.sle_userid=create sle_userid
this.cb_ok=create cb_ok
this.p_ingreso=create p_ingreso
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_ip
this.Control[iCurrent+2]=this.st_hostname
this.Control[iCurrent+3]=this.cb_cancel
this.Control[iCurrent+4]=this.sle_password
this.Control[iCurrent+5]=this.sle_userid
this.Control[iCurrent+6]=this.cb_ok
this.Control[iCurrent+7]=this.p_ingreso
end on

on w_ingresoseguro.destroy
call super::destroy
destroy(this.st_ip)
destroy(this.st_hostname)
destroy(this.cb_cancel)
destroy(this.sle_password)
destroy(this.sle_userid)
destroy(this.cb_ok)
destroy(this.p_ingreso)
end on

event ue_postopen;call super::ue_postopen;int	 li_rtn


// Initialize login service
this.title= "Iniciar sesi$$HEX1$$f300$$ENDHEX$$n en " + Gn_Config.Is_Work.Aplicacion

st_hostname.text = "PC : "+ gn_config.is_config.hostname 
st_ip.text = "IP : "+ gn_config.is_config.ip

li_rtn = inv_entrar.of_inicio( "CONFIG.INI", "Profile")

IF li_rtn = -1 THEN
	MessageBox("Fallo de Apertura de Ventana", ": Incapaz para inicializar la ventana .  ~r~n~ ~r~n~Verifique el Archivo: CONFIG.INI")
	Close(This)
END IF




return 1


end event

event open;call super::open;////st_4.text =st_4.text + string(gdt_build)
//// get window outer and innner rectangles and calculate window client position
////GetWindowRect (Handle (This), WindowRect)
////GetClientRect (Handle (This), ClientRect)
////
////BorderSize = ((WindowRect.Right - WindowRect.Left) - (ClientRect.Right - ClientRect.Left)) / 2
////TitleSize = (WindowRect.Bottom -  WindowRect.Top) -  (ClientRect.Bottom - ClientRect.Top) - BorderSize
////	
////// calculate eye and screen properties
////RelativeCenter.X = BorderSize + (ClientRect.Right - ClientRect.Left) / 2
////RelativeCenter.Y = TitleSize + (ClientRect.Bottom - ClientRect.Top) / 2
////
////environment env
////GetEnvironment (env)
////ScreenWidth = env.ScreenWidth
////ScreenHeight = env.ScreenHeight
////
////// create eliptic window
////Long hRgn
////hRgn = CreateEllipticRgn (BorderSize + ClientRect.Left, TitleSize + ClientRect.Top, BorderSize + ClientRect.Right, TitleSize + ClientRect.Bottom)
////SetWindowRgn (Handle (w_ingresoseguro), hRgn, True)
////// make the window floating
////SetWindowPos (Handle (w_ingresoseguro), HWND_TOPMOST, 0, 0, 0, 0, SWP_NOACTIVATE + SWP_SHOWWINDOW + SWP_NOMOVE + SWP_NOSIZE) 
//
end event

event mousedown;call super::mousedown;s_POINTAPI CursorPosition

if flags = 1 then
	// capture mouse until mouseup
	this.SetCapture (Handle (this))

	//calculate drag offset
	this.GetCursorPos (CursorPosition)
	
	this.DragOffset.X = CursorPosition.X - UnitsToPixels (this.X, XUnitsToPixels!)
	this.DragOffset.Y = CursorPosition.Y - UnitsToPixels (this.Y, YUnitsToPixels!)
end if 
end event

event mousemove;call super::mousemove;s_POINTAPI CursorPosition

// move the window if neccesary
if flags = 1 then
	// get curent cursor position
	this.GetCursorPos (CursorPosition)

	// move the window
	this.X = PixelsToUnits (CursorPosition.X - this.DragOffset.X, XPixelsToUnits!)
	this.Y = PixelsToUnits (CursorPosition.Y - this.DragOffset.Y, YPixelsToUnits!)
	
end if


end event

event mouseup;call super::mouseup;// release mouse capture
ReleaseCapture ()
end event

type st_ip from st_uo_transparent within w_ingresoseguro
integer x = 384
integer y = 740
integer width = 1115
integer height = 80
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
long backcolor = 0
string text = "IP:"
alignment alignment = left!
boolean focusrectangle = false
end type

type st_hostname from st_uo_transparent within w_ingresoseguro
integer x = 384
integer y = 652
integer width = 1115
integer height = 80
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
long backcolor = 0
string text = "PC :"
alignment alignment = left!
boolean focusrectangle = false
end type

type cb_cancel from u_cb within w_ingresoseguro
integer x = 1120
integer y = 920
integer width = 343
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
string facename = "Tahoma"
string text = "Cancelar"
end type

event clicked;call super::clicked;	gb_Entro = False
		Close (Parent)
		Close(w_frame)

end event

type sle_password from u_sle within w_ingresoseguro
integer x = 384
integer y = 556
integer width = 1115
integer height = 80
integer taborder = 20
integer textsize = -8
string facename = "Microsoft Sans Serif"
string text = "sa2008"
boolean password = true
integer accelerator = 112
end type

event ue_keydown;call super::ue_keydown;
//*************************************************************************************************************************************************************************************
// Le doy el foco al objecto correspondiente.
//*************************************************************************************************************************************************************************************

if keydown(keyenter!) or keydown(keydownarrow!) or keydown(keyrightarrow!) or keydown(keytab!) then
	cb_ok.setfocus()	
	cb_ok.triggerevent( clicked!)
end if
end event

type sle_userid from u_sle within w_ingresoseguro
integer x = 384
integer y = 448
integer width = 1115
integer height = 80
integer textsize = -8
string facename = "Microsoft Sans Serif"
string text = "SA"
textcase textcase = upper!
integer accelerator = 117
end type

event ue_keydown;call super::ue_keydown;//*************************************************************************************************************************************************************************************
// Le doy el foco al objecto correspondiente.
//*************************************************************************************************************************************************************************************

if keydown(keyenter!) or keydown(keydownarrow!) or keydown(keyrightarrow!) or keydown(keytab!)then
	sle_password.setfocus()
	cb_ok.default = true
end if
end event

type cb_ok from u_cb within w_ingresoseguro
event ue_cerrar pbm_close
integer x = 379
integer y = 920
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
string facename = "Tahoma"
string text = "Aceptar"
boolean default = true
end type

event ue_cerrar;	Close (Parent)
	gb_Entro = True
	
	  OpenSheet(w_selecion_empresa,w_frame,1,Original!)
end event

event clicked;call super::clicked;
String	ls_userid, ls_password,ls_quien , ls_sql_syntax
Integer li_existe, li_retorno

ls_userid = Upper(Trim(sle_userid.text))
ls_password = Trim(sle_password.text)

//IF ls_userid = "" OR ls_password = "" THEN
//	MessageBox("Entrada invalida", "Por favor ingrese su Usuario y Password ")
//	sle_userid.SetFocus()
//	Return
//END IF

// Registrar el usuario con el objeto seguridad
gnv_seguridad.of_setseguridad( ls_userid, ls_password)

//Connectar a la Base de datos y abrir la ventana si esta bien
IF inv_entrar.of_coneccion(ls_userid, ls_password, SQLCA) <> 1 THEN
	sle_userid.SetFocus()
	Return
ELSE
	li_retorno = f_execute_sql("SET TRANSACTION ISOLATION LEVEL SERIALIZABLE")
     li_retorno = f_execute_sql("EXEC SYS.SP_RESET_CONNECTION")
	  
	gn_config.is_config.usuario = ls_userid
	gn_config.is_config.clave = ls_password
		//COMPARAR MODO DE INGRESO DE USUARIO Y PERMISOS
	//Open(w_frame)
	w_frame.changemenu(m_tppsoftbase)
	This.PostEvent("ue_cerrar")
	//seleccionar Empresa a escoger
	//OpenSheetWithParm(w_selecion_empresa, "", w_frame, 2, Original!)
	//  OpenSheet(w_selecion_empresa,w_frame,1,Original!)
	//OpenSheetWithParm(w_securityadmin, "", w_frame, 2, Original!)
	//Close (Parent)
	//gb_Entro = True
	//CloseWithReturn(Parent, 1)
	

END IF
end event

type p_ingreso from picture within w_ingresoseguro
event mousedown pbm_lbuttondown
event mousemove pbm_mousemove
event mouseup pbm_lbuttonup
integer width = 1879
integer height = 1056
string picturename = "Imagenes\Others\Login.bmp"
boolean focusrectangle = false
end type

event mousedown;s_POINTAPI CursorPosition

if flags = 1 then
	// capture mouse until mouseup
	parent.SetCapture (Handle (Parent))

	//calculate drag offset
	parent.GetCursorPos (CursorPosition)
	
	parent.DragOffset.X = CursorPosition.X - UnitsToPixels (parent.X, XUnitsToPixels!)
	parent.DragOffset.Y = CursorPosition.Y - UnitsToPixels (parent.Y, YUnitsToPixels!)
end if
end event

event mousemove;s_POINTAPI CursorPosition

// move the window if neccesary
if flags = 1 then
	// get curent cursor position
	parent.GetCursorPos (CursorPosition)

	// move the window
	parent.X = PixelsToUnits (CursorPosition.X - parent.DragOffset.X, XPixelsToUnits!)
	parent.Y = PixelsToUnits (CursorPosition.Y - parent.DragOffset.Y, YPixelsToUnits!)
	
end if


end event

event mouseup;// release mouse capture
ReleaseCapture ()
end event

