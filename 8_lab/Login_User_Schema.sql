USE Airport

/*1. Выбрать имена всех таблиц, созданных назначенным пользователем базы данных (например, пользователем s33 для базы d33)*/
SELECT sys.objects.name FROM sys.objects, sys.sql_logins
WHERE sys.objects.type = 'U'
AND sys.sql_logins.name = 'test'
AND sys.objects.object_id not in (SELECT sys.extended_properties.major_id FROM sys.extended_properties 
											WHERE sys.extended_properties.name = 'microsoft_database_tools_support')

SELECT sys.objects.name FROM sys.objects
WHERE sys.objects.type = 'U'
		AND sys.objects.object_id not in (SELECT sys.extended_properties.major_id FROM sys.extended_properties 
											WHERE sys.extended_properties.name = 'microsoft_database_tools_support')

select t.name
from sys.tables t
where   user_name(objectproperty(t.object_id,'OwnerId')) = @username 
		and objectproperty(t.object_id,'IsUserTable') = 1
		and t.object_id not in 
			(
			select major_id 
			from sys.extended_properties 
			where name = 'microsoft_database_tools_support' 
			)

SELECT sys.objects.name FROM sys.objects, sys.database_principals
WHERE sys.objects.type = 'U'
AND sys.database_principals.name = 's33'
AND sys.objects.object_id not in (SELECT sys.extended_properties.major_id FROM sys.extended_properties 
											WHERE sys.extended_properties.name = 'microsoft_database_tools_support')

SELECT sys.objects.name FROM sys.objects, sys.database_principals
WHERE sys.objects.type = 'U'
AND sys.database_principals.principal_id = sys.objects.schema_id
AND sys.objects.object_id not in (SELECT sys.extended_properties.major_id FROM sys.extended_properties 
											WHERE sys.extended_properties.name = 'microsoft_database_tools_support')


SELECT user_name(objectproperty(t.object_id,'OwnerId'))
FROM sys.tables t