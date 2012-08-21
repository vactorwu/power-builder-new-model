HA$PBExportHeader$n_printer.sru
$PBExportComments$User object encapsulating new PB8 printer functionality
forward
global type n_printer from nonvisualobject
end type
end forward

global type n_printer from nonvisualobject autoinstantiate
end type

type variables
s_printer is_printers
end variables

forward prototypes
public function integer setcurrentprinter (string as_printername)
private function string formatprinterdescription (string as_printername, string as_drivername, string as_port)
public function string getcurrentprinter (boolean ab_format)
private function integer getcurrentprinter (ref string as_printername, ref string as_drivername, ref string as_port)
public function integer setupprinter (string as_printername)
public function long getinstalledprinters (ref blob ab_printers)
public subroutine getprinters (ref s_printer as_printers)
end prototypes

public function integer setcurrentprinter (string as_printername);// Sets printer to supplied argument name
//
// Returns: 1 if successful, -1 if failure
//          (value from PowerBuilder function PrintSetPrinter)

RETURN PrintSetPrinter(as_printerName)
end function

private function string formatprinterdescription (string as_printername, string as_drivername, string as_port);// Returns printer name formatted for presentation to user.
// Customize this function to meet application display needs.
//
// Returns: formatted printer name "<name> on <port>"
//
// N.B., this is a PRIVATE function
RETURN as_printername + " on " + as_port
end function

public function string getcurrentprinter (boolean ab_format);// The boolean argument, ab_format, controls whether resulting 
// string is formatted for display or just left alone to be used
// as argument to other printer functions.  This function invokes
// an identically named (overloaded) private function.
//
// Returns: printer name (formatted or unformatted)

string ls_printerName
string ls_driverName
string ls_port

// get the current printer and return a formatted description string
IF (this.getCurrentPrinter(ls_printerName, ls_driverName, ls_port) = 1) THEN
	IF ab_format THEN
		RETURN this.formatPrinterDescription(ls_printerName, ls_driverName, ls_port)
	ELSE
		RETURN ls_printerName
	END IF
ELSE
	IF ab_format THEN
		RETURN "<No default printer>"
	ELSE
		RETURN ""
	END IF
END IF
end function

private function integer getcurrentprinter (ref string as_printername, ref string as_drivername, ref string as_port);// Encapsulates new PrintGetPrinter function by parsing the
// individual elements from the returned tab delimited string.
//
// Returns: 1 if successful, -1 if not
//
// N.B., this is a PRIVATE function; use the overloaded version
// of this function to return a formatted or unformatted printer
// description.

string ls_currentPrinter
string ls_printerName
string ls_driverName
string ls_port
long   ll_pos

// get current printer
ls_currentPrinter = PrintGetPrinter()

// parse string to get printer name, driver, and port
ll_pos = Pos(ls_currentPrinter, "~t")
IF ll_pos > 0 THEN
	
	// strip off printer name
	ls_printerName = Left(ls_currentPrinter, ll_pos - 1)
	
	// with remaining string
   ls_currentPrinter = Right(ls_currentPrinter, Len(ls_currentPrinter) - ll_pos)
	ll_pos = Pos(ls_currentPrinter, "~t")
	
	// strip off driver name and port
	IF ll_pos > 0 THEN
		ls_driverName = Left(ls_currentPrinter, ll_pos -1)
		ls_port = Right(ls_currentPrinter, Len(ls_currentPrinter) - ll_pos)
	END IF
	
	// set return vars
	as_printerName = ls_printerName
	as_driverName  = ls_driverName
	as_port        = ls_port
	
	return 1
ELSE
	as_printerName = ""
	as_driverName  = ""
	as_port        = ""
	
	return -1
END IF
end function

public function integer setupprinter (string as_printername);// Causes printer-specific setup dialog to display
//
// Returns: 1 if successful, -1 if failure, 0 if dialog canceled by user
//          (value from PowerBuilder PrintSetupPrinter function)

// need to set the default printer first, as PrintSetupPrinter
// only works for current printer
IF this.setCurrentPrinter(as_PrinterName) = 1 THEN
	RETURN PrintSetupPrinter()
ELSE
	RETURN -1
END IF
end function

public function long getinstalledprinters (ref blob ab_printers);// Retrieves list of installed printers and converts list to a
// datastore blob within the reference variable argument.
//
// Returns: number of printers installed

string    ls_printerList
long      ll_rowCount
long      i
datastore ds_printers

// get list of printers
ls_printerList = PrintGetPrinters()

// import into datastore (i.e., let DataWindow engine parse the list)
ds_printers = CREATE datastore
ds_printers.dataObject = "d_printers"
ds_printers.ImportString(ls_printerList)

// 'formattedName' column of datastore is empty when list is imported
// set this column to the display name desired for the printer
ll_rowCount = ds_printers.RowCount()

FOR i = 1 to ll_rowCount
	ds_printers.object.formattedName[i] = formatPrinterDescription(ds_printers.object.printerName[i], ds_printers.object.driverName[i], ds_printers.object.port[i])
	is_printers.s_impresora[i] = ds_printers.object.printerName[i]
	is_printers.s_driver[i] =	ds_printers.object.driverName[i]
	is_printers.s_puerto[i] =	ds_printers.object.port[i]
NEXT

// capture printer datastore in blob

ds_printers.getFullstate(ab_printers)

// destroy the datastore object
DESTROY ds_printers

// return number of printers in list
RETURN ll_rowCount
end function

public subroutine getprinters (ref s_printer as_printers);// Retrieves list of installed printers and converts list to a
// datastore blob within the reference variable argument.
//
// Returns: number of printers installed

string    ls_printerList
long      ll_rowCount
long      i
datastore ds_printers

// get list of printers
ls_printerList = PrintGetPrinters()

// import into datastore (i.e., let DataWindow engine parse the list)
ds_printers = CREATE datastore
ds_printers.dataObject = "d_printers"
ds_printers.ImportString(ls_printerList)

// 'formattedName' column of datastore is empty when list is imported
// set this column to the display name desired for the printer
ll_rowCount = ds_printers.RowCount()
as_printers.d_impresoras = ll_rowCount
FOR i = 1 to ll_rowCount
	ds_printers.object.formattedName[i] = formatPrinterDescription(ds_printers.object.printerName[i], ds_printers.object.driverName[i], ds_printers.object.port[i])
	as_printers.s_impresora[i] = ds_printers.object.printerName[i]
	as_printers.s_driver[i] =	ds_printers.object.driverName[i]
	as_printers.s_puerto[i] =	ds_printers.object.port[i]
NEXT

// destroy the datastore object
DESTROY ds_printers


end subroutine

on n_printer.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_printer.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

