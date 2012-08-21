HA$PBExportHeader$w_message.srw
$PBExportComments$ventana de mensajes del aplicativo.
forward
global type w_message from Window
end type
type st_mensaje from statictext within w_message
end type
end forward

global type w_message from Window
int X=1216
int Y=1040
int Width=1179
int Height=228
long BackColor=8421376
WindowType WindowType=response!
st_mensaje st_mensaje
end type
global w_message w_message

on w_message.create
this.st_mensaje=create st_mensaje
this.Control[]={this.st_mensaje}
end on

on w_message.destroy
destroy(this.st_mensaje)
end on

event open;
//**************************************************************************************************************************************************************************************
// Defino el timer de la ventana correspondiente.
//**************************************************************************************************************************************************************************************

timer(message.doubleparm,this)

end event

event timer;
//**************************************************************************************************************************************************************************************
// Efecto de cerrar la ventana correspondiente.
//**************************************************************************************************************************************************************************************

close(this)
end event

type st_mensaje from statictext within w_message
int X=64
int Y=64
int Width=1042
int Height=112
boolean Enabled=false
string Text="Por favor esperar un momento."
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=16777215
long BackColor=8421376
int TextSize=-11
int Weight=400
string FaceName="Century Gothic"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

