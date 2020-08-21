--Потеря изменений часть 2
USE Airport

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

BEGIN TRANSACTION

DECLARE @weight FLOAT
SELECT @weight = Overweight FROM Flight
WHERE Flight_ID = 5

SELECT Overweight FROM Flight
WHERE Flight_ID = 5

UPDATE Flight 
SET Overweight = @weight + 5
WHERE Flight_ID = 5

COMMIT

SELECT Overweight FROM Flight
WHERE Flight_ID = 5
