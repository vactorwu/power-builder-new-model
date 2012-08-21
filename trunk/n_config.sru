HA$PBExportHeader$n_config.sru
forward
global type n_config from nonvisualobject
end type
end forward

global type n_config from nonvisualobject
end type
global n_config n_config

type prototypes

end prototypes

type variables
constant ulong		NULL_HOST = 0
constant integer	HOSTENT_LEN = 16
constant	integer	ADDRLIST_LEN = 4
constant	integer	LOCAL_HOST_NAME_LEN = 256
constant	integer	SUCCESS = 0
constant	integer	FAILURE = -1
String is_ipaddr, is_macaddr
s_config is_config
s_work is_work
s_sqlca is_sqlca
string	host , hostip
int		err, rc
end variables

forward prototypes
public function datetime of_datetime ()
public function string of_user ()
public function string of_terminal ()
public function string of_gethostname ()
public function string of_getip ()
public function string of_host ()
public function string of_ip ()
public function string of_getipaddr ()
public function string of_getmacaddr ()
public function string of_get_codigo (string as_tabla, integer ai_largo)
public function string of_get_ubigeo (string as_ubigeo)
public function string of_diskserialnumber ()
end prototypes

public function datetime of_datetime ();
datetime ldt_fecha

//***************************************************************************************************************************************************************************************
// Fecha de servidor.
//***************************************************************************************************************************************************************************************

select distinct getdate() into :ldt_fecha from sysusers using SQLCA;

//***************************************************************************************************************************************************************************************
// Retorno.
//***************************************************************************************************************************************************************************************

return ldt_fecha 
end function

public function string of_user ();
String ls_user

//***************************************************************************************************************************************************************************************
// Fecha de servidor.
//***************************************************************************************************************************************************************************************

ls_user =gn_config.is_config.usuario

//***************************************************************************************************************************************************************************************
// Retorno.
//***************************************************************************************************************************************************************************************

return ls_user 
end function

public function string of_terminal ();
String ls_terminal

//***************************************************************************************************************************************************************************************
// Fecha de servidor.
//***************************************************************************************************************************************************************************************

RegistryGet ("HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\ComputerName\ComputerName", "ComputerName", ls_terminal)


//ls_terminal = "Terminal"

//***************************************************************************************************************************************************************************************
// Retorno.
//***************************************************************************************************************************************************************************************

return ls_terminal 
end function

public function string of_gethostname ();String localhost


//try
	RegistryGet ("HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\ComputerName\ComputerName", "ComputerName", localhost)
//finally
	Return Upper(localhost)
//end try
end function

public function string of_getip ();String ls_ip
integer	i
long		lHost, lIPAddr
hostent	hst
char		ipaddr[]
String ls_hostip
//Returns a pointer to a hostent structure
lHost = GetHostByName ( host )
IF lHost = NULL_HOST THEN
	err = GetLastError()
	Return "0.0.0.0"
END IF

//Copy the structure into a local structure
CopyMemory ( hst, lHost, HOSTENT_LEN )

//The members of the local structure are also pointers, so copy them into local variable(s)
CopyMemory ( lIPAddr, hst.h_addrlist, ADDRLIST_LEN )

FOR i = 1 TO hst.h_length
	ipaddr[i] = ' '
NEXT
CopyMemory ( ipaddr, lIPAddr, hst.h_length )

FOR i = 1 TO hst.h_length
	ls_hostip = ls_hostip + String ( AscA ( ipaddr[i] ) )
	IF i < hst.h_length THEN
		ls_hostip = ls_hostip + '.'
	END IF
NEXT

 Return ls_hostip
end function

public function string of_host ();String localhost
// Get our own host name
localhost = Space ( LOCAL_HOST_NAME_LEN )
rc = GetHostName ( localhost, LOCAL_HOST_NAME_LEN )
IF rc <> SUCCESS THEN
	err = GetLastError()
	Return Upper("localhost")
END IF

Return Upper(localhost)
end function

public function string of_ip ();String ls_ip
integer	i
long		lHost, lIPAddr
hostent	hst
char		ipaddr[]
String ls_hostip

//Returns a pointer to a hostent structure
lHost = GetHostByName ( host )
IF lHost = NULL_HOST THEN
	err = GetLastError()
	Return "0.0.0.0"
END IF

//Copy the structure into a local structure
CopyMemory ( hst, lHost, HOSTENT_LEN )

//The members of the local structure are also pointers, so copy them into local variable(s)
CopyMemory ( lIPAddr, hst.h_addrlist, ADDRLIST_LEN )

FOR i = 1 TO hst.h_length
	ipaddr[i] = ' '
NEXT
CopyMemory ( ipaddr, lIPAddr, hst.h_length )

FOR i = 1 TO hst.h_length
	ls_hostip = ls_hostip + String ( AscA ( ipaddr[i] ) )
	IF i < hst.h_length THEN
		ls_hostip = ls_hostip + '.'
	END IF
NEXT

 Return ls_hostip
end function

public function string of_getipaddr ();n_macip uo_macip
String IP
uo_macip = CREATE n_macip
uo_macip.uf_getipaddr(IP)
DESTROY uo_macip
Return IP
end function

public function string of_getmacaddr ();n_macip uo_macip
String MAC
uo_macip = CREATE n_macip
uo_macip.uf_getmacaddr(MAC)
DESTROY uo_macip
Return MAC
end function

public function string of_get_codigo (string as_tabla, integer ai_largo);String ls_Codigo
Long ll_Codigo
ls_Codigo=Space(10)
choose case Upper(as_tabla)
	case "MONEDA"
   ll_Codigo = SQLCA.Usp_Moneda_Cod(ls_Codigo,ai_largo)		
	case "TIPOCAMBIO"
   ll_Codigo = SQLCA.Usp_TipoCambio_Cod(ls_Codigo,ai_largo)		
	case "EMPRESA"
   ll_Codigo = SQLCA.Usp_Empresa_Cod(ls_Codigo,ai_largo)
	case "ENTIDAD"
   ll_Codigo = SQLCA.Usp_Entidad_Cod(ls_Codigo,ai_largo)	
	case "ENTIDADPARAMETROS"
   ll_Codigo = SQLCA.Usp_EntidadParametros_Cod(ls_Codigo,ai_largo)		
	case "ALMACEN"
   ll_Codigo = SQLCA.Usp_Almacen_Cod(is_work.idempresa, ls_Codigo,ai_largo)	
	case "AREALABORAL"
   ll_Codigo = SQLCA.Usp_AreaLaboral_Cod(is_work.idempresa, ls_Codigo,ai_largo)		
	case "BANCO"
   ll_Codigo = SQLCA.Usp_Banco_Cod( ls_Codigo,ai_largo)	
	case "IMPUESTO"
   ll_Codigo = SQLCA.Usp_Impuesto_Cod( ls_Codigo,ai_largo)			
	case "IMPUESTOVIGENCIA"
   ll_Codigo = SQLCA.Usp_ImpuestoVigencia_Cod( ls_Codigo,ai_largo)			
	case "COLOR"
   ll_Codigo = SQLCA.Usp_Color_Cod(is_work.idempresa, ls_Codigo,ai_largo)
	case "TIPODOCUMENTO"
   ll_Codigo = SQLCA.Usp_TipoDocumento_Cod(is_work.idempresa, ls_Codigo,ai_largo)	
	case "DOCUMENTO"
   ll_Codigo = SQLCA.Usp_Documento_Cod(is_work.idempresa, ls_Codigo,ai_largo)		
	case "LINEA"
   ll_Codigo = SQLCA.Usp_Linea_Cod(is_work.idempresa, ls_Codigo,ai_largo)
	case "MARCA"
   ll_Codigo = SQLCA.Usp_Marca_Cod(is_work.idempresa, ls_Codigo,ai_largo)
	case "PRODUCTO"
   ll_Codigo = SQLCA.Usp_Producto_Cod(is_work.idempresa, ls_Codigo,ai_largo)
	case "LISTAPRECIO"
   ll_Codigo = SQLCA.Usp_ListaPrecio_Cod(is_work.idempresa, ls_Codigo,ai_largo)	
	case "TALLA"
   ll_Codigo = SQLCA.Usp_Talla_Cod(is_work.idempresa, ls_Codigo,ai_largo)
	case "UNIDAD"
   ll_Codigo = SQLCA.Usp_Unidad_Cod( ls_Codigo,ai_largo)
	case "ESTADOOPERACION"
   ll_Codigo = SQLCA.Usp_EstadoOperacion_Cod(is_work.idempresa, is_work.anio, ls_Codigo,ai_largo)	
	case "ESTADOMENSUALOPERACION"
   ll_Codigo = SQLCA.Usp_EstadoMesOperacion_Cod(is_work.idempresa, ls_Codigo,ai_largo)		
	case "COMPRA"
   ll_Codigo = SQLCA.Usp_Compra_Cod(is_work.idempresa, ls_Codigo,ai_largo)	
		
	
    	case else	
	ls_Codigo = "0"		
end choose


Return ls_Codigo
end function

public function string of_get_ubigeo (string as_ubigeo);String ls_Codigo
Long ll_Codigo
ls_Codigo=Space(100)
ls_Codigo = SQLCA.Usf_Get_Ubigeo(as_ubigeo)

Return ls_Codigo
end function

public function string of_diskserialnumber ();OLEObject ole_wsh
Any la_processor[]
string ls_DiskSerialNumber

Any la_usb[]

 ole_wsh = CREATE OLEObject
 ole_wsh.ConnectToNewObject("MSScriptControl.ScriptControl")
 ole_wsh.Language = "vbscript"
 ole_wsh.AddCode('Function rtnDiskSerialNumber()~r~n' &
 + 'DiskSerialNumber = "" ~r~n'  &
 + 'strComputer = "." ~r~n'  &
 + 'Set objWMIService = GetObject("winmgmts:\\" & strComputer & "\root\cimv2")~r~n' &
 + 'Set colItems =  objWMIService.ExecQuery("Select SerialNumber from Win32_PhysicalMedia")~r~n' &
 + 'For Each objItem in colItems~r~n' &
 + '   IF Trim(objItem.SerialNumber) <> "" Then ~r~n' &   
 + '    DiskSerialNumber =  Trim(objItem.SerialNumber) ~r~n' &
 + '   End If~r~n' & 
 + 'Next~r~n' &
 + 'rtnDiskSerialNumber = DiskSerialNumber~r~n' &
 + 'End Function')

 ls_DiskSerialNumber = ole_wsh.Eval("rtnDiskSerialNumber")
 ole_wsh.DisconnectObject()
 DESTROY ole_wsh

Return ls_DiskSerialNumber


// ole_wsh = CREATE OLEObject
// ole_wsh.ConnectToNewObject("MSScriptControl.ScriptControl")
// ole_wsh.Language = "vbscript"
// ole_wsh.AddCode('Function rtnSoftwares()~r~n' &
// + 'SoftwareList = "" ~r~n' + &
// + 'strComputer = "." ~r~n' + &
// + 'Set objWMIService = GetObject("winmgmts:{impersonationLevel=impersonate}!\\" _~r~n& strComputer & "\root\cimv2")~r~n' &
// + 'Set colItems =  objWMIService.ExecQuery("Select SerialNumber from Win32_PhysicalMedia")~r~n' &
// + 'For Each objItem in colItems~r~n' &
// + '   IF Trim(objItem.SerialNumber) <> "" Then ~r~n' &   
// + '     SoftwareList = Trim(objItem.SerialNumber)  ~r~n' &
// + '   End If~r~n' &
// + 'Next~r~n' &
// + 'rtnSoftwares = SoftwareList ~r~n' &
// + 'End Function')
// ls_message = ole_wsh.Eval("rtnSoftwares")
// ole_wsh.DisconnectObject()
// DESTROY ole_wsh
//
//MessageBox("Software List",ls_message)
end function

on n_config.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_config.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

