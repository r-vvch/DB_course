USE Airport


/*1. Выбрать имена всех таблиц, созданных назначенным пользователем базы данных (например, пользователем s33 для базы d33)*/
	SELECT name
	FROM sys.objects
	WHERE type = 'U'
		  AND sys.objects.is_ms_shipped = 0
		  AND sys.objects.object_id not in (SELECT sys.extended_properties.major_id FROM sys.extended_properties 
											WHERE sys.extended_properties.name = 'microsoft_database_tools_support')

	SELECT sys.objects.name
	FROM sys.objects, sys.database_principals
	WHERE sys.objects.type = 'U'
		  AND sys.objects.is_ms_shipped = 0
		  AND sys.objects.object_id not in (SELECT sys.extended_properties.major_id FROM sys.extended_properties 
											WHERE sys.extended_properties.name = 'microsoft_database_tools_support')
		  AND sys.database_principals.name = user_name()

	SELECT sys.objects.name AS tab_name, sys.database_principals.name AS [schema_name]
	FROM sys.objects, sys.database_principals
	WHERE sys.database_principals.principal_id = sys.objects.schema_id
	AND sys.objects.type = 'U'
	AND sys.objects.is_ms_shipped = 0
	AND sys.objects.object_id not in (SELECT sys.extended_properties.major_id FROM sys.extended_properties 
	WHERE sys.extended_properties.name = 'microsoft_database_tools_support')

	SELECT sys.objects.name AS tab_name, sys.database_principals.name AS [schema_name]
	FROM sys.objects, sys.database_principals
	WHERE sys.database_principals.principal_id = sys.objects.schema_id
	AND sys.objects.type = 'U'
	AND sys.objects.is_ms_shipped = 0
	AND sys.database_principals.name = 's33'
	AND sys.objects.object_id not in (SELECT sys.extended_properties.major_id FROM sys.extended_properties
	WHERE sys.extended_properties.name = 'microsoft_database_tools_support')

	SELECT *
	/*sys.objects.name AS tab_name, sys.database_principals.name AS [schema_name]*/
	FROM sys.objects, sys.database_principals
	WHERE sys.database_principals.name = 's33'
	AND sys.database_principals.principal_id = sys.objects.schema_id
	AND sys.objects.type = 'U'
	AND sys.objects.is_ms_shipped = 0
	AND sys.objects.object_id not in (SELECT sys.extended_properties.major_id FROM sys.extended_properties
	WHERE sys.extended_properties.name = 'microsoft_database_tools_support') 

/*2. Выбрать имя таблицы, имя столбца таблицы, признак того, допускает ли данный столбец null-значения, название типа данных столбца
  таблицы, размер этого типа данных - для всех таблиц, созданных назначенным пользователем базы данных и всех их столбцов*/
	SELECT sys.objects.name, sys.columns.name, sys.columns.is_nullable, sys.types.name, sys.columns.max_length
	FROM sys.objects INNER JOIN sys.columns ON sys.objects.object_id = sys.columns.object_id, sys.types
	WHERE sys.objects.type = 'U'
		  AND sys.objects.object_id not in (SELECT sys.extended_properties.major_id FROM sys.extended_properties 
											WHERE sys.extended_properties.name = 'microsoft_database_tools_support')
		  AND sys.types.system_type_id = sys.columns.system_type_id
	ORDER BY sys.objects.name


/*3. Выбрать название ограничения целостности (первичные и внешние ключи), имя таблицы, в которой оно находится,
	признак того, что это за ограничение ('PK' для первичного ключа и 'F' для внешнего) - для всех ограничений целостности,
	созданных назначенным пользователем базы данных*/

	SELECT t1.name AS ref_name, t2.name AS tab_name, t1.type AS type_in_tab
	FROM sys.objects  AS t1, sys.objects AS t2, sys.database_principals
	WHERE t2.object_id = t1.parent_object_id
	AND t1.schema_id = sys.database_principals.principal_id
	AND (t1.type = 'F' OR t1.type = 'PK')


/*4. Выбрать название внешнего ключа, имя таблицы, содержащей внешний ключ, имя таблицы,
	содержащей его родительский ключ - для всех внешних ключей, созданных назначенным пользователем базы данных*/

	SELECT sys.foreign_keys.name, t1.name AS tab_FK_name, t2.name AS tab_PK_name
	FROM sys.foreign_keys, sys.tables AS t1, sys.tables AS t2, sys.database_principals
	WHERE sys.foreign_keys.parent_object_id = t1.object_id
	AND sys.foreign_keys.referenced_object_id = t2.object_id
	AND sys.database_principals.name = user_name()


/*5. Выбрать название представления, SQL-запрос, создающий это представление - для всех представлений,
	созданных назначенным пользователем базы данных*/

	SELECT sys.views.name, OBJECT_DEFINITION(OBJECT_ID(name, 'V')) AS txt FROM sys.views


/*6. Выбрать название триггера, имя таблицы, для которой определен триггер - для всех триггеров,
	созданных назначенным пользователем базы данных*/

	SELECT sys.triggers.name AS trig_name, sys.tables.name AS tab_trig_name
	FROM sys.triggers, sys.tables, sys.database_principals
	WHERE sys.triggers.parent_id = sys.tables.object_id
	AND sys.tables.schema_id = sys.database_principals.principal_id
	AND sys.database_principals.name = user_name()


	/*
	SELECT * FROM sys.objects WHERE type = 'U'
	SELECT * FROM sys.columns
	SELECT * FROM sys.types
	SELECT * FROM sys.database_principals
	SELECT * FROM sys.server_principals
	SELECT * FROM sys.sql_logins

	SELECT * FROM sys.foreign_keys
	SELECT * FROM sys.extended_properties 

	SELECT * FROM sys.all_objects
	SELECT * FROM sys.sql_logins
	SELECT * FROM sys.objects
	SELECT * FROM sysobjects
	SELECT * FROM sys.schemas

	SELECT * FROM sys.tables

	SELECT * FROM sys.views

	SELECT * FROM sys.objects
	WHERE type = 'U'

	SELECT * FROM sys.database_principals
	SELECT user_name()
	*/