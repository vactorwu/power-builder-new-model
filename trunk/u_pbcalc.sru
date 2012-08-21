HA$PBExportHeader$u_pbcalc.sru
$PBExportComments$Drop down calander user object
forward
global type u_pbcalc from userobject
end type
type pb_boton from picturebutton within u_pbcalc
end type
type pb_prev from picturebutton within u_pbcalc
end type
type pb_next from picturebutton within u_pbcalc
end type
type dw_cal from datawindow within u_pbcalc
end type
end forward

global type u_pbcalc from userobject
integer width = 759
integer height = 732
long backcolor = 67108864
long tabtextcolor = 33554432
event clic ( )
event ue_fecha ( )
pb_boton pb_boton
pb_prev pb_prev
pb_next pb_next
dw_cal dw_cal
end type
global u_pbcalc u_pbcalc

type variables
Int ii_Day, ii_Month, ii_Year
String is_old_column
String is_DateFormat
Date id_date_selected
end variables

forward prototypes
public function integer days_in_month (integer month, integer year)
public subroutine draw_month (integer year, integer month)
public subroutine enter_day_numbers (integer ai_start_day_num, integer ai_days_in_month)
public function int get_month_number (string as_month)
public function string get_month_string (integer as_month)
public subroutine init_cal (date ad_start_date)
public function integer unhighlight_column (string as_column)
public function integer highlight_column (string as_column)
public subroutine set_date (date ad_date)
public subroutine set_date_format (string as_date_format)
public subroutine ver (boolean ab_ver)
public subroutine calendario ()
end prototypes

public function integer days_in_month (integer month, integer year);//Most cases are straight forward in that there are a fixed number of 
//days in 11 of the 12 months.  February is, of course, the problem.
//In a leap year February has 29 days, otherwise 28.

Integer		li_DaysInMonth, li_Days[12] = {31,28,31,30,31,30,31,31,30,31,30,31}

// Get the number of days per month for a non leap year.
li_DaysInMonth = li_Days[Month]

// Check for a leap year.
If Month = 2 Then
	// If the year is a leap year, change the number of days.
	// Leap Year Calculation:
	//	Year divisible by 4, but not by 100, unless it is also divisible by 400
	If ( (Mod(Year,4) = 0 And Mod(Year,100) <> 0) Or (Mod(Year,400) = 0) ) Then
		li_DaysInMonth = 29
	End If
End If

//Return the number of days in the relevant month
Return li_DaysInMonth

end function

public subroutine draw_month (integer year, integer month);Int  li_FirstDayNum, li_cell, li_daysinmonth
Date ld_firstday
String ls_month, ls_cell, ls_return

//Set Pointer to an Hourglass and turn off redrawing of Calendar
SetPointer(Hourglass!)
SetRedraw(dw_cal,FALSE)

//Set Instance variables to arguments
ii_month = month
ii_year = year

//check in the instance day is valid for month/year 
//back the day down one if invalid for month ie 31 will become 30
Do While Date(ii_year,ii_month,ii_day) = Date(00,1,1)
	ii_day --
Loop

//Work out how many days in the month
li_daysinmonth = days_in_month(ii_month,ii_year)

//Find the date of the first day in the month
ld_firstday = Date(ii_year,ii_month,1)

//Find what day of the week this is
li_FirstDayNum = DayNumber(ld_firstday)

//Set the first cell
li_cell = li_FirstDayNum + ii_day - 1

//If there was an old column turn off the highlight
unhighlight_column (is_old_column)

//Set the Title
ls_month = get_month_string(ii_month) + " " + string(ii_year)
dw_cal.Object.st_month.text = ls_month

//Enter the day numbers into the datawindow
enter_day_numbers(li_FirstDayNum,li_daysinmonth)

//Define the current cell name
ls_cell = 'cell'+string(li_cell)

//Highlight the current date
highlight_column (ls_cell)

//Set the old column for next time
is_old_column = ls_cell

//Reset the pointer and Redraw
SetPointer(Arrow!)
dw_cal.SetRedraw(TRUE)

end subroutine

public subroutine enter_day_numbers (integer ai_start_day_num, integer ai_days_in_month);Int li_count, li_daycount

//Blank the columns before the first day of the month
For li_count = 1 to ai_start_day_num
	dw_cal.SetItem(1,li_count,"")
Next

//Set the columns for the days to the String of their Day number
For li_count = 1 to ai_days_in_month
	//Use li_daycount to find which column needs to be set
	li_daycount = ai_start_day_num + li_count - 1
	dw_cal.SetItem(1,li_daycount,String(li_count))
Next

//Move to next column
li_daycount = li_daycount + 1

//Blank remainder of columns
For li_count = li_daycount to 42
	dw_cal.SetItem(1,li_count,"")
Next

//If there was an old column turn off the highlight
unhighlight_column (is_old_column)

is_old_column = ''


end subroutine

public function int get_month_number (string as_month);Int li_month_number

CHOOSE CASE as_month
	CASE "Jan"
		li_month_number = 1
	CASE "Feb"
		li_month_number = 2
	CASE "Mar"
		li_month_number = 3
	CASE "Apr"
		li_month_number = 4
	CASE "May"
		li_month_number = 5
	CASE "Jun"
		li_month_number = 6
	CASE "Jul"
		li_month_number = 7
	CASE "Aug"
		li_month_number = 8
	CASE "Sep"
		li_month_number = 9
	CASE "Oct"
		li_month_number = 10
	CASE "Nov"
		li_month_number = 11
	CASE "Dec"
		li_month_number = 12
END CHOOSE

return li_month_number
end function

public function string get_month_string (integer as_month);String ls_month

CHOOSE CASE as_month
	CASE 1
		ls_month = "ENERO"
	CASE 2
		ls_month = "FEBRERO"
	CASE 3
		ls_month = "MARZO"
	CASE 4
		ls_month = "ABRIL"
	CASE 5
		ls_month = "MAYO"
	CASE 6
		ls_month = "JUNIO"
	CASE 7
		ls_month = "JULIO"
	CASE 8
		ls_month = "AGOSTO"
	CASE 9
		ls_month = "SEPTIEMBRE"
	CASE 10
		ls_month = "OCTUBRE"
	CASE 11
		ls_month = "NOVIEMBRE"
	CASE 12
		ls_month = "DICIEMBRE"
END CHOOSE

return ls_month
end function

public subroutine init_cal (date ad_start_date);Int li_FirstDayNum, li_Cell, li_DaysInMonth
String ls_Year, ls_Month, ls_Return, ls_Cell
Date ld_FirstDay

//Insert a row into the script datawindow
dw_cal.InsertRow(0)

//Set the variables for Day, Month and Year from the date passed to
//the function
ii_Month = Month(ad_start_date)
ii_Year = Year(ad_start_date)
ii_Day = Day(ad_start_date)

//Find how many days in the relevant month
li_daysinmonth = days_in_month(ii_month, ii_year)

//Find the date of the first day of this month
ld_FirstDay = Date(ii_Year, ii_month, 1)

//What day of the week is the first day of the month
li_FirstDayNum = DayNumber(ld_FirstDay)

//Set the starting "cell" in the datawindow. i.e the column in which
//the first day of the month will be displayed
li_Cell = li_FirstDayNum + ii_Day - 1

//Set the Title of the calendar with the Month and Year
ls_Month = get_month_string(ii_Month) + " " + string(ii_Year)
dw_cal.Object.st_month.text = ls_month

//Enter the numbers of the days
enter_day_numbers(li_FirstDayNum, li_DaysInMonth)

dw_cal.SetItem(1,li_cell,String(Day(ad_start_date)))

//Define the first Cell as a string
ls_cell = 'cell'+string(li_cell)

//Display the first day in bold (or 3D)
highlight_column (ls_cell)

//Set the instance variable i_old_column to hold the current cell, so
//when we change it, we know the old setting
is_old_column = ls_Cell

end subroutine

public function integer unhighlight_column (string as_column);//If the highlight is on the column set the border of the column back to normal

string ls_return

If as_column <> '' then
	ls_return = dw_cal.Modify(as_column + ".border=6")
	If ls_return <> "" then 
		MessageBox("Modify",ls_return)
		Return -1
	End if
End If
//bordes
// 0 plano 1 sombra 2 recuadro 3 undido
// 4 subrayado 5 undido 6 
Return 1
end function

public function integer highlight_column (string as_column);//Highlight the current column/date

string ls_return

ls_return = dw_cal.Modify(as_column + ".border=5")
If ls_return <> "" then 
	MessageBox("Modify",ls_return)
	Return -1
End if

Return 1
end function

public subroutine set_date (date ad_date);// Set the date.  Use the desired format.

//If Not isnull(ad_date) then 
	//sle_date.text = string(ad_date, is_dateformat)
//End If
end subroutine

public subroutine set_date_format (string as_date_format);// Set the format.
is_DateFormat = as_date_format

// Set the date with the new format.
If Not isnull(id_date_selected) then 
	set_date (id_date_selected)
End If
end subroutine

public subroutine ver (boolean ab_ver);If ab_Ver then
	 this.height = dw_cal.height
	 this.width =  dw_cal.width
Else
	 this.height = 0
	 this.width = 0
End If
end subroutine

public subroutine calendario ();
//Works as a toggle, if the DropDown is visible, make it invisible
//otherwise make it visible

date 	ld_date

If dw_cal.visible then
	dw_cal.visible = FALSE
	pb_next.visible = FALSE
	pb_prev.visible = FALSE
	Ver(False)
else
	Ver(True)
	//Reset the datawindow

	reset(dw_cal)

	// If there is already a date in the edit box then make this the
	// current date in the calendar, otherwise use today
	If ii_day = 0 Then ii_day = 1
	ld_date = date(ii_year, ii_month, ii_day)  // This line used for debugging
	init_cal(date(ii_year, ii_month, ii_day))


	dw_cal.visible = TRUE
	pb_next.visible = TRUE
	pb_prev.visible = TRUE

	dw_cal.setfocus()
End If
end subroutine

event constructor;id_date_selected = date(uf_datetime())
init_cal(id_date_selected)
set_date (id_date_selected)
ver(false)
end event

on u_pbcalc.create
this.pb_boton=create pb_boton
this.pb_prev=create pb_prev
this.pb_next=create pb_next
this.dw_cal=create dw_cal
this.Control[]={this.pb_boton,&
this.pb_prev,&
this.pb_next,&
this.dw_cal}
end on

on u_pbcalc.destroy
destroy(this.pb_boton)
destroy(this.pb_prev)
destroy(this.pb_next)
destroy(this.dw_cal)
end on

type pb_boton from picturebutton within u_pbcalc
integer x = 763
integer y = 428
integer width = 101
integer height = 88
integer taborder = 50
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string picturename = "AutosizeHeight!"
alignment htextalign = left!
end type

event clicked;
//Works as a toggle, if the DropDown is visible, make it invisible
//otherwise make it visible

date 	ld_date

If dw_cal.visible then
	dw_cal.visible = FALSE
	pb_next.visible = FALSE
	pb_prev.visible = FALSE
	Ver(False)
else
	Ver(True)
	//Reset the datawindow

	reset(dw_cal)

	// If there is already a date in the edit box then make this the
	// current date in the calendar, otherwise use today
	If ii_day = 0 Then ii_day = 1
	ld_date = date(ii_year, ii_month, ii_day)  // This line used for debugging
	init_cal(date(ii_year, ii_month, ii_day))


	dw_cal.visible = TRUE
	pb_next.visible = TRUE
	pb_prev.visible = TRUE

	dw_cal.setfocus()
End If
end event

type pb_prev from picturebutton within u_pbcalc
event clicked pbm_bnclicked
boolean visible = false
integer width = 91
integer height = 80
integer taborder = 30
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string picturename = "VCRPrior!"
alignment htextalign = left!
end type

event clicked;//Decrement the month, if 0, set to 12 (December)
ii_month = ii_month - 1
If ii_month = 0 then
	ii_month = 12
	ii_year = ii_year - 1
End If

//check if selected day is no longer valid for new month
If not(isdate(string(ii_month) + "/" + string(ii_day) + "/"+ string(ii_year))) Then ii_day = 1

//Darw the month
draw_month ( ii_year, ii_month )

//Return the chosen date into the SingleLineEdit in the chosen format
id_date_selected = date(ii_year,ii_month,ii_Day)
set_date (id_date_selected)
parent.event clic( )
end event

type pb_next from picturebutton within u_pbcalc
boolean visible = false
integer x = 581
integer width = 91
integer height = 80
integer taborder = 40
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string picturename = "VCRNext!"
alignment htextalign = left!
end type

event clicked;//Increment the month number, but if its 13, set back to 1 (January)
ii_month = ii_month + 1
If ii_month = 13 then
	ii_month = 1
	ii_year = ii_year + 1
End If

//check if selected day is no longer valid for new month
If not(isdate(string(ii_month) + "/" + string(ii_day) + "/"+ string(ii_year))) Then ii_day = 1
	
//Draw the month
draw_month ( ii_year, ii_month )

//Return the chosen date into the SingleLineEdit in the chosen format
id_date_selected = date(ii_year,ii_month,ii_Day)
set_date (id_date_selected)
parent.event clic( )
end event

type dw_cal from datawindow within u_pbcalc
event ue_dwnkey pbm_dwnkey
event clic ( )
boolean visible = false
integer width = 677
integer height = 624
integer taborder = 20
string dataobject = "d_calendar"
end type

event ue_dwnkey;//This script will allow someone to use the ctrl right arrow and
//ctrl left arrow key combinations to change the months on
//the calendar

If keydown(keyRightArrow!) and keydown(keyControl!) then
	pb_next.triggerevent(clicked!)
Elseif keydown(keyLeftArrow!) and keydown(keyControl!) then
	pb_prev.triggerevent(clicked!)
End If
end event

event clicked;String ls_clickedcolumn, ls_clickedcolumnID
String ls_day, ls_return
string ls_col_name

//Return if click was not on a valid dwobject, depending on what was
//clicked, dwo will be null or dwo.name will be "datawindow"
If IsNull(dwo) Then Return
If Pos(dwo.name, "cell") = 0 Then Return

//Find which column was clicked on and return if it is not valid
ls_clickedcolumn = dwo.name
ls_clickedcolumnID = dwo.id
If ls_clickedcolumn = '' Then Return

//Set Day to the text of the clicked column. Return if it is an empty column
ls_day = dwo.primary[1]
If ls_day = "" then Return

//Convert to a number and place in Instance variable
ii_day = Integer(ls_day)

//If the highlight was on a previous column (is_old_column <> '')
//set the border of the old column back to normal
unhighlight_column (is_old_column)

//Highlight chosen day/column
dwo.border = 5

//Set the old column for next time
is_old_column = ls_clickedcolumn

//Return the chosen date into the SingleLineEdit in the chosen format
id_date_selected = date(ii_year, ii_month, ii_Day)
set_date (id_date_selected)
parent.event clic( )
end event

event doubleclicked;String ls_day

//Return if click was not on a valid dwobject, depending on what was
//clicked, dwo will be null or dwo.name will be "datawindow"
If IsNull(dwo) Then Return
If Pos(dwo.name, "cell") = 0 Then Return

//Set the Day to the chosen column
ls_day = dwo.primary[1]
ii_day = Integer(ls_day)

//Return the chosen date into the SingleLineEdit in the chosen format
id_date_selected = date(ii_year, ii_month, ii_Day)
set_date (id_date_selected)
parent.event clic( )

//Hide the components of the DropDown
dw_cal.visible = FALSE
pb_next.visible = FALSE
pb_prev.visible = FALSE
Ver(False)

end event

