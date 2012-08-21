HA$PBExportHeader$n_ds.sru
$PBExportComments$Base datastore class
forward
global type n_ds from datastore
end type
end forward

global type n_ds from datastore
end type
global n_ds n_ds

on n_ds.create
call datastore::create
TriggerEvent( this, "constructor" )
end on

on n_ds.destroy
call datastore::destroy
TriggerEvent( this, "destructor" )
end on

event dberror;// In reality, errors would be logged and a message sent back
// to customized error object.  User should not have modal message 
// box reporting DBError unless it is posted to display AFTER the ROLLBACK. 

MessageBox("DBError msg from n_ds", sqlerrtext + & 
	" Error: " + string(sqldbcode) + " " + sqlsyntax)
end event

