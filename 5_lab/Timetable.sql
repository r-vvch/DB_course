/*Табло*/
/*Время вылета по расписанию, Рейс, Авиакомпания, Город назначения, Аэропорт назначения, Статус рейса*/

IF (OBJECT_ID('Timetable') IS NOT NULL)
	DROP VIEW Timetable;

GO

CREATE VIEW Timetable (Время_вылета_по_расписанию, Рейс, Авиакомпания, Город_назначения, Аэропорт_назначения, Статус_рейса)
AS
SELECT Departure_time_planned, Flight_name, Air_company.Name, City.City_name, CONCAT (Airport.Airport_name, ' (', Destination_airport, ')'), Flight_status.[Description]
FROM Flight INNER JOIN Air_company ON Flight.Air_company_ID = Air_company.Air_company_ID
			INNER JOIN Airport ON Flight.Destination_airport = Airport.IATA
			INNER JOIN City ON Airport.City_ID = City.City_ID
			INNER JOIN Flight_fact ON Flight.Flight_ID = Flight_fact.Flight_ID
			INNER JOIN Flight_status ON Flight_fact.Status_ID = Flight_status.Status_ID
GO

SELECT * FROM Timetable