HA$PBExportHeader$n_coneccion_entrar.sru
forward
global type n_coneccion_entrar from n_base_coneccion
end type
end forward

global type n_coneccion_entrar from n_base_coneccion autoinstantiate descriptor "PB_ObjectCodeAssistants" = "{BB0DD547-B36E-11D1-BB47-000086095DDA}" 
end type

type variables

s_tr Is_Tr_Data
s_tr Is_Tr

end variables

forward prototypes
public function integer of_inicio (string as_inifile, string as_section)
public function integer of_dbparm (string as_userid, string as_password, string as_database, ref string as_dbparm)
public function integer of_dbparm_adonet (ref string as_dbparm)
public function integer of_desconectar ()
public function boolean of_valor_ps_how_b (string as_param)
public function string of_valor_ps_how_is (string as_param)
public function string of_valor_ps_how_bs (string as_param)
public function integer of_valor_pb_how_i (boolean ab_param)
public function string of_valor_pb_how_ss (boolean ab_param)
public function string of_valor_pb_how_si (boolean ab_param)
public function string of_valor_ps_how_ss (string as_param)
public function boolean of_valor_pi_how_b (integer ai_param)
public function string of_valor_pi_how_s (integer ai_param)
public function string of_validar (string as_valor)
public function integer of_coneccion (string as_id, string as_pwd, ref n_transaccion_entrar itr_sqlca)
public function integer of_conexion_parms (string as_id, string as_pwd, ref n_transaccion_entrar itr_sqlca)
public function integer of_conexion_test (ref n_transaccion_entrar itr_sqlca)
public function string of_valor_pb_how_sb (boolean ab_param)
public function integer of_aplicar (string as_inifile, string as_section)
public function string of_validar_null (string as_valor)
public function string of_valor_defecto (string as_key)
public function string of_comparar_valor_defecto (string as_key, string as_valor)
public function string of_asignar_valor_defecto (string as_key, string as_valor)
public function integer of_asignar ()
end prototypes

public function integer of_inicio (string as_inifile, string as_section);
//SQLCA
IF ProfileString(as_inifile, as_section, "WindowLibraryName", "0") = "1" THEN
	gb_VentanaLibreria = TRUE
ELSE
	gb_VentanaLibreria = FALSE	
END IF
Is_Tr_Data.Is_Profile          				= of_Validar(ProfileString(as_inifile, as_section, "Profile"						, ""))
Is_Tr_Data.Is_DBMS						= of_Validar(ProfileString(as_inifile, as_section, "DBMS"						, ""))
Is_Tr_Data.Is_DBParm					= of_Validar(ProfileString(as_inifile, as_section, "DBParm"					, ""))
//Is_Tr_Data.Is_UserId					= of_Validar(ProfileString(as_inifile, as_section, "UserId"					, ""))
//Is_Tr_Data.Is_Password					= of_Validar(ProfileString(as_inifile, as_section, "Password"				, ""))
//Is_Tr_Data.Is_DBPass           			= of_Validar(ProfileString(as_inifile, as_section, "DBPass"					, ""))
//Is_Tr_Data.Is_Lock             				= of_Validar(ProfileString(as_inifile, as_section, "Lock"						, ""))
//Is_Tr_Data.Is_ServerName  			= of_Validar(ProfileString(as_inifile, as_section, "ServerName"				, gn_config.Is_config.hostname )))

//Connection
Is_Tr_Data.Is_NameSpace				= of_Validar(ProfileString(as_inifile, as_section, "NameSpace"				, ""))
Is_Tr_Data.Is_Provider					= of_Validar(ProfileString(as_inifile, as_section, "Provider"					, ""))
Is_Tr_Data.Is_DataSource				= of_Validar(ProfileString(as_inifile, as_section, "DataSource"				, ""))
Is_Tr_Data.Is_LogID						= of_Validar(ProfileString(as_inifile, as_section, "LogID"						, ""))
Is_Tr_Data.Is_LogPass					= of_Validar(ProfileString(as_inifile, as_section, "LogPass"					, ""))
Is_Tr_Data.Is_Database					= of_Validar(ProfileString(as_inifile, as_section, "Database"				, ""))
Is_Tr_Data.Is_AdoRelease				= of_Validar(ProfileString(as_inifile, as_section, "AdoRelease"				, ""))
Is_Tr_Data.Is_TrustedConnection		= of_Validar(ProfileString(as_inifile, as_section, "TrustedConnection"	, ""))
Is_Tr_Data.Is_FileName					= of_Validar(ProfileString(as_inifile, as_section, "FileName"					, ""))
Is_Tr_Data.Is_DataLink					= of_Validar(ProfileString(as_inifile, as_section, "DataLink"					, ""))
Is_Tr_Data.Is_ProviderString			= of_Validar(ProfileString(as_inifile, as_section, "ProviderString"			, ""))

//System
Is_Tr_Data.Is_PBCatalogOwner		= of_Validar(ProfileString(as_inifile, as_section, "PBCatalogOwner"		, ""))
Is_Tr_Data.Is_DefaultProcOwner		= of_Validar(ProfileString(as_inifile, as_section, "DefaultProcOwner"		, ""))
Is_Tr_Data.Is_SPCache					= of_Validar(ProfileString(as_inifile, as_section, "SPCache"					, ""))
Is_Tr_Data.Is_GenerateTrace			= of_Validar(ProfileString(as_inifile, as_section, "GenerateTrace"			, ""))
Is_Tr_Data.Is_CommitOnDisconnect	= of_Validar(ProfileString(as_inifile, as_section, "CommitOnDisconnect"	, ""))
Is_Tr_Data.Is_AutoCommit				= of_Validar(ProfileString(as_inifile, as_section, "AutoCommit"				, ""))
Is_Tr_Data.Ib_AutoCommit				=  of_Valor_ps_how_b(Is_Tr_Data.Is_AutoCommit)
Is_Tr_Data.Is_TimeOut					= of_Validar(ProfileString(as_inifile, as_section, "TimeOut"					, ""))
Is_Tr_Data.Is_CommandTimeout		= of_Validar(ProfileString(as_inifile, as_section, "CommandTimeout"		, ""))
Is_Tr_Data.Is_DbConfigSection		= of_Validar(ProfileString(as_inifile, as_section, "DbConfigSection"		, ""))

//Transaction
Is_Tr_Data.Is_Isolation					= of_Validar(ProfileString(as_inifile, as_section, "Isolation"					, ""))
Is_Tr_Data.Is_Disablebind				= of_Validar(ProfileString(as_inifile, as_section, "Disablebind"				, ""))
Is_Tr_Data.Is_StaticBind				= of_Validar(ProfileString(as_inifile, as_section, "StaticBind"				, ""))
Is_Tr_Data.Is_NCharBind				= of_Validar(ProfileString(as_inifile, as_section, "NCharBind"				, ""))
Is_Tr_Data.Is_PBMaxBlobSize			= of_Validar(ProfileString(as_inifile, as_section, "PBMaxBlobSize"			, ""))

//Syntax
Is_Tr_Data.Is_DelimitIdentifier			= of_Validar(ProfileString(as_inifile, as_section, "DelimitIdentifier"			, ""))
Is_Tr_Data.Is_TrimSpaces				= of_Validar(ProfileString(as_inifile, as_section, "TrimSpaces"				, ""))
Is_Tr_Data.Is_IdentifierQuoteChar	= of_Validar(ProfileString(as_inifile, as_section, "IdentifierQuoteChar"	, ""))
Is_Tr_Data.Is_DateFormat				= of_Validar(ProfileString(as_inifile, as_section, "DateFormat"				, ""))
Is_Tr_Data.Is_DateTimeFormat		= of_Validar(ProfileString(as_inifile, as_section, "DateTimeFormat"		, ""))
Is_Tr_Data.Is_TimeFormat				= of_Validar(ProfileString(as_inifile, as_section, "TimeFormat"				, ""))
Is_Tr_Data.Is_DecimalSeparator		= of_Validar(ProfileString(as_inifile, as_section, "DecimalSeparator"		, ""))
Is_Tr_Data.Is_OJSyntax				= of_Validar(ProfileString(as_inifile, as_section, "OJSyntax"				, ""))


//SQLCA                                                                              //SQLCA                                                                                                                  
Is_Tr.Is_Profile          				= of_asignar_valor_defecto("Profile"						,Is_Tr_Data.Is_Profile)                                                                                                           
Is_Tr.Is_DBMS      					= of_asignar_valor_defecto("DBMS"						,Is_Tr_Data.Is_DBMS)                                                                                                           
Is_Tr.Is_DBParm   				= of_asignar_valor_defecto("DBParm"					,Is_Tr_Data.Is_DBParm)                                                                                                           
Is_Tr.Is_UserId					= of_asignar_valor_defecto("UserId"						,Is_Tr_Data.Is_UserId)                                                                                                           
Is_Tr.Is_Password				= of_asignar_valor_defecto("Password"					,Is_Tr_Data.Is_Password)                                                                                                           
Is_Tr.Is_DBPass           		  	= of_asignar_valor_defecto("DBPass"					,Is_Tr_Data.Is_DBPass)                                                                                                           
Is_Tr.Is_Lock             				= of_asignar_valor_defecto("Lock"						,Is_Tr_Data.Is_Lock)                                                                                                           
Is_Tr.Is_ServerName      	    	= of_asignar_valor_defecto("ServerName"				,Is_Tr_Data.Is_ServerName)                                                                   
                                                                                                                                                                                                              
//Connection                                                                         //Connection                                                                                                             
Is_Tr.Is_NameSpace				= of_asignar_valor_defecto("NameSpace"				,Is_Tr_Data.Is_NameSpace)                                                                                                          
Is_Tr.Is_Provider					= of_asignar_valor_defecto("Provider"					,Is_Tr_Data.Is_Provider)                                                                                                           
Is_Tr.Is_DataSource				= of_asignar_valor_defecto("DataSource"				,Is_Tr_Data.Is_DataSource)                                                                                                         
Is_Tr.Is_LogID 					= of_asignar_valor_defecto("LogID"						,Is_Tr_Data.Is_LogID)                                                                                                           
Is_Tr.Is_LogPass					= of_asignar_valor_defecto("LogPass"					,Is_Tr_Data.Is_LogPass)                                                                                                           
Is_Tr.Is_Database				= of_asignar_valor_defecto("Database"					,Is_Tr_Data.Is_Database)                                                                                                           
Is_Tr.Is_AdoRelease				= of_asignar_valor_defecto("AdoRelease"				,Is_Tr_Data.Is_AdoRelease)                                                                                                         
Is_Tr.Is_TrustedConnection	= of_asignar_valor_defecto("TrustedConnection"		,Is_Tr_Data.Is_TrustedConnection)                                                                                                  
Is_Tr.Is_FileName		               = of_asignar_valor_defecto("FileName"					,Is_Tr_Data.Is_FileName)                                                                                                           
Is_Tr.Is_DataLink					= of_asignar_valor_defecto("DataLink"					,Is_Tr_Data.Is_DataLink)                                                                                                           
Is_Tr.Is_ProviderString			= of_asignar_valor_defecto("ProviderString"			,Is_Tr_Data.Is_ProviderString)                                                                                                     
                                                                                                                                                                                                              
//System                                                                             //System                                                                                                                 
Is_Tr.Is_PBCatalogOwner		= of_asignar_valor_defecto("PBCatalogOwner"		,Is_Tr_Data.Is_PBCatalogOwner)                                                                                                     
Is_Tr.Is_DefaultProcOwner		= of_asignar_valor_defecto("DefaultProcOwner"		,Is_Tr_Data.Is_DefaultProcOwner)                                                                                                   
Is_Tr.Is_SPCache              	  	= of_asignar_valor_defecto("SPCache"					,Is_Tr_Data.Is_SPCache)                                                                                                           
Is_Tr.Is_GenerateTrace      		= of_asignar_valor_defecto("GenerateTrace"			,Is_Tr_Data.Is_GenerateTrace)                                                                                                      
Is_Tr.Is_CommitOnDisconnect	= of_asignar_valor_defecto("CommitOnDisconnect"	,Is_Tr_Data.Is_CommitOnDisconnect)                                                                                                 
Is_Tr.Is_AutoCommit				= of_asignar_valor_defecto("AutoCommit"				,Is_Tr_Data.Is_AutoCommit)                                                                                                         
Is_Tr.Ib_AutoCommit				= of_Valor_ps_how_b(Is_Tr.Is_AutoCommit)                                                                                                          
Is_Tr.Is_TimeOut					= of_asignar_valor_defecto("TimeOut"					,Is_Tr_Data.Is_TimeOut)                                                                                                           
Is_Tr.Is_CommandTimeout		= of_asignar_valor_defecto("CommandTimeout"		,Is_Tr_Data.Is_CommandTimeout)                                                                                                     
Is_Tr.Is_DbConfigSection		= of_asignar_valor_defecto("DbConfigSection"		,Is_Tr_Data.Is_DbConfigSection)                                                                                                    
                                                                                                                                                                                                              
//Transaction                                                                        //Transaction                                                                                                            
Is_Tr.Is_Isolation					= of_asignar_valor_defecto("Isolation"					,Is_Tr_Data.Is_Isolation)                                                                                                          
Is_Tr.Is_Disablebind				= of_asignar_valor_defecto("Disablebind"				,Is_Tr_Data.Is_Disablebind)                                                                                                        
Is_Tr.Is_StaticBind				= of_asignar_valor_defecto("StaticBind"					,Is_Tr_Data.Is_StaticBind)                                                                                                         
Is_Tr.Is_NCharBind				= of_asignar_valor_defecto("NCharBind"				,Is_Tr_Data.Is_NCharBind)                                                                                                          
Is_Tr.Is_PBMaxBlobSize			= of_asignar_valor_defecto("PBMaxBlobSize"			,Is_Tr_Data.Is_PBMaxBlobSize)                                                                                                      
                                                                                                                                                                                                              
//Syntax                                                                             //Syntax                                                                                                                 
Is_Tr.Is_DelimitIdentifier			= of_asignar_valor_defecto("DelimitIdentifier"			,Is_Tr_Data.Is_DelimitIdentifier)                                                                                                  
Is_Tr.Is_TrimSpaces				= of_asignar_valor_defecto("TrimSpaces"				,Is_Tr_Data.Is_TrimSpaces)                                                                                                         
Is_Tr.Is_IdentifierQuoteChar	= of_asignar_valor_defecto("IdentifierQuoteChar"	,Is_Tr_Data.Is_IdentifierQuoteChar)                                                                                                
Is_Tr.Is_DateFormat				= of_asignar_valor_defecto("DateFormat"				,Is_Tr_Data.Is_DateFormat)                                                                                                         
Is_Tr.Is_DateTimeFormat		= of_asignar_valor_defecto("DateTimeFormat"		,Is_Tr_Data.Is_DateTimeFormat)                                                                                                     
Is_Tr.Is_TimeFormat				= of_asignar_valor_defecto("TimeFormat"				,Is_Tr_Data.Is_TimeFormat)                                                                                                         
Is_Tr.Is_DecimalSeparator		= of_asignar_valor_defecto("DecimalSeparator"		,Is_Tr_Data.Is_DecimalSeparator)                                                                                                   
Is_Tr.Is_OJSyntax				= of_asignar_valor_defecto("OJSyntax"					,Is_Tr_Data.Is_OJSyntax)                                                                                                           

IF  Trim(Is_Tr_Data.Is_Database) = "" OR Trim(Is_Tr_Data.Is_DBMS) = "" THEN
	RETURN -1
ELSE
	RETURN 1
END IF



end function

public function integer of_dbparm (string as_userid, string as_password, string as_database, ref string as_dbparm);IF as_database = "" OR as_userid = "" OR as_password = "" THEN
	RETURN -1 
ELSE
	as_dbparm = "ConnectString='DSN=" + as_database + ";UID=" + & 
		as_userid + ";PWD=" + as_password + &
		"',Disablebind=1, ConnectOption ='SQL_DRIVER_CONNECT,SQL_DRIVER_NOPROMPT',CommitOnDisconnect='No' ,Date=' \''DD/MM/YYYY\'' ',DateTime=' \''DD/MM/YYYY HH:MM:SS\'' ',Time=' \''HH:MM:SS\'' '"
	RETURN 1
END IF




end function

public function integer of_dbparm_adonet (ref string as_dbparm);IF Is_Tr.Is_DataBase = "" THEN
	RETURN -1 
ELSE


as_DBParm = ""+ &
"Namespace='System.Data.SqlClient',"+ &
"DataSource='"+Is_Tr.Is_ServerName+ "',"+& 
"Database='"+Is_Tr.Is_DataBase +"',"+& 
"Isolation='"+Is_Tr.is_Lock+"',"+&  
"TrustedConnection="+Is_Tr.is_TrustedConnection+","+& 
 Is_Tr.Is_DBParm +","+&  
"PROVIDERSTRING='App = "+ Gn_Config.Is_Work.Aplicacion +" ; WSID = "+gn_config.is_config.hostname+" en "+gn_config.is_config.ip+"'"


	RETURN 1
END IF


//'Application Name =PB10 DESARROLLO ; Workstation ID = IPJLAM'
//SQLCA.DBParm =Language='Spanish',Database='Standard',PBCatalogOwner='dbo',DefaultProcOwner='dbo',DisableBind=0,CommitOnDisconnect='No',StaticBind=0,Isolation='TS',DateFormat='DD/MM/YYYY',DateTimeFormat='DD/MM/YYYY HH:MM:SS',TimeFormat='HH:MM:SS',OptSelectBlob=1,AtAtIdentity=1,MaxConnect=50"

end function

public function integer of_desconectar ();Int ret
ret =1
//Try 
  Disconnect Using SQLCA;
/*
catch ( runtimeerror e )
	  ret =0 
	  messagebox("exception", e.getmessage())
Finally
*/	
	Return ret
//end try


end function

public function boolean of_valor_ps_how_b (string as_param);Boolean lb_ret
CHOOSE CASE Upper(as_param)
	CASE "1","TRUE","SI","OK","VERDAD","YES"
		lb_ret = TRUE
	CASE ELSE
		lb_ret = FALSE
END CHOOSE

RETURN lb_ret

end function

public function string of_valor_ps_how_is (string as_param);String lb_ret
choose case Upper(as_param)
	case "1","TRUE","SI","OK","VERDAD","YES"
		lb_ret = "1"
	case "0","false","NO","CANCEL","FALSO"
		lb_ret = "0"	
	Case else
			SetNull(lb_ret)
end choose

Return lb_ret
end function

public function string of_valor_ps_how_bs (string as_param);String lb_ret
choose case Upper(as_param)
	case "1","TRUE","SI","OK","VERDAD","YES"
		lb_ret = "True"
	case "0","FALSE","NO","CANCEL","FALSO"
		lb_ret = "False"
	Case else
			SetNull(lb_ret)
end choose

Return lb_ret
end function

public function integer of_valor_pb_how_i (boolean ab_param);integer li_ret
If ab_param Then
	li_ret =1
Else
	li_ret=0
End If

Return li_ret
end function

public function string of_valor_pb_how_ss (boolean ab_param);String ls_ret
If ab_param Then
	ls_ret ="Yes"
Else
	ls_ret="No"
End If

Return ls_ret
end function

public function string of_valor_pb_how_si (boolean ab_param);string ls_ret
If ab_param Then
	ls_ret ="1"
Else
	ls_ret="0"
End If

Return ls_ret
end function

public function string of_valor_ps_how_ss (string as_param);String lb_ret
choose case Upper(as_param)
	case "1","TRUE","SI","OK","VERDAD","YES"
		lb_ret = "Yes"
	case "0","false","NO","CANCEL","FALSO"
		lb_ret = "No"	
	Case else
			SetNull(lb_ret)
end choose

Return lb_ret
end function

public function boolean of_valor_pi_how_b (integer ai_param);boolean lb_ret
If (ai_param = 1 ) Then
	lb_ret =True
ElseIf (ai_param = 0 ) Then
	lb_ret=False
Else
	SetNull(lb_ret)
End If

Return lb_ret
end function

public function string of_valor_pi_how_s (integer ai_param);string ls_ret
If (ai_param = 1 ) Then
	ls_ret ="Yes"
ElseIf (ai_param = 0 ) Then
	ls_ret="No"
Else
	SetNull(ls_ret)
End If

Return ls_ret
end function

public function string of_validar (string as_valor);
String ls_Retorno

If IsNull(as_Valor) OR Trim(as_Valor) = "" Then SetNull(ls_Retorno) Else ls_Retorno = as_Valor

Return ls_Retorno
end function

public function integer of_coneccion (string as_id, string as_pwd, ref n_transaccion_entrar itr_sqlca);
If of_conexion_parms(  as_id,  as_pwd, itr_sqlca ) = 1 THEN
//	Try 
		CONNECT USING itr_SQLCA;
/*
catch ( runtimeerror e )
		  messagebox("exception", e.getmessage())
	Finally
*/		
		IF itr_SQLCA.SQLCode < 0 THEN
			MessageBox(Gn_Config.Is_Work.Aplicacion+ "  Error de Conecci$$HEX1$$f300$$ENDHEX$$n", itr_SQLCA.SQLErrText,StopSign!)
			Return -1
		ELSE
			Return 1
		END IF
//	end try

ELSE
	Return -1
END IF







end function

public function integer of_conexion_parms (string as_id, string as_pwd, ref n_transaccion_entrar itr_sqlca);
String	ls_dbparm
choose case Upper(Mid(Is_Tr.Is_DBMS,1,3))
	case "ADO"
		itr_SQLCA.LogId = as_Id
		itr_SQLCA.LogPass = as_Pwd 
		itr_SQLCA.Is_Tr_Data = Is_Tr_Data
		itr_SQLCA.Is_Tr = Is_Tr		
		itr_SQLCA.of_ado_net( )
		//this.of_dbparm_adonet(ls_dbparm)
	case "JDB"
		itr_SQLCA.DBMS = "ADO.Net"
		itr_SQLCA.LogId = as_id
		itr_SQLCA.LogPass = as_pwd
		//this.of_dbparm_jdbc(ls_dbparm)
	case "ODB"
		itr_SQLCA.DBMS = "ADO.Net"
		itr_SQLCA.LogId = as_id
		itr_SQLCA.LogPass = as_pwd
		//this.of_dbparm_odbc(ls_dbparm)
	case "O10"
		itr_SQLCA.DBMS =  "O10 Oracle10g (10.1.0)"
		itr_SQLCA.LogId = as_Id
		itr_SQLCA.LogPass = as_Pwd 
		itr_SQLCA.Is_Tr_Data = Is_Tr_Data
		itr_SQLCA.Is_Tr = Is_Tr		
		itr_SQLCA.of_oracle( )
		//SQLCA.DBParm = "PackageProcs=1,QualifyPublic=1,PBCatalogOwner='ENVIOS'"
		//this.of_dbparm_odbc(ls_dbparm)			
end choose
/*
// Profile SA
**SQLCA.DBMS = "O10 Oracle10g (10.1.0)"
**SQLCA.LogPass = <******>
SQLCA.ServerName = "XE"
**SQLCA.LogId = "SA"
SQLCA.AutoCommit = False
SQLCA.DBParm = "PackageProcs=1,QualifyPublic=1,PBCatalogOwner='ENVIOS'"

*/

Return 1









end function

public function integer of_conexion_test (ref n_transaccion_entrar itr_sqlca);
//Try 
	CONNECT USING itr_SQLCA;
/*
Catch ( runtimeerror e )
	  messagebox("exception", e.getmessage())
Finally
*/	
	IF itr_SQLCA.SQLCode = 0 THEN
		DISCONNECT USING itr_SQLCA;
		MessageBox(Gn_Config.Is_Work.Aplicacion ,"Conexi$$HEX1$$f300$$ENDHEX$$n exitosa")
		Return 1
	ELSEIF itr_SQLCA.SQLCode < 0 THEN
		MessageBox(Gn_Config.Is_Work.Aplicacion+ "  Error de Conexi$$HEX1$$f300$$ENDHEX$$n", itr_SQLCA.SQLErrText,StopSign!)
		Return -1
	ELSE
		Return 1
	END IF
//end try








end function

public function string of_valor_pb_how_sb (boolean ab_param);String ls_ret
If ab_param Then
	ls_ret ="True"
Else
	ls_ret="False"
End If

Return ls_ret
end function

public function integer of_aplicar (string as_inifile, string as_section);
//SQLCA                                                 
SetProfileString(as_inifile, as_section, "Profile"						,of_Comparar_Valor_Defecto("Profile"					,of_Validar_Null(Is_Tr.Is_Profile)))                
SetProfileString(as_inifile, as_section, "DBMS"						,of_Comparar_Valor_Defecto("DBMS"					,of_Validar_Null(Is_Tr.Is_DBMS)))                                  
                                                                                                               
//Connection                                      
SetProfileString(as_inifile, as_section, "NameSpace"				,of_Comparar_Valor_Defecto("NameSpace"				,of_Validar_Null(Is_Tr.Is_NameSpace)))              
SetProfileString(as_inifile, as_section, "Provider"					,of_Comparar_Valor_Defecto("Provider"					,of_Validar_Null(Is_Tr.Is_Provider)))                
SetProfileString(as_inifile, as_section, "DataSource"				,of_Comparar_Valor_Defecto("DataSource"				,of_Validar_Null(Is_Tr.Is_DataSource)))             
SetProfileString(as_inifile, as_section, "LogID"						,of_Comparar_Valor_Defecto("LogID"					,of_Validar_Null(Is_Tr.Is_LogID)))                      
SetProfileString(as_inifile, as_section, "LogPass"					,of_Comparar_Valor_Defecto("LogPass"					,of_Validar_Null(Is_Tr.Is_LogPass)))                  
SetProfileString(as_inifile, as_section, "Database"					,of_Comparar_Valor_Defecto( "Database"				,of_Validar_Null(Is_Tr.Is_Database)))                  
SetProfileString(as_inifile, as_section, "AdoRelease"				,of_Comparar_Valor_Defecto("AdoRelease"			,of_Validar_Null(Is_Tr.Is_AdoRelease)))             
SetProfileString(as_inifile, as_section, "TrustedConnection"		,of_Comparar_Valor_Defecto("TrustedConnection"	,of_Validar_Null(Is_Tr.Is_TrustedConnection)))      
SetProfileString(as_inifile, as_section, "FileName"					,of_Comparar_Valor_Defecto("FileName"				,of_Validar_Null(Is_Tr.Is_FileName)))               
SetProfileString(as_inifile, as_section, "DataLink"					,of_Comparar_Valor_Defecto("DataLink"					,of_Validar_Null(Is_Tr.Is_DataLink)))                
SetProfileString(as_inifile, as_section, "ProviderString"			,of_Comparar_Valor_Defecto("ProviderString"			,of_Validar_Null(Is_Tr.Is_ProviderString)))         
                                                                                                                
//System                                          
SetProfileString(as_inifile, as_section, "PBCatalogOwner"		,of_Comparar_Valor_Defecto("PBCatalogOwner"		,of_Validar_Null(Is_Tr.Is_PBCatalogOwner)))         
SetProfileString(as_inifile, as_section, "DefaultProcOwner"		,of_Comparar_Valor_Defecto("DefaultProcOwner"	,of_Validar_Null(Is_Tr.Is_DefaultProcOwner)))       
SetProfileString(as_inifile, as_section, "SPCache"					,of_Comparar_Valor_Defecto("SPCache"				,of_Validar_Null(Is_Tr.Is_SPCache)))                
SetProfileString(as_inifile, as_section, "GenerateTrace"			,of_Comparar_Valor_Defecto("GenerateTrace"		,of_Validar_Null(Is_Tr.Is_GenerateTrace)))          
SetProfileString(as_inifile, as_section, "CommitOnDisconnect"	,of_Comparar_Valor_Defecto("CommitOnDisconnect"	,of_Validar_Null(Is_Tr.Is_CommitOnDisconnect)))     
SetProfileString(as_inifile, as_section, "AutoCommit"				,of_Comparar_Valor_Defecto("AutoCommit"			,of_Validar_Null(Is_Tr.Is_AutoCommit)))             
SetProfileString(as_inifile, as_section, "TimeOut"					,of_Comparar_Valor_Defecto("TimeOut"					,of_Validar_Null(Is_Tr.Is_TimeOut)))                  
SetProfileString(as_inifile, as_section, "CommandTimeout"		,of_Comparar_Valor_Defecto("CommandTimeout"		,of_Validar_Null(Is_Tr.Is_CommandTimeout)))         
SetProfileString(as_inifile, as_section, "DbConfigSection"		,of_Comparar_Valor_Defecto("DbConfigSection"		,of_Validar_Null(Is_Tr.Is_DbConfigSection)))        
                                                                                                                 
//Transaction                                     
SetProfileString(as_inifile, as_section, "Isolation"					,of_Comparar_Valor_Defecto("Isolation"					,of_Validar_Null(Is_Tr.Is_Isolation)))              
SetProfileString(as_inifile, as_section, "Disablebind"				,of_Comparar_Valor_Defecto("Disablebind"				,of_Validar_Null(Is_Tr.Is_Disablebind)))            
SetProfileString(as_inifile, as_section, "StaticBind"					,of_Comparar_Valor_Defecto("StaticBind"				,of_Validar_Null(Is_Tr.Is_StaticBind)))             
SetProfileString(as_inifile, as_section, "NCharBind"				,of_Comparar_Valor_Defecto("NCharBind"				,of_Validar_Null(Is_Tr.Is_NCharBind)))              
SetProfileString(as_inifile, as_section, "PBMaxBlobSize"			,of_Comparar_Valor_Defecto("PBMaxBlobSize"			,of_Validar_Null(Is_Tr.Is_PBMaxBlobSize)))          
                                                                                                                 
//Syntax                                          
SetProfileString(as_inifile, as_section, "DelimitIdentifier"			,of_Comparar_Valor_Defecto("DelimitIdentifier"		,of_Validar_Null(Is_Tr.Is_DelimitIdentifier)))      
SetProfileString(as_inifile, as_section, "TrimSpaces"				,of_Comparar_Valor_Defecto("TrimSpaces"				,of_Validar_Null(Is_Tr.Is_TrimSpaces)))             
SetProfileString(as_inifile, as_section, "IdentifierQuoteChar"	,of_Comparar_Valor_Defecto("IdentifierQuoteChar"	,of_Validar_Null(Is_Tr.Is_IdentifierQuoteChar)))    
SetProfileString(as_inifile, as_section, "DateFormat"				,of_Comparar_Valor_Defecto("DateFormat"			,of_Validar_Null(Is_Tr.Is_DateFormat)))             
SetProfileString(as_inifile, as_section, "DateTimeFormat"		,of_Comparar_Valor_Defecto("DateTimeFormat"		,of_Validar_Null(Is_Tr.Is_DateTimeFormat)))         
SetProfileString(as_inifile, as_section, "TimeFormat"				,of_Comparar_Valor_Defecto("TimeFormat"				,of_Validar_Null(Is_Tr.Is_TimeFormat)))             
SetProfileString(as_inifile, as_section, "DecimalSeparator"		,of_Comparar_Valor_Defecto("DecimalSeparator"		,of_Validar_Null(Is_Tr.Is_DecimalSeparator)))       
SetProfileString(as_inifile, as_section, "OJSyntax"					,of_Comparar_Valor_Defecto("OJSyntax"				,of_Validar_Null(Is_Tr.Is_OJSyntax)))

RETURN 1




end function

public function string of_validar_null (string as_valor);
String ls_Retorno

If IsNull(as_Valor) OR Trim(as_Valor) = "" Then ls_Retorno="" Else ls_Retorno = as_Valor

Return ls_Retorno
end function

public function string of_valor_defecto (string as_key);String ls_Valor_Defecto 

ls_Valor_Defecto=""

IF Upper(as_Key) = "DBMS" 			THEN ls_Valor_Defecto="ADO.Net"
IF Upper(as_Key) = "NAMESPACE" 	THEN ls_Valor_Defecto="System.Data.SqlClient"
CHOOSE CASE Upper(Is_Tr.Is_DBMS)
	CASE "ADO.NET"
	CHOOSE CASE Upper(Is_Tr.Is_Namespace)
		CASE "ORACLE.DATAACCESS.CLIENT"
		CASE "SYBASE.DATA.ASECLIENT"
		CASE "SYSTEM.DATA.OLEDB"
		CASE "SYSTEM.DATA.SQLCLIENT"	
		CHOOSE CASE Upper(as_Key)
			//Connection               
			CASE  "NAMESPACE"		
				ls_Valor_Defecto="" 
			CASE  "PROVIDER"					
				ls_Valor_Defecto=""  
			CASE  "DATASOURCE"				
				ls_Valor_Defecto="" 
			CASE  "LOGID"							
				ls_Valor_Defecto="Sa"     
			CASE  "LOGPASS"						
				ls_Valor_Defecto="Sa2005"   
			CASE  "DATABASE"					
				ls_Valor_Defecto="Standard"    
			CASE  "ADORELEASE"				
				ls_Valor_Defecto="" 
			CASE  "TRUSTEDCONNECTION"	
				ls_Valor_Defecto="0" 
			CASE  "FILENAME"					
				ls_Valor_Defecto="" 
			CASE  "DATALINK"					
				ls_Valor_Defecto=""  
			CASE  "PROVIDERSTRING"		
				ls_Valor_Defecto=""                      
			//System                   
			CASE  "PBCATALOGOWNER"		
				ls_Valor_Defecto="" 
			CASE  "DEFAULTPROCOWNER"	
				ls_Valor_Defecto="" 
			CASE  "SPCACHE"						
				ls_Valor_Defecto="50" 
			CASE  "GENERATETRACE"			
				ls_Valor_Defecto="" 
			CASE  "COMMITONDISCONNECT"
				ls_Valor_Defecto="Yes" 
			CASE  "AUTOCOMMIT"				
				ls_Valor_Defecto="False" 
			CASE  "TIMEOUT"						
				ls_Valor_Defecto=""   
			CASE  "COMMANDTIMEOUT"		
				ls_Valor_Defecto="" 
			CASE  "DBCONFIGSECTION"		
				ls_Valor_Defecto=""                       
			//Transaction              
			CASE  "ISOLATION"					
				ls_Valor_Defecto="" 
			CASE  "DISABLEBIND"				
				ls_Valor_Defecto="1" 
			CASE  "STATICBIND"				
				ls_Valor_Defecto="1" 
			CASE  "NCHARBIND"					
				ls_Valor_Defecto="" 
			CASE  "PBMAXBLOBSIZE"			
				ls_Valor_Defecto="1024000" 
			//Syntax                   
			CASE  "DELIMITIDENTIFIER"	
				ls_Valor_Defecto="No" 
			CASE  "TRIMSPACES"				
				ls_Valor_Defecto="0" 
			CASE  "IDENTIFIERQUOTECHAR"
				ls_Valor_Defecto=""   
			CASE  "DATEFORMAT"				
				ls_Valor_Defecto="" 
			CASE  "DATETIMEFORMAT"		
				ls_Valor_Defecto="" 
			CASE  "TIMEFORMAT"				
				ls_Valor_Defecto="" 
			CASE  "DECIMALSEPARATOR"	
				ls_Valor_Defecto="." 
			CASE  "OJSYNTAX"					
				ls_Valor_Defecto="ANSI_ESCAPE"
			CASE ELSE
				ls_Valor_Defecto=""				
		END CHOOSE
	END CHOOSE		
END CHOOSE
			
RETURN ls_Valor_Defecto
end function

public function string of_comparar_valor_defecto (string as_key, string as_valor);String ls_Valor_Defecto

IF Trim(as_Valor) = "" OR IsNull(as_Valor) THEN RETURN ""

IF of_Valor_Defecto(as_key) = as_Valor THEN
	ls_Valor_Defecto = ""
ELSE
	ls_Valor_Defecto = as_Valor
END IF

RETURN ls_Valor_Defecto
end function

public function string of_asignar_valor_defecto (string as_key, string as_valor);String ls_Valor_Defecto

IF Trim(as_Valor) = "" OR IsNull(as_Valor) THEN 
	ls_Valor_Defecto = of_Valor_Defecto(as_key)
ELSE
	ls_Valor_Defecto = as_Valor
END IF

RETURN ls_Valor_Defecto
end function

public function integer of_asignar ();
//SQLCA                                                 
Is_Tr_Data.Is_Profile						=   of_Validar(of_Comparar_Valor_Defecto("Profile"						,of_Validar_Null(Is_Tr.Is_Profile)))                
Is_Tr_Data.Is_DBMS						=   of_Validar(of_Comparar_Valor_Defecto("DBMS"						,of_Validar_Null(Is_Tr.Is_DBMS)))                                  
                                                                                                               
//Connection                                      
Is_Tr_Data.Is_NameSpace				=   of_Validar(of_Comparar_Valor_Defecto("NameSpace"				,of_Validar_Null(Is_Tr.Is_NameSpace)))              
Is_Tr_Data.Is_Provider					=   of_Validar(of_Comparar_Valor_Defecto("Provider"					,of_Validar_Null(Is_Tr.Is_Provider)))                
Is_Tr_Data.Is_DataSource				=   of_Validar(of_Comparar_Valor_Defecto("DataSource"				,of_Validar_Null(Is_Tr.Is_DataSource)))             
Is_Tr_Data.Is_LogID						=   of_Validar(of_Comparar_Valor_Defecto("LogID"						,of_Validar_Null(Is_Tr.Is_LogID)))                      
Is_Tr_Data.Is_LogPass					=   of_Validar(of_Comparar_Valor_Defecto("LogPass"					,of_Validar_Null(Is_Tr.Is_LogPass)))                  
Is_Tr_Data.Is_Database					=   of_Validar(of_Comparar_Valor_Defecto( "Database"					,of_Validar_Null(Is_Tr.Is_Database)))                  
Is_Tr_Data.Is_AdoRelease				=   of_Validar(of_Comparar_Valor_Defecto("AdoRelease"				,of_Validar_Null(Is_Tr.Is_AdoRelease)))             
Is_Tr_Data.Is_TrustedConnection		=   of_Validar(of_Comparar_Valor_Defecto("TrustedConnection"		,of_Validar_Null(Is_Tr.Is_TrustedConnection)))      
Is_Tr_Data.Is_FileName					=   of_Validar(of_Comparar_Valor_Defecto("FileName"					,of_Validar_Null(Is_Tr.Is_FileName)))               
Is_Tr_Data.Is_DataLink					=   of_Validar(of_Comparar_Valor_Defecto("DataLink"					,of_Validar_Null(Is_Tr.Is_DataLink)))                
Is_Tr_Data.Is_ProviderString			=   of_Validar(of_Comparar_Valor_Defecto("ProviderString"			,of_Validar_Null(Is_Tr.Is_ProviderString)))         
                                                                                                                
//System                                          
Is_Tr_Data.Is_PBCatalogOwner		=   of_Validar(of_Comparar_Valor_Defecto("PBCatalogOwner"			,of_Validar_Null(Is_Tr.Is_PBCatalogOwner)))         
Is_Tr_Data.Is_DefaultProcOwner		=   of_Validar(of_Comparar_Valor_Defecto("DefaultProcOwner"		,of_Validar_Null(Is_Tr.Is_DefaultProcOwner)))       
Is_Tr_Data.Is_SPCache					=   of_Validar(of_Comparar_Valor_Defecto("SPCache"					,of_Validar_Null(Is_Tr.Is_SPCache)))                
Is_Tr_Data.Is_GenerateTrace			=   of_Validar(of_Comparar_Valor_Defecto("GenerateTrace"			,of_Validar_Null(Is_Tr.Is_GenerateTrace)))          
Is_Tr_Data.Is_CommitOnDisconnect	=   of_Validar(of_Comparar_Valor_Defecto("CommitOnDisconnect"	,of_Validar_Null(Is_Tr.Is_CommitOnDisconnect)))     
Is_Tr_Data.Is_AutoCommit				=   of_Validar(of_Comparar_Valor_Defecto("AutoCommit"				,of_Validar_Null(Is_Tr.Is_AutoCommit))) 
Is_Tr_Data.Ib_AutoCommit				=   of_Valor_ps_how_b(Is_Tr_Data.Is_AutoCommit)
Is_Tr_Data.Is_TimeOut					=   of_Validar(of_Comparar_Valor_Defecto("TimeOut"					,of_Validar_Null(Is_Tr.Is_TimeOut)))                  
Is_Tr_Data.Is_CommandTimeout		=   of_Validar(of_Comparar_Valor_Defecto("CommandTimeout"		,of_Validar_Null(Is_Tr.Is_CommandTimeout)))         
Is_Tr_Data.Is_DbConfigSection		=   of_Validar(of_Comparar_Valor_Defecto("DbConfigSection"			,of_Validar_Null(Is_Tr.Is_DbConfigSection)))        
                                                                                                                 
//Transaction                                     
Is_Tr_Data.Is_Isolation					=   of_Validar(of_Comparar_Valor_Defecto("Isolation"					,of_Validar_Null(Is_Tr.Is_Isolation)))              
Is_Tr_Data.Is_Disablebind				=   of_Validar(of_Comparar_Valor_Defecto("Disablebind"				,of_Validar_Null(Is_Tr.Is_Disablebind)))            
Is_Tr_Data.Is_StaticBind				=   of_Validar(of_Comparar_Valor_Defecto("StaticBind"					,of_Validar_Null(Is_Tr.Is_StaticBind)))             
Is_Tr_Data.Is_NCharBind				=   of_Validar(of_Comparar_Valor_Defecto("NCharBind"					,of_Validar_Null(Is_Tr.Is_NCharBind)))              
Is_Tr_Data.Is_PBMaxBlobSize			=   of_Validar(of_Comparar_Valor_Defecto("PBMaxBlobSize"			,of_Validar_Null(Is_Tr.Is_PBMaxBlobSize)))          
                                                                                                                 
//Syntax                                          
Is_Tr_Data.Is_DelimitIdentifier			=   of_Validar(of_Comparar_Valor_Defecto("DelimitIdentifier"			,of_Validar_Null(Is_Tr.Is_DelimitIdentifier)))      
Is_Tr_Data.Is_TrimSpaces				=   of_Validar(of_Comparar_Valor_Defecto("TrimSpaces"				,of_Validar_Null(Is_Tr.Is_TrimSpaces)))             
Is_Tr_Data.Is_IdentifierQuoteChar	=   of_Validar(of_Comparar_Valor_Defecto("IdentifierQuoteChar"	,of_Validar_Null(Is_Tr.Is_IdentifierQuoteChar)))    
Is_Tr_Data.Is_DateFormat				=   of_Validar(of_Comparar_Valor_Defecto("DateFormat"				,of_Validar_Null(Is_Tr.Is_DateFormat)))             
Is_Tr_Data.Is_DateTimeFormat		=   of_Validar(of_Comparar_Valor_Defecto("DateTimeFormat"			,of_Validar_Null(Is_Tr.Is_DateTimeFormat)))         
Is_Tr_Data.Is_TimeFormat				=   of_Validar(of_Comparar_Valor_Defecto("TimeFormat"				,of_Validar_Null(Is_Tr.Is_TimeFormat)))             
Is_Tr_Data.Is_DecimalSeparator		=   of_Validar(of_Comparar_Valor_Defecto("DecimalSeparator"		,of_Validar_Null(Is_Tr.Is_DecimalSeparator)))       
Is_Tr_Data.Is_OJSyntax				=   of_Validar(of_Comparar_Valor_Defecto("OJSyntax"					,of_Validar_Null(Is_Tr.Is_OJSyntax)))

RETURN 1




end function

on n_coneccion_entrar.create
call super::create
end on

on n_coneccion_entrar.destroy
call super::destroy
end on

