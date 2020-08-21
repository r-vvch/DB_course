/*Воздушные суда авиакомпаний (обслуживаемые в данном аэропорте)*/
/*Авиакомпания, № Самолёта, Модель*/

IF (OBJECT_ID('Air_company_plane') IS NOT NULL)
	DROP VIEW Air_company_plane;

GO

CREATE VIEW Air_company_plane (Авиакомпания, Номер_самолёта, Модель)
AS
SELECT Air_company.Name, Airplane.Airplane_ID, Model.Name
FROM Flight INNER JOIN Air_company ON Flight.Air_company_ID = Air_company.Air_company_ID
			INNER JOIN Airplane ON Flight.Airplane_ID = Airplane.Airplane_ID
			INNER JOIN Model ON Airplane.Model_ID = Model.Model_ID
GO

SELECT * FROM Air_company_plane