--������ "��������" ������ 1 �����
USE Airport

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
--SET TRANSACTION ISOLATION LEVEL REPEATABLE READ
BEGIN TRANSACTION

SELECT Flight.Overweight FROM Flight
WHERE Flight_ID = 5	

WAITFOR DELAY '00:00:03';

SELECT Flight.Overweight FROM Flight
WHERE Flight_ID = 5

WAITFOR DELAY '00:00:03';

SELECT Flight.Overweight FROM Flight
WHERE Flight_ID = 5

COMMIT