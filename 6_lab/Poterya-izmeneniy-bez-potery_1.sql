--Потеря изменений "без потери" часть 1
USE Airport

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

BEGIN TRANSACTION

SELECT Overweight FROM Flight
WHERE Flight_ID = 5

WAITFOR DELAY '00:00:04'

	UPDATE Flight 
	SET Overweight =  10
	WHERE Flight_ID = 5

COMMIT

SELECT Overweight FROM Flight
WHERE Flight_ID = 5
