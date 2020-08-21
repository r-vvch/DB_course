--Потеря изменений "без потери" часть 2
USE Airport

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

BEGIN TRANSACTION

SELECT Overweight FROM Flight
WHERE Flight_ID = 5

UPDATE Flight 
SET Overweight =  5
WHERE Flight_ID = 5

COMMIT

SELECT Overweight FROM Flight
WHERE Flight_ID = 5
