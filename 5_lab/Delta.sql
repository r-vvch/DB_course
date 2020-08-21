/*Разника запланированного и фактического*/
/*Рейс, Номер_рейса, Разница_регистрации, Разница_посадки, Разница_взлёта, Разница_прибытия*/

IF (OBJECT_ID('Delta') IS NOT NULL)
	DROP VIEW Delta;

GO

CREATE VIEW Delta (Дата, Номер_рейса, Разница_регистрации, Разница_посадки, Разница_взлёта, Разница_прибытия)
AS
SELECT  Flight.Departure_date, Flight_name,
		--CONCAT(CAST((ABS(CAST((DATEDIFF(hour, Departure_time_planned, Arrival_time_planned)) AS int)) - 1) AS varchar(50)), ':',CAST((ABS(CAST((DATEDIFF(minute, Departure_time_planned, Arrival_time_planned)) AS int))) - CAST((ABS(CAST((DATEDIFF(hour, Departure_time_planned, Arrival_time_planned)) AS int)) - 1)*60 AS int),
		CONCAT(RIGHT('00' + CAST(ABS(CAST(DATEDIFF(minute, Reg_begin_planned, Reg_begin_fact) AS INT)/60) AS varchar(50)), 2), ':', RIGHT('00' + CAST(ABS(CAST(DATEDIFF(minute, Reg_begin_planned, Reg_begin_fact) AS INT)%60) AS varchar(50)), 2)),
		CONCAT(RIGHT('00' + CAST(ABS(CAST(DATEDIFF(minute, Boarding_begin_planned, Boarding_begin_fact) AS INT)/60) AS varchar(50)), 2), ':', RIGHT('00' + CAST(ABS(CAST(DATEDIFF(minute, Reg_begin_planned, Reg_begin_fact) AS INT)%60) AS varchar(50)), 2)),
		CONCAT(RIGHT('00' + CAST(ABS(CAST(DATEDIFF(minute, Departure_time_planned, Departure_time_fact) AS INT)/60) AS varchar(50)), 2), ':', RIGHT('00' + CAST(ABS(CAST(DATEDIFF(minute, Reg_begin_planned, Reg_begin_fact) AS INT)%60) AS varchar(50)), 2)),
		CONCAT(RIGHT('00' + CAST(ABS(CAST(DATEDIFF(minute, Arrival_time_planned, Arrival_time_fact) AS INT)/60) AS varchar(50)), 2), ':', RIGHT('00' + CAST(ABS(CAST(DATEDIFF(minute, Reg_begin_planned, Reg_begin_fact) AS INT)%60) AS varchar(50)), 2))
FROM Flight INNER JOIN Flight_fact ON Flight.Flight_ID = Flight_fact.Flight_ID
GO

SELECT * FROM Delta


/*
SELECT  Flight.Departure_date, Flight_name,
		--CONCAT(CAST((ABS(CAST((DATEDIFF(hour, Departure_time_planned, Arrival_time_planned)) AS int)) - 1) AS varchar(50)), ':',CAST((ABS(CAST((DATEDIFF(minute, Departure_time_planned, Arrival_time_planned)) AS int))) - CAST((ABS(CAST((DATEDIFF(hour, Departure_time_planned, Arrival_time_planned)) AS int)) - 1)*60 AS int),
		ABS(CAST(DATEDIFF(minute, Reg_begin_planned, Reg_begin_fact) AS INT)),
		ABS(CAST(DATEDIFF(minute, Boarding_begin_planned, Boarding_begin_fact) AS INT)),
		ABS(CAST(DATEDIFF(minute, Departure_time_planned, Departure_time_fact) AS INT)),
		ABS(CAST(DATEDIFF(minute, Arrival_time_planned, Arrival_time_fact) AS INT))
FROM Flight INNER JOIN Flight_fact ON Flight.Flight_ID = Flight_fact.Flight_ID
GO

SELECT  Flight.Departure_date, Flight_name,
		--CONCAT(CAST((ABS(CAST((DATEDIFF(hour, Departure_time_planned, Arrival_time_planned)) AS int)) - 1) AS varchar(50)), ':',CAST((ABS(CAST((DATEDIFF(minute, Departure_time_planned, Arrival_time_planned)) AS int))) - CAST((ABS(CAST((DATEDIFF(hour, Departure_time_planned, Arrival_time_planned)) AS int)) - 1)*60 AS int),
		CONCAT(CAST(ABS(CAST(DATEDIFF(minute, Reg_begin_planned, Reg_begin_fact) AS INT)/60) AS varchar(50)), ':', CAST(ABS(CAST(DATEDIFF(minute, Reg_begin_planned, Reg_begin_fact) AS INT)%60) AS varchar(50))),
		CONCAT(CAST(ABS(CAST(DATEDIFF(minute, Boarding_begin_planned, Boarding_begin_fact) AS INT)/60) AS varchar(50)), ':', CAST(ABS(CAST(DATEDIFF(minute, Reg_begin_planned, Reg_begin_fact) AS INT)%60) AS varchar(50))),
		CONCAT(CAST(ABS(CAST(DATEDIFF(minute, Departure_time_planned, Departure_time_fact) AS INT)/60) AS varchar(50)), ':', CAST(ABS(CAST(DATEDIFF(minute, Reg_begin_planned, Reg_begin_fact) AS INT)%60) AS varchar(50))),
		CONCAT(CAST(ABS(CAST(DATEDIFF(minute, Arrival_time_planned, Arrival_time_fact) AS INT)/60) AS varchar(50)), ':', CAST(ABS(CAST(DATEDIFF(minute, Reg_begin_planned, Reg_begin_fact) AS INT)%60) AS varchar(50)))
FROM Flight INNER JOIN Flight_fact ON Flight.Flight_ID = Flight_fact.Flight_ID
*/