USE Airport

UPDATE Flight
SET Overweight = 12
WHERE Flight_ID = 5

UPDATE Flight
SET Destination_airport = 'MXP'
WHERE Flight_ID = 2

SELECT Flight_ID, Overweight FROM Flight