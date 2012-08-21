HA$PBExportHeader$ou_crviewer.sru
forward
global type ou_crviewer from olecustomcontrol
end type
end forward

global type ou_crviewer from olecustomcontrol
integer width = 859
integer height = 716
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
string binarykey = "ou_crviewer.udo"
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
event closebuttonclicked ( ref boolean usedefault )
event firstpagebuttonclicked ( ref boolean usedefault )
event lastpagebuttonclicked ( ref boolean usedefault )
event prevpagebuttonclicked ( ref boolean usedefault )
event nextpagebuttonclicked ( ref boolean usedefault )
event gotopagenclicked ( ref boolean usedefault,  integer pagenumber )
event stopbuttonclicked ( integer loadingtype,  ref boolean usedefault )
event refreshbuttonclicked ( ref boolean usedefault )
event printbuttonclicked ( ref boolean usedefault )
event grouptreebuttonclicked ( boolean ocx_visible )
event zoomlevelchanged ( integer zoomlevel )
event searchbuttonclicked ( string searchtext,  ref boolean usedefault )
event drillongroup ( any groupnamelist,  integer drilltype,  ref boolean usedefault )
event drillondetail ( any fieldvalues,  long selectedfieldindex,  ref boolean usedefault )
event showgroup ( any groupnamelist,  ref boolean usedefault )
event selectionformulabuttonclicked ( ref string selctionformula,  ref boolean usedefault )
event selectionformulabuilt ( string selctionformula,  ref boolean usedefault )
event ocx_clicked ( long ocx_x,  long ocx_y,  any eventinfo,  ref boolean usedefault )
event dblclicked ( long ocx_x,  long ocx_y,  any eventinfo,  ref boolean usedefault )
event downloadstarted ( integer loadingtype )
event downloadfinished ( integer loadingtype )
event viewchanging ( long oldviewindex,  long newviewindex )
event viewchanged ( long oldviewindex,  long newviewindex )
event onreportsourceerror ( string errormsg,  long errorcode,  ref boolean usedefault )
event exportbuttonclicked ( ref boolean usedefault )
event searchexpertbuttonclicked ( ref boolean usedefault )
event drillongraph ( long pagenumber,  long ocx_x,  long ocx_y,  ref boolean usedefault )
event drillonsubreport ( any groupnamelist,  string subreportname,  string title,  long pagenumber,  long index,  ref boolean usedefault )
event helpbuttonclicked ( )
event focuschanged ( boolean hasfocus )
event oncontextmenu ( any objectdescription,  long ocx_x,  long ocx_y,  ref boolean usedefault )
event onchangeobjectrect ( any objectdescription,  long ocx_x,  long ocx_y,  long ocx_width,  long ocx_height )
event onlaunchhyperlink ( ref string hyperlink,  ref boolean usedefault )
end type
global ou_crviewer ou_crviewer

type variables
// Set viewer properties

OLEObject Crpt_Application     	// application object
OLEObject Crpt_Report				// report object
OLEObject Crpt_Connection_Info	// database connection properties
OLEObject Crpt_Export_Options		// export options

string Crpt_ReportFileName			// full  report file name
string Crpt_ReportFilePath			// full path to the report file

String DSN      // Mi ODBC
String DATABASE // BASDE DE DATOS
String User_ID  
String Password 


Boolean DisplayBorder = True					//Borde de reporte
Boolean DisplayGroupTree = True				//Arbol de Grupo
Boolean DisplayTabs = True						//Paletas
Boolean DisplayToolBar = True					//Barra de Herramientas
Boolean EnableAnimationCtrl = True			//Logo Crystall
Boolean EnableCloseButton = True				//Boton Cerrar
Boolean EnableDrillDown = True				//Entrenese abajo
Boolean EnableExportButton = True			//Boton de Exportacion
Boolean EnableGroupTree = True				//Arbol de Grupo
Boolean EnableHelpButton = True 			//Boton Ajuda
Boolean EnableNavigationControls	= True 	//Botones de Navegacion
Boolean EnablePopupMenu	= True 			//Popup Menu
Boolean EnablePrintButton = True				//Boton de Impresion
Boolean EnableProgressControl	= True 	//Control de Proceso
Boolean EnableRefreshButton = True 		//Botone de Actualizacion
Boolean EnableSearchControl	= True 		//Botone de Busqueda
Boolean EnableSearchExpertButton	= True//Botone de Busqueda experta
Boolean EnableStopButton = True 			//Botone de detener
Boolean EnableToolBar = True 					//Barra de Herramientas
Boolean EnableZoomControl	= True 			//Zoom

end variables

forward prototypes
public subroutine f_conectar ()
public subroutine f_desconectar ()
public subroutine f_preview ()
end prototypes

public subroutine f_conectar ();int li_return
string ls_path,ls_pathFile


ls_path = GetCurrentDirectory ( )
// crear OLE object
Crpt_Application = CREATE OLEObject


// connectar a craxdrt.Application
li_return = Crpt_application.ConnectToNewObject('CrystalRuntime.Application')
if li_return < 0 then
	MessageBox("Error", "No se conect$$HEX2$$f3002000$$ENDHEX$$a Crystal Application Object")
	return 
end if

If IsNull(Crpt_ReportFilePath) or Crpt_ReportFilePath= "" Then 
	Crpt_ReportFilePath = ls_path
Else
	If  Not DirectoryExists (Crpt_ReportFilePath) Then 
				MessageBox("Error", "No se encontro Ruta para Crystal Report File ")
				return
	End If
End If

If IsNull(Crpt_ReportFileName) or Crpt_ReportFileName= "" Then
		MessageBox("Error", "No se encontro a Crystal Report File ")
		return
End If

ls_pathFile = Crpt_ReportFilePath +"\"+ Crpt_ReportFileName

// Abrir el Reporte
Crpt_report = Crpt_application.OpenReport(ls_pathFile)

// Loguear a la base de datos
//
// Setear connection_info al  Report ConnectionProperties
Crpt_connection_info = Crpt_report.database.tables[1].ConnectionProperties

//Borrar las Coneccioes Antiguas
// Trabaja para actualizar las connecciones antiguas
Crpt_connection_info.deleteAll

// Agreagar Nueva Conneccion

Crpt_connection_info.add("DSN", DSN)
Crpt_connection_info.add("Database", Database)
Crpt_connection_info.add("User ID", User_ID)
Crpt_connection_info.add("Password", Password)

// Verificar la Base de Datos

Crpt_report.database.Verify


end subroutine

public subroutine f_desconectar ();DESTROY Crpt_Application     		     // application object
DESTROY Crpt_Report					// report object
DESTROY Crpt_Connection_Info		// database connection properties
DESTROY Crpt_Export_Options		// export options

end subroutine

public subroutine f_preview ();// pass report to the viewer
this.object.ReportSource(Crpt_report)

// Set viewer properties
This.object.DisplayBorder 					= DisplayBorder					//Borde de reporte
This.object.DisplayGroupTree 				= DisplayGroupTree				//Arbol de Grupo
This.object.DisplayTabs 					= DisplayTabs						//Paletas
This.object.DisplayToolBar 				= DisplayToolBar					//Barra de Herramientas
This.object.EnableAnimationCtrl 			= EnableAnimationCtrl			//Logo Crystall
This.object.EnableCloseButton 			= EnableCloseButton				//Boton Cerrar
This.object.EnableDrillDown 				= EnableDrillDown					//Entrenese abajo
This.object.EnableExportButton 			= EnableExportButton				//Boton de Exportacion
This.object.EnableGroupTree 				= EnableGroupTree					//Arbol de Grupo
This.object.EnableHelpButton 				= EnableHelpButton 				//Boton Ajuda
This.object.EnableNavigationControls	= EnableNavigationControls 	//Botones de Navegacion
This.object.EnablePopupMenu				= EnablePopupMenu 				//Popup Menu
This.object.EnablePrintButton 			= EnablePrintButton				//Boton de Impresion
This.object.EnableProgressControl		= EnableProgressControl 		//Control de Proceso
This.object.EnableRefreshButton			= EnableRefreshButton 			//Botone de Actualizacion
This.object.EnableSearchControl			= EnableSearchControl 			//Botone de Busqueda
This.object.EnableSearchExpertButton	= EnableSearchExpertButton 	//Botone de Busqueda experta
This.object.EnableStopButton				= EnableStopButton 				//Botone de detener
This.object.EnableToolBar			 		= EnableToolBar 					//Barra de Herramientas
This.object.EnableZoomControl				= EnableZoomControl 				//Zoom

// view report
this.object.ViewReport

end subroutine

on ou_crviewer.create
end on

on ou_crviewer.destroy
end on


Start of PowerBuilder Binary Data Section : Do NOT Edit
01ou_crviewer.bin 
2600000a00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffefffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff0000000100000000000000000000000000000000000000000000000000000000bd6a6d8001c50b1300000003000000800000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff000000000000000000000000000000000000000000000000000000000000000000000000fffffffe0000000000000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff000000032def453041c98ce645a5b6841302c93600000000bd68e6e001c50b13bd6a6d8001c50b13000000000000000000000000006f00430074006e006e00650073007400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001020012ffffffffffffffffffffffff00000000000000000000000000000000000000000000000000000000000000000000000000000000000000720000000000000001fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
20ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff00000300000001f40000136e00001280ffff000bffff000bffff000bffff000bffff000bffff000bffff000bffff000bffff000bffff000bffff000bffff000bffff000b0000000bffff000bffff000bffff000bffff000b00000008000b0000000bffff000b0000000b0000000b00000000ffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
11ou_crviewer.bin 
End of PowerBuilder Binary Data Section : No Source Expected After This Point
