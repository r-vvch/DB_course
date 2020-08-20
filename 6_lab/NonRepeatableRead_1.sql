--Неповторяющееся чтение 1
USE Airport

SET TRAN ISOLATION LEVEL READ COMMITTED
BEGIN TRAN

SELECT Flight_ID, Destination_Airport
FROM Flight
WHERE Flight_ID = 2

WAITFOR DELAY '00:00:03'

SELECT Flight_ID, Destination_Airport
FROM Flight
WHERE Flight_ID = 2

COMMIT
