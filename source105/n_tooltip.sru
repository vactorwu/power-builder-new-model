HA$PBExportHeader$n_tooltip.sru
$PBExportComments$Non-Visual tooltip control object
forward
global type n_tooltip from nonvisualobject
end type
type rect from structure within n_tooltip
end type
type toolinfo from structure within n_tooltip
end type
type point from structure within n_tooltip
end type
type msg from structure within n_tooltip
end type
type size from structure within n_tooltip
end type
end forward

type rect from structure
	long		left
	long		top
	long		right
	long		bottom
end type

type toolinfo from structure
	long		cbsize
	long		uflags
	long		hwnd
	long		uid
	RECT		rect
	long		hinstance
	long		lpsztext
end type

type point from structure
	long		x
	long		y
end type

type msg from structure
	long		hwnd
	long		message
	long		wparam
	long		lparam
	long		time
	point		pt
end type

type size from structure
	long		l_x
	long		l_y
end type

global type n_tooltip from nonvisualobject autoinstantiate
end type

type prototypes
// ToolTip Functions
SubRoutine InitCommonControls() library "comctl32.dll"
Function long CreateWindowExA(ulong dwExStyle, string ClassName, long WindowName, ulong dwStyle, ulong X, ulong Y, ulong nWidth, ulong nHeight, ulong hWndParent, ulong hMenu, ulong hInstance, ulong lpParam) library "user32.dll" alias for "CreateWindowExA;Ansi"
Function integer DestroyWindow(long hWnd) library "user32.dll"
Function integer ToolTipMsg(long hWnd, long uMsg, long wParam, REF TOOLINFO ToolInfo) library "user32.dll" Alias For "SendMessageA;Ansi"
Function integer RelayMsg(long hWnd, long uMsg, long wParam, REF MSG Msg) library "user32.dll" Alias For "SendMessageA;Ansi"

// Memory handling functions
Function long LocalAlloc(long Flags, long Bytes) library "kernel32.dll"
Function long LocalFree(long MemHandle) library "kernel32.dll"
Function long lstrcpy(long Destination, string Source) library "kernel32.dll" alias for "lstrcpy;Ansi"

Function uLong GetDC( uLong hwnd ) Library "user32.dll"
Function long ReleaseDC(ulong hWnd, ulong hdcr) Library "USER32.DLL"

Function boolean GetTextExtentPoint32A(ulong hdcr, string lpString, long nCount, ref size size) Library "GDI32.DLL" alias for "GetTextExtentPoint32A;Ansi"
Function ulong SelectObject(ulong hdc, ulong hWnd) Library "GDI32.DLL"

end prototypes

type variables
Private:

// Misc Constants
CONSTANT string TOOLTIPS_CLASS		= 'tooltips_class32'
CONSTANT ulong CW_USEDEFAULT		= 2147483648
CONSTANT long WM_USER 		= 1024
CONSTANT long WS_EX_TOPMOST		= 8
CONSTANT long  WM_SETFONT          	= 48
CONSTANT long  WM_GETFONT          	= 49

// ToolTip Messages
CONSTANT long TTM_ADDTOOL 		= WM_USER + 4
CONSTANT long TTM_NEWTOOLRECT	= WM_USER + 6
CONSTANT long TTM_RELAYEVENT 		= WM_USER + 7
CONSTANT long TTM_UPDATETIPTEXT	= WM_USER + 12
CONSTANT long TTM_TRACKACTIVATE	= WM_USER + 17
CONSTANT long TTM_TRACKPOSITION	= WM_USER + 18
CONSTANT long TTM_SETMAXTIPWIDTH	= 1048
CONSTANT long TTM_GETMAXTIPWIDTH	= WM_USER + 25

// Public variables and constants
Public:
long hWndTT	// Tooltip control window handle
long ToolID = 1	// Tooltip internal ID

// Tooltip flags
CONSTANT integer TTF_CENTERTIP 		= 2
CONSTANT integer TTF_RTLREADING	= 4
CONSTANT integer TTF_SUBCLASS		= 16
CONSTANT integer TTF_TRACK		= 32
CONSTANT integer TTF_ABSOLUTE		= 128
CONSTANT integer TTF_TRANSPARENT	= 256
CONSTANT integer TTF_DI_SETITEM		= 32768
CONSTANT integer TTS_BALLOON = 64

uLong		iul_Handle[]
end variables

forward prototypes
public subroutine relaymsg (dragobject object)
public function long getfont ()
public subroutine settipposition (integer x, integer y)
public subroutine setfont (long hfont)
public subroutine settrack (dragobject object, integer uid, boolean status)
public subroutine setmaxwidth (string tiptext, dragobject object)
public subroutine updatetiprect (dragobject object, long uid, long left, long top, long right, long bottom)
public subroutine settiptext (dragobject object, long uid, string tiptext)
public subroutine settiptext (dragobject object, long uid, long tiptext)
public function integer addtool (dragobject object, string tiptext, integer flags)
end prototypes

public subroutine relaymsg (dragobject object);// This function will send the control message to the toolwindow control
MSG Msg

Msg.hWnd		= Handle(Object)
Msg.Message	= 512	// WM_MOUSEMOVE
Msg.WParam 	= Message.WordParm
Msg.LParam 	= Message.LongParm

RelayMsg(hWndTT,TTM_RELAYEVENT,0,Msg)

end subroutine

public function long getfont ();uLong			lul_Font

// Gets the font used in the tooltip window
lul_Font = Send( hWndTT, WM_GETFONT, 0, 0 )

//If lul_Font > 0 Then
//	GetObject( lul_Font, 60, astr_LogFont )
//End If

Return lul_Font
end function

public subroutine settipposition (integer x, integer y);// This function sets the position of a tracking tooltip..
//
// Arguments:
//				X 	=> X position of the tooltip
//				Y	=> Y position of the tooltip
//
// Notes: The tooltip control chooses where the tooltip will be displayed (typically near
// the tool) unless the TTF_ABSOLUTE flags is specified when adding the tool
Send(hWndTT,TTM_TRACKPOSITION,0,Long(X,Y))
end subroutine

public subroutine setfont (long hfont);// Sets the font used in the tooltip window
Send(hWndTT,WM_SETFONT,hFont,1)

end subroutine

public subroutine settrack (dragobject object, integer uid, boolean status);// This function (de)activates a tracking tooltip, this kind of tooltip can be reposicioned on
// the screen using the SetTipPosition function... 
//
// Arguments:
//				object	=> Object registered within the tooltip control
//				uID		=> Internal ID of the object
//				Status	=> True to activate tracking, False to deactivate tracking
TOOLINFO ToolInfo

ToolInfo.cbSize	= 40
ToolInfo.hWnd		= Handle(Object)
ToolInfo.uID		= uID

If Status Then 
	ToolTipMsg(hWndTT,TTM_TRACKACTIVATE,1,ToolInfo)
Else
	ToolTipMsg(hWndTT,TTM_TRACKACTIVATE,0,ToolInfo)
End If
end subroutine

public subroutine setmaxwidth (string tiptext, dragobject object);/*****************************************************************************

	Functie:			setmaxwidth

	Omschrijving:	Bepaalt op basis van van de wijdte van een tooltiptekst
						of deze over meerdere regels getoond moet worden. 

	Retourneert:	(none)

	Argumenten:		string 		tiptext	
						dragobject 	object	

	Gebruik:			

-------------------------------------------------------------------------------

	Auteur:	Aart Onkenhout, AINO N.V.

	Revisie Geschiedenis
	--------------------
	Datum			Versie
	15-05-2000	1.0		Initiele versie

******************************************************************************/

Integer		li_Width, li_Height, li_Len, li_Return
Size			lstr_size
uLong			lul_Hdc, lul_hFont

lul_hFont = GetFont()
	
lul_Hdc = GetDC( hWndTT )

// Select it into the device context
SelectObject( lul_Hdc, lul_hFont )

li_Len = Len( TipText )

// Get the size of the text.
If Not GetTextExtentpoint32A(lul_Hdc, TipText, li_Len, lstr_Size ) Then Return

ReleaseDC( hWndTT, lul_Hdc )

li_Height = PixelsToUnits( lstr_Size.l_y, yPixelsToUnits! )
li_Width = PixelsToUnits( lstr_Size.l_x, xPixelsToUnits! )

If li_Width > 2000 Then
	li_Width = li_Width / Int( li_Width / 1000 )
	li_Return = Send( hWndTT, TTM_SETMAXTIPWIDTH, 0, UnitsToPixels( li_Width, xUnitsToPixels! ) )
End If

Return
end subroutine

public subroutine updatetiprect (dragobject object, long uid, long left, long top, long right, long bottom);// Updates the tip rectangle
//
// Arguments:
//				hWnd		=> Handle of the registered tool
//				uID		=> Internal tool ID
//				Rect		=> New Rectangle
TOOLINFO ToolInfo

ToolInfo.hWnd	= Handle(Object)
ToolInfo.uID	= uID

ToolInfo.Rect.Left	= Left
ToolInfo.Rect.Top		= Top
ToolInfo.Rect.Right	= Right
ToolInfo.Rect.Bottom	= Bottom

ToolTipMsg(hWndTT,TTM_NEWTOOLRECT,0,ToolInfo)

end subroutine

public subroutine settiptext (dragobject object, long uid, string tiptext);// Sets the new text for a tool window
//
// Arguments:
//				object	: Object registered on the toolwindow control
//				uID	 	: Object ID
//				text		: Tooltip text
long lpszText

lpszText = LocalAlloc(0,255)
lStrCpy(lpszText,Left(TipText,255))
SetTipText(Object,uId,lpszText)

LocalFree(lpszText)
end subroutine

public subroutine settiptext (dragobject object, long uid, long tiptext);// Sets the new text for a tool window
//
// Arguments:
//				object	: Object registered on the toolwindow control
//				uID	 	: Object ID
//				text		: Tooltip text
TOOLINFO ToolInfo

ToolInfo.hWnd		= Handle(Object)
//ToolInfo.hWnd		= hWndTT
ToolInfo.uID		= uID
ToolInfo.lpszText	= TipText

ToolTipMsg(hWndTT,TTM_UPDATETIPTEXT,0,ToolInfo)
end subroutine

public function integer addtool (dragobject object, string tiptext, integer flags);// Registers a control within the tooltip control
//
// Arguments: 
//				object  	=> Object to register within the tooltip control
//				tiptext	=> Tooltip Text
//				Flags		=> Tool creation flags
TOOLINFO ToolInfo
Integer	li_Width, li_Height

ToolInfo.cbSize 	= 40
ToolInfo.uFlags 	= 16	//Flags 
ToolInfo.hWnd		= Handle(Object)
ToolInfo.hInstance= 0 // Not used 
ToolInfo.uID		= ToolID
iul_Handle[ToolID] = ToolInfo.hWnd
ToolID++
ToolInfo.lpszText	= LocalAlloc(0,120)
POST LocalFree( ToolInfo.lpszText ) // Free Allocated Memory
lStrCpy( ToolInfo.lpszText, Left( tiptext, 120 ) )

SetMaxWidth( tiptext, object )

ToolInfo.Rect.Left	= 0
ToolInfo.Rect.Top 	= 0
ToolInfo.Rect.Right	= UnitsToPixels(Object.Width,XUnitsToPixels! )
ToolInfo.Rect.Bottom	= UnitsToPixels(Object.Height,YUnitsToPixels! )

If ToolTipMsg( hWndTT, TTM_ADDTOOL, 0, ToolInfo ) = 0 Then
	MessageBox( "Error", "Cannot register object in the toolwindow control!", StopSign!, Ok! )
	Return( -1 )
End If

Return ( ToolID - 1 )

end function

on n_tooltip.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_tooltip.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;InitCommonControls()

hWndTT = CreateWindowExA(WS_EX_TOPMOST,TOOLTIPS_CLASS,0, TTF_CENTERTIP + TTS_BALLOON + 1, &
         CW_USEDEFAULT, CW_USEDEFAULT, CW_USEDEFAULT, CW_USEDEFAULT,  &
         0, 0, Handle(GetApplication()),0)

end event

event destructor;DestroyWindow(hWndTT)
end event

