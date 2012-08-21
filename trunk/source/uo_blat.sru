HA$PBExportHeader$uo_blat.sru
forward
global type uo_blat from nonvisualobject
end type
end forward

global type uo_blat from nonvisualobject
end type
global uo_blat uo_blat

type prototypes
Function long Send (String sCmd) Library "X:\BLAT.DLL"
end prototypes

type variables

end variables

forward prototypes
public function long of_envia (string p_assunto, string p_mensagem, string p_destinatario, string p_anexo)
public function long of_envia (string p_assunto, string p_mensagem, string p_destinatario, string p_anexo[])
public function long of_envia (string p_assunto, string p_mensagem, string p_destinatario[])
public function long of_envia (string p_assunto, string p_mensagem, string p_destinatario[], string p_anexo)
public function long of_envia (string p_assunto, string p_mensagem, string p_destinatario[], string p_anexo[])
public function string of_mapeia_erro (mailreturncode p_mret, string p_processo)
public function integer of_seta_blat (string p_smtp, string p_emitente)
public function long of_envia_blat (string p_assunto, string p_mensagem, string p_destinatario)
public function long of_envia (string p_assunto, string p_mensagem, string p_destinatario)
public function long of_envia_blat (string p_assunto, string p_mensagem, string p_destinatario, string p_anexo)
end prototypes

public function long of_envia (string p_assunto, string p_mensagem, string p_destinatario, string p_anexo); string vla_destinatario[], vla_anexo[]

vla_destinatario[1] = p_destinatario
vla_anexo[1] = p_anexo

return of_envia(p_assunto,p_mensagem,vla_destinatario[],vla_anexo[])
end function

public function long of_envia (string p_assunto, string p_mensagem, string p_destinatario, string p_anexo[]);string vla_destinatario[]

vla_destinatario[1] = p_destinatario

return of_envia(p_assunto,p_mensagem,vla_destinatario[],p_anexo[])
end function

public function long of_envia (string p_assunto, string p_mensagem, string p_destinatario[]);string vla_anexo[]

return of_envia(p_assunto,p_mensagem,p_destinatario[],vla_anexo[])
end function

public function long of_envia (string p_assunto, string p_mensagem, string p_destinatario[], string p_anexo);string vla_anexo[]

vla_anexo[1] = p_anexo

return of_envia(p_assunto,p_mensagem,p_destinatario[],vla_anexo[])
end function

public function long of_envia (string p_assunto, string p_mensagem, string p_destinatario[], string p_anexo[]);
mailSession mSes
mailReturnCode mRet
mailMessage mMsg
mailFileDescription mAttach
long k
boolean vlberro
String vismsg
// Cria uma sess$$HEX1$$e300$$ENDHEX$$o de e-mail
mses = create mailsession

// Inicia a sess$$HEX1$$e300$$ENDHEX$$o (Logon)
mret = mses.maillogon(mailNewSession!)
if mret <> mailreturnsuccess! then
      vismsg = of_mapeia_erro(mret,'Logon')
      return -1
end if

// Preenche a estrutura mailmessage
// 1. Assunto 
mmsg.subject  = p_assunto
mmsg.notetext = p_mensagem

// 2. Destinat$$HEX1$$e100$$ENDHEX$$rio
for k = 1 to upperbound(p_destinatario)
      mmsg.recipient[k].name = p_destinatario[k]
next

//do 
//      vlberro = false
//      for k = 1 to upperbound(mmsg.recipient)
//            mret = mses.mailresolverecipient(mmsg.recipient[k].name)
//            if mret <> mailreturnsuccess! then vlberro = true
//      next
//      if vlberro then
//            mret = mses.mailaddress(mmsg)
//            if mret = mailreturnuserabort! then 
//                  vismsg = of_mapeia_erro(mret,'Envia')
//                  return -1
//            end if
//      end if
//loop until not vlberro

// 3. Anexos
for k = 1 to upperbound(p_anexo)
      mAttach.Pathname = p_anexo[k]
      //JuanLam mAttach.FileName = f_arquivo(p_anexo[k])
      mmsg.attachmentfile[k] = mAttach
next

// Envia o e-mail
mret = mses.mailsend(mmsg)
if mret <> mailreturnsuccess! then
      vismsg = of_mapeia_erro(mret,'Envio')
      return -1
end if

// Efetua Logoff
mses.maillogoff()

destroy mses

return 1

end function

public function string of_mapeia_erro (mailreturncode p_mret, string p_processo);string vlsmsg

choose case p_mret
      case mailReturnAccessDenied!
            vlsmsg = 'Acesso n$$HEX1$$e300$$ENDHEX$$o Permitido!'
      case mailReturnAttachmentNotFound!
            vlsmsg = 'Anexo(s) n$$HEX1$$e300$$ENDHEX$$o encontrado(s)!'
      case mailReturnAttachmentOpenFailure!
            vlsmsg = 'Falha na Abertura do(s) Anexo(s)!'
      case mailReturnAttachmentWriteFailure!
            vlsmsg = 'Falha na Grava$$HEX2$$e700e300$$ENDHEX$$o do(s) Anexo(s)!'
      case mailReturnDiskFull!
            vlsmsg = 'Disco Cheio!'
      case mailReturnFailure!
            vlsmsg = 'Falha Geral!'
      case mailReturnInsufficientMemory!
            vlsmsg = 'Mem$$HEX1$$f300$$ENDHEX$$ria Insuficiente!'
      case mailReturnInvalidMessage!
            vlsmsg = 'Mensagem Inv$$HEX1$$e100$$ENDHEX$$lida!'
      case mailReturnLoginFailure!
            vlsmsg = 'Falha no Login!'
      case mailReturnMessageInUse!
            vlsmsg = 'Mensagem em Uso!'
      case mailReturnNoMessages!
            vlsmsg = 'Nenhuma Mensagem Especificada!'
      case mailReturnSuccess!
            vlsmsg = 'Sucesso!'
      case mailReturnTextTooLarge!
            vlsmsg = 'Texto muito Grande!'
      case mailReturnTooManyFiles!
            vlsmsg = 'Muitos Anexos!'
      case mailReturnTooManyRecipients!
            vlsmsg = 'Muitos Destinat$$HEX1$$e100$$ENDHEX$$rios!'
      case mailReturnTooManySessions!
            vlsmsg = 'Muitas Sess$$HEX1$$f500$$ENDHEX$$es!'
      case mailReturnUnknownRecipient!
            vlsmsg = 'Destinat$$HEX1$$e100$$ENDHEX$$rio Desconhecido!'
      case mailReturnUserAbort!
            vlsmsg = 'Processo Abortado pelo Usu$$HEX1$$e100$$ENDHEX$$rio!'
      case else
            vlsmsg = 'Erro n$$HEX1$$e300$$ENDHEX$$o Definido!'
end choose

return p_processo+': '+vlsmsg

end function

public function integer of_seta_blat (string p_smtp, string p_emitente);
//========================================================================================
//  Descri$$HEX2$$e700e300$$ENDHEX$$o  : Checar e configurar os par$$HEX1$$e200$$ENDHEX$$metros de Envio de E-Mail peloBlat.dll
//  Retorno    : Long - Informa o resultado do processamento:
//                 0 = Um erro ocorreu durante a configura$$HEX2$$e700e300$$ENDHEX$$o.
//                 1 = Registro configurado com sucesso      
//
//  Par$$HEX1$$e200$$ENDHEX$$metros : p_smtp = Servidor de SMTP da empresa - Ex:mail.cataguazes.com.br
//               p_emitente = Quem est$$HEX2$$e1002000$$ENDHEX$$enviando o e-mail - Ex: usar o nomedo sistema
//========================================================================================
//  (C) C F L C L - Companhia For$$HEX1$$e700$$ENDHEX$$a e Luz Cataguazes-Leopoldina.
//========================================================================================

Integer VLIRet
String  VLSAux,VISMsg

if isnull(p_smtp) then
      VISMsg = 'Erro: SMTP n$$HEX1$$e300$$ENDHEX$$o pode ser nulo.'
      return 0
end if

if isnull(p_emitente) then
      VISMsg = 'Erro: Emitente n$$HEX1$$e300$$ENDHEX$$o pode ser nulo.'
      return 0
end if

VLIRet = RegistrySet("HKEY_LOCAL_MACHINE\SOFTWARE\Public Domain\Blat","SMTP server",RegString!, p_smtp)
if VLIRet <> 1 then 
      VISMsg = 'Erro ' + string(VLIRet) + ' ao tentar configurar registro para envio de E-Mail (SMTP).'
      return 0
end if

VLIRet = RegistrySet("HKEY_LOCAL_MACHINE\SOFTWARE\Public Domain\Blat","Sender",RegString!, p_emitente)
if VLIRet <> 1 then 
      VISMsg = 'Erro ' + string(VLIRet) + ' ao tentar configurar registro para envio de E-Mail (Emitente).'
      return 0
end if

VLIRet = RegistryGet("HKEY_LOCAL_MACHINE\SOFTWARE\Public Domain\Blat","SMTP Port",RegString!, VLSAux)
if VLIRet < 0 then
      RegistrySet("HKEY_LOCAL_MACHINE\SOFTWARE\Public Domain\Blat","SMTP Port",RegString!, '25')
end if

VLIRet = RegistryGet("HKEY_LOCAL_MACHINE\SOFTWARE\Public Domain\Blat","Try",RegString!, VLSAux)
if VLIRet < 0 then
      RegistrySet("HKEY_LOCAL_MACHINE\SOFTWARE\Public Domain\Blat","Try",RegString!, '1')
end if

VLIRet = RegistryGet("HKEY_LOCAL_MACHINE\SOFTWARE\Public Domain\Blat","Login",RegString!, VLSAux)
if VLIRet < 0 then
      RegistrySet("HKEY_LOCAL_MACHINE\SOFTWARE\Public Domain\Blat","Login",RegString!, '')
end if

VLIRet = RegistryGet("HKEY_LOCAL_MACHINE\SOFTWARE\Public Domain\Blat","Pwd",RegString!, VLSAux)
if VLIRet < 0 then
      RegistrySet("HKEY_LOCAL_MACHINE\SOFTWARE\Public Domain\Blat","Pwd",RegString!, '')
end if

return 1
end function

public function long of_envia_blat (string p_assunto, string p_mensagem, string p_destinatario);
String VISNulo
return of_envia_blat(p_assunto, p_mensagem,p_destinatario, VISNulo)


end function

public function long of_envia (string p_assunto, string p_mensagem, string p_destinatario);
string vla_destinatario[], vla_anexo[]

vla_destinatario[1] = p_destinatario

return of_envia(p_assunto,p_mensagem,vla_destinatario[],vla_anexo[])
end function

public function long of_envia_blat (string p_assunto, string p_mensagem,string p_destinatario, string p_anexo);
//========================================================================================
//  Descri$$HEX2$$e700e300$$ENDHEX$$o  : Envia E-Mail usando Blat.dll sem usar o OUTLOOK
//  Retorno    : Long - Informa o resultado do processamento:
//                -1 = Um erro ocorreu durante a execu$$HEX2$$e700e300$$ENDHEX$$o.
//                 1 = E-mail enviado com sucesso      
//
//  Par$$HEX1$$e200$$ENDHEX$$metros : p_assunto = Assunto da mensagem
//               p_mensagem = Corpo da menssagem
//               p_destinat$$HEX1$$e100$$ENDHEX$$rio = E-mail do destinat$$HEX1$$e100$$ENDHEX$$rio
//               p_anexo = Lista de arquivos para enviar como anexo
//========================================================================================
//  (C) C F L C L - Companhia For$$HEX1$$e700$$ENDHEX$$a e Luz Cataguazes-Leopoldina.
//========================================================================================

integer VLIRet
string  VLSEmail,VISMsg

if isnull(p_destinatario) then
      VISMsg = 'Erro: Destinat$$HEX1$$e100$$ENDHEX$$rio n$$HEX1$$e300$$ENDHEX$$o pode ser nulo.'
      return 0
end if

//Enviar e-mail
VLSEmail = '- -body "' + p_mensagem + '" -subject "' + p_assunto + '" -to "' + p_destinatario + '"'

//Teste provis$$HEX1$$f300$$ENDHEX$$rio devido a retirada do par$$HEX1$$e200$$ENDHEX$$metro p_caminho
//Testa se string termina com ":\"
if not isnull(p_anexo) and right(trim(p_anexo), 2) = ':\' then 
      setnull(p_anexo)
end if

if not isnull(p_anexo) then VLSEmail += ' -attach "' + p_anexo + '"' 

VLIRet = Send(VLSEmail)

if VLIRet <> 0 then 
      VISMsg = 'Erro ' + string(VLIRet) + ' ao tentar enviar E-Mail.'
      return 0
end if

return 1
end function

on uo_blat.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_blat.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;Randomize(0)

end event

