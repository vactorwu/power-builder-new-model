HA$PBExportHeader$n_transaccion_entrar.sru
forward
global type n_transaccion_entrar from n_base_transaccion
end type
end forward

global type n_transaccion_entrar from n_base_transaccion
end type
global n_transaccion_entrar n_transaccion_entrar

type prototypes
function long Usp_Empresa_Cod(ref string CodEmpresa,int Largo) RPCFUNC ALIAS FOR "SISTEM.Usp_Empresa_Cod"
function long Usp_Banco_Cod(ref string Codigo,int Largo) RPCFUNC ALIAS FOR "SISTEM.Usp_Banco_Cod"
function long Usp_Almacen_Cod(longlong IdEmpresa,ref string Codigo,int Largo) RPCFUNC ALIAS FOR "SISTEM.Usp_Almacen_Cod"
function long Usp_AreaLaboral_Cod(longlong IdEmpresa,ref string Codigo,int Largo) RPCFUNC ALIAS FOR "SISTEM.Usp_AreaLaboral_Cod"
function long Usp_Color_Cod(longlong IdEmpresa,ref string Codigo,int Largo) RPCFUNC ALIAS FOR "SISTEM.Usp_Color_Cod"
function long Usp_Linea_Cod(longlong IdEmpresa,ref string Codigo,int Largo) RPCFUNC ALIAS FOR "SISTEM.Usp_Linea_Cod"
function long Usp_Marca_Cod(longlong IdEmpresa,ref string Codigo,int Largo) RPCFUNC ALIAS FOR "SISTEM.Usp_Marca_Cod"
function long Usp_Producto_Cod(longlong IdEmpresa,ref string Codigo,int Largo) RPCFUNC ALIAS FOR "SISTEM.Usp_Producto_Cod"
function long Usp_ListaPrecio_Cod(longlong IdEmpresa,ref string Codigo,int Largo) RPCFUNC ALIAS FOR "SISTEM.Usp_ListaPrecio_Cod"
function long Usp_Talla_Cod(longlong IdEmpresa,ref string Codigo,int Largo) RPCFUNC ALIAS FOR "SISTEM.Usp_Talla_Cod"
function long Usp_Unidad_Cod(ref string Codigo,int Largo) RPCFUNC ALIAS FOR "SISTEM.Usp_Unidad_Cod"
function long Usp_Moneda_Cod(ref string Codigo,int Largo) RPCFUNC ALIAS FOR "SISTEM.Usp_Moneda_Cod"
function long Usp_TipoCambio_Cod(ref string Codigo,int Largo) RPCFUNC ALIAS FOR "SISTEM.Usp_TipoCambio_Cod"
function long Usp_Entidad_Cod(ref string CodEntidad,int Largo) RPCFUNC ALIAS FOR "SISTEM.Usp_Entidad_Cod"
function long Usp_EntidadParametros_Cod(ref string CodEntidadParametros,int Largo) RPCFUNC ALIAS FOR "SISTEM.Usp_EntidadParametros_Cod"
function long Usp_EstadoMesOperacion_Cod(longlong IdEmpresa,ref string Codigo,int Largo) RPCFUNC ALIAS FOR "SISTEM.Usp_EstadoMesOperacion_Cod"
function long Usp_TipoDocumento_Cod(longlong IdEmpresa,ref string Codigo,int Largo) RPCFUNC ALIAS FOR "SISTEM.Usp_TipoDocumento_Cod"
function long Usp_Documento_Cod(longlong IdEmpresa,ref string Codigo,int Largo) RPCFUNC ALIAS FOR "SISTEM.Usp_Documento_Cod"

function long Usp_EstadoOperacion_Cod(longlong IdEmpresa,long Anio,ref string Codigo,int Largo) RPCFUNC ALIAS FOR "SISTEM.Usp_EstadoOperacion_Cod"

function long Usp_Compra_Cod(longlong IdEmpresa,ref string Codigo,int Largo) RPCFUNC ALIAS FOR "SISTEM.Usp_Compra_Cod"


function long Usp_Impuesto_Cod(ref string Codigo,int Largo) RPCFUNC ALIAS FOR "SISTEM.Usp_Impuesto_Cod"
function long Usp_ImpuestoVigencia_Cod(ref string Codigo,int Largo) RPCFUNC ALIAS FOR "SISTEM.Usp_ImpuestoVigencia_Cod"


function long Usp_TipoCambio(longlong IdMonedaNacional,longlong IdMonedaExtranjera,string Fecha,ref longlong IdTipoCambio,ref decimal{4} Compra,ref decimal{4} Venta) RPCFUNC ALIAS FOR "SISTEM.Usp_TipoCambio"

function long Usp_TipoCambio_Ins(ref longlong IdTipoCambio,string CodTipoCambio,longlong IdMonedaNacional,longlong IdMonedaExtranjera,datetime Fecha,decimal{4} Compra,decimal{4} Venta,boolean Estado) RPCFUNC ALIAS FOR "SISTEM.Usp_TipoCambio_Ins"
function long Usp_TipoCambio_Sel(longlong IdMonedaNacional,longlong IdMonedaExtranjera,longlong IdTipoCambio) RPCFUNC ALIAS FOR "SISTEM.Usp_TipoCambio_Sel"
function long Usp_TipoCambio_Upd(longlong IdTipoCambio,string CodTipoCambio,longlong IdMonedaNacional,longlong IdMonedaExtranjera,datetime Fecha,decimal{4} Compra,decimal{4} Venta,boolean Estado) RPCFUNC ALIAS FOR "SISTEM.Usp_TipoCambio_Upd"

function long Usf_Get_EstadoOperacion_Count(longlong IdEmpresa,long Anio) RPCFUNC ALIAS FOR "SISTEM.Usf_Get_EstadoOperacion_Count"

function decimal Usf_Get_EstMesOperacion_Id_x_AM(longlong IdEmpresa,long Anio,long Mes) RPCFUNC ALIAS FOR "SISTEM.Usf_Get_EstMesOperacion_Id_x_AM"
function decimal Usf_Get_EstMesOperacion_Id_x_Fe(longlong IdEmpresa,datetime Fecha) RPCFUNC ALIAS FOR "SISTEM.Usf_Get_EstMesOperacion_Id_x_Fe"
function long Usp_EstadoMensualOperacion(longlong  IdEmpresa,datetime Fecha,long Anio,long Mes,ref longlong  IdEstadoMensualOperacion,ref boolean EstadoOperacion,ref boolean Estado) RPCFUNC ALIAS FOR "SISTEM.Usp_EstadoMensualOperacion"
function long Usp_EstadoMensualOperacion_Gen(longlong IdEmpresa,long Anio,long Mes) RPCFUNC ALIAS FOR "SISTEM.Usp_EstadoMensualOperacion_Gen"

function string Usf_Get_Ubigeo(string Ubigeo) RPCFUNC ALIAS FOR "SISTEM.Usf_Get_Ubigeo"
function decimal Usf_Get_ImpuestoVigente_Porcent(longlong IdImpuesto,datetime Fecha) RPCFUNC ALIAS FOR "SISTEM.Usf_Get_ImpuestoVigente_Porcent"

end prototypes

type variables

s_tr Is_Tr_Data
s_tr Is_Tr

end variables

forward prototypes
public subroutine of_ado_net ()
public subroutine of_validar (ref string as_dbparm, string as_seccion, string as_valor, string as_agregado)
public subroutine of_oracle ()
end prototypes

public subroutine of_ado_net ();String ls_DBParm

THIS.DBMS = Is_Tr_Data.Is_Dbms
THIS.AutoCommit = Is_Tr_Data.Ib_AutoCommit

ls_DBParm = ""
                                                                               
of_Validar(ls_DBParm,"NameSpace='"          		,Is_Tr_Data.is_NameSpace          		,"',")
of_Validar(ls_DBParm,"Provider='"           			,Is_Tr_Data.is_Provider           			,"',")
of_Validar(ls_DBParm,"DataSource='"         			,Is_Tr_Data.is_DataSource         		,"',")
of_Validar(ls_DBParm,"Database='"           			,Is_Tr_Data.is_Database           		,"',")
of_Validar(ls_DBParm,"AdoRelease='"         			,Is_Tr_Data.is_AdoRelease         		,"',")
of_Validar(ls_DBParm,"TrustedConnection='"  		,Is_Tr_Data.is_TrustedConnection 	,"',")
of_Validar(ls_DBParm,"FileName='"           			,Is_Tr_Data.is_FileName           		,"',")
of_Validar(ls_DBParm,"DataLink='"           			,Is_Tr_Data.is_DataLink           			,"',")
of_Validar(ls_DBParm,"ProviderString='"     			,Is_Tr_Data.is_ProviderString     		,"',")
                                                                               
of_Validar(ls_DBParm,"PBCatalogOwner='"     		,Is_Tr_Data.is_PBCatalogOwner     	,"',")
of_Validar(ls_DBParm,"DefaultProcOwner='"   		,Is_Tr_Data.is_DefaultProcOwner   	,"',")
of_Validar(ls_DBParm,"SPCache='"            			,Is_Tr_Data.is_SPCache        			,"',")
of_Validar(ls_DBParm,"GenerateTrace='"      		,Is_Tr_Data.is_GenerateTrace     		,"',")
of_Validar(ls_DBParm,"CommitOnDisconnect='"	,Is_Tr_Data.is_CommitOnDisconnect	,"',")
of_Validar(ls_DBParm,"AutoCommit='"         			,Is_Tr_Data.is_AutoCommit         		,"',")
of_Validar(ls_DBParm,"TimeOut='"            			,Is_Tr_Data.is_TimeOut            		,"',")
of_Validar(ls_DBParm,"CommandTimeout='"     		,Is_Tr_Data.is_CommandTimeout		,"',")
of_Validar(ls_DBParm,"DbConfigSection='"    		,Is_Tr_Data.is_DbConfigSection    	,"',")
                                                                               
of_Validar(ls_DBParm,"Isolation='"          			,Is_Tr_Data.is_Isolation          			,"',")
of_Validar(ls_DBParm,"Disablebind='"        			,Is_Tr_Data.is_Disablebind        		,"',")
of_Validar(ls_DBParm,"StaticBind='"         			,Is_Tr_Data.is_StaticBind         			,"',")
of_Validar(ls_DBParm,"NCharBind='"          			,Is_Tr_Data.is_NCharBind          		,"',")
of_Validar(ls_DBParm,"PBMaxBlobSize='"      		,Is_Tr_Data.is_PBMaxBlobSize    		,"',")
                                                                               
of_Validar(ls_DBParm,"DelimitIdentifier='"  			,Is_Tr_Data.is_DelimitIdentifier  		,"',")
of_Validar(ls_DBParm,"TrimSpaces='"         			,Is_Tr_Data.is_TrimSpaces      			,"',")
of_Validar(ls_DBParm,"IdentifierQuoteChar='"		,Is_Tr_Data.is_IdentifierQuoteChar	,"',")
of_Validar(ls_DBParm,"DateFormat='"         			,Is_Tr_Data.is_DateFormat       		,"',")
of_Validar(ls_DBParm,"DateTimeFormat='"     		,Is_Tr_Data.is_DateTimeFormat     	,"',")
of_Validar(ls_DBParm,"TimeFormat='"         			,Is_Tr_Data.is_TimeFormat     			,"',")
of_Validar(ls_DBParm,"DecimalSeparator='"   		,Is_Tr_Data.is_DecimalSeparator   	,"',")
of_Validar(ls_DBParm,"OJSyntax='"           			,Is_Tr_Data.is_OJSyntax           		,"',")

of_Validar(ls_DBParm,"", Is_Tr_Data.Is_DBParm,",")

ls_DBParm = ls_DBParm + "PROVIDERSTRING='Language=Spanish; App ="+ Gn_Config.Is_Work.Aplicacion +"; WSID ='"+gn_config.is_config.hostname+" en "+gn_config.is_config.ip+"' '"

THIS.DBParm = ls_DBParm




end subroutine

public subroutine of_validar (ref string as_dbparm, string as_seccion, string as_valor, string as_agregado);
IF NOT IsNull(as_Valor) THEN as_DBParm = as_DBParm + as_Seccion+as_Valor+as_Agregado
end subroutine

public subroutine of_oracle ();String ls_DBParm

THIS.DBMS = Is_Tr_Data.Is_Dbms
THIS.AutoCommit = Is_Tr_Data.Ib_AutoCommit
THIS.ServerName = Is_Tr_Data.Is_ServerName

ls_DBParm = ""
                                                                               
of_Validar(ls_DBParm,"NameSpace='"          		,Is_Tr_Data.is_NameSpace          		,"',")
of_Validar(ls_DBParm,"Provider='"           			,Is_Tr_Data.is_Provider           			,"',")
of_Validar(ls_DBParm,"DataSource='"         			,Is_Tr_Data.is_DataSource         		,"',")
of_Validar(ls_DBParm,"Database='"           			,Is_Tr_Data.is_Database           		,"',")
of_Validar(ls_DBParm,"AdoRelease='"         			,Is_Tr_Data.is_AdoRelease         		,"',")
of_Validar(ls_DBParm,"TrustedConnection='"  		,Is_Tr_Data.is_TrustedConnection 	,"',")
of_Validar(ls_DBParm,"FileName='"           			,Is_Tr_Data.is_FileName           		,"',")
of_Validar(ls_DBParm,"DataLink='"           			,Is_Tr_Data.is_DataLink           			,"',")
of_Validar(ls_DBParm,"ProviderString='"     			,Is_Tr_Data.is_ProviderString     		,"',")
                                                                               
of_Validar(ls_DBParm,"PBCatalogOwner='"     		,Is_Tr_Data.is_PBCatalogOwner     	,"',")
of_Validar(ls_DBParm,"DefaultProcOwner='"   		,Is_Tr_Data.is_DefaultProcOwner   	,"',")
of_Validar(ls_DBParm,"SPCache='"            			,Is_Tr_Data.is_SPCache        			,"',")
of_Validar(ls_DBParm,"GenerateTrace='"      		,Is_Tr_Data.is_GenerateTrace     		,"',")
of_Validar(ls_DBParm,"CommitOnDisconnect='"	,Is_Tr_Data.is_CommitOnDisconnect	,"',")
of_Validar(ls_DBParm,"AutoCommit='"         			,Is_Tr_Data.is_AutoCommit         		,"',")
of_Validar(ls_DBParm,"TimeOut='"            			,Is_Tr_Data.is_TimeOut            		,"',")
of_Validar(ls_DBParm,"CommandTimeout='"     		,Is_Tr_Data.is_CommandTimeout		,"',")
of_Validar(ls_DBParm,"DbConfigSection='"    		,Is_Tr_Data.is_DbConfigSection    	,"',")
                                                                               
of_Validar(ls_DBParm,"Isolation='"          			,Is_Tr_Data.is_Isolation          			,"',")
of_Validar(ls_DBParm,"Disablebind='"        			,Is_Tr_Data.is_Disablebind        		,"',")
of_Validar(ls_DBParm,"StaticBind='"         			,Is_Tr_Data.is_StaticBind         			,"',")
of_Validar(ls_DBParm,"NCharBind='"          			,Is_Tr_Data.is_NCharBind          		,"',")
of_Validar(ls_DBParm,"PBMaxBlobSize='"      		,Is_Tr_Data.is_PBMaxBlobSize    		,"',")
                                                                               
of_Validar(ls_DBParm,"DelimitIdentifier='"  			,Is_Tr_Data.is_DelimitIdentifier  		,"',")
of_Validar(ls_DBParm,"TrimSpaces='"         			,Is_Tr_Data.is_TrimSpaces      			,"',")
of_Validar(ls_DBParm,"IdentifierQuoteChar='"		,Is_Tr_Data.is_IdentifierQuoteChar	,"',")
of_Validar(ls_DBParm,"DateFormat='"         			,Is_Tr_Data.is_DateFormat       		,"',")
of_Validar(ls_DBParm,"DateTimeFormat='"     		,Is_Tr_Data.is_DateTimeFormat     	,"',")
of_Validar(ls_DBParm,"TimeFormat='"         			,Is_Tr_Data.is_TimeFormat     			,"',")
of_Validar(ls_DBParm,"DecimalSeparator='"   		,Is_Tr_Data.is_DecimalSeparator   	,"',")
of_Validar(ls_DBParm,"OJSyntax='"           			,Is_Tr_Data.is_OJSyntax           		,"',")

of_Validar(ls_DBParm,"", Is_Tr_Data.Is_DBParm,",")

//ls_DBParm = ls_DBParm + "PROVIDERSTRING='Language=Spanish; App ="+ Gn_Config.Is_Work.Aplicacion +"; WSID ='"+gn_config.is_config.hostname+" en "+gn_config.is_config.ip+"' '"

THIS.DBParm = ls_DBParm




end subroutine

on n_transaccion_entrar.create
call super::create
end on

on n_transaccion_entrar.destroy
call super::destroy
end on

