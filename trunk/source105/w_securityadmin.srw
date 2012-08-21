HA$PBExportHeader$w_securityadmin.srw
forward
global type w_securityadmin from window
end type
type uo_mssql from uo_security_mssql within w_securityadmin
end type
end forward

global type w_securityadmin from window
integer width = 2533
integer height = 2132
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
uo_mssql uo_mssql
end type
global w_securityadmin w_securityadmin

event resize;//tv_admin.Height = newheight - 25
//lv_admin.Height = newheight - 25

// Do not run the first time the window is opened.
If IsValid(uo_mssql.idrg_Vertical[1]) Then
	//Resize Bars
	uo_mssql.of_ResizeBars()

	//Resize the panels
	uo_mssql.of_ResizePanels()
End If


end event

on w_securityadmin.create
this.uo_mssql=create uo_mssql
this.Control[]={this.uo_mssql}
end on

on w_securityadmin.destroy
destroy(this.uo_mssql)
end on

event open;//Resize Bars
uo_mssql.of_ResizeBars()

//Resize the panels
uo_mssql.of_ResizePanels()

end event

type uo_mssql from uo_security_mssql within w_securityadmin
integer taborder = 30
end type

on uo_mssql.destroy
call uo_security_mssql::destroy
end on

event constructor;call super::constructor;THIS.of_settranssobject( SQLCA )
THIS.of_activar( )
end event

