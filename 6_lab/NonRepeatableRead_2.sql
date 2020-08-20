--Неповторяющееся чтение 2
USE Airport

SET TRAN ISOLATION LEVEL READ COMMITTED
BEGIN TRAN

UPDATE Flight
SET Destination_Airport = 'RIX'
WHERE Flight_ID = 2

COMMIT