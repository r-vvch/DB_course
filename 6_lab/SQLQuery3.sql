--������ "��������" ������ 2 �����
USE Airport

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

BEGIN TRANSACTION

UPDATE Flight SET Flight.Overweight = Flight.Overweight + 10
WHERE Flight_ID = 5



/*
SELECT Flight.Overweight FROM Flight
WHERE Flight_ID = 5
*/
--ROLLBACK
ROLLBACK