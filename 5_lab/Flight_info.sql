/*Все полёты по данному рейсу*/
/*Дата, Время вылета, Время прилёта, Город, Аэропорт, Авиакомпания, Время в пути*/

IF (OBJECT_ID('Flight_info') IS NOT NULL)
	DROP VIEW Flight_info;

GO

/*SELECT CONCAT(CAST((CAST((DATEDIFF(hour, Departure_time_planned, Arrival_time_planned)) AS int) - 1) AS varchar(50)), ':',CAST((DATEDIFF(minute, Departure_time_planned, Arrival_time_planned)) AS int) - (CAST((DATEDIFF(hour, Departure_time_planned, Arrival_time_planned)) AS int) - 1)*60)
FROM Flight*/

CREATE VIEW Flight_info (Дата, Время_вылета, Время_прилёта, Город, Аэропорт, Авиакомпания, Время_в_пути)
AS
SELECT Departure_date, Departure_time_planned, Arrival_time_planned, City.City_name, CONCAT (Airport.Airport_name, ' (', Destination_airport, ')'), Air_company.Name, CONCAT(RIGHT('00' + CAST(ABS(CAST(DATEDIFF(minute, Departure_time_planned, Arrival_time_planned) AS INT)/60) AS varchar(50)), 2), ':', RIGHT('00' + CAST(ABS(CAST(DATEDIFF(minute, Departure_time_planned, Arrival_time_planned) AS INT)%60) AS varchar(50)), 2))
FROM Flight INNER JOIN Air_company ON Flight.Air_company_ID = Air_company.Air_company_ID
			INNER JOIN Airport ON Flight.Destination_airport = Airport.IATA
			INNER JOIN City ON Airport.City_ID = City.City_ID
			INNER JOIN Flight_fact ON Flight.Flight_ID = Flight_fact.Flight_ID
			INNER JOIN Flight_status ON Flight_fact.Status_ID = Flight_status.Status_ID
WHERE Flight_name = 'DP 811'
GO

SELECT * FROM Flight_info

/*
SELECT Departure_date, Departure_time_planned, Arrival_time_planned, City.City_name, CONCAT (Airport.Airport_name, ' (', Destination_airport, ')'), Air_company.Name, CONCAT(CAST((CAST((DATEDIFF(hour, Departure_time_planned, Arrival_time_planned)) AS int) - 1) AS varchar(50)), ':',CAST((DATEDIFF(minute, Departure_time_planned, Arrival_time_planned)) AS int) - (CAST((DATEDIFF(hour, Departure_time_planned, Arrival_time_planned)) AS int) - 1)*60)
FROM Flight INNER JOIN Air_company ON Flight.Air_company_ID = Air_company.Air_company_ID
			INNER JOIN Airport ON Flight.Destination_airport = Airport.IATA
			INNER JOIN City ON Airport.City_ID = City.City_ID
			INNER JOIN Flight_fact ON Flight.Flight_ID = Flight_fact.Flight_ID
			INNER JOIN Flight_status ON Flight_fact.Status_ID = Flight_status.Status_ID
WHERE Flight_name = 'DP 811'
CONCAT(RIGHT('00' + CAST(ABS(CAST(DATEDIFF(minute, Departure_time_planned, Arrival_time_planned) AS INT)/60) AS varchar(50)), 2), ':', RIGHT('00' + CAST(ABS(CAST(DATEDIFF(minute, Departure_time_planned, Arrival_time_planned) AS INT)%60) AS varchar(50)), 2))
*/