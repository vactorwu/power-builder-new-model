HA$PBExportHeader$w_crystal_prueba.srw
forward
global type w_crystal_prueba from window
end type
type ole_1 from olecontrol within w_crystal_prueba
end type
end forward

global type w_crystal_prueba from window
integer width = 2958
integer height = 1680
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
ole_1 ole_1
end type
global w_crystal_prueba w_crystal_prueba

type variables
OleObject  iole_crapplication, iole_crReport
end variables

on w_crystal_prueba.create
this.ole_1=create ole_1
this.Control[]={this.ole_1}
end on

on w_crystal_prueba.destroy
destroy(this.ole_1)
end on

event open;OleObject lole_table,lole_connection,RptObj
 
Long ll_rc ,ll_tableCount,ll_index,ll_count
String as_report // Nombre del Reporte
String ls_dll, as_servername,as_database, as_user, as_password
String ls_location
Any anv_param[]
as_report = "C:\Report1.rpt"
// Cria a aplica$$HEX2$$e700e300$$ENDHEX$$o  CR se for o seu caso
THIS.iole_crapplication = CREATE OleObject
ll_rc =THIS.iole_crApplication.connectToNewObject('CrystalRuntime.Application')

// abre o relat$$HEX1$$f300$$ENDHEX$$rio
THIS.iole_crReport = THIS.iole_crapplication.OpenReport(as_report)

// estabiliza a conex$$HEX1$$e300$$ENDHEX$$o - n$$HEX1$$e300$$ENDHEX$$o inclui sub-relat$$HEX1$$f300$$ENDHEX$$rios
//THIS.iole_crReport.Database.LogOnServer( ls_dll, as_servername,as_database, as_user, as_password) 
THIS.iole_crReport.Database.LogOnServer( "pdsodbc.dll", "CHEGUIMO","STANDARDDB", "sa", "sa") 

// relat$$HEX1$$f300$$ENDHEX$$rio  principal
ll_tableCount = THIS.iole_crReport.Database.Tables.Count
FOR ll_index = 1 TO ll_tableCount
  lole_table = THIS.iole_crReport.Database.Tables(ll_index)
  ls_location = lole_table.Location
  lole_connection = lole_table.ConnectionProperties
 If ll_index>1 then  lole_connection.Delete("Server")
  //lole_connection.Delete("Server")
  lole_connection.Add("Server", "CHEGUIMO")
  lole_connection.Delete("User Id")
  lole_connection.Add("User Id", "sa")
  lole_connection.Delete("password")
  lole_connection.Add("password", "sa")
  ls_location =  "STANDARDDB" + "." + ls_location
  //lole_table.Location = ls_location
NEXT

// Monta os  parametros do relat$$HEX1$$f300$$ENDHEX$$rio - anv_param e a estrutura structure I
// Disable prompting do relat$$HEX1$$f300$$ENDHEX$$rio
THIS.iole_crreport.EnableParameterPrompting = FALSE

ll_count = UpperBound(anv_param)

FOR ll_index = 1 TO ll_count

THIS.iole_crreport.ParameterFields.Item[ll_index].ClearCurrentValueAndRange()
//THIS.iole_crreport.ParameterFields.Item[ll_index].AddCurrentValue(anv_param[ll_index].value)

NEXT

// imprime o relatorio
//THIS.iole_crReport.printOut()

// Open report
//RptObj = sc1.OpenReport( "c:\Report1.rpt")
RptObj = CREATE OleObject
RptObj.connectToNewObject('CrystalRuntime.Application')
RptObj = RptObj.OpenReport( "c:\Report1.rpt")
ole_1.object.ReportSource(RptObj)

// Connection verification (not necessary)
//DbObj = RptObj.Database
//DbObj.Verify()

// Run
ole_1.object.ViewReport()


end event

type ole_1 from olecontrol within w_crystal_prueba
integer x = 14
integer width = 846
integer height = 1460
integer taborder = 10
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
string binarykey = "w_crystal_prueba.win"
omactivation activation = activateondoubleclick!
omdisplaytype displaytype = displayascontent!
omcontentsallowed contentsallowed = containsany!
end type


Start of PowerBuilder Binary Data Section : Do NOT Edit
0Dw_crystal_prueba.bin 
2B00000600e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe00000006000000000000000000000001000000010000000000001000fffffffe00000000fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000fffffffe00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1Dw_crystal_prueba.bin 
End of PowerBuilder Binary Data Section : No Source Expected After This Point
