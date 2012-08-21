HA$PBExportHeader$w_pruebafoto.srw
forward
global type w_pruebafoto from window
end type
type cb_5 from commandbutton within w_pruebafoto
end type
type sle_1 from singlelineedit within w_pruebafoto
end type
type cb_4 from commandbutton within w_pruebafoto
end type
type cb_3 from commandbutton within w_pruebafoto
end type
type cb_2 from commandbutton within w_pruebafoto
end type
type cb_1 from commandbutton within w_pruebafoto
end type
type dw_1 from datawindow within w_pruebafoto
end type
end forward

global type w_pruebafoto from window
integer width = 3182
integer height = 2332
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_5 cb_5
sle_1 sle_1
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_pruebafoto w_pruebafoto

forward prototypes
public subroutine wf_grava_arquivo (string as_arquivo, ref blob lblob_final)
end prototypes

public subroutine wf_grava_arquivo (string as_arquivo, ref blob lblob_final);long ll_row, ll_codigo, ll_file, ll_tam
blob lblob_arquivo

//ll_codigo = long (sle_1.text)

//Carrega o arquivo
ll_file = FileOpen ( as_arquivo , StreamMode! , Read! , LockRead!)
if ll_file = -1 then
messagebox("Erro","Ocorreu um erro na abertura do arquivo",stopsign!)
return
end if

lBlob_final = blob('')
ll_tam = fileread(ll_file, lblob_arquivo)


do while (ll_tam > 0)
lBlob_final = lBlob_final + lblob_arquivo
ll_tam = fileread(ll_file, lblob_arquivo)
loop

fileclose(ll_file)

end subroutine

on w_pruebafoto.create
this.cb_5=create cb_5
this.sle_1=create sle_1
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.cb_5,&
this.sle_1,&
this.cb_4,&
this.cb_3,&
this.cb_2,&
this.cb_1,&
this.dw_1}
end on

on w_pruebafoto.destroy
destroy(this.cb_5)
destroy(this.sle_1)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
end on

type cb_5 from commandbutton within w_pruebafoto
integer x = 2528
integer y = 64
integer width = 402
integer height = 112
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "none"
end type

event clicked;//////////////////////////////////////////////////////////// 
// Integer global function f_copia_blob_arq( string input_blob by reference, string output_arq by value ) 
// Argumentos: 
// input_blob = A variavel BLOB que vc quer copiar para o HD 
// output_arq = nome do arquivo que vc quer criar , se ele n$$HEX1$$e300$$ENDHEX$$o existir ser$$HEX2$$e1002000$$ENDHEX$$criado. 
// Returns 1 - OK , -1 ERRO 
//////////////////////////////////////////////////////////// 

integer fout 
integer loops 
integer i 
long blen 
long bytes_read = 0 
long bytes_written ,ll_codigo
long new_pos 
String output_file,output_arq
blob input_blob
// 
blob b 
long max_bytes = 32765 
integer yield_every = 30 


ll_codigo = long(sle_1.text)

output_file ="C:\FOTO.JPG"
output_arq="C:\FOTO1.JPG"
IF FileExists(output_file) THEN 
IF MessageBox("f_copia_blob_arq", "Arquivo ~r~n" + & 
output_file + & 
"~r~nj$$HEX2$$e1002000$$ENDHEX$$existe." + & 
"~r~nOK re-gravar? ", & 
Question!, YesNo!) <> 1 THEN 
RETURN -1 
END IF 
END IF 

// 
fout = FileOpen( output_arq, StreamMode!, Write!, LockWrite!, Replace! ) // 
IF fout < 0 THEN RETURN fout 

selectblob foto
into :input_blob
from teste_foto
where codigo = :ll_codigo using SQLCA;
// 
blen = Len( input_blob ) 

IF blen > max_bytes THEN 
IF Mod( blen, max_bytes ) = 0 THEN 
loops = blen / max_bytes 
ELSE 
loops = blen / max_bytes + 1
END IF 
ELSE 
loops = 1 
END IF 
// iniciando a copia do BLOB, byte 1. 
new_pos = 1 
// Loop do BLOB para grava$$HEX2$$e700e300$$ENDHEX$$o 
FOR I = 1 TO loops 
// 
IF Mod( i, yield_every ) = 0 THEN Yield( )
// 
b = BlobMid( input_blob, new_pos, max_bytes )
// 
bytes_written = FileWrite( fout, b ) 
IF bytes_written = -1 THEN RETURN -1 
// 
new_pos = new_pos + max_bytes 
NEXT 
// Fechando arquivo 
IF FileClose( fout ) = - 1 THEN RETURN -1 
// finaliza$$HEX2$$e700e300$$ENDHEX$$o com sucesso. 
RETURN 1 

end event

type sle_1 from singlelineedit within w_pruebafoto
integer x = 2071
integer y = 76
integer width = 402
integer height = 112
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "1"
borderstyle borderstyle = stylelowered!
end type

type cb_4 from commandbutton within w_pruebafoto
integer x = 1650
integer y = 76
integer width = 402
integer height = 112
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Retrieve"
end type

event clicked;long ll_rowcount
long ll_codigo, ll_file, ll_row
blob lblb_imagem, lBlob_final, lblob_arquivo
string ls_imagem, ls_path
datastore vld_datastore

//Configura DataStore de Gerenciamento de arquivos tempor$$HEX1$$e100$$ENDHEX$$rios
vld_datastore = create datastore
vld_datastore.dataobject = 'd_arquivos_temporarios'

ll_codigo = long(sle_1.text)

//Recupera os Registros
ll_rowcount = dw_1.retrieve (ll_codigo)

//Se existir registro, vai para o tratamento do Blob
if ll_rowcount > 0 then
//Seleciona o campo Blob
selectblob foto
into :lblb_imagem
from teste_foto
where codigo = :ll_codigo using SQLCA;

//Importa os dados do arquivo XML de controle de arquivos temporarios
vld_datastore.importfile(XML!,'C:\tmpfoto.xml')

//Apaga todos os arquivos temporarios existentes na m$$HEX1$$e100$$ENDHEX$$quina
for ll_row = vld_datastore.rowcount() to 1 step -1
filedelete(vld_datastore.getitemstring(ll_row,"filename"))
vld_datastore.deleterow(ll_row)
next

//gera um arquivo temporario, com a extensao original
ls_path = "c:\tmpfoto" + string(today(),"yyyymmdd")+string(now(),"hhmmssffff")+"."+dw_1.getitemstring(1,"extensao")

//Grava o nome do aquivo temporario no XML de controle
ll_row = vld_datastore.insertrow(0)
vld_datastore.setitem(ll_row,"filename",ls_path)
vld_datastore.saveas( "C:\tmpfoto.xml", XML!,true )


//Carrega o arquivo
ll_file = FileOpen ( ls_path , StreamMode! , write! , Lockwrite!, Replace!)
if ll_file = -1 then
messagebox("Erro","Ocorreu um erro na abertura do arquivo",stopsign!)
return
end if

//L$$HEX2$$ea002000$$ENDHEX$$o blob e grava um arquivo
lBlob_final = lblb_imagem

do while (len(lBlob_final) > 0)
lblob_arquivo = blobmid(lBlob_final,1,32000)
filewrite(ll_file,lblob_arquivo)
lBlob_final = blobmid(lBlob_final,32001)
loop

fileclose(ll_file)

//Exibe o arquivo temporario
DW_1.Object.P_1.Filename=ls_path


messagebox("Sucesso","Arquivo recuperad com sucesso!")
end if

end event

type cb_3 from commandbutton within w_pruebafoto
integer x = 727
integer y = 76
integer width = 402
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Update"
end type

event clicked;dw_1.update( )
commit using SQLCA;
end event

type cb_2 from commandbutton within w_pruebafoto
integer x = 1170
integer y = 76
integer width = 402
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Open File"
end type

event clicked;string docpath, docname ,filename ,ls_picturename,ls_extensao
Blob LL_BLOB,lblb_imagem
integer li_rtn,ll_i
long ll_aux,ll_codigo

//Exibe janela para selecionar o arquivo
li_rtn = GetFileOpenName("Selecione a Imagem",docpath, docname, "JPEG",+ "JPEG (*.jpg),*.jpg," + "BMP (*.BMP),*.BMP,All Files (*.*), *.*", "C:\", 18)

IF li_rtn >0 then
	DW_1.Object.P_1.Filename=docpath
	ls_picturename = trim(DW_1.Object.P_1.Filename)
	ll_aux = len(ls_picturename) 
	ll_i = ll_aux
	ls_extensao = mid(ls_picturename,ll_i + 1)
else
	setNUll(ls_extensao)
end if

dw_1.setitem(1,"extensao",ls_extensao)

//Salva a DataWindow
dw_1.update()

//Transforma o arquivo em um valor Blob
WF_grava_arquivo( DW_1.Object.P_1.Filename, LL_BLOB)


lblb_imagem = LL_BLOB
ll_codigo = dw_1.getitemnumber(1,"codigo")

//Atualiza o valor blog no Banco de Dados
updateblob teste_foto
set foto = :lblb_imagem
where codigo = :ll_codigo using SQLCA ;


//Finaliza a transacao
commit using SQLCA ;

end event

type cb_1 from commandbutton within w_pruebafoto
integer x = 233
integer y = 76
integer width = 402
integer height = 112
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Insert"
end type

event clicked;dw_1.scrolltorow(dw_1.insertrow(0))
end event

type dw_1 from datawindow within w_pruebafoto
integer x = 37
integer y = 236
integer width = 3017
integer height = 1884
integer taborder = 10
string title = "none"
string dataobject = "d_imagen_prueba"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;dw_1.settransobject( SQLCA )
end event

