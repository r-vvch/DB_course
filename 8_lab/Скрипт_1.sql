/*
SELECT sys.objects.name FROM sys.objects, sys.sql_logins
WHERE sys.objects.type = 'U'
AND sys.sql_logins.name = 'test'
AND sys.objects.object_id not in (SELECT sys.extended_properties.major_id FROM sys.extended_properties 
											WHERE sys.extended_properties.name = 'microsoft_database_tools_support')

SELECT * FROM sys.dm_xe_session_event_actions
SELECT * FROM sys.dm_xe_session_object_columns
select path from sys.traces where is_default = 1 ;

select * from ::fn_trace_gettable( @base_tracefilename, default )
*/

BEGIN TRANSACTION

declare @d1 datetime;
declare @diff int;
declare @curr_tracefilename varchar(500);
declare @base_tracefilename varchar(500);
declare @indx int ;

select @curr_tracefilename = path from sys.traces where is_default = 1 ;
set @curr_tracefilename = reverse(@curr_tracefilename)
select @indx = PATINDEX('%\%', @curr_tracefilename)
set @curr_tracefilename = reverse(@curr_tracefilename)
set @base_tracefilename = LEFT(@curr_tracefilename,len(@curr_tracefilename) - @indx) + '\log.trc';
/*
insert into @temp_trace
select distinct ObjectName
, DatabaseName
, StartTime
, EventClass
, EventSubClass
, ObjectType
, ServerName
, LoginName
, ApplicationName
, 'temp'
from ::fn_trace_gettable( @base_tracefilename, default )
where EventClass in (46,47,164) and EventSubclass = 0 and
DatabaseID <> 2 and
LoginName = 'test'
*/
select distinct ObjectName
, ObjectType
, ServerName
, LoginName
from ::fn_trace_gettable( @base_tracefilename, default )
where EventClass in (46,47,164) and EventSubclass = 0 and
DatabaseID <> 2 and
ObjectType = 8277 and
LoginName = 'test'

/*
update @temp_trace set ddl_operation = 'CREATE' where
event_class = 46
update @temp_trace set ddl_operation = 'DROP' where
event_class = 47
update @temp_trace set ddl_operation = 'ALTER' where
event_class = 164

select @d1 = min(start_time) from @temp_trace
set @diff= datediff(hh,@d1,getdate())
set @diff=@diff/24;

select @diff as difference
, @d1 as date
, object_type as obj_type_desc
, *
from @temp_trace where object_type not in (21587)
order by start_time desc
*/

ROLLBACK


/*
select @indx = PATINDEX('%\%', select path from sys.traces)
select PATINDEX('%\%', select path from sys.traces)
select @curr_tracefilename = path from sys.traces where is_default = 1 ;
select path from sys.traces
select (CONCAT((CAST(LEFT((select path from sys.traces),len((select path from sys.traces)) - (select PATINDEX('%\%', (select path from sys.traces)))) as varchar(50))), '\log.trc'))

select ObjectName
, DatabaseName
, StartTime
, EventClass
, EventSubClass
, ObjectType
, ServerName
, LoginName
, ApplicationName
, 'temp'
from ::fn_trace_gettable( @base_tracefilename, default )
where EventClass in (46,47,164) and EventSubclass = 0 and
DatabaseID <> 2

update @temp_trace set ddl_operation = 'CREATE' where
event_class = 46
update @temp_trace set ddl_operation = 'DROP' where
event_class = 47
update @temp_trace set ddl_operation = 'ALTER' where
event_class = 164
*/

/*
BEGIN TRANSACTION

declare @d1 datetime;
declare @diff int;
declare @curr_tracefilename varchar(500);
declare @base_tracefilename varchar(500);
declare @indx int ;
declare @temp_trace table (
 obj_name nvarchar(256) collate database_default
, database_name nvarchar(256) collate database_default
, start_time datetime
, event_class int
, event_subclass int
, object_type int
, server_name nvarchar(256) collate database_default
, login_name nvarchar(256) collate database_default
, application_name nvarchar(256) collate database_default
, ddl_operation nvarchar(40) collate database_default
);

select @curr_tracefilename = path from sys.traces where is_default = 1 ;
set @curr_tracefilename = reverse(@curr_tracefilename)
select @indx = PATINDEX('%\%', @curr_tracefilename)
set @curr_tracefilename = reverse(@curr_tracefilename)
set @base_tracefilename = LEFT(@curr_tracefilename,len(@curr_tracefilename) - @indx) + '\log.trc';

insert into @temp_trace
select ObjectName
, DatabaseName
, StartTime
, EventClass
, EventSubClass
, ObjectType
, ServerName
, LoginName
, ApplicationName
, 'temp'
from ::fn_trace_gettable( @base_tracefilename, default )
where EventClass in (46,47,164) and EventSubclass = 0 and
DatabaseID <> 2

update @temp_trace set ddl_operation = 'CREATE' where
event_class = 46
update @temp_trace set ddl_operation = 'DROP' where
event_class = 47
update @temp_trace set ddl_operation = 'ALTER' where
event_class = 164

select @d1 = min(start_time) from @temp_trace
set @diff= datediff(hh,@d1,getdate())
set @diff=@diff/24;

select @diff as difference
, @d1 as date
, object_type as obj_type_desc
, *
from @temp_trace where object_type not in (21587)
order by start_time desc

ROLLBACK
*/


/*1. Выбрать имена всех таблиц, созданных назначенным пользователем базы данных (например, пользователем s33 для базы d33)*/
	BEGIN TRANSACTION

	CREATE LOGIN d33 WITH PASSWORD = 'd33' 
	CREATE USER s33 FOR LOGIN d33

	GRANT CREATE TABLE TO s33;

	GRANT ALTER ON SCHEMA::dbo TO s33;

	--EXECUTE AS USER = 's33'
	EXECUTE AS LOGIN = 'd33'
	CREATE TABLE Alphabet(
		Number INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
		Letter VARCHAR(5) NOT NULL);
	CREATE TABLE WhySuchAStrangeNameForATable(
		Number INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
		[Column] VARCHAR(5) NOT NULL);

	REVERT

	declare @d1 datetime;
	declare @diff int;
	declare @curr_tracefilename varchar(500);
	declare @base_tracefilename varchar(500);
	declare @indx int ;

	select @curr_tracefilename = path from sys.traces where is_default = 1 ;
	set @curr_tracefilename = reverse(@curr_tracefilename)
	select @indx = PATINDEX('%\%', @curr_tracefilename)
	set @curr_tracefilename = reverse(@curr_tracefilename)
	set @base_tracefilename = LEFT(@curr_tracefilename,len(@curr_tracefilename) - @indx) + '\log.trc';

	select a.ObjectName
	from ::fn_trace_gettable( @base_tracefilename, default) a inner join ::fn_trace_gettable( @base_tracefilename, default) b on a.ObjectName = b.ObjectName
	where b.EventClass in (46,47,164) and b.EventSubclass = 0 and
	b.DatabaseID <> 2 and
	b.ObjectType = 8277 and
	b.LoginName = 'test'

	ROLLBACK