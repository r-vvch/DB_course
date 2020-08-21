--Фантом 1
USE Airport

SET TRAN ISOLATION LEVEL  READ UNCOMMITTED
BEGIN TRAN

SELECT Flight_ID, Departure_date, Destination_airport, Air_company_ID
FROM Flight
WHERE Air_company_ID > 2

WAITFOR DELAY '00:00:05'

SELECT Flight_ID, Departure_date, Destination_airport, Air_company_ID
FROM Flight
WHERE Air_company_ID > 2

COMMIT TRAN