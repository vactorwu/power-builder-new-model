HA$PBExportHeader$tpplamsoft.sra
$PBExportComments$Generated Application Object
forward
global type tpplamsoft from application
end type
global n_transaccion_entrar sqlca
global dynamicdescriptionarea sqlda
global dynamicstagingarea sqlsa
global error error
global message message
end forward

global variables
n_coneccion_seguridad gnv_seguridad	//global security object
n_config gn_config
environment ge_environment
//A$$HEX1$$f100$$ENDHEX$$adir autom$$HEX1$$e100$$ENDHEX$$ticamente la fecha de compilaci$$HEX1$$f300$$ENDHEX$$n a tu aplicaci$$HEX1$$f300$$ENDHEX$$n
DateTime gdt_build = DateTime(Today(), Now())

Date DiasTrial
String Path,sREGKEY
Long gl_colorboton 
String gs_nulo
Boolean gb_Entro,gb_Fondo, gb_AbrirCatalogos ,gb_AbrirTransaciones , gb_AbrirOperaciones , gb_VentanaLibreria
OLEObject PBObjectNewid
end variables

global type tpplamsoft from application
string appname = "tpplamsoft"
string toolbarframetitle = "Menu Principal"
string toolbarsheettitle = "Herramientas"
string toolbarpopmenutext = "Menu Flotante"
boolean freedblibraries = true
event ue_postopen ( )
end type
global tpplamsoft tpplamsoft

type prototypes
FUNCTION integer GetFileVersionInfoA( REF string lpFilename, REF ulong lpdwHandle, ulong dwLen, REF string lpData ) LIBRARY "version.dll" alias for "GetFileVersionInfoA;Ansi"
FUNCTION boolean VerQueryValueA ( REF string lpBlock, string lpSubBlock, REF long lpBuffer, REF uint puLen )   LIBRARY "version.dll" alias for "VerQueryValueA;Ansi" 
FUNCTION Ulong FindWindowA( ulong stado, string aplicacion ) LIBRARY "User32.dll" Alias for "FindWindowA;Ansi"
FUNCTION ulong GetFileVersionInfoSizeA ( REF string lpFilename, REF ulong lpdwHandle ) LIBRARY "version.dll" alias for "GetFileVersionInfoSizeA;Ansi" 
FUNCTION boolean GetVolumeInformation(ref string lpRootPathName,ref string lpVolumeNameBuffer,ulong nVolumeNameSize,ref ulong lpVolumeSerialNumber,ref ulong lpMaximumComponentLength,ref ulong lpFileSystemFlags,ref string lpFileSystemNameBuffer,ulong nFileSystemNameSize) Library "kernel32.dll" alias for "GetVolumeInformationA;Ansi"
function	ulong InetAddr ( string hostip ) Library "Ws2_32.dll" ALIAS FOR 'inet_addr;Ansi'
function	int GetHostName ( ref string HOSTname, int namelen ) Library "Ws2_32.dll" ALIAS FOR 'gethostname;Ansi'
function	long GetHostByName ( string hostname ) Library "Ws2_32.dll" ALIAS FOR "gethostbyname;Ansi"
function	int GetLastError () Library "Ws2_32.dll" ALIAS FOR "WSAGetLastError"
subroutine CopyMemory ( ref long dst, long src, long nSize ) Library "kernel32.dll" Alias For "RtlMoveMemory" 
subroutine CopyMemory ( ref structure dst, long src, long nSize ) Library "kernel32.dll" Alias For "RtlMoveMemory;Ansi" 
subroutine CopyMemory ( ref string dst, long src, long nSize ) Library "kernel32.dll" Alias For "RtlMoveMemory;Ansi" 
subroutine CopyMemory ( ref char dst[], long src, long nSize ) Library "kernel32.dll" Alias For "RtlMoveMemory;Ansi" 
Function integer GetMACAddress ( ref string buf, integer len ) library "getmacip.dll" alias for "GetMACAddress;Ansi"
Function integer GetIPAddress ( ref string buf, integer len ) library "getmacip.dll" alias for "GetIPAddress;Ansi"
end prototypes

event ue_postopen();Gn_Config.Is_Work.Aplicacion 	= "Sistema"// de Informaci$$HEX1$$f300$$ENDHEX$$n Gerencial"
Gn_Config.Is_Config.HostName = gn_config.of_gethostname( )
//Gn_Config.Is_Config.Ip  			= gn_config.of_getipaddr( )
Gn_Config.Is_Config.Licencias  	= 1
ulong dis
String ls_pru

//ls_pru = gn_config.of_getmacaddr( )
//ls_pru = gn_config.of_host( )
//ls_pru = gn_config.of_terminal( )
//ls_pru = gn_config.of_getip( )


Open(w_frame)
//Open(w_process_compra)



end event

on tpplamsoft.create
appname="tpplamsoft"
message=create message
sqlca=create n_transaccion_entrar
sqlda=create dynamicdescriptionarea
sqlsa=create dynamicstagingarea
error=create error
end on

on tpplamsoft.destroy
destroy(sqlca)
destroy(sqlda)
destroy(sqlsa)
destroy(error)
destroy(message)
end on

event close;
DISCONNECT USING SQLCA;
DESTROY PBObjectNewid;
DESTROY gn_config ;

end event

event open;//Open(w_prueba)
// Create global transaction object for access to orderentry database y
long ll_result
SetNull(gs_nulo)

gl_colorboton = uf_colorboton()

Gn_Config = CREATE n_Config

Gb_Fondo = FALSE
//************************************************************************************************************************************************************************************
// Inicializo.
//************************************************************************************************************************************************************************************
sRegKey= "HKEY_CURRENT_USER\Software\LamSoft\Sacav"

Path = getcurrentdirectory()

PBObjectNewid = CREATE OLEObject

ll_result = PBObjectNewid.ConnectToNewObject("InternetExplorer.Application")
ll_result = PBObjectNewid.ConnectToNewObject( "outlook.application")
ll_result = PBObjectNewid.ConnectToNewObject( "WScript.Network" )
//IF ll_result = 0 THEN     
//	MessageBox ("Domain", string( PBObjectNewid.UserDomain ))     
//	MessageBox ("User", string( PBObjectNewid.UserName ))    
//	MessageBox ("Computer", string( PBObjectNewid.ComputerName ))
//END IF

IF ll_result < 0 THEN
	CHOOSE CASE ll_result
		CASE -1
			messagebox("INICIALIZACION GUID " ,"PBObjectNewid -No se puede cargar la Libreria Generate GUID",Information!)
		CASE -2		
			messagebox("INICIALIZACION GUID "  ,"PBObjectNewid -No se encontr$$HEX2$$f3002000$$ENDHEX$$tarjeta de Red",Information!)
		CASE -3		
			messagebox("INICIALIZACION GUID "  ,"PBObjectNewid -Fallo en la creci$$HEX1$$f300$$ENDHEX$$n de GUID",Information!)
		CASE -9		
			messagebox("INICIALIZACION GUID " ,"PBObjectNewid -Error GUID desconocido",Information!)
	END CHOOSE
END IF


THIS.triggerevent( "ue_postopen")
//OPEN(w_database_profile_setup)
end event

event systemerror;uf_report_error ()
end event

