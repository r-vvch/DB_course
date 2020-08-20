--Потеря изменений часть 1
USE Airport

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

BEGIN TRANSACTION
DECLARE @weight FLOAT
SELECT @weight = Overweight FROM Flight
WHERE Flight_ID = 5

SELECT Overweight FROM Flight
WHERE Flight_ID = 5

WAITFOR DELAY '00:00:04'

	UPDATE Flight 
	SET Overweight = @weight + 10
	WHERE Flight_ID = 5


COMMIT

SELECT Overweight FROM Flight
WHERE Flight_ID = 5
