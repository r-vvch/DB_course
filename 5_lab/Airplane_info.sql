/*��� ����� ������� �������*/
/*����� ����������, ��������, ����, ����� ������, ����� ������, ������ �����*/

IF (OBJECT_ID('Airplane_info') IS NOT NULL)
	DROP VIEW Airplane_info;
--IF (OBJECT_ID('Airplane_info1') IS NOT NULL)
--	DROP VIEW Airplane_info1;

GO

CREATE VIEW Airplane_info (�����_����������, ��������, ����, �����_������, �����_������, ������_�����)
AS
SELECT  City.City_name, CONCAT (Airport.Airport_name, ' (', Destination_airport, ')'), Departure_date, Departure_time_planned,
		Arrival_time_planned, Flight_status.[Description]
FROM Flight INNER JOIN Air_company ON Flight.Air_company_ID = Air_company.Air_company_ID
			INNER JOIN Airport ON Flight.Destination_airport = Airport.IATA
			INNER JOIN City ON Airport.City_ID = City.City_ID
			INNER JOIN Flight_fact ON Flight.Flight_ID = Flight_fact.Flight_ID
			INNER JOIN Flight_status ON Flight_fact.Status_ID = Flight_status.Status_ID
			INNER JOIN Airplane ON Flight.Airplane_ID = Airplane.Airplane_ID
WHERE Airplane.Airplane_number = '8931'

GO

/*
CREATE VIEW Airplane_info1 (�����_����������, ��������, ����, �����_������, �����_������, ������_�����)
AS
SELECT  City.City_name, CONCAT (Airport.Airport_name, ' (', Destination_airport, ')'), Departure_date, Departure_time_planned,
		Arrival_time_planned, Flight_status.[Description]
FROM Flight INNER JOIN Air_company ON Flight.Air_company_ID = Air_company.Air_company_ID
			INNER JOIN Airport ON Flight.Destination_airport = Airport.IATA
			INNER JOIN City ON Airport.City_ID = City.City_ID
			INNER JOIN Flight_fact ON Flight.Flight_ID = Flight_fact.Flight_ID
			INNER JOIN Flight_status ON Flight_fact.Status_ID = Flight_status.Status_ID
			INNER JOIN Airplane ON Flight.Airplane_ID = Airplane.Airplane_ID
WHERE Airplane.Airplane_number = '8931'
with check option
GO
*/

SELECT * FROM Airplane_info

