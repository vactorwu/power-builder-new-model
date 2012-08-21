HA$PBExportHeader$w_mail.srw
forward
global type w_mail from w_center
end type
type cb_1 from commandbutton within w_mail
end type
type pb_para from picturebutton within w_mail
end type
type mle_para from multilineedit within w_mail
end type
type cb_close from commandbutton within w_mail
end type
type cb_send_mail from commandbutton within w_mail
end type
type mle_subject from multilineedit within w_mail
end type
type st_status_bar from statictext within w_mail
end type
type mle_msg from multilineedit within w_mail
end type
type gb_body from groupbox within w_mail
end type
type gb_5 from groupbox within w_mail
end type
type gb_subject from groupbox within w_mail
end type
type gb_destinatario from groupbox within w_mail
end type
end forward

global type w_mail from w_center
integer width = 2857
integer height = 1420
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
cb_1 cb_1
pb_para pb_para
mle_para mle_para
cb_close cb_close
cb_send_mail cb_send_mail
mle_subject mle_subject
st_status_bar st_status_bar
mle_msg mle_msg
gb_body gb_body
gb_5 gb_5
gb_subject gb_subject
gb_destinatario gb_destinatario
end type
global w_mail w_mail

type variables
mailSession				mSes
mailReturnCode			mRet
mailMessage			mMsg
mailFileDescription		mAttach
datawindow ldw_mail

string  ls_attach_name='DataWndw.psr'
String  ls_ret
end variables

forward prototypes
public subroutine wf_logoff_mail (ref mailsession ams_mses, string as_attach_name)
public subroutine wf_resolvermail (string as_mails)
end prototypes

public subroutine wf_logoff_mail (ref mailsession ams_mses, string as_attach_name);string 	ls_ret1	
mailreturncode mRet1

/*****************************************************************
	Log off from the mail system
 *****************************************************************/
mRet1 = ams_mSes.mailLogoff ( )
ls_ret1 = f_mail_error_to_string ( mRet1, 'Logoff:', FALSE )
st_status_bar.text = ' Logoff: ' + ls_ret1

If mRet1 <> mailReturnSuccess! Then
	MessageBox ("Mail Logoff", 'Return Code <> mailReturnSuccess!' )
	return
End If

/*****************************************************************
	Finally, destroy the mail session object created earlier.
	Also, delete the temporary attachment file.
 *****************************************************************/
destroy ams_mses


FileDelete ( as_attach_name )
end subroutine

public subroutine wf_resolvermail (string as_mails); 

 string  sFind   = ';'
 string  sMail
 String  sMails[], sMailsMal[] 
 long  llStart, llEnd , ll_Cuantos ,llStart1, llEnd1,ll_Arroba,ll_mailsmal
 long ll_array
	
  as_mails =af_global_replace(as_mails, " ", "")
  as_mails =af_global_replace(as_mails, char(13), "")
  as_mails =af_global_replace(as_mails, ",", ";")
 
  llEnd = Len(as_mails) + 1
 
 DO
    llStart = LastPos(as_mails, sFind, llEnd)
    llEnd = llStart - 1
	 ll_Cuantos++
 LOOP WHILE llStart > 1
 
 llEnd = Len(as_mails) + 1
 
 
 DO
    llStart = LastPos(as_mails, sFind, llEnd)
    sMail = Mid(as_mails, (llStart + 1),  (llEnd - llStart))
	 ll_array = 	ll_Cuantos 
	 sMails[ll_array] = sMail
	 ll_Cuantos --
    llEnd = llStart - 1
	 
	  llEnd1 = Len(sMail) + 1
	  DO
		 llStart1 = LastPos(sMail, "@", llEnd1)
		 llEnd1 = llStart1 - 1
		 ll_Arroba++
	 LOOP WHILE llStart1 > 1
	 
	 If ll_Arroba<>2 Then
		ll_mailsmal++
     sMailsMal[ll_mailsmal] =  sMail
	 End If

ll_Arroba=0
	 

 LOOP WHILE llStart > 1
 
 
end subroutine

on w_mail.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.pb_para=create pb_para
this.mle_para=create mle_para
this.cb_close=create cb_close
this.cb_send_mail=create cb_send_mail
this.mle_subject=create mle_subject
this.st_status_bar=create st_status_bar
this.mle_msg=create mle_msg
this.gb_body=create gb_body
this.gb_5=create gb_5
this.gb_subject=create gb_subject
this.gb_destinatario=create gb_destinatario
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.pb_para
this.Control[iCurrent+3]=this.mle_para
this.Control[iCurrent+4]=this.cb_close
this.Control[iCurrent+5]=this.cb_send_mail
this.Control[iCurrent+6]=this.mle_subject
this.Control[iCurrent+7]=this.st_status_bar
this.Control[iCurrent+8]=this.mle_msg
this.Control[iCurrent+9]=this.gb_body
this.Control[iCurrent+10]=this.gb_5
this.Control[iCurrent+11]=this.gb_subject
this.Control[iCurrent+12]=this.gb_destinatario
end on

on w_mail.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.pb_para)
destroy(this.mle_para)
destroy(this.cb_close)
destroy(this.cb_send_mail)
destroy(this.mle_subject)
destroy(this.st_status_bar)
destroy(this.mle_msg)
destroy(this.gb_body)
destroy(this.gb_5)
destroy(this.gb_subject)
destroy(this.gb_destinatario)
end on

event open;call super::open;
ldw_mail = message.powerobjectparm

mSes = create mailSession
mRet = mSes.mailLogon ( mailNewSession! )
ls_ret = f_mail_error_to_string ( mRet, 'Logon:', FALSE )
st_status_bar.text = ' Logon: ' + ls_ret
If mRet <> mailReturnSuccess! Then
	MessageBox ("Mail Logon", 'Return Code <> mailReturnSuccess!' )
	wf_logoff_mail(mSes, ls_attach_name)
	return
End If

SetPointer(HourGlass!)

end event

type cb_1 from commandbutton within w_mail
integer x = 795
integer y = 52
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

event clicked;wf_resolvermail(mle_para.text)
end event

type pb_para from picturebutton within w_mail
integer x = 105
integer y = 264
integer width = 101
integer height = 88
integer taborder = 150
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean originalsize = true
string picturename = "Custom025!"
alignment htextalign = left!
end type

event clicked;int 	li_index, li_nrecipients
String ls_para

	mRet = mSes.mailAddress ( mMsg )
	If mRet = mailReturnUserAbort! Then 
		st_status_bar.text = "User Canceled send Mail"
		wf_logoff_mail(mSes, ls_attach_name)
		Return
	End If
	ls_ret = f_mail_error_to_string ( mRet, 'Address Mail:', FALSE )
	st_status_bar.text = ' Address Mail: ' + ls_ret

   li_nrecipients = UpperBound( mMsg.Recipient )
	ls_para = mMsg.Recipient[1].address
	
	If li_nrecipients > 1 then
		For li_index = 2 To li_nrecipients
			ls_para = ls_para+";"+mMsg.Recipient[li_index].address
		Next
	End If
	
	mle_para.text = ls_para
end event

type mle_para from multilineedit within w_mail
integer x = 247
integer y = 256
integer width = 2222
integer height = 120
integer taborder = 140
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
boolean autovscroll = true
end type

type cb_close from commandbutton within w_mail
integer x = 1225
integer y = 1176
integer width = 338
integer height = 100
integer taborder = 30
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Cerrar"
end type

on clicked;// Clicked script for cb_exit

Close (Parent)

end on

type cb_send_mail from commandbutton within w_mail
integer x = 759
integer y = 1176
integer width = 453
integer height = 100
integer taborder = 20
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Enviar Correo"
end type

event clicked;// Clicked script for cb_send_mail

/*******************************************************************
	Mail the definition and current contents of a DataWindow using
	MAPI facilities.
	1. Get the PSR file saved from the datawindow chosen
	2. Create a mail session object and log onto the mail system
	3. Read addressees from a file (ASCII, one per line), If desired
	4. Get address names from box If needed
	5. Resolve all names
	6. send mail, with attached .dwx file
	7. Log off from mail system
	8. Destroy the mail session object
	9. Delete the attachment (saved) file
 *******************************************************************/

string					 ls_syntax, ls_name, ls_open_pathname, ls_filename
int						li_index, li_nret, li_nrecipients, li_nfile
boolean 				lb_noerrors


/*****************************************************************
	Make sure user has chosen at least one addressing option.
 *****************************************************************/


/*****************************************************************
	Obtain the syntax of the DataWindow definition and contents,
	and write it in a ".dwx" transport file (in ASCII)
 *****************************************************************/

ldw_mail.saveas(ls_attach_name,PSReport!,True)

/*****************************************************************
	Establish an instance of the Mail Session object, and log on
 *****************************************************************/


/*****************************************************************
	Note: If the mail-system user ID and password are known,
			they could be hard-coded here, as shown in the
			commented-out statement that follows.  If user ID and
			password are not supplied, it is assumed that they
			are stored in MSMAIL.INI
 *****************************************************************/

/*****************************************************************
	Copy user's subject to the mail message.
	Set return receipt flag If needed.
	Build an Attachment structure, and assign it to the mail message.
 *****************************************************************/
mMsg.Subject	= mle_subject.text

mMsg.ReceiptRequested = true


mMsg.notetext = mle_msg.text +"~n~r "

mAttach.FileType = mailAttach!
mAttach.PathName = ls_attach_name
mAttach.FileName = ls_attach_name
// Note: In MS Mail version 3.0b, Position=-1 puts attachment at
//  the beginning of the message.
// This will place the attachment at the End of the text of the message
mAttach.Position = len(mMsg.notetext) - 1		
mMsg.AttachmentFile[1] = mAttach

/*****************************************************************
	If user requested "addresses-from-a-file," open that file and
	read the address list.
 *****************************************************************/
/*
	li_nrecipients = 0
	do while FileRead ( li_nfile, ls_name ) > 0
		li_nrecipients = li_nrecipients + 1
		mMsg.Recipient[li_nrecipients].Name = ls_name
	loop
*/

/*****************************************************************
	If user requested "address-from-Post-Office," call the
	mail system's Address function
 *****************************************************************/



/*****************************************************************
	Resolve recipient addresses, which may be only partially
	supplied, to get the complete address for each one.

	Loop in this until the names are all resovled with no
	errors. The message will not be sent If errors are in
	the user name.

	The user can cancel out of resolving names which
	will cancel the entire send mail process
 *****************************************************************/
SetPointer(HourGlass!)

Do 
	lb_noerrors = True
	li_nrecipients = UpperBound( mMsg.Recipient )
	For li_index = 1 To li_nrecipients
		mRet = mSes.mailResolveRecipient(mMsg.Recipient[li_index].Name)
		If mRet <> mailReturnSuccess! Then lb_noerrors = False
		ls_ret = f_mail_error_to_string ( mRet, 'Resolve Recipient:', FALSE )
		st_status_bar.text = ' Resolve Recipient (' + mMsg.Recipient[li_index].Name + '): ' + ls_ret
	Next
	If Not lb_noerrors Then
		Messagebox("Microsoft Mail","Error Resolving Name(s)~n~r"+&
		"The name(s) not underlined are unresolvable.~n~n~rPlease Correct or Cancel"&
		,Exclamation!)
		mRet = mSes.mailAddress(mMsg)
		If mRet = mailReturnUserAbort! Then 
			st_status_bar.text = "User Canceled Send Mail"
			wf_logoff_mail(mSes, ls_attach_name)
			Return
		End If
	End If
Loop Until lb_noerrors

/*****************************************************************
	Now, send the mail message, including the attachment
 *****************************************************************/
If UpperBound ( mMsg.Recipient ) < 1 Then 
	messagebox ("Powerbuilder send","Mail must included at least 1 recipient",Exclamation!)
	wf_logoff_mail(mSes, ls_attach_name)
	return
End If
mRet = mSes.mailsend ( mMsg )
ls_ret = f_mail_error_to_string ( mRet, 'send Mail:', FALSE )
st_status_bar.text = ' send Mail: ' + ls_ret

wf_logoff_mail(mSes, ls_attach_name)

end event

type mle_subject from multilineedit within w_mail
integer x = 256
integer y = 428
integer width = 2208
integer height = 92
integer taborder = 130
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
boolean autovscroll = true
end type

type st_status_bar from statictext within w_mail
integer x = 293
integer y = 1064
integer width = 2194
integer height = 72
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 74481808
boolean enabled = false
boolean focusrectangle = false
end type

type mle_msg from multilineedit within w_mail
integer x = 261
integer y = 592
integer width = 2281
integer height = 372
integer taborder = 10
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
boolean vscrollbar = true
end type

type gb_body from groupbox within w_mail
integer x = 215
integer y = 532
integer width = 2354
integer height = 468
integer taborder = 140
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 74481808
string text = "&Mensaje"
end type

type gb_5 from groupbox within w_mail
integer x = 215
integer y = 1004
integer width = 2354
integer height = 156
integer taborder = 50
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 74481808
string text = "Status"
end type

type gb_subject from groupbox within w_mail
integer x = 215
integer y = 368
integer width = 2354
integer height = 164
integer taborder = 120
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 74481808
string text = "&Sujeto"
end type

type gb_destinatario from groupbox within w_mail
integer x = 215
integer y = 212
integer width = 2354
integer height = 164
integer taborder = 130
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 74481808
string text = "&Para"
end type

