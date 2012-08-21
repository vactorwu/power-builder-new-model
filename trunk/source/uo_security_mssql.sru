HA$PBExportHeader$uo_security_mssql.sru
forward
global type uo_security_mssql from userobject
end type
type st_vertical from statictext within uo_security_mssql
end type
type tv_admin from treeview within uo_security_mssql
end type
type lv_admin from listview within uo_security_mssql
end type
end forward

global type uo_security_mssql from userobject
integer width = 3191
integer height = 576
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
st_vertical st_vertical
tv_admin tv_admin
lv_admin lv_admin
end type
global uo_security_mssql uo_security_mssql

type variables
n_transaccion_entrar itr_SQLCA
st_db ist_db
st_objetos ist_objetos
int ii_i
String is_y =  "~t"
boolean		ib_debug=False	//Debug mode
long		il_hiddencolor=0	//Bar hidden color to match the window background
integer		ii_barthickness=11	//Bar Thickness
integer		ii_windowborder=25	//Window border to be used on all sides
dragobject	idrg_Vertical[2]	//Reference to the vertical controls on the window

end variables

forward prototypes
public function string of_db_id (integer ai_id)
public subroutine of_limpiar ()
public subroutine of_funcion_basedatos (long al_tvi_hdl, long al_dbid)
public subroutine of_funcion_200 (long al_tvi_hdl)
public subroutine of_funcion_100 (long al_tvi_hdl)
public subroutine of_funcion_principal ()
public subroutine of_mostrarbd ()
public subroutine of_mostrar_seguridad_sesiones ()
public subroutine of_mostrar_seguridad_funciones ()
public subroutine of_mostrar_seguridad ()
public subroutine of_mostrar_objetos_bd_tipo_vista (string as_database)
public subroutine of_mostrar_objetos_bd_tipo_tabla (string as_database)
public subroutine of_mostrar_objetos_bd_tipo_spex (string as_database)
public subroutine of_mostrar_objetos_bd_tipo_sp (string as_database)
public subroutine of_mostrar_objetos_bd_tipo_sesiones (string as_database)
public subroutine of_mostrar_objetos_bd_tipo_roles (string as_database)
public subroutine of_mostrar_objetos_bd_tipo_regla (string as_database)
public subroutine of_mostrar_objetos_bd_tipo_funcion (string as_database)
public subroutine of_mostrar_objetos_bd_tipo_default (string as_database)
public subroutine of_mostrar_objetos_bd_tipo_datos_usuario (string as_database)
public subroutine of_mostrar_objetos_bd_tipo (string as_database, string as_tipo, integer ai_icono)
public subroutine of_mostrar_objetos_bd (long al_bdid)
public subroutine of_mostrar_seguridad_objetos_bd (string as_database, integer ai_id)
public function integer of_refreshbars ()
public function integer of_resizebars ()
public function integer of_resizepanels ()
public function string of_buscar_parametro (string as_parametro)
public subroutine of_settranssobject (n_transaccion_entrar atr_sqlca)
public subroutine of_activar ()
end prototypes

public function string of_db_id (integer ai_id);String ls_nombre
Int i

 For i = 1  To UpperBound(ist_db.name)
 If (ist_db.dbid[i] = ai_id or ist_db.datadbid[i] = ai_id ) Then
	ls_nombre = ist_db.name[i]  
 End If

Next


Return ls_nombre
end function

public subroutine of_limpiar ();long tvi_hdl = 0

DO UNTIL tv_admin.FindItem(RootTreeItem!, 0) = -1

    tv_admin.DeleteItem(tvi_hdl)

LOOP
end subroutine

public subroutine of_funcion_basedatos (long al_tvi_hdl, long al_dbid);TreeViewItem		ltvi_Item
long tvi_hdl
// Recuperar Inicios de Sesion
ltvi_Item.label = "Tablas"
ltvi_Item.data = 1100 + al_dbid
ltvi_Item.pictureindex = 6
ltvi_Item.children = False
ltvi_Item.OverlayPictureIndex	= ltvi_Item.pictureindex
ltvi_Item.selectedpictureindex =ltvi_Item.pictureindex
ltvi_Item.HasFocus	= True
tvi_hdl =  tv_admin.InsertItemLast(al_tvi_hdl, ltvi_Item)
     ii_i++
	ist_objetos.handlepadre[ii_i] = al_tvi_hdl
	ist_objetos.handleactual[ii_i] = tvi_hdl
	ist_objetos.uid[ii_i] =  ltvi_Item.data
	ist_objetos.servidor[ii_i] = itr_SQLCA.Is_Tr.Is_Datasource
	ist_objetos.basedatos[ii_i] = of_db_id(al_dbid)
	ist_objetos.tipoobjeto[ii_i] = "DB"
	ist_objetos.nombre[ii_i] = ltvi_Item.label
	ist_objetos.nombresesion[ii_i] =""
	ist_objetos.acceso[ii_i] = 0
	ist_objetos.tipo[ii_i] =0
	ist_objetos.grupo[ii_i] =""
	ist_objetos.propietario[ii_i]=""
	ist_objetos.creacion[ii_i]=DateTime(Date(2007,1,1), Time(0,0,0))
	ist_objetos.data[ii_i] = ltvi_Item.data
	

// Recuperar Roles / Funciones del Servidor
ltvi_Item.label = "Vistas"
ltvi_Item.data =  1200 + al_dbid
ltvi_Item.pictureindex = 9
ltvi_Item.children = False
ltvi_Item.OverlayPictureIndex	= ltvi_Item.pictureindex
ltvi_Item.selectedpictureindex =ltvi_Item.pictureindex
ltvi_Item.HasFocus	= True
tvi_hdl = tv_admin.InsertItemLast(al_tvi_hdl, ltvi_Item)
     ii_i++
	ist_objetos.handlepadre[ii_i] = al_tvi_hdl
	ist_objetos.handleactual[ii_i] = tvi_hdl
	ist_objetos.uid[ii_i] =  ltvi_Item.data
	ist_objetos.servidor[ii_i] = itr_SQLCA.Is_Tr.Is_Datasource
	ist_objetos.basedatos[ii_i] = of_db_id(al_dbid)
	ist_objetos.tipoobjeto[ii_i] = "DB"
	ist_objetos.nombre[ii_i] = ltvi_Item.label
	ist_objetos.nombresesion[ii_i] =""
	ist_objetos.acceso[ii_i] = 0
	ist_objetos.tipo[ii_i] =0
	ist_objetos.grupo[ii_i] =""
	ist_objetos.propietario[ii_i]=""
	ist_objetos.creacion[ii_i]=DateTime(Date(2007,1,1), Time(0,0,0))
	ist_objetos.data[ii_i] = ltvi_Item.data
	
	
// Recuperar Inicios de Sesion
ltvi_Item.label = "Procedimientos Almacenados"
ltvi_Item.data = 1300 + al_dbid
ltvi_Item.pictureindex = 8
ltvi_Item.children = False
ltvi_Item.OverlayPictureIndex	= ltvi_Item.pictureindex
ltvi_Item.selectedpictureindex =ltvi_Item.pictureindex
ltvi_Item.HasFocus	= True
tvi_hdl = tv_admin.InsertItemLast(al_tvi_hdl, ltvi_Item)
     ii_i++
	ist_objetos.handlepadre[ii_i] = al_tvi_hdl
	ist_objetos.handleactual[ii_i] = tvi_hdl
	ist_objetos.uid[ii_i] =  ltvi_Item.data
	ist_objetos.servidor[ii_i] = itr_SQLCA.Is_Tr.Is_Datasource
	ist_objetos.basedatos[ii_i] = of_db_id(al_dbid)
	ist_objetos.tipoobjeto[ii_i] = "DB"
	ist_objetos.nombre[ii_i] = ltvi_Item.label
	ist_objetos.nombresesion[ii_i] =""
	ist_objetos.acceso[ii_i] = 0
	ist_objetos.tipo[ii_i] =0
	ist_objetos.grupo[ii_i] =""
	ist_objetos.propietario[ii_i]=""
	ist_objetos.creacion[ii_i]=DateTime(Date(2007,1,1), Time(0,0,0))
	ist_objetos.data[ii_i] = ltvi_Item.data
	
	
// Recuperar Roles / Funciones del Servidor
ltvi_Item.label = "Procedimientos Almacenados Extendidos"
ltvi_Item.data =  1400 + al_dbid
ltvi_Item.pictureindex =14
ltvi_Item.children = False
ltvi_Item.OverlayPictureIndex	= ltvi_Item.pictureindex
ltvi_Item.selectedpictureindex =ltvi_Item.pictureindex
ltvi_Item.HasFocus	= True
tvi_hdl = tv_admin.InsertItemLast(al_tvi_hdl, ltvi_Item)
     ii_i++
	ist_objetos.handlepadre[ii_i] = al_tvi_hdl
	ist_objetos.handleactual[ii_i] = tvi_hdl
	ist_objetos.uid[ii_i] =  ltvi_Item.data
	ist_objetos.servidor[ii_i] = itr_SQLCA.Is_Tr.Is_Datasource
	ist_objetos.basedatos[ii_i] = of_db_id(al_dbid)
	ist_objetos.tipoobjeto[ii_i] = "DB"
	ist_objetos.nombre[ii_i] = ltvi_Item.label
	ist_objetos.nombresesion[ii_i] =""
	ist_objetos.acceso[ii_i] = 0
	ist_objetos.tipo[ii_i] =0
	ist_objetos.grupo[ii_i] =""
	ist_objetos.propietario[ii_i]=""
	ist_objetos.creacion[ii_i]=DateTime(Date(2007,1,1), Time(0,0,0))
	ist_objetos.data[ii_i] = ltvi_Item.data
	
// Recuperar Inicios de Sesion
ltvi_Item.label = "Usuarios"
ltvi_Item.data =  1500 + al_dbid
ltvi_Item.pictureindex = 10
ltvi_Item.children = False
ltvi_Item.OverlayPictureIndex	= ltvi_Item.pictureindex
ltvi_Item.selectedpictureindex =ltvi_Item.pictureindex
ltvi_Item.HasFocus	= True
tvi_hdl = tv_admin.InsertItemLast(al_tvi_hdl, ltvi_Item)
     ii_i++
	ist_objetos.handlepadre[ii_i] = al_tvi_hdl
	ist_objetos.handleactual[ii_i] = tvi_hdl
	ist_objetos.uid[ii_i] =  ltvi_Item.data
	ist_objetos.servidor[ii_i] = itr_SQLCA.Is_Tr.Is_Datasource
	ist_objetos.basedatos[ii_i] = of_db_id(al_dbid)
	ist_objetos.tipoobjeto[ii_i] = "DB"
	ist_objetos.nombre[ii_i] = ltvi_Item.label
	ist_objetos.nombresesion[ii_i] =""
	ist_objetos.acceso[ii_i] = 0
	ist_objetos.tipo[ii_i] =0
	ist_objetos.grupo[ii_i] =""
	ist_objetos.propietario[ii_i]=""
	ist_objetos.creacion[ii_i]=DateTime(Date(2007,1,1), Time(0,0,0))
	ist_objetos.data[ii_i] = ltvi_Item.data
	
// Recuperar Roles / Funciones del Servidor
ltvi_Item.label = "Funciones de Base de Datos"
ltvi_Item.data =  1600 + al_dbid
ltvi_Item.pictureindex = 15
ltvi_Item.children = False
ltvi_Item.OverlayPictureIndex	= ltvi_Item.pictureindex
ltvi_Item.selectedpictureindex =ltvi_Item.pictureindex
ltvi_Item.HasFocus	= True
tvi_hdl = tv_admin.InsertItemLast(al_tvi_hdl, ltvi_Item)
     ii_i++
	ist_objetos.handlepadre[ii_i] = al_tvi_hdl
	ist_objetos.handleactual[ii_i] = tvi_hdl
	ist_objetos.uid[ii_i] =  ltvi_Item.data
	ist_objetos.servidor[ii_i] = itr_SQLCA.Is_Tr.Is_Datasource
	ist_objetos.basedatos[ii_i] = of_db_id(al_dbid)
	ist_objetos.tipoobjeto[ii_i] = "DB"
	ist_objetos.nombre[ii_i] = ltvi_Item.label
	ist_objetos.nombresesion[ii_i] =""
	ist_objetos.acceso[ii_i] = 0
	ist_objetos.tipo[ii_i] =0
	ist_objetos.grupo[ii_i] =""
	ist_objetos.propietario[ii_i]=""
	ist_objetos.creacion[ii_i]=DateTime(Date(2007,1,1), Time(0,0,0))
	ist_objetos.data[ii_i] = ltvi_Item.data
	
// Recuperar Inicios de Sesion
ltvi_Item.label = "Reglas"
ltvi_Item.data =  1700 + al_dbid
ltvi_Item.pictureindex = 11
ltvi_Item.children = False
ltvi_Item.OverlayPictureIndex	= ltvi_Item.pictureindex
ltvi_Item.selectedpictureindex =ltvi_Item.pictureindex
ltvi_Item.HasFocus	= True
tvi_hdl = tv_admin.InsertItemLast(al_tvi_hdl, ltvi_Item)
     ii_i++
	ist_objetos.handlepadre[ii_i] = al_tvi_hdl
	ist_objetos.handleactual[ii_i] = tvi_hdl
	ist_objetos.uid[ii_i] =  ltvi_Item.data
	ist_objetos.servidor[ii_i] = itr_SQLCA.Is_Tr.Is_Datasource
	ist_objetos.basedatos[ii_i] = of_db_id(al_dbid)
	ist_objetos.tipoobjeto[ii_i] = "DB"
	ist_objetos.nombre[ii_i] = ltvi_Item.label
	ist_objetos.nombresesion[ii_i] =""
	ist_objetos.acceso[ii_i] = 0
	ist_objetos.tipo[ii_i] =0
	ist_objetos.grupo[ii_i] =""
	ist_objetos.propietario[ii_i]=""
	ist_objetos.creacion[ii_i]=DateTime(Date(2007,1,1), Time(0,0,0))
	ist_objetos.data[ii_i] = ltvi_Item.data
	
// Recuperar Roles / Funciones del Servidor
ltvi_Item.label = "Valores Predeterminados"
ltvi_Item.data =  1800 + al_dbid
ltvi_Item.pictureindex = 12
ltvi_Item.children = False
ltvi_Item.OverlayPictureIndex	= ltvi_Item.pictureindex
ltvi_Item.selectedpictureindex =ltvi_Item.pictureindex
ltvi_Item.HasFocus	= True
tvi_hdl = tv_admin.InsertItemLast(al_tvi_hdl, ltvi_Item)
     ii_i++
	ist_objetos.handlepadre[ii_i] = al_tvi_hdl
	ist_objetos.handleactual[ii_i] = tvi_hdl
	ist_objetos.uid[ii_i] =  ltvi_Item.data
	ist_objetos.servidor[ii_i] = itr_SQLCA.Is_Tr.Is_Datasource
	ist_objetos.basedatos[ii_i] = of_db_id(al_dbid)
	ist_objetos.tipoobjeto[ii_i] = "DB"
	ist_objetos.nombre[ii_i] = ltvi_Item.label
	ist_objetos.nombresesion[ii_i] =""
	ist_objetos.acceso[ii_i] = 0
	ist_objetos.tipo[ii_i] =0
	ist_objetos.grupo[ii_i] =""
	ist_objetos.propietario[ii_i]=""
	ist_objetos.creacion[ii_i]=DateTime(Date(2007,1,1), Time(0,0,0))
	ist_objetos.data[ii_i] = ltvi_Item.data
	
// Recuperar Inicios de Sesion
ltvi_Item.label = "Tipos de datos definidos por el Usuario"
ltvi_Item.data =  1900 + al_dbid
ltvi_Item.pictureindex = 13
ltvi_Item.children = False
ltvi_Item.OverlayPictureIndex	= ltvi_Item.pictureindex
ltvi_Item.selectedpictureindex =ltvi_Item.pictureindex
ltvi_Item.HasFocus	= True
tvi_hdl = tv_admin.InsertItemLast(al_tvi_hdl, ltvi_Item)
     ii_i++
	ist_objetos.handlepadre[ii_i] = al_tvi_hdl
	ist_objetos.handleactual[ii_i] = tvi_hdl
	ist_objetos.uid[ii_i] =  ltvi_Item.data
	ist_objetos.servidor[ii_i] = itr_SQLCA.Is_Tr.Is_Datasource
	ist_objetos.basedatos[ii_i] = of_db_id(al_dbid)
	ist_objetos.tipoobjeto[ii_i] = "DB"
	ist_objetos.nombre[ii_i] = ltvi_Item.label
	ist_objetos.nombresesion[ii_i] =""
	ist_objetos.acceso[ii_i] = 0
	ist_objetos.tipo[ii_i] =0
	ist_objetos.grupo[ii_i] =""
	ist_objetos.propietario[ii_i]=""
	ist_objetos.creacion[ii_i]=DateTime(Date(2007,1,1), Time(0,0,0))
	ist_objetos.data[ii_i] = ltvi_Item.data
	
// Recuperar Roles / Funciones del Servidor
ltvi_Item.label = "Funciones definidos por el Usuario"
ltvi_Item.data =  2000 + al_dbid
ltvi_Item.pictureindex = 7
ltvi_Item.children = False
ltvi_Item.OverlayPictureIndex	= ltvi_Item.pictureindex
ltvi_Item.selectedpictureindex =ltvi_Item.pictureindex
ltvi_Item.HasFocus	= True
tvi_hdl = tv_admin.InsertItemLast(al_tvi_hdl, ltvi_Item)
     ii_i++
	ist_objetos.handlepadre[ii_i] = al_tvi_hdl
	ist_objetos.handleactual[ii_i] = tvi_hdl
	ist_objetos.uid[ii_i] =  ltvi_Item.data
	ist_objetos.servidor[ii_i] = itr_SQLCA.Is_Tr.Is_Datasource
	ist_objetos.basedatos[ii_i] = of_db_id(al_dbid)
	ist_objetos.tipoobjeto[ii_i] = "DB"
	ist_objetos.nombre[ii_i] = ltvi_Item.label
	ist_objetos.nombresesion[ii_i] =""
	ist_objetos.acceso[ii_i] = 0
	ist_objetos.tipo[ii_i] =0
	ist_objetos.grupo[ii_i] =""
	ist_objetos.propietario[ii_i]=""
	ist_objetos.creacion[ii_i]=DateTime(Date(2007,1,1), Time(0,0,0))
	ist_objetos.data[ii_i] = ltvi_Item.data
end subroutine

public subroutine of_funcion_200 (long al_tvi_hdl);TreeViewItem		ltvi_Item
// Recuperar Inicios de Sesion
ltvi_Item.label = "Inicios de sesi$$HEX1$$f300$$ENDHEX$$n"
ltvi_Item.data = 2100
ltvi_Item.pictureindex = 3
ltvi_Item.OverlayPictureIndex	= ltvi_Item.pictureindex
ltvi_Item.selectedpictureindex =ltvi_Item.pictureindex
ltvi_Item.HasFocus	= True
tv_admin.InsertItemLast(al_tvi_hdl, ltvi_Item)

// Recuperar Roles / Funciones del Servidor
ltvi_Item.label = "Funciones del Servidor"
ltvi_Item.data = 2200
ltvi_Item.pictureindex = 4
ltvi_Item.OverlayPictureIndex	= ltvi_Item.pictureindex
ltvi_Item.selectedpictureindex =ltvi_Item.pictureindex
ltvi_Item.HasFocus	= True
tv_admin.InsertItemLast(al_tvi_hdl, ltvi_Item)
end subroutine

public subroutine of_funcion_100 (long al_tvi_hdl);// Recuperar las Base de Datos
String ls_name , ls_filename , ls_param
Int li_dbid ,  li_cmptlevel   , i
Datetime ldt_crdate
Long tvi_hdl
TreeViewItem		ltvi_Item
i = 0 

If (itr_SQLCA.Is_Tr.Is_Database <> "master") Then
	DisConnect Using itr_SQLCA ;	
	DisConnect Using itr_SQLCA ;	
	itr_SQLCA.Is_Tr.Is_Database = "master"
	itr_SQLCA.of_ado_net( )
	Connect Using itr_SQLCA ;
End If

ls_param = "SET NOCOUNT OFF"
EXECUTE IMMEDIATE :ls_param USING itr_SQLCA ; 

If itr_SQLCA.sqlcode = 0 Then

	DECLARE lc_bd CURSOR FOR SELECT  name , dbid , crdate, cmptlevel , filename FROM dbo.sysdatabases With (Nolock)   Using itr_SQLCA ;
	
	Open lc_bd ;
	
	FETCH lc_bd   INTO  :ls_name , :li_dbid , :ldt_crdate, :li_cmptlevel , :ls_filename  ;
	
	DO WHILE itr_SQLCA.sqlcode = 0 and itr_SQLCA.sqldbcode = 0
	//////
	i++
	ii_i++
	ist_db.name[i]  		= ls_name
	ist_db.dbid[i] 			= li_dbid
	ist_db.datadbid[i]		= 1000 + li_dbid
	ist_db.crdate[i] 		= ldt_crdate
	ist_db.cmptlevel[i] 	= li_cmptlevel
	ist_db.filename[i]		= ls_filename
	
	ltvi_Item.label = ist_db.name[i]  
	ltvi_Item.data = ist_db.datadbid[i] 	
	ltvi_Item.pictureindex = 5
	ltvi_Item.children = True
	ltvi_Item.OverlayPictureIndex	= ltvi_Item.pictureindex
	ltvi_Item.selectedpictureindex =ltvi_Item.pictureindex
	tvi_hdl = tv_admin.InsertItemLast(al_tvi_hdl, ltvi_Item) 
	ist_db.handle[i] = tvi_hdl
	
	ist_objetos.handlepadre[ii_i] = al_tvi_hdl
	ist_objetos.handleactual[ii_i] = tvi_hdl
	ist_objetos.uid[ii_i] = li_dbid
	ist_objetos.servidor[ii_i] = itr_SQLCA.servername
	ist_objetos.basedatos[ii_i] = ls_name
	ist_objetos.tipoobjeto[ii_i] = "DB"
	ist_objetos.nombre[ii_i] = ls_name
	ist_objetos.nombresesion[ii_i] =""
	ist_objetos.acceso[ii_i] = 0
	ist_objetos.tipo[ii_i] =0
	ist_objetos.grupo[ii_i] =""
	ist_objetos.propietario[ii_i]=""
	ist_objetos.creacion[ii_i]=ldt_crdate
	ist_objetos.data[ii_i] = ltvi_Item.data

	
	
     of_funcion_basedatos( tvi_hdl , li_dbid)
	  
	//////	
	FETCH lc_bd   INTO  :ls_name , :li_dbid , :ldt_crdate, :li_cmptlevel , :ls_filename  ;
	
	LOOP
	
	Close  lc_bd ;
	
End If


end subroutine

public subroutine of_funcion_principal ();TreeViewItem		ltvi_Item
long tvi_hdl 

SetPointer(HourGlass!)


IF 1 = 1 Then

ltvi_Item.label = "BASE DE DATOS"
ltvi_Item.bold =  true
ltvi_Item.data = 1000
ltvi_Item.pictureindex = 1
ltvi_Item.children = True
ltvi_Item.OverlayPictureIndex	= ltvi_Item.pictureindex
ltvi_Item.selectedpictureindex =ltvi_Item.pictureindex
tvi_hdl = tv_admin.InsertItemLast(0, ltvi_Item)



of_funcion_100(tvi_hdl)


ltvi_Item.label = "SEGURIDAD"
ltvi_Item.data = 2000
ltvi_Item.pictureindex = 2
ltvi_Item.children = True
ltvi_Item.OverlayPictureIndex	= ltvi_Item.pictureindex
ltvi_Item.selectedpictureindex =ltvi_Item.pictureindex
tvi_hdl = tv_admin.InsertItemLast(0, ltvi_Item)
of_funcion_200(tvi_hdl)


End If

end subroutine

public subroutine of_mostrarbd ();ListViewItem llvi_Item
Int i

lv_admin.DeleteItems ( )

lv_admin.view = ListViewLargeIcon!

 For i = 1  To UpperBound(ist_db.name)
	llvi_Item.label = ist_db.name[i]  
	llvi_Item.data = ist_db.datadbid[i] 	
	llvi_Item.pictureindex = 5
	llvi_Item.OverlayPictureIndex	= llvi_Item.pictureindex
	lv_admin.additem(llvi_Item)
Next

end subroutine

public subroutine of_mostrar_seguridad_sesiones ();ListViewItem llvi_Item
Int li_denylogin, li_isntname, li_isntgroup, li_sysadmin 
String  ls_param , ls_loginname , ls_language , ls_dbname , ls_data
DateTime ldt_createdate

  
lv_admin.DeleteItems ( )
lv_admin.Deletecolumns( )

lv_admin.view = ListViewReport!

lv_admin.AddColumn( "Nombre" , Left! , 750)
lv_admin.AddColumn( "Tipo" , Left! , 550)
lv_admin.AddColumn( "Acceso al servidor" , Left! , 350)
lv_admin.AddColumn( "Base de datos predeterminada" , Left! , 300)
lv_admin.AddColumn( "Creaci$$HEX1$$f300$$ENDHEX$$n" , Left! , 500)
lv_admin.AddColumn( "Idioma predeterminado" , Left! , 500)

If (itr_SQLCA.Is_Tr.Is_Database <> "master") Then
	DisConnect Using itr_SQLCA ;	
	itr_SQLCA.Is_Tr.Is_Database = "master"
	itr_SQLCA.of_ado_net( )
	Connect Using itr_SQLCA ;
End If

ls_param = "SET NOCOUNT OFF"
EXECUTE IMMEDIATE :ls_param USING itr_SQLCA ; 

If itr_SQLCA.sqlcode = 0 Then

	DECLARE lc_bd CURSOR FOR SELECT   loginname, language, dbname, createdate, denylogin, isntname, isntgroup, sysadmin from master..syslogins With (Nolock)   order by isntname desc,  sysadmin desc , name Using itr_SQLCA ;

	
	Open lc_bd ;
	
	FETCH lc_bd   INTO   :ls_loginname, :ls_language, :ls_dbname, :ldt_createdate, :li_denylogin, :li_isntname, :li_isntgroup, :li_sysadmin  ;
	
	DO WHILE itr_SQLCA.sqlcode = 0 and itr_SQLCA.sqldbcode = 0
	//////
	
	ls_data =  ls_loginname+is_y
	
	If ((li_isntname=1) and (li_isntgroup=1) )Then
		ls_data = ls_data + "Grupo de Windows"+is_y
		llvi_Item.pictureindex = 16
	ElseIf ((li_isntname=1) and (li_isntgroup=0) )Then
		ls_data = ls_data+  "Usuario de Windows"+is_y
		llvi_Item.pictureindex =3
	ElseIf ((li_isntname=0) and (li_isntgroup=0)) Then
		ls_data =ls_data+  "Est$$HEX1$$e100$$ENDHEX$$ndar"+is_y
		llvi_Item.pictureindex = 10
	End If
	
	If (li_denylogin=0) Then
		ls_data = ls_data + "Permiso"+is_y
	Else
		ls_data = ls_data + "Denegar"+is_y
	End If
	
	ls_data = ls_data + ls_dbname+is_y+String(ldt_createdate,"DD/MM/YYYY HH:MM:SS")+is_y+ls_language
	
	
	// Recuperar Inicios de Sesion
	llvi_Item.label = ls_data
	llvi_Item.data = ls_loginname
		llvi_Item.OverlayPictureIndex	= llvi_Item.pictureindex
	lv_admin.additem(llvi_Item)

	//////	
	FETCH lc_bd   INTO   :ls_loginname, :ls_language, :ls_dbname, :ldt_createdate, :li_denylogin, :li_isntname, :li_isntgroup, :li_sysadmin  ;
	
	LOOP
	
	Close  lc_bd ;
	
End If
end subroutine

public subroutine of_mostrar_seguridad_funciones ();ListViewItem llvi_Item
Int i
String ls_1 , ls_2 , ls_3 , ls_4 , ls_5 , ls_6 , ls_7, ls_8

lv_admin.DeleteItems ( )
lv_admin.Deletecolumns( )

lv_admin.view = ListViewReport!

lv_admin.AddColumn( "Nombre completo" , Left! , 750)
lv_admin.AddColumn( "Nombre" , Left! , 350)
lv_admin.AddColumn( "N$$HEX1$$fa00$$ENDHEX$$mero" , Right! , 250)
lv_admin.AddColumn( "Descripcion" , Left! , 1600)


ls_1 = "System Administrators"+is_y		+"sysadmin"+is_y		+"16"+is_y		+"Puede reaqlizar cualquier actividad en la instalacion de SQL Server"
ls_2 = "Security Administrators"+is_y	+"securityadmin"+is_y	+"32"+is_y		+"Puede administrar los inicios de sesi$$HEX1$$f300$$ENDHEX$$n del servidor"
ls_3 = "Server Administrators"+is_y		+"serveradmin"+is_y	+"64"+is_y		+"Puede configurar las opciones globales del servidor"
ls_4 = "Setup Administrators"+is_y		+"setupadmin"+is_y	+"128"+is_y	+"Puede administrar los procedimientos almacenados extendidos"
ls_5 = "Process Administrators"+is_y		+"processadmin"+is_y+"256"+is_y	+"Puede administrar los procesos que se ejecuran en el SQL Server"
ls_6 = "Disk Administrators"+is_y			+"diskadmin"+is_y		+"512"+is_y	+"Puede administrar los archivos de disco"
ls_7 = "Database Creators"+is_y			+"dbcreator"+is_y		+"1024"+is_y	+"Puede crear y modificar las bases de datos"
ls_8 = "Bulk Insert Administrators"+is_y+"bulkadmin"+is_y		+"4096"+is_y	+"Puede ejecutar una operaci$$HEX1$$f300$$ENDHEX$$n de inserci$$HEX1$$f300$$ENDHEX$$n masiva"


// Recuperar Inicios de Sesion
llvi_Item.label = ls_1
llvi_Item.data = 1100 
llvi_Item.pictureindex = 4

llvi_Item.OverlayPictureIndex	= llvi_Item.pictureindex
lv_admin.additem(llvi_Item)

// Recuperar Roles / Funciones del Servidor
llvi_Item.label = ls_2
llvi_Item.data =  1200 
llvi_Item.pictureindex = 4

llvi_Item.OverlayPictureIndex	= llvi_Item.pictureindex
lv_admin.additem(llvi_Item)

// Recuperar Inicios de Sesion
llvi_Item.label = ls_3
llvi_Item.data = 1300 
llvi_Item.pictureindex = 4

llvi_Item.OverlayPictureIndex	= llvi_Item.pictureindex
lv_admin.additem(llvi_Item)

// Recuperar Roles / Funciones del Servidor
llvi_Item.label = ls_4
llvi_Item.data =  1400 
llvi_Item.pictureindex =4

llvi_Item.OverlayPictureIndex	= llvi_Item.pictureindex
lv_admin.additem(llvi_Item)

// Recuperar Inicios de Sesion
llvi_Item.label = ls_5
llvi_Item.data =  1500 
llvi_Item.pictureindex = 4

llvi_Item.OverlayPictureIndex	= llvi_Item.pictureindex
lv_admin.additem(llvi_Item)

// Recuperar Roles / Funciones del Servidor
llvi_Item.label = ls_6
llvi_Item.data =  1600 
llvi_Item.pictureindex = 4

llvi_Item.OverlayPictureIndex	= llvi_Item.pictureindex
lv_admin.additem(llvi_Item)

// Recuperar Inicios de Sesion
llvi_Item.label = ls_7
llvi_Item.data =  1700 
llvi_Item.pictureindex = 4

llvi_Item.OverlayPictureIndex	= llvi_Item.pictureindex
lv_admin.additem(llvi_Item)

// Recuperar Roles / Funciones del Servidor
llvi_Item.label = ls_8
llvi_Item.data =  1800 
llvi_Item.pictureindex = 4

llvi_Item.OverlayPictureIndex	= llvi_Item.pictureindex
lv_admin.additem(llvi_Item)
end subroutine

public subroutine of_mostrar_seguridad ();ListViewItem llvi_Item
Int i

lv_admin.DeleteItems ( )

lv_admin.view = ListViewLargeIcon!


// Recuperar Inicios de Sesion
llvi_Item.label = "Inicios de sesi$$HEX1$$f300$$ENDHEX$$n"
llvi_Item.data = 2100
llvi_Item.pictureindex = 3
llvi_Item.OverlayPictureIndex	= llvi_Item.pictureindex
lv_admin.additem(llvi_Item)

// Recuperar Roles / Funciones del Servidor
llvi_Item.label = "Funciones del Servidor"
llvi_Item.data = 2200
llvi_Item.pictureindex = 4
llvi_Item.OverlayPictureIndex	= llvi_Item.pictureindex
lv_admin.additem(llvi_Item)



end subroutine

public subroutine of_mostrar_objetos_bd_tipo_vista (string as_database);ListViewItem llvi_Item

String   ls_Nombre, ls_Propietario, ls_Pariente
DateTime ldt_FechaCreacion
String ls_param , ls_SQL , ls_data
Long lll_id ,   lll_idPariente
Int li_TipoSistema

lv_admin.DeleteItems ( )
lv_admin.Deletecolumns( )

lv_admin.view = ListViewReport!

lv_admin.AddColumn( "Nombre" , Left! , 750)
lv_admin.AddColumn( "Propietario" , Left! , 750)
lv_admin.AddColumn( "Tipo" , Left! , 350)
lv_admin.AddColumn( "Fecha de creaci$$HEX1$$f300$$ENDHEX$$n" , Left! , 550)

If (itr_SQLCA.Is_Tr.Is_Database <> as_database) Then
	DisConnect Using itr_SQLCA ;	
	itr_SQLCA.Is_Tr.Is_Database = as_database
	itr_SQLCA.of_ado_net( )
	Connect Using itr_SQLCA ;
End If

ls_param = "SET NOCOUNT OFF"
EXECUTE IMMEDIATE :ls_param USING itr_SQLCA ; 


 If itr_SQLCA.sqlcode = 0 Then


DECLARE lc_bd CURSOR FOR 
Select  
Nombre = IsNull(name ,'') , id ,  Propietario = IsNull(user_name(uid),'') ,  
FechaCreacion = crdate ,  
Pariente = IsNull(object_name(parent_obj),'')  , idPariente = IsNull(parent_obj,'')  ,  
TipoSistema  = (case when (OBJECTPROPERTY(id, 'IsMSShipped')=1) then 1 else OBJECTPROPERTY(id, 'IsSystemTable') end)  
From dbo.sysobjects (NoLock) 
Where OBJECTPROPERTY(id, 'IsView') = 1   and Xtype = 'V' 
order by TipoSistema , Nombre   
Using itr_SQLCA ;

 OPEN  lc_bd ; 

 FETCH lc_bd   INTO  :ls_Nombre, :lll_id, :ls_Propietario, :ldt_FechaCreacion, :ls_Pariente, :lll_idPariente, :li_TipoSistema ;
	
	DO WHILE itr_SQLCA.sqlcode = 0 and itr_SQLCA.sqldbcode = 0
	//////
	
	ls_data =  ls_Nombre+is_y+ls_Propietario+is_y
	
	If (li_TipoSistema=1) Then
		ls_data = ls_data + "Sistema"+is_y
	Else
		ls_data = ls_data + "Usuario"+is_y
	End If
	
	ls_data = ls_data + String(ldt_FechaCreacion,"DD/MM/YYYY HH:MM:SS")
	
	llvi_Item.label = ls_data
	llvi_Item.data = lll_id
	llvi_Item.pictureindex =9
	llvi_Item.OverlayPictureIndex	= llvi_Item.pictureindex
	lv_admin.additem(llvi_Item)

	//////	
FETCH lc_bd   INTO :ls_Nombre, :lll_id, :ls_Propietario, :ldt_FechaCreacion, :ls_Pariente, :lll_idPariente, :li_TipoSistema ;
	
	LOOP
	
	Close  lc_bd ;
	
End If
end subroutine

public subroutine of_mostrar_objetos_bd_tipo_tabla (string as_database);ListViewItem llvi_Item

String   ls_Nombre, ls_Propietario, ls_Pariente
DateTime ldt_FechaCreacion
String ls_param , ls_SQL , ls_data
Long ll_id ,   lll_idPariente
Int li_TipoSistema

lv_admin.DeleteItems ( )
lv_admin.Deletecolumns( )

lv_admin.view = ListViewReport!

lv_admin.AddColumn( "Nombre" , Left! , 750)
lv_admin.AddColumn( "Propietario" , Left! , 750)
lv_admin.AddColumn( "Tipo" , Left! , 350)
lv_admin.AddColumn( "Fecha de creaci$$HEX1$$f300$$ENDHEX$$n" , Left! , 550)

If (itr_SQLCA.Is_Tr.Is_Database <> as_database) Then
	DisConnect Using itr_SQLCA ;	
	DisConnect Using itr_SQLCA ;		
	itr_SQLCA.Is_Tr.Is_Database = as_database
	itr_SQLCA.of_ado_net( )
	Connect Using itr_SQLCA ;
End If

ls_param = "SET NOCOUNT OFF"
EXECUTE IMMEDIATE :ls_param USING itr_SQLCA ; 


 If itr_SQLCA.sqlcode = 0 Then


DECLARE lc_bd CURSOR FOR 
Select  
Nombre = IsNull(name ,'') , id ,  Propietario = IsNull(user_name(uid),'') ,  
FechaCreacion = crdate ,  
Pariente = IsNull(object_name(parent_obj),'')  , idPariente = IsNull(parent_obj,'')  ,  
TipoSistema  = (case when (OBJECTPROPERTY(id, 'IsMSShipped')=1) then 1 else OBJECTPROPERTY(id, 'IsSystemTable') end)  
From dbo.sysobjects (NoLock) 
Where OBJECTPROPERTY(id, 'IsTable') = 1  and Xtype in ( 'U','S') 
order by TipoSistema , Nombre   Using itr_SQLCA ;

 OPEN  lc_bd ; 

 FETCH lc_bd   INTO  :ls_Nombre, :ll_id, :ls_Propietario, :ldt_FechaCreacion, :ls_Pariente, :lll_idPariente, :li_TipoSistema ;
	
	DO WHILE itr_SQLCA.sqlcode = 0 and itr_SQLCA.sqldbcode = 0
	//////
	
	ls_data =  ls_Nombre+is_y+ls_Propietario+is_y
	
	If (li_TipoSistema=1) Then
		ls_data = ls_data + "Sistema"+is_y
	Else
		ls_data = ls_data + "Usuario"+is_y
	End If
	
	ls_data = ls_data + String(ldt_FechaCreacion,"DD/MM/YYYY HH:MM:SS")
	
	llvi_Item.label = ls_data
	llvi_Item.data = ll_id
	llvi_Item.pictureindex =6
	llvi_Item.OverlayPictureIndex	= llvi_Item.pictureindex
	lv_admin.additem(llvi_Item)

	//////	
FETCH lc_bd   INTO :ls_Nombre, :ll_id, :ls_Propietario, :ldt_FechaCreacion, :ls_Pariente, :lll_idPariente, :li_TipoSistema ;
	
	LOOP
	
	Close  lc_bd ;
	
End If
end subroutine

public subroutine of_mostrar_objetos_bd_tipo_spex (string as_database);ListViewItem llvi_Item

String   ls_Nombre, ls_Propietario, ls_Pariente
DateTime ldt_FechaCreacion
String ls_param , ls_SQL , ls_data
Long ll_id ,   lll_idPariente
Int li_TipoSistema

lv_admin.DeleteItems ( )
lv_admin.Deletecolumns( )

lv_admin.view = ListViewReport!

lv_admin.AddColumn( "Nombre" , Left! , 750)
lv_admin.AddColumn( "Propietario" , Left! , 750)
lv_admin.AddColumn( "Tipo" , Left! , 350)
lv_admin.AddColumn( "Fecha de creaci$$HEX1$$f300$$ENDHEX$$n" , Left! , 550)

If (itr_SQLCA.Is_Tr.Is_Database <> as_database) Then
	DisConnect Using itr_SQLCA ;	
	itr_SQLCA.Is_Tr.Is_Database = as_database
	itr_SQLCA.of_ado_net( )
	Connect Using itr_SQLCA ;
End If

ls_param = "SET NOCOUNT OFF"
EXECUTE IMMEDIATE :ls_param USING itr_SQLCA ; 


 If itr_SQLCA.sqlcode = 0 Then


DECLARE lc_bd CURSOR FOR 
Select  
Nombre = IsNull(name ,'') , id ,  Propietario = IsNull(user_name(uid),'') ,  
FechaCreacion = crdate ,  
Pariente = IsNull(object_name(parent_obj),'')  , idPariente = IsNull(parent_obj,'')  ,  
TipoSistema  = (case when (OBJECTPROPERTY(id, 'IsMSShipped')=1) then 1 else OBJECTPROPERTY(id, 'IsSystemTable') end)  
From dbo.sysobjects (NoLock) 
Where (OBJECTPROPERTY(id, 'IsProcedure') = 1 or OBJECTPROPERTY(id, 'IsExtendedProc') = 1 or OBJECTPROPERTY(id, 'IsReplProc') = 1)  and Xtype = 'X'
order by TipoSistema , Nombre   
Using itr_SQLCA ;

 OPEN  lc_bd ; 

 FETCH lc_bd   INTO  :ls_Nombre, :ll_id, :ls_Propietario, :ldt_FechaCreacion, :ls_Pariente, :lll_idPariente, :li_TipoSistema ;
	
	DO WHILE itr_SQLCA.sqlcode = 0 and itr_SQLCA.sqldbcode = 0
	//////
	
	ls_data =  ls_Nombre+is_y+ls_Propietario+is_y
	
	If (li_TipoSistema=1) Then
		ls_data = ls_data + "Sistema"+is_y
	Else
		ls_data = ls_data + "Usuario"+is_y
	End If
	
	ls_data = ls_data + String(ldt_FechaCreacion,"DD/MM/YYYY HH:MM:SS")
	
	llvi_Item.label = ls_data
	llvi_Item.data = ll_id
	llvi_Item.pictureindex =14
	llvi_Item.OverlayPictureIndex	= llvi_Item.pictureindex
	lv_admin.additem(llvi_Item)

	//////	
FETCH lc_bd   INTO :ls_Nombre, :ll_id, :ls_Propietario, :ldt_FechaCreacion, :ls_Pariente, :lll_idPariente, :li_TipoSistema ;
	
	LOOP
	
	Close  lc_bd ;
	
End If
end subroutine

public subroutine of_mostrar_objetos_bd_tipo_sp (string as_database);ListViewItem llvi_Item

String   ls_Nombre, ls_Propietario, ls_Pariente
DateTime ldt_FechaCreacion
String ls_param , ls_SQL , ls_data
Long ll_id ,   lll_idPariente
Int li_TipoSistema

lv_admin.DeleteItems ( )
lv_admin.Deletecolumns( )

lv_admin.view = ListViewReport!

lv_admin.AddColumn( "Nombre" , Left! , 750)
lv_admin.AddColumn( "Propietario" , Left! , 750)
lv_admin.AddColumn( "Tipo" , Left! , 350)
lv_admin.AddColumn( "Fecha de creaci$$HEX1$$f300$$ENDHEX$$n" , Left! , 550)

If (itr_SQLCA.Is_Tr.Is_Database <> as_database) Then
	DisConnect Using itr_SQLCA ;	
	itr_SQLCA.Is_Tr.Is_Database = as_database
	itr_SQLCA.of_ado_net( )
	Connect Using itr_SQLCA ;
End If

ls_param = "SET NOCOUNT OFF"
EXECUTE IMMEDIATE :ls_param USING itr_SQLCA ; 


 If itr_SQLCA.sqlcode = 0 Then


DECLARE lc_bd CURSOR FOR 
Select  
Nombre = IsNull(name ,'') , id ,  Propietario = IsNull(user_name(uid),'') ,  
FechaCreacion = crdate ,  
Pariente = IsNull(object_name(parent_obj),'')  , idPariente = IsNull(parent_obj,'')  ,  
TipoSistema  = (case when (OBJECTPROPERTY(id, 'IsMSShipped')=1) then 1 else OBJECTPROPERTY(id, 'IsSystemTable') end)  
From dbo.sysobjects (NoLock) 
Where (OBJECTPROPERTY(id, 'IsProcedure') = 1 or OBJECTPROPERTY(id, 'IsExtendedProc') = 1 or OBJECTPROPERTY(id, 'IsReplProc') = 1)  and Xtype = 'P'
order by TipoSistema , Nombre   
Using itr_SQLCA ;

 OPEN  lc_bd ; 

 FETCH lc_bd   INTO  :ls_Nombre, :ll_id, :ls_Propietario, :ldt_FechaCreacion, :ls_Pariente, :lll_idPariente, :li_TipoSistema ;
	
	DO WHILE itr_SQLCA.sqlcode = 0 and itr_SQLCA.sqldbcode = 0
	//////
	
	ls_data =  ls_Nombre+is_y+ls_Propietario+is_y
	
	If (li_TipoSistema=1) Then
		ls_data = ls_data + "Sistema"+is_y
	Else
		ls_data = ls_data + "Usuario"+is_y
	End If
	
	ls_data = ls_data + String(ldt_FechaCreacion,"DD/MM/YYYY HH:MM:SS")
	
	llvi_Item.label = ls_data
	llvi_Item.data = ll_id
	llvi_Item.pictureindex =8
	llvi_Item.OverlayPictureIndex	= llvi_Item.pictureindex
	lv_admin.additem(llvi_Item)

	//////	
FETCH lc_bd   INTO :ls_Nombre, :ll_id, :ls_Propietario, :ldt_FechaCreacion, :ls_Pariente, :lll_idPariente, :li_TipoSistema ;
	
	LOOP
	
	Close  lc_bd ;
	
End If
end subroutine

public subroutine of_mostrar_objetos_bd_tipo_sesiones (string as_database);ListViewItem llvi_Item
Int li_uid  , li_islogin , li_isntname,li_isntgroup,li_isntuser, li_issqluser  
String  ls_param , ls_name   , ls_loginname , ls_grupo 
DateTime ldt_createdate
String ls_SQL , ls_data
  
lv_admin.DeleteItems ( )
lv_admin.Deletecolumns( )

lv_admin.view = ListViewReport!

lv_admin.AddColumn( "Nombre" , Left! , 750)
lv_admin.AddColumn( "Nombre de inicio de sesi$$HEX1$$f300$$ENDHEX$$n" , Left! , 750)
lv_admin.AddColumn( "Acceso a base de datos" , Left! , 350)
lv_admin.AddColumn( "Tipo" , Left! , 350)
lv_admin.AddColumn( "Grupo" , Left! , 300)
lv_admin.AddColumn( "Creaci$$HEX1$$f300$$ENDHEX$$n" , Left! , 550)
lv_admin.AddColumn( "UId" , Left! , 150)


If (itr_SQLCA.Is_Tr.Is_Database <> as_database) Then
	DisConnect Using itr_SQLCA ;	
	itr_SQLCA.Is_Tr.Is_Database = as_database
	itr_SQLCA.of_ado_net( )
	Connect Using itr_SQLCA ;
End If

ls_param = "SET NOCOUNT OFF"
EXECUTE IMMEDIATE :ls_param USING itr_SQLCA ; 


 If itr_SQLCA.sqlcode = 0 Then

	DECLARE lc_bd CURSOR FOR 
	Select  
	o.name,   
	loginname = (case when (o.sid = 0) then '' else l.loginname end),  
	user_name(o.gid) grupo ,   
	o.createdate ,  
	o.uid,   
	o.islogin , o.isntname,o.isntgroup,o.isntuser, o.issqluser   
	from dbo.sysusers o (nolock)  
	left join (select sid, loginname, 1 as matched from master.dbo.syslogins (nolock)) l on l.sid = o.sid   
	where ((o.issqlrole != 1 and o.isapprole != 1 and o.status != 0 and matched is not null)   
	or (o.sid = 0) and o.hasdbaccess = 1) and o.isaliased != 1 order by o.isntname desc , isntgroup desc , o.name   

	Using itr_SQLCA ;

    OPEN  lc_bd ; 

     FETCH lc_bd   INTO  :ls_name, :ls_loginname, :ls_grupo, :ldt_createdate, :li_uid, :li_islogin , :li_isntname, :li_isntgroup, :li_isntuser, :li_issqluser    ;
	
	DO WHILE itr_SQLCA.sqlcode = 0 and itr_SQLCA.sqldbcode = 0
		//////	
		ls_data =  ls_name+is_y+ls_loginname+is_y
		
		If (li_islogin=1) Then
			ls_data = ls_data + "Permiso"+is_y
		Else
			ls_data = ls_data + "Denegar"+is_y
		End If
		
		If ((li_isntname=1) and (li_isntgroup=1) )Then
			ls_data = ls_data + "Grupo de Windows"+is_y
			llvi_Item.pictureindex = 16
		ElseIf ((li_isntname=1) and (li_isntgroup=0) )Then
			ls_data = ls_data+  "Usuario de Windows"+is_y
			llvi_Item.pictureindex =3
		ElseIf ((li_isntname=0) and (li_isntgroup=0) and (li_issqluser=1)) Then
			ls_data =ls_data+  "Est$$HEX1$$e100$$ENDHEX$$ndar"+is_y
			llvi_Item.pictureindex = 10
		End If
		
		ls_data = ls_data + ls_grupo+is_y+String(ldt_createdate,"DD/MM/YYYY HH:MM:SS")+is_y+String(li_uid)
		
		// Recuperar Inicios de Sesion
		llvi_Item.label = ls_data
		llvi_Item.data = ls_loginname
			llvi_Item.OverlayPictureIndex	= llvi_Item.pictureindex
		lv_admin.additem(llvi_Item)
	
		//////	
		 FETCH lc_bd   INTO  :ls_name, :ls_loginname, :ls_grupo, :ldt_createdate, :li_uid, :li_islogin , :li_isntname, :li_isntgroup, :li_isntuser, :li_issqluser    ;
	
	LOOP
	
	Close  lc_bd ;
	
End If


end subroutine

public subroutine of_mostrar_objetos_bd_tipo_roles (string as_database);ListViewItem llvi_Item
Long ll_uid 
Int  li_issqlrole, li_isapprole  
String  ls_param , ls_name   
DateTime ldt_createdate
String ls_SQL , ls_data
  
lv_admin.DeleteItems ( )
lv_admin.Deletecolumns( )

lv_admin.view = ListViewReport!

lv_admin.AddColumn( "Nombre" , Left! , 750)
lv_admin.AddColumn( "Tipo de funci$$HEX1$$f300$$ENDHEX$$n" , Left! , 350)
lv_admin.AddColumn( "Creaci$$HEX1$$f300$$ENDHEX$$n" , Left! , 550)


If (itr_SQLCA.Is_Tr.Is_Database <> as_database) Then
	DisConnect Using itr_SQLCA ;	
	itr_SQLCA.Is_Tr.Is_Database = as_database
	itr_SQLCA.of_ado_net( )
	Connect Using itr_SQLCA ;
End If

ls_param = "SET NOCOUNT OFF"
EXECUTE IMMEDIATE :ls_param USING itr_SQLCA ; 


 If itr_SQLCA.sqlcode = 0 Then

	DECLARE lc_bd CURSOR FOR 
	Select name, createdate ,uid, issqlrole, isapprole   
	from dbo.sysusers o (nolock)  
	where (issqlrole = 1 or isapprole = 1 ) order by isntname desc , isntgroup desc , name   

	Using itr_SQLCA ;

    OPEN  lc_bd ; 

     FETCH lc_bd   INTO  :ls_name,  :ldt_createdate, :ll_uid, :li_issqlrole, :li_isapprole     ;
	
	DO WHILE itr_SQLCA.sqlcode = 0 and itr_SQLCA.sqldbcode = 0
		//////	
		ls_data =  ls_name+is_y
		
		If (li_issqlrole=1) Then
			ls_data = ls_data + "Est$$HEX1$$e100$$ENDHEX$$ndar"+is_y
		ElseIf (li_isapprole=1) Then
			ls_data = ls_data + "Aplicaci$$HEX1$$f300$$ENDHEX$$n"+is_y
		End If
		
	
		ls_data = ls_data + String(ldt_createdate,"DD/MM/YYYY HH:MM:SS")
		
		// Recuperar Inicios de Sesion 			
		llvi_Item.pictureindex = 15
		llvi_Item.label = ls_data
		llvi_Item.data = ll_uid
		llvi_Item.OverlayPictureIndex	= llvi_Item.pictureindex
		lv_admin.additem(llvi_Item)
	
		//////	
		     FETCH lc_bd   INTO  :ls_name,  :ldt_createdate, :ll_uid, :li_issqlrole, :li_isapprole     ;
	
	LOOP
	
	Close  lc_bd ;
	
End If


end subroutine

public subroutine of_mostrar_objetos_bd_tipo_regla (string as_database);ListViewItem llvi_Item

String   ls_Nombre, ls_Propietario, ls_Pariente
DateTime ldt_FechaCreacion
String ls_param , ls_SQL , ls_data
Long ll_id ,   lll_idPariente
Int li_TipoSistema

lv_admin.DeleteItems ( )
lv_admin.Deletecolumns( )

lv_admin.view = ListViewReport!

lv_admin.AddColumn( "Nombre" , Left! , 750)
lv_admin.AddColumn( "Propietario" , Left! , 750)
lv_admin.AddColumn( "Tipo" , Left! , 350)
lv_admin.AddColumn( "Fecha de creaci$$HEX1$$f300$$ENDHEX$$n" , Left! , 550)

If (itr_SQLCA.Is_Tr.Is_Database <> as_database) Then
	DisConnect Using itr_SQLCA ;	
	itr_SQLCA.Is_Tr.Is_Database = as_database
	itr_SQLCA.of_ado_net( )
	Connect Using itr_SQLCA ;
End If

ls_param = "SET NOCOUNT OFF"
EXECUTE IMMEDIATE :ls_param USING itr_SQLCA ; 


 If itr_SQLCA.sqlcode = 0 Then


DECLARE lc_bd CURSOR FOR 
Select  
Nombre = IsNull(name ,'') , id ,  Propietario = IsNull(user_name(uid),'') ,  
FechaCreacion = crdate ,  
Pariente = IsNull(object_name(parent_obj),'')  , idPariente = IsNull(parent_obj,'')  ,  
TipoSistema  = (case when (OBJECTPROPERTY(id, 'IsMSShipped')=1) then 1 else OBJECTPROPERTY(id, 'IsSystemTable') end)  
From dbo.sysobjects (NoLock) 
Where OBJECTPROPERTY(id, 'IsRule') = 1   and Xtype = 'R'
order by TipoSistema , Nombre   
Using itr_SQLCA ;

 OPEN  lc_bd ; 

 FETCH lc_bd   INTO  :ls_Nombre, :ll_id, :ls_Propietario, :ldt_FechaCreacion, :ls_Pariente, :lll_idPariente, :li_TipoSistema ;
	
	DO WHILE itr_SQLCA.sqlcode = 0 and itr_SQLCA.sqldbcode = 0
	//////
	
	ls_data =  ls_Nombre+is_y+ls_Propietario+is_y
	
	If (li_TipoSistema=1) Then
		ls_data = ls_data + "Sistema"+is_y
	Else
		ls_data = ls_data + "Usuario"+is_y
	End If
	
	ls_data = ls_data + String(ldt_FechaCreacion,"DD/MM/YYYY HH:MM:SS")
	
	llvi_Item.label = ls_data
	llvi_Item.data = ll_id
	llvi_Item.pictureindex =11
	llvi_Item.OverlayPictureIndex	= llvi_Item.pictureindex
	lv_admin.additem(llvi_Item)

	//////	
FETCH lc_bd   INTO :ls_Nombre, :ll_id, :ls_Propietario, :ldt_FechaCreacion, :ls_Pariente, :lll_idPariente, :li_TipoSistema ;
	
	LOOP
	
	Close  lc_bd ;
	
End If
end subroutine

public subroutine of_mostrar_objetos_bd_tipo_funcion (string as_database);ListViewItem llvi_Item

String   ls_Nombre, ls_Propietario, ls_Pariente
DateTime ldt_FechaCreacion
String ls_param , ls_SQL , ls_data
Long ll_id ,   lll_idPariente
Int li_TipoSistema

lv_admin.DeleteItems ( )
lv_admin.Deletecolumns( )

lv_admin.view = ListViewReport!

lv_admin.AddColumn( "Nombre" , Left! , 750)
lv_admin.AddColumn( "Propietario" , Left! , 750)
lv_admin.AddColumn( "Tipo" , Left! , 350)
lv_admin.AddColumn( "Fecha de creaci$$HEX1$$f300$$ENDHEX$$n" , Left! , 550)

If (itr_SQLCA.Is_Tr.Is_Database <> as_database) Then
	DisConnect Using itr_SQLCA ;	
	itr_SQLCA.Is_Tr.Is_Database = as_database
	itr_SQLCA.of_ado_net( )
	Connect Using itr_SQLCA ;
End If

ls_param = "SET NOCOUNT OFF"
EXECUTE IMMEDIATE :ls_param USING itr_SQLCA ; 


 If itr_SQLCA.sqlcode = 0 Then


DECLARE lc_bd CURSOR FOR 
Select  
Nombre = IsNull(name ,'') , id ,  Propietario = IsNull(user_name(uid),'') ,  
FechaCreacion = crdate ,  
Pariente = IsNull(object_name(parent_obj),'')  , idPariente = IsNull(parent_obj,'')  ,  
TipoSistema  = (case when (OBJECTPROPERTY(id, 'IsMSShipped')=1) then 1 else OBJECTPROPERTY(id, 'IsSystemTable') end)  
From dbo.sysobjects (NoLock) 
Where  (xtype = 'TF' or xtype = 'FN' or xtype = 'IF')
order by TipoSistema , Nombre   
Using itr_SQLCA ;

 OPEN  lc_bd ; 

 FETCH lc_bd   INTO  :ls_Nombre, :ll_id, :ls_Propietario, :ldt_FechaCreacion, :ls_Pariente, :lll_idPariente, :li_TipoSistema ;
	
	DO WHILE itr_SQLCA.sqlcode = 0 and itr_SQLCA.sqldbcode = 0
	//////
	
	ls_data =  ls_Nombre+is_y+ls_Propietario+is_y
	
	If (li_TipoSistema=1) Then
		ls_data = ls_data + "Sistema"+is_y
	Else
		ls_data = ls_data + "Usuario"+is_y
	End If
	
	ls_data = ls_data + String(ldt_FechaCreacion,"DD/MM/YYYY HH:MM:SS")
	
	llvi_Item.label = ls_data
	llvi_Item.data = ll_id
	llvi_Item.pictureindex =7
	llvi_Item.OverlayPictureIndex	= llvi_Item.pictureindex
	lv_admin.additem(llvi_Item)

	//////	
FETCH lc_bd   INTO :ls_Nombre, :ll_id, :ls_Propietario, :ldt_FechaCreacion, :ls_Pariente, :lll_idPariente, :li_TipoSistema ;
	
	LOOP
	
	Close  lc_bd ;
	
End If
end subroutine

public subroutine of_mostrar_objetos_bd_tipo_default (string as_database);ListViewItem llvi_Item

String   ls_Nombre, ls_Propietario, ls_Pariente
DateTime ldt_FechaCreacion
String ls_param , ls_SQL , ls_data
Long ll_id ,   lll_idPariente
Int li_TipoSistema

lv_admin.DeleteItems ( )
lv_admin.Deletecolumns( )

lv_admin.view = ListViewReport!

lv_admin.AddColumn( "Nombre" , Left! , 750)
lv_admin.AddColumn( "Propietario" , Left! , 750)
lv_admin.AddColumn( "Tipo" , Left! , 350)
lv_admin.AddColumn( "Fecha de creaci$$HEX1$$f300$$ENDHEX$$n" , Left! , 550)

//If (itr_SQLCA.Is_Tr.Is_Database <> as_database) Then
	DisConnect Using itr_SQLCA ;	
	itr_SQLCA.Is_Tr.Is_Database = as_database
	itr_SQLCA.of_ado_net( )
	Connect Using itr_SQLCA ;
//End If

ls_param = "SET NOCOUNT OFF"
EXECUTE IMMEDIATE :ls_param USING itr_SQLCA ; 


 If itr_SQLCA.sqlcode = 0 Then


DECLARE lc_bd CURSOR FOR 
Select  
Nombre = IsNull(name ,'') , id ,  Propietario = IsNull(user_name(uid),'') ,  
FechaCreacion = crdate ,  
Pariente = IsNull(object_name(parent_obj),'')  , idPariente = IsNull(parent_obj,'')  ,  
TipoSistema  = (case when (OBJECTPROPERTY(id, 'IsMSShipped')=1) then 1 else OBJECTPROPERTY(id, 'IsSystemTable') end)  
From dbo.sysobjects (NoLock) 
Where  OBJECTPROPERTY(id, 'IsDefault') = 1  and Xtype = 'D' 
order by TipoSistema , Nombre   
Using itr_SQLCA ;

 OPEN  lc_bd ; 

 FETCH lc_bd   INTO  :ls_Nombre, :ll_id, :ls_Propietario, :ldt_FechaCreacion, :ls_Pariente, :lll_idPariente, :li_TipoSistema ;
	
	DO WHILE itr_SQLCA.sqlcode = 0 and itr_SQLCA.sqldbcode = 0
	//////
	
	ls_data =  ls_Nombre+is_y+ls_Propietario+is_y
	
	If (li_TipoSistema=1) Then
		ls_data = ls_data + "Sistema"+is_y
	Else
		ls_data = ls_data + "Usuario"+is_y
	End If
	
	ls_data = ls_data + String(ldt_FechaCreacion,"DD/MM/YYYY HH:MM:SS")
	
	llvi_Item.label = ls_data
	llvi_Item.data = ll_id
	llvi_Item.pictureindex =12
	llvi_Item.OverlayPictureIndex	= llvi_Item.pictureindex
	lv_admin.additem(llvi_Item)

	//////	
FETCH lc_bd   INTO :ls_Nombre, :ll_id, :ls_Propietario, :ldt_FechaCreacion, :ls_Pariente, :lll_idPariente, :li_TipoSistema ;
	
	LOOP
	
	Close  lc_bd ;
	
End If
end subroutine

public subroutine of_mostrar_objetos_bd_tipo_datos_usuario (string as_database);ListViewItem llvi_Item
String ls_param ,  ls_data , ls_typename, ls_flags 
String 	ls_UserDatatypeName , &
			ls_owner, &
			ls_basetypename, &
			ls_defaultname, &
			ls_rulename, &
			ls_defaultowner, &
			ls_ruleowner , &   
			ls_dt_prec, &
			ls_dt_scale, &
			ls_collation   
Int 	li_tid, &
		li_length, &
		li_nullable, &
		li_dt_prec, &
		li_dt_scale, &
		li_dt_flags, &
		li_allowidentity, &
		li_variablelength, &
		li_maxlen

SetNull(ls_typename) 
ls_flags = "uddt"
lv_admin.DeleteItems ( )
lv_admin.Deletecolumns( )

lv_admin.view = ListViewReport!

lv_admin.AddColumn( "Nombre" , Left! , 500)
lv_admin.AddColumn( "Propietario" , Left! , 200)
lv_admin.AddColumn( "Tipo" , Left! , 350)
lv_admin.AddColumn( "Longitud" , Left! , 200)
lv_admin.AddColumn( "Precisi$$HEX1$$f300$$ENDHEX$$n" , Left! , 200)
lv_admin.AddColumn( "Escala" , Left! , 200)
lv_admin.AddColumn( "Permitir valores NULL" , Left! , 350)
lv_admin.AddColumn( "Valor predeterminado" , Left! , 350)
lv_admin.AddColumn( "Regla" , Left! , 350)


If (itr_SQLCA.Is_Tr.Is_Database <> as_database) Then
	DisConnect Using itr_SQLCA ;	
	itr_SQLCA.Is_Tr.Is_Database = as_database
	itr_SQLCA.of_ado_net( )
	Connect Using itr_SQLCA ;
End If

ls_param = "SET NOCOUNT OFF"
EXECUTE IMMEDIATE :ls_param USING itr_SQLCA ; 


 If itr_SQLCA.sqlcode = 0 Then


 DECLARE Usp_MShelptype PROCEDURE FOR  sp_MShelptype  @typename = :ls_typename,   @flags =:ls_flags   Using itr_SQLCA ;

EXECUTE Usp_MShelptype ; 

 FETCH Usp_MShelptype   INTO  	:ls_UserDatatypeName,
												:ls_owner,
												:ls_basetypename,
												:ls_defaultname,
												:ls_rulename,
												:li_tid,
												:li_length,
												:li_nullable,
												:li_dt_prec,
												:li_dt_scale,
												:li_dt_flags,
												:li_allowidentity,
												:li_variablelength,
												:li_maxlen,
												:ls_defaultowner,
												:ls_ruleowner, 
												:ls_collation  ;
	
	DO WHILE itr_SQLCA.sqlcode = 0 and itr_SQLCA.sqldbcode = 0
	//////
	
	If Isnull(li_dt_prec) Then 
	ls_dt_prec = ""
	Else
	ls_dt_prec = String(li_dt_prec)
	End If
	
	If Isnull(li_dt_scale) Then 
	ls_dt_scale = ""
	Else
	ls_dt_scale = String(li_dt_scale)
	End If
	
	
	ls_data =  ls_UserDatatypeName+is_y+ls_owner+is_y+ls_basetypename+is_y+String(li_maxlen)+is_y+ls_dt_prec+is_y+ls_dt_scale+is_y+String(li_nullable)+is_y
	

	If Isnull( ls_defaultowner) and Isnull (ls_defaultname) Then 
		ls_data = ls_data + ""+is_y
	Else
		ls_data = ls_data + ls_defaultowner+"."+ls_defaultname+is_y
	End If
	
	If Isnull( ls_ruleowner) and Isnull (ls_rulename) Then 
		ls_data = ls_data + ""+is_y
	Else
		ls_data = ls_data + ls_ruleowner+"."+ls_rulename+is_y
	End If
	
	
	llvi_Item.label = ls_data
	llvi_Item.data = li_tid
	llvi_Item.pictureindex =13
	llvi_Item.OverlayPictureIndex	= llvi_Item.pictureindex
	lv_admin.additem(llvi_Item)

	//////	
 FETCH Usp_MShelptype   INTO  	:ls_UserDatatypeName,
												:ls_owner,
												:ls_basetypename,
												:ls_defaultname,
												:ls_rulename,
												:li_tid,
												:li_length,
												:li_nullable,
												:li_dt_prec,
												:li_dt_scale,
												:li_dt_flags,
												:li_allowidentity,
												:li_variablelength,
												:li_maxlen,
												:ls_defaultowner,
												:ls_ruleowner, 
												:ls_collation  ;	
	LOOP
	
End If

Rollback Using itr_SQLCA ;
//	DisConnect Using itr_SQLCA ;	
//	itr_SQLCA.database = as_database
//	Connect Using itr_SQLCA ;
end subroutine

public subroutine of_mostrar_objetos_bd_tipo (string as_database, string as_tipo, integer ai_icono);ListViewItem llvi_Item

String   ls_Nombre, ls_Propietario, ls_Pariente
DateTime ldt_FechaCreacion
String ls_param ,  ls_data
Long ll_id ,   lll_idPariente
Int li_TipoSistema

lv_admin.DeleteItems ( )
lv_admin.Deletecolumns( )

lv_admin.view = ListViewReport!

lv_admin.AddColumn( "Nombre" , Left! , 750)
lv_admin.AddColumn( "Propietario" , Left! , 750)
lv_admin.AddColumn( "Tipo" , Left! , 350)
lv_admin.AddColumn( "Fecha de creaci$$HEX1$$f300$$ENDHEX$$n" , Left! , 550)

If (itr_SQLCA.Is_Tr.Is_Database <> as_database) Then
	DisConnect Using itr_SQLCA ;	
	DisConnect Using itr_SQLCA ;	
	itr_SQLCA.Is_Tr.Is_Database = as_database
	itr_SQLCA.of_ado_net( )
	Connect Using itr_SQLCA ;
End If

ls_param = "SET NOCOUNT OFF"
EXECUTE IMMEDIATE :ls_param USING itr_SQLCA ; 

 If itr_SQLCA.sqlcode = 0 Then


DECLARE lc_bd CURSOR FOR Select   Nombre = IsNull(name ,'') , id ,  Propietario = IsNull(user_name(uid),'') ,   FechaCreacion = crdate ,   Pariente = IsNull(object_name(parent_obj),'')  , idPariente = IsNull(parent_obj,'')  ,   TipoSistema  = (case when (OBJECTPROPERTY(id, 'IsMSShipped')=1) then 1 else OBJECTPROPERTY(id, 'IsSystemTable') end)   From pubs.dbo.sysobjects (NoLock)  Where  OBJECTPROPERTY(id, 'IsDefault') = 1  and Xtype = 'D'   order by TipoSistema , Nombre Using itr_SQLCA ;

 OPEN  lc_bd ; 

 FETCH lc_bd   INTO  :ls_Nombre, :ll_id, :ls_Propietario, :ldt_FechaCreacion, :ls_Pariente, :lll_idPariente, :li_TipoSistema ;
	
	DO WHILE itr_SQLCA.sqlcode = 0 and itr_SQLCA.sqldbcode = 0
	//////
	
	ls_data =  ls_Nombre+is_y+ls_Propietario+is_y
	
	If (li_TipoSistema=1) Then
		ls_data = ls_data + "Sistema"+is_y
	Else
		ls_data = ls_data + "Usuario"+is_y
	End If
	
	ls_data = ls_data + String(ldt_FechaCreacion,"DD/MM/YYYY HH:MM:SS")
	
	// Recuperar Inicios de Sesion
	llvi_Item.label = ls_data
	llvi_Item.data = ll_id
	llvi_Item.pictureindex =ai_icono
	llvi_Item.OverlayPictureIndex	= llvi_Item.pictureindex
	lv_admin.additem(llvi_Item)

	//////	
FETCH lc_bd   INTO :ls_Nombre, :ll_id, :ls_Propietario, :ldt_FechaCreacion, :ls_Pariente, :lll_idPariente, :li_TipoSistema ;
	
	LOOP
	
	Close  lc_bd ;
	
End If
end subroutine

public subroutine of_mostrar_objetos_bd (long al_bdid);ListViewItem llvi_Item
Int i , li_dbid

li_dbid = al_bdid - 1000

lv_admin.DeleteItems ( )

lv_admin.view = ListViewLargeIcon!

// Recuperar Inicios de Sesion
llvi_Item.label = "Tablas"
llvi_Item.data = 1100 + li_dbid
llvi_Item.pictureindex = 6

llvi_Item.OverlayPictureIndex	= llvi_Item.pictureindex
lv_admin.additem(llvi_Item)

// Recuperar Roles / Funciones del Servidor
llvi_Item.label = "Vistas"
llvi_Item.data =  1200 + li_dbid
llvi_Item.pictureindex = 9

llvi_Item.OverlayPictureIndex	= llvi_Item.pictureindex
lv_admin.additem(llvi_Item)

// Recuperar Inicios de Sesion
llvi_Item.label = "Procedimientos Almacenados"
llvi_Item.data = 1300 + li_dbid
llvi_Item.pictureindex = 8

llvi_Item.OverlayPictureIndex	= llvi_Item.pictureindex
lv_admin.additem(llvi_Item)

// Recuperar Roles / Funciones del Servidor
llvi_Item.label = "Procedimientos Almacenados Extendidos"
llvi_Item.data =  1400 + li_dbid
llvi_Item.pictureindex =14

llvi_Item.OverlayPictureIndex	= llvi_Item.pictureindex
lv_admin.additem(llvi_Item)

// Recuperar Inicios de Sesion
llvi_Item.label = "Usuarios"
llvi_Item.data =  1500 + li_dbid
llvi_Item.pictureindex = 10

llvi_Item.OverlayPictureIndex	= llvi_Item.pictureindex
lv_admin.additem(llvi_Item)

// Recuperar Roles / Funciones del Servidor
llvi_Item.label = "Funciones de Base de Datos"
llvi_Item.data =  1600 + li_dbid
llvi_Item.pictureindex = 15

llvi_Item.OverlayPictureIndex	= llvi_Item.pictureindex
lv_admin.additem(llvi_Item)

// Recuperar Inicios de Sesion
llvi_Item.label = "Reglas"
llvi_Item.data =  1700 + li_dbid
llvi_Item.pictureindex = 11

llvi_Item.OverlayPictureIndex	= llvi_Item.pictureindex
lv_admin.additem(llvi_Item)

// Recuperar Roles / Funciones del Servidor
llvi_Item.label = "Valores Predeterminados"
llvi_Item.data =  1800 + li_dbid
llvi_Item.pictureindex = 12

llvi_Item.OverlayPictureIndex	= llvi_Item.pictureindex
lv_admin.additem(llvi_Item)

// Recuperar Inicios de Sesion
llvi_Item.label = "Tipos de datos definidos por el Usuario"
llvi_Item.data =  1900 + li_dbid
llvi_Item.pictureindex = 13

llvi_Item.OverlayPictureIndex	= llvi_Item.pictureindex
lv_admin.additem(llvi_Item)

// Recuperar Roles / Funciones del Servidor
llvi_Item.label = "Funciones definidos por el Usuario"
llvi_Item.data =  2000 + li_dbid
llvi_Item.pictureindex = 7

llvi_Item.OverlayPictureIndex	= llvi_Item.pictureindex
lv_admin.additem(llvi_Item)

end subroutine

public subroutine of_mostrar_seguridad_objetos_bd (string as_database, integer ai_id);int li_icono 
string ls_tipo

choose case ai_id
	case 1101 to 1199 
			of_mostrar_objetos_bd_tipo_tabla( as_database)
	case 1201 to 1299	
			of_mostrar_objetos_bd_tipo_vista( as_database)
	case 1301 to 1399 
	   		of_mostrar_objetos_bd_tipo_sp( as_database)	
	case 1401 to 1499 
	   		of_mostrar_objetos_bd_tipo_spex( as_database)	
	case 1501 to 1599 	
			of_mostrar_objetos_bd_tipo_sesiones( as_database)	
	case 1601 to 1699 
			of_mostrar_objetos_bd_tipo_roles( as_database)	
	case 1701 to 1799 
	   		of_mostrar_objetos_bd_tipo_regla( as_database)	
	case 1801 to 1899 
	   		of_mostrar_objetos_bd_tipo_default( as_database)	
	case 1901 to 1999 
      		of_mostrar_objetos_bd_tipo_datos_usuario( as_database)
	case 2001 to 2099 
	   		of_mostrar_objetos_bd_tipo_funcion( as_database)	
end choose
end subroutine

public function integer of_refreshbars ();Integer	li_Cnt

//Force appropriate order
st_vertical.SetPosition(ToTop!)

//Make sure the Width is not lost
st_vertical.Width = ii_BarThickness

Return 1

end function

public function integer of_resizebars ();//Resize Bars according to Bars themselves, WindowBorder, and BarThickness.

Integer	li_HX, li_HW, li_Cnt

st_vertical.Move(st_vertical.X, ii_WindowBorder)
st_vertical.Resize(ii_barthickness, 5 + (Parent.Dynamic WorkSpaceHeight()) - (2 * ii_WindowBorder))

of_RefreshBars()

Return 1
end function

public function integer of_resizepanels ();//Resize the panels according to the Lines, 
//BarThickness, and WindowBorder.

Integer	li_Cnt, li_X, li_Y, li_HHeight, li_HWidth
Long		ll_Width, ll_Height

ll_Width =  Parent.Dynamic WorkSpaceWidth()
ll_Height = Parent.Dynamic WorkspaceHeight()

If ll_Width < idrg_Vertical[2].X + 150 Then
	ll_Width = idrg_Vertical[2].X + 150
End If

If ll_Height < idrg_Vertical[1].Y + 150 Then
	ll_Height = Idrg_Vertical[1].Y + 150
End If

// Left vertical object processing
idrg_Vertical[1].Move (ii_WindowBorder, ii_WindowBorder)
idrg_Vertical[1].Resize (st_vertical.X - idrg_Vertical[1].X, ll_Height - idrg_Vertical[1].Y - ii_WindowBorder)

// Right vertical object processing
idrg_Vertical[2].Move (st_vertical.X + ii_BarThickness, ii_WindowBorder)
idrg_Vertical[2].Resize (ll_Width - idrg_Vertical[2].X - ii_WindowBorder, ll_Height - idrg_Vertical[2].Y - ii_WindowBorder)


This.width = ll_Width - ii_WindowBorder
This.height =  ll_Height - ii_WindowBorder

Return 1

end function

public function string of_buscar_parametro (string as_parametro);
String ls_Parametro , ls_Parametros[] , ls_Buscar, ls_Cade

int li_ini_pos=1,li_len , Li_i

ls_Parametro= itr_SQLCA.dbparm
li_len = len( ls_Parametro )

ls_Buscar = ","
li_ini_pos = Pos(ls_Parametro,ls_Buscar,1)

//only enter the loop if you find whats in look_for

DO WHILE li_ini_pos > 0
	Li_i ++
	 ls_Parametros[Li_i] = Mid(ls_Parametro , 1, li_ini_pos -1)
	ls_Parametro = Mid(ls_Parametro , li_ini_pos+1)
	li_ini_pos = Pos( ls_Parametro ,ls_Buscar,1)
LOOP



Return ls_Parametro

end function

public subroutine of_settranssobject (n_transaccion_entrar atr_sqlca);
itr_SQLCA.LogId = atr_SQLCA.LogId
itr_SQLCA.LogPass = atr_SQLCA.LogPass 
itr_SQLCA.Is_Tr = atr_SQLCA.Is_Tr
end subroutine

public subroutine of_activar ();Post of_limpiar()
Post of_funcion_principal( )
end subroutine

on uo_security_mssql.create
this.st_vertical=create st_vertical
this.tv_admin=create tv_admin
this.lv_admin=create lv_admin
this.Control[]={this.st_vertical,&
this.tv_admin,&
this.lv_admin}
end on

on uo_security_mssql.destroy
destroy(this.st_vertical)
destroy(this.tv_admin)
destroy(this.lv_admin)
end on

event constructor;// The following lines are for setting up the resizing service
idrg_Vertical[1] = tv_admin
idrg_Vertical[2] = lv_admin

// Set the color of the bars to make them invisible
il_HiddenColor = This.BackColor
st_Vertical.BackColor = il_HiddenColor

//Resize Bars
of_ResizeBars()

//Resize the panels
of_ResizePanels()

itr_SQLCA = CREATE n_transaccion_entrar
end event

event destructor;
Disconnect Using itr_SQLCA;

If Not IsValid(itr_SQLCA) Then
	DESTROY itr_SQLCA
End If
end event

type st_vertical from statictext within uo_security_mssql
event mousemove pbm_mousemove
event mouseup pbm_lbuttonup
event mousedown pbm_lbuttondown
integer x = 1627
integer width = 32
integer height = 532
string dragicon = "Exclamation!"
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string pointer = "SizeWE!"
long textcolor = 255
long backcolor = 0
long bordercolor = 273962025
boolean focusrectangle = false
end type

event mousemove;//Check for move in progess
If KeyDown(keyLeftButton!) Then
	This.x = Parent.PointerX()
End If




end event

event mouseup;//Hide the bar
If Not ib_debug Then This.BackColor = il_hiddencolor

//Resize the panels
of_ResizePanels()

end event

event mousedown;If Not ib_debug Then this.BackColor = 0  //show Bar in Black

end event

type tv_admin from treeview within uo_security_mssql
integer width = 1614
integer height = 532
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
boolean linesatroot = true
boolean fullrowselect = true
string picturename[] = {"C:\JLam\PB\database.jpg","C:\JLam\PB\seguridad.jpg","C:\JLam\PB\ic012.gif","C:\JLam\PB\tools.jpg","C:\JLam\PB\dbicon.gif","C:\JLam\PB\dbtable.gif","C:\JLam\PB\DSL_D.gif","C:\JLam\PB\widget.jpg","C:\JLam\PB\window_up.jpg","C:\JLam\PB\usuario_perfil_p.gif","C:\JLam\PB\watch_exp.gif","C:\JLam\PB\present_pal.gif","C:\JLam\PB\log.jpg","C:\JLam\PB\widget2.jpg","C:\JLam\PB\new_ico_toolbar.gif","C:\JLam\PB\btn_domain-user_bg.gif"}
integer picturewidth = 16
integer pictureheight = 16
long picturemaskcolor = 536870912
string statepicturename[] = {"C:\JLam\PB\database.jpg","C:\JLam\PB\seguridad.jpg","C:\JLam\PB\ic012.gif","C:\JLam\PB\tools.jpg","C:\JLam\PB\dbicon.gif","C:\JLam\PB\dbtable.gif","C:\JLam\PB\DSL_D.gif","C:\JLam\PB\widget.jpg","C:\JLam\PB\window_up.jpg","C:\JLam\PB\usuario_perfil_p.gif","C:\JLam\PB\watch_exp.gif","C:\JLam\PB\present_pal.gif","C:\JLam\PB\log.jpg","C:\JLam\PB\widget2.jpg","C:\JLam\PB\new_ico_toolbar.gif","C:\JLam\PB\btn_domain-user_bg.gif"}
long statepicturemaskcolor = 536870912
end type

event selectionchanged;TreeViewItem ltvi_current , ltvi_parent

This.GetItem(newhandle, ltvi_current)
This.GetItem(This.FindItem(ParentTreeItem!, newhandle), ltvi_parent)

choose case  ltvi_current.data
	case 1000
		of_mostrarbd( )	
	case 1001 to 1099
		of_mostrar_objetos_bd( ltvi_current.data)	
	case 1101 to 1199 , 1201 to 1299 , 1301 to 1399 , 1401 to 1499 ,1501 to 1599,  1601 to 1699 , 1701 to 1799 , 1801 to 1899 , 1901 to 1999 , 2001 to 2099 
		of_mostrar_seguridad_objetos_bd(ltvi_parent.label ,  ltvi_current.data )	
	case 2000
		of_mostrar_seguridad()
	case 2100
		of_mostrar_seguridad_sesiones()
	case 2200
		of_mostrar_seguridad_funciones()			
end choose



 


end event

type lv_admin from listview within uo_security_mssql
integer x = 1664
integer width = 1614
integer height = 544
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
boolean autoarrange = true
boolean extendedselect = true
boolean fullrowselect = true
string largepicturename[] = {"C:\JLam\PB\database.jpg","C:\JLam\PB\seguridad.jpg","C:\JLam\PB\ic012.gif","C:\JLam\PB\tools.jpg","C:\JLam\PB\dbicon.gif","C:\JLam\PB\dbtable.gif","C:\JLam\PB\DSL_D.gif","C:\JLam\PB\widget.jpg","C:\JLam\PB\window_up.jpg","C:\JLam\PB\usuario_perfil_p.gif","C:\JLam\PB\watch_exp.gif","C:\JLam\PB\present_pal.gif","C:\JLam\PB\log.jpg","C:\JLam\PB\widget2.jpg","C:\JLam\PB\new_ico_toolbar.gif","C:\JLam\PB\btn_domain-user_bg.gif"}
integer largepicturewidth = 32
integer largepictureheight = 32
long largepicturemaskcolor = 536870912
string smallpicturename[] = {"C:\JLam\PB\database.jpg","C:\JLam\PB\seguridad.jpg","C:\JLam\PB\ic012.gif","C:\JLam\PB\tools.jpg","C:\JLam\PB\dbicon.gif","C:\JLam\PB\dbtable.gif","C:\JLam\PB\DSL_D.gif","C:\JLam\PB\widget.jpg","C:\JLam\PB\window_up.jpg","C:\JLam\PB\usuario_perfil_p.gif","C:\JLam\PB\watch_exp.gif","C:\JLam\PB\present_pal.gif","C:\JLam\PB\log.jpg","C:\JLam\PB\widget2.jpg","C:\JLam\PB\new_ico_toolbar.gif","C:\JLam\PB\btn_domain-user_bg.gif"}
integer smallpicturewidth = 16
integer smallpictureheight = 16
long smallpicturemaskcolor = 536870912
string statepicturename[] = {"C:\JLam\PB\database.jpg","C:\JLam\PB\seguridad.jpg","C:\JLam\PB\ic012.gif","C:\JLam\PB\tools.jpg","C:\JLam\PB\dbicon.gif","C:\JLam\PB\dbtable.gif","C:\JLam\PB\DSL_D.gif","C:\JLam\PB\widget.jpg","C:\JLam\PB\window_up.jpg","C:\JLam\PB\usuario_perfil_p.gif","C:\JLam\PB\watch_exp.gif","C:\JLam\PB\present_pal.gif","C:\JLam\PB\log.jpg","C:\JLam\PB\widget2.jpg","C:\JLam\PB\new_ico_toolbar.gif","C:\JLam\PB\btn_domain-user_bg.gif"}
integer statepicturewidth = 16
integer statepictureheight = 16
long statepicturemaskcolor = 536870912
end type

event itemactivate;listviewitem llvi_current

This.GetItem(index,  llvi_current)

Long ll_data

ll_data =  Long(llvi_current.data)



choose case  ll_data
	case 1000
			of_mostrarbd( )	
	case 1001 to 1099
		of_mostrar_objetos_bd( ll_data)	
	case 1101 to 1199 , 1201 to 1299 , 1301 to 1399 , 1401 to 1499 ,1501 to 1599,  1601 to 1699 , 1701 to 1799 , 1801 to 1899 , 1901 to 1999 , 2001 to 2099 
		of_mostrar_seguridad_objetos_bd(of_db_id(Mod( ll_data,100)) , ll_data )	
	case 2000
		of_mostrar_seguridad()
	case 2100
		of_mostrar_seguridad_sesiones()
	case 2200
		of_mostrar_seguridad_funciones()			
end choose

RETURN 0
end event

