HA$PBExportHeader$w_database_profile_setup.srw
forward
global type w_database_profile_setup from window
end type
type dw_setup from datawindow within w_database_profile_setup
end type
type cb_help from commandbutton within w_database_profile_setup
end type
type cb_apply from commandbutton within w_database_profile_setup
end type
type cb_cancel from commandbutton within w_database_profile_setup
end type
type cb_ok from commandbutton within w_database_profile_setup
end type
type tab_setup from tab within w_database_profile_setup
end type
type tp_connection from userobject within tab_setup
end type
type dw_connection from datawindow within tp_connection
end type
type tp_connection from userobject within tab_setup
dw_connection dw_connection
end type
type tp_system from userobject within tab_setup
end type
type dw_system from datawindow within tp_system
end type
type tp_system from userobject within tab_setup
dw_system dw_system
end type
type tp_transaction from userobject within tab_setup
end type
type dw_transaction from datawindow within tp_transaction
end type
type tp_transaction from userobject within tab_setup
dw_transaction dw_transaction
end type
type tp_syntax from userobject within tab_setup
end type
type dw_syntax from datawindow within tp_syntax
end type
type tp_syntax from userobject within tab_setup
dw_syntax dw_syntax
end type
type tp_preview from userobject within tab_setup
end type
type cb_copy from commandbutton within tp_preview
end type
type st_database_connection_syntax from statictext within tp_preview
end type
type mle_profile from multilineedit within tp_preview
end type
type cb_testconnection from commandbutton within tp_preview
end type
type tp_preview from userobject within tab_setup
cb_copy cb_copy
st_database_connection_syntax st_database_connection_syntax
mle_profile mle_profile
cb_testconnection cb_testconnection
end type
type tab_setup from tab within w_database_profile_setup
tp_connection tp_connection
tp_system tp_system
tp_transaction tp_transaction
tp_syntax tp_syntax
tp_preview tp_preview
end type
end forward

global type w_database_profile_setup from window
integer width = 4398
integer height = 1920
boolean titlebar = true
string title = "Database Profile Setup - ADO.Net DB"
boolean controlmenu = true
boolean resizable = true
long backcolor = 67108864
boolean center = true
event ue_leer_dw ( )
dw_setup dw_setup
cb_help cb_help
cb_apply cb_apply
cb_cancel cb_cancel
cb_ok cb_ok
tab_setup tab_setup
end type
global w_database_profile_setup w_database_profile_setup

type variables
n_coneccion_entrar inv_entrar
n_transaccion_entrar itr_SQLCA
end variables

forward prototypes
public function integer of_profile_setup ()
public subroutine of_setear_dw ()
public subroutine of_leer_dw ()
end prototypes

event ue_Leer_Dw();of_Leer_Dw( ) 
end event

public function integer of_profile_setup ();
String ls_enter= "~r~n"
String ls_Profile
ls_Profile =  "// Profile "+itr_SQLCA.Is_Tr.Is_Profile +ls_enter
ls_Profile =  ls_Profile + "SQLCA.DBMS = ~""+itr_SQLCA.DBMS+"~""+ls_enter
ls_Profile = ls_Profile + "SQLCA.LogPass = <**"+Mid("******************",1,Len(itr_SQLCA.LogPass))+"**>"+ls_enter
ls_Profile = ls_Profile + "SQLCA.LogId = ~""+itr_SQLCA.LogId+"~""+ls_enter
ls_Profile = ls_Profile + "SQLCA.AutoCommit = "+inv_entrar.of_valor_pb_how_sb(itr_SQLCA.AutoCommit)+ls_enter
ls_Profile = ls_Profile + "SQLCA.DBParm = ~""+itr_SQLCA.DBParm+"~""+ls_enter
tab_setup.tp_preview.mle_profile.Text = ls_Profile
tab_setup.tp_preview.mle_profile.SelectText(1, Len(tab_setup.tp_preview.mle_profile.Text))

Return 1


end function

public subroutine of_setear_dw ();Long ll_FilaActual

ll_FilaActual = dw_setup.InsertRow(0)

dw_setup.Object.Profile[ll_FilaActual]         			=	itr_SQLCA.is_Tr.is_Profile
dw_setup.Object.DBMS[ll_FilaActual]					=	itr_SQLCA.is_Tr.is_DBMS
dw_setup.Object.AutoCommit[ll_FilaActual]			=	itr_SQLCA.is_Tr.is_AutoCommit
dw_setup.Object.DBParm[ll_FilaActual]					=	itr_SQLCA.is_Tr.is_DBParm
//dw_setup.Object.DBPass[ll_FilaActual]					=	itr_SQLCA.is_Tr.is_DBPass
//dw_setup.Object.Lock[ll_FilaActual]						=	itr_SQLCA.is_Tr.is_Lock                     
//dw_setup.Object.UserId[ll_FilaActual]					=	itr_SQLCA.is_Tr.is_UserId
//dw_setup.Object.Password[ll_FilaActual]				=	itr_SQLCA.is_Tr.is_Password
//dw_setup.Object.ServerName[ll_FilaActual]			=	itr_SQLCA.is_Tr.is_ServerName
             
dw_setup.Object.NameSpaces[ll_FilaActual]			=	itr_SQLCA.is_Tr.is_NameSpace
dw_setup.Object.Provider[ll_FilaActual]					=	itr_SQLCA.is_Tr.is_Provider
dw_setup.Object.DataSource[ll_FilaActual]				=	itr_SQLCA.is_Tr.is_DataSource
dw_setup.Object.LogID[ll_FilaActual]						=	itr_SQLCA.is_Tr.is_LogID
dw_setup.Object.LogPass[ll_FilaActual]					=	itr_SQLCA.is_Tr.is_LogPass
dw_setup.Object.Database[ll_FilaActual]				=	itr_SQLCA.is_Tr.is_Database
dw_setup.Object.AdoRelease[ll_FilaActual]				=	itr_SQLCA.is_Tr.is_AdoRelease
dw_setup.Object.TrustedConnection[ll_FilaActual]	=	itr_SQLCA.is_Tr.is_TrustedConnection
dw_setup.Object.FileName[ll_FilaActual]					=	itr_SQLCA.is_Tr.is_FileName
dw_setup.Object.DataLink[ll_FilaActual]					=	itr_SQLCA.is_Tr.is_DataLink
dw_setup.Object.ProviderString[ll_FilaActual]			=	itr_SQLCA.is_Tr.is_ProviderString

dw_setup.Object.PBCatalogOwner[ll_FilaActual]		=	itr_SQLCA.is_Tr.is_PBCatalogOwner
dw_setup.Object.DefaultProcOwner[ll_FilaActual	]	=	itr_SQLCA.is_Tr.is_DefaultProcOwner
dw_setup.Object.SPCache[ll_FilaActual]					=	itr_SQLCA.is_Tr.is_SPCache
dw_setup.Object.GenerateTrace[ll_FilaActual]			=	itr_SQLCA.is_Tr.is_GenerateTrace
dw_setup.Object.CommitOnDisconnect[ll_FilaActual]	=	itr_SQLCA.is_Tr.is_CommitOnDisconnect
dw_setup.Object.AutoCommit[ll_FilaActual]				=	itr_SQLCA.is_Tr.is_AutoCommit
dw_setup.Object.TimeOut[ll_FilaActual]					=	itr_SQLCA.is_Tr.is_TimeOut
dw_setup.Object.CommandTimeout[ll_FilaActual]		=	itr_SQLCA.is_Tr.is_CommandTimeout
dw_setup.Object.DbConfigSection[ll_FilaActual]		=	itr_SQLCA.is_Tr.is_DbConfigSection

dw_setup.Object.Isolation[ll_FilaActual]					=	itr_SQLCA.is_Tr.is_Isolation
dw_setup.Object.Disablebind[ll_FilaActual]				=	itr_SQLCA.is_Tr.is_Disablebind
dw_setup.Object.StaticBind[ll_FilaActual]				=	itr_SQLCA.is_Tr.is_StaticBind
dw_setup.Object.NCharBind[ll_FilaActual]				=	itr_SQLCA.is_Tr.is_NCharBind
dw_setup.Object.PBMaxBlobSize[ll_FilaActual]			=	itr_SQLCA.is_Tr.is_PBMaxBlobSize       
        
dw_setup.Object.DelimitIdentifier[ll_FilaActual]		=	itr_SQLCA.is_Tr.is_DelimitIdentifier
dw_setup.Object.TrimSpaces[ll_FilaActual]				=	itr_SQLCA.is_Tr.is_TrimSpaces
dw_setup.Object.IdentifierQuoteChar[ll_FilaActual]	=	itr_SQLCA.is_Tr.is_IdentifierQuoteChar
dw_setup.Object.DateFormat[ll_FilaActual]				=	itr_SQLCA.is_Tr.is_DateFormat
dw_setup.Object.DateTimeFormat[ll_FilaActual]		=	itr_SQLCA.is_Tr.is_DateTimeFormat
dw_setup.Object.TimeFormat[ll_FilaActual]				=	itr_SQLCA.is_Tr.is_TimeFormat
dw_setup.Object.DecimalSeparator[ll_FilaActual]		=	itr_SQLCA.is_Tr.is_DecimalSeparator
dw_setup.Object.OJSyntax[ll_FilaActual]				=	itr_SQLCA.is_Tr.is_OJSyntax
dw_setup.Accepttext( )

end subroutine

public subroutine of_leer_dw ();Long ll_FilaActual

dw_setup.Accepttext( )

ll_FilaActual = dw_setup.Getrow()

inv_entrar.is_Tr.is_Profile                 		=	dw_setup.Object.Profile[ll_FilaActual]         		
inv_entrar.is_Tr.is_DBMS                    	=	dw_setup.Object.DBMS[ll_FilaActual]								
inv_entrar.is_Tr.is_AutoCommit              	=	dw_setup.Object.AutoCommit[ll_FilaActual]					
inv_entrar.is_Tr.is_DBParm                  	=	dw_setup.Object.DBParm[ll_FilaActual]							
//inv_entrar.is_Tr.is_DBPass                  	=	dw_setup.Object.DBPass[ll_FilaActual]						
//inv_entrar.is_Tr.is_Lock                    		=	dw_setup.Object.Lock[ll_FilaActual]							
//inv_entrar.is_Tr.is_UserId                  		=	dw_setup.Object.UserId[ll_FilaActual]						
//inv_entrar.is_Tr.is_Password                	=	dw_setup.Object.Password[ll_FilaActual]					
//inv_entrar.is_Tr.is_ServerName              	=	dw_setup.Object.ServerName[ll_FilaActual]				
                                                                                               
inv_entrar.is_Tr.is_NameSpace              	=	dw_setup.Object.NameSpaces[ll_FilaActual]					
inv_entrar.is_Tr.is_Provider               		=	dw_setup.Object.Provider[ll_FilaActual]						
inv_entrar.is_Tr.is_DataSource              	=	dw_setup.Object.DataSource[ll_FilaActual]					
inv_entrar.is_Tr.is_LogID                  		=	dw_setup.Object.LogID[ll_FilaActual]							
inv_entrar.is_Tr.is_LogPass                 	=	dw_setup.Object.LogPass[ll_FilaActual]						
inv_entrar.is_Tr.is_Database                	=	dw_setup.Object.Database[ll_FilaActual]						
inv_entrar.is_Tr.is_AdoRelease              	=	dw_setup.Object.AdoRelease[ll_FilaActual]					
inv_entrar.is_Tr.is_TrustedConnection	=	dw_setup.Object.TrustedConnection[ll_FilaActual]	
inv_entrar.is_Tr.is_FileName                	=	dw_setup.Object.FileName[ll_FilaActual]						
inv_entrar.is_Tr.is_DataLink                	=	dw_setup.Object.DataLink[ll_FilaActual]						
inv_entrar.is_Tr.is_ProviderString          	=	dw_setup.Object.ProviderString[ll_FilaActual]			
                                                                                               
inv_entrar.is_Tr.is_PBCatalogOwner		=	dw_setup.Object.PBCatalogOwner[ll_FilaActual]			
inv_entrar.is_Tr.is_DefaultProcOwner   	=	dw_setup.Object.DefaultProcOwner[ll_FilaActual]		
inv_entrar.is_Tr.is_SPCache                 	=	dw_setup.Object.SPCache[ll_FilaActual]						
inv_entrar.is_Tr.is_GenerateTrace       	=	dw_setup.Object.GenerateTrace[ll_FilaActual]			
inv_entrar.is_Tr.is_CommitOnDisconnect=	dw_setup.Object.CommitOnDisconnect[ll_FilaActual]	
inv_entrar.is_Tr.is_AutoCommit              	=	dw_setup.Object.AutoCommit[ll_FilaActual]					
inv_entrar.is_Tr.is_TimeOut                 	=	dw_setup.Object.TimeOut[ll_FilaActual]						
inv_entrar.is_Tr.is_CommandTimeout  	=	dw_setup.Object.CommandTimeout[ll_FilaActual]			
inv_entrar.is_Tr.is_DbConfigSection    	=	dw_setup.Object.DbConfigSection[ll_FilaActual]		
                                                                                               
inv_entrar.is_Tr.is_Isolation               	=	dw_setup.Object.Isolation[ll_FilaActual]					
inv_entrar.is_Tr.is_Disablebind             	=	dw_setup.Object.Disablebind[ll_FilaActual]				
inv_entrar.is_Tr.is_StaticBind              	=	dw_setup.Object.StaticBind[ll_FilaActual]					
inv_entrar.is_Tr.is_NCharBind               	=	dw_setup.Object.NCharBind[ll_FilaActual]					
inv_entrar.is_Tr.is_PBMaxBlobSize       	=	dw_setup.Object.PBMaxBlobSize[ll_FilaActual]			
                                                                                               
inv_entrar.is_Tr.is_DelimitIdentifier       	=	dw_setup.Object.DelimitIdentifier[ll_FilaActual]	
inv_entrar.is_Tr.is_TrimSpaces              	=	dw_setup.Object.TrimSpaces[ll_FilaActual]					
inv_entrar.is_Tr.is_IdentifierQuoteChar	=	dw_setup.Object.IdentifierQuoteChar[ll_FilaActual]
inv_entrar.is_Tr.is_DateFormat              	=	dw_setup.Object.DateFormat[ll_FilaActual]					
inv_entrar.is_Tr.is_DateTimeFormat  		=	dw_setup.Object.DateTimeFormat[ll_FilaActual]			
inv_entrar.is_Tr.is_TimeFormat       		=	dw_setup.Object.TimeFormat[ll_FilaActual]					
inv_entrar.is_Tr.is_DecimalSeparator   	=	dw_setup.Object.DecimalSeparator[ll_FilaActual]		
inv_entrar.is_Tr.is_OJSyntax       			=	dw_setup.Object.OJSyntax[ll_FilaActual]				

inv_entrar.of_asignar( )

IF inv_entrar.of_conexion_parms("SA", "SA2005",itr_SQLCA) <> 1 THEN
//IF inv_entrar.of_conexion_parms(gn_config.is_config.usuario, gn_config.is_config.clave,itr_SQLCA) <> 1 THEN
	Return
ELSE 
	of_profile_setup( )
END IF

end subroutine

on w_database_profile_setup.create
this.dw_setup=create dw_setup
this.cb_help=create cb_help
this.cb_apply=create cb_apply
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.tab_setup=create tab_setup
this.Control[]={this.dw_setup,&
this.cb_help,&
this.cb_apply,&
this.cb_cancel,&
this.cb_ok,&
this.tab_setup}
end on

on w_database_profile_setup.destroy
destroy(this.dw_setup)
destroy(this.cb_help)
destroy(this.cb_apply)
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.tab_setup)
end on

type dw_setup from datawindow within w_database_profile_setup
integer x = 1755
integer y = 20
integer width = 1938
integer height = 1792
integer taborder = 80
string title = "none"
string dataobject = "d_database_profile_setup"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean border = false
boolean livescroll = true
end type

event constructor;
Integer li_rtn

li_rtn = inv_entrar.of_inicio( "CONFIG.INI", "Profile")

IF li_rtn = -1 THEN
	MessageBox("Fallo de apertura de archivo de configuraci$$HEX1$$f300$$ENDHEX$$n de conexi$$HEX1$$f300$$ENDHEX$$n", ": Incapaz para inicializar la ventana .  ~r~n~ ~r~n~Verifique el Archivo: CONFIG.INI")
END IF

itr_SQLCA = CREATE n_transaccion_entrar
IF inv_entrar.of_conexion_parms("SA", "SA2005",itr_SQLCA) <> 1 THEN
//IF inv_entrar.of_conexion_parms(gn_config.is_config.usuario, gn_config.is_config.clave,itr_SQLCA) <> 1 THEN
	Return
END IF
of_Setear_Dw( )
of_Profile_Setup()
This.accepttext( )
This.ShareData(tab_setup.tp_connection.dw_connection)
This.ShareData(tab_setup.tp_system.dw_system)
This.ShareData(tab_setup.tp_transaction.dw_transaction)
This.ShareData(tab_setup.tp_syntax.dw_syntax)

end event

event destructor;IF IsValid(itr_SQLCA) THEN DESTROY itr_SQLCA

end event

event editchanged;
This.Accepttext( )
Messagebox("Edit "+String(Dwo.name), Data)
end event

event itemchanged;
This.Accepttext( )
Messagebox("Item "+String(Dwo.name), Data)
end event

type cb_help from commandbutton within w_database_profile_setup
integer x = 1390
integer y = 1700
integer width = 343
integer height = 92
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Help"
end type

type cb_apply from commandbutton within w_database_profile_setup
integer x = 1019
integer y = 1700
integer width = 343
integer height = 92
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Apply"
end type

event clicked;of_Leer_Dw( )
inv_entrar.of_aplicar("CONFIG.INI","Profile")
end event

type cb_cancel from commandbutton within w_database_profile_setup
integer x = 649
integer y = 1700
integer width = 343
integer height = 92
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Cancel"
end type

type cb_ok from commandbutton within w_database_profile_setup
integer x = 279
integer y = 1700
integer width = 343
integer height = 92
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "OK"
boolean default = true
end type

type tab_setup from tab within w_database_profile_setup
integer x = 27
integer y = 4
integer width = 1705
integer height = 1672
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 67108864
boolean raggedright = true
boolean focusonbuttondown = true
integer selectedtab = 1
tp_connection tp_connection
tp_system tp_system
tp_transaction tp_transaction
tp_syntax tp_syntax
tp_preview tp_preview
end type

on tab_setup.create
this.tp_connection=create tp_connection
this.tp_system=create tp_system
this.tp_transaction=create tp_transaction
this.tp_syntax=create tp_syntax
this.tp_preview=create tp_preview
this.Control[]={this.tp_connection,&
this.tp_system,&
this.tp_transaction,&
this.tp_syntax,&
this.tp_preview}
end on

on tab_setup.destroy
destroy(this.tp_connection)
destroy(this.tp_system)
destroy(this.tp_transaction)
destroy(this.tp_syntax)
destroy(this.tp_preview)
end on

type tp_connection from userobject within tab_setup
integer x = 18
integer y = 100
integer width = 1669
integer height = 1556
long backcolor = 67108864
string text = "Connection"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
string powertiptext = "La hoja de conexi$$HEX1$$f300$$ENDHEX$$n incluye algunas opciones de conexi$$HEX1$$f300$$ENDHEX$$n b$$HEX1$$e100$$ENDHEX$$sicas que usted debe proporcionar para acceder a sus datos."
dw_connection dw_connection
end type

on tp_connection.create
this.dw_connection=create dw_connection
this.Control[]={this.dw_connection}
end on

on tp_connection.destroy
destroy(this.dw_connection)
end on

type dw_connection from datawindow within tp_connection
integer width = 1664
integer height = 1560
integer taborder = 30
string title = "none"
string dataobject = "d_database_profile_setup_01"
boolean border = false
boolean livescroll = true
end type

event constructor;This.InsertRow(0)
end event

event editchanged;
THIS.Accepttext( )
POST EVENT ue_Leer_Dw( )
end event

event itemchanged;
THIS.Accepttext( )
POST EVENT ue_Leer_Dw( )
end event

type tp_system from userobject within tab_setup
integer x = 18
integer y = 100
integer width = 1669
integer height = 1556
long backcolor = 67108864
string text = "System"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
dw_system dw_system
end type

on tp_system.create
this.dw_system=create dw_system
this.Control[]={this.dw_system}
end on

on tp_system.destroy
destroy(this.dw_system)
end on

type dw_system from datawindow within tp_system
integer width = 1669
integer height = 1552
integer taborder = 40
string title = "none"
string dataobject = "d_database_profile_setup_02"
boolean border = false
boolean livescroll = true
end type

event constructor;This.InsertRow(0)
end event

event itemchanged;
THIS.Accepttext( )
POST EVENT ue_Leer_Dw( )
end event

event editchanged;
THIS.Accepttext( )
POST EVENT ue_Leer_Dw( )
end event

type tp_transaction from userobject within tab_setup
integer x = 18
integer y = 100
integer width = 1669
integer height = 1556
long backcolor = 67108864
string text = "Transaction"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
dw_transaction dw_transaction
end type

on tp_transaction.create
this.dw_transaction=create dw_transaction
this.Control[]={this.dw_transaction}
end on

on tp_transaction.destroy
destroy(this.dw_transaction)
end on

type dw_transaction from datawindow within tp_transaction
integer width = 1669
integer height = 1552
integer taborder = 40
string title = "none"
string dataobject = "d_database_profile_setup_03"
boolean border = false
boolean livescroll = true
end type

event constructor;This.InsertRow(0)
end event

event editchanged;
THIS.Accepttext( )
POST EVENT ue_Leer_Dw( )
end event

event itemchanged;
THIS.Accepttext( )
POST EVENT ue_Leer_Dw( )
end event

type tp_syntax from userobject within tab_setup
integer x = 18
integer y = 100
integer width = 1669
integer height = 1556
long backcolor = 67108864
string text = "Syntax"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
dw_syntax dw_syntax
end type

on tp_syntax.create
this.dw_syntax=create dw_syntax
this.Control[]={this.dw_syntax}
end on

on tp_syntax.destroy
destroy(this.dw_syntax)
end on

type dw_syntax from datawindow within tp_syntax
integer width = 1669
integer height = 1552
integer taborder = 40
string title = "none"
string dataobject = "d_database_profile_setup_04"
boolean border = false
boolean livescroll = true
end type

event constructor;This.InsertRow(0)
end event

event editchanged;
THIS.Accepttext( )
POST EVENT ue_Leer_Dw( )
end event

event itemchanged;
THIS.Accepttext( )
POST EVENT ue_Leer_Dw( )
end event

type tp_preview from userobject within tab_setup
integer x = 18
integer y = 100
integer width = 1669
integer height = 1556
long backcolor = 67108864
string text = "Preview"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
cb_copy cb_copy
st_database_connection_syntax st_database_connection_syntax
mle_profile mle_profile
cb_testconnection cb_testconnection
end type

on tp_preview.create
this.cb_copy=create cb_copy
this.st_database_connection_syntax=create st_database_connection_syntax
this.mle_profile=create mle_profile
this.cb_testconnection=create cb_testconnection
this.Control[]={this.cb_copy,&
this.st_database_connection_syntax,&
this.mle_profile,&
this.cb_testconnection}
end on

on tp_preview.destroy
destroy(this.cb_copy)
destroy(this.st_database_connection_syntax)
destroy(this.mle_profile)
destroy(this.cb_testconnection)
end on

type cb_copy from commandbutton within tp_preview
string accessiblename = "Copy"
string accessibledescription = "Copiar la cadena del perfil de Conexion"
integer x = 1070
integer y = 1004
integer width = 453
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "&Copy"
end type

event clicked;tab_setup.tp_preview.mle_profile.SelectText(1, Len(tab_setup.tp_preview.mle_profile.Text))
tab_setup.tp_preview.mle_profile.SetFocus( )
tab_setup.tp_preview.mle_profile.Copy( )
end event

type st_database_connection_syntax from statictext within tp_preview
integer x = 41
integer y = 40
integer width = 667
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Database Connection Syntax:"
boolean focusrectangle = false
end type

type mle_profile from multilineedit within tp_preview
integer x = 41
integer y = 112
integer width = 1477
integer height = 872
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
boolean hscrollbar = true
boolean vscrollbar = true
boolean autohscroll = true
boolean autovscroll = true
boolean displayonly = true
borderstyle borderstyle = stylelowered!
boolean hideselection = false
end type

type cb_testconnection from commandbutton within tp_preview
string accessiblename = "TestConnection"
string accessibledescription = "Probar la Conexion"
integer x = 1070
integer y = 1192
integer width = 453
integer height = 92
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "&Test Connection"
end type

event clicked;inv_entrar.of_conexion_test( itr_SQLCA)
end event

