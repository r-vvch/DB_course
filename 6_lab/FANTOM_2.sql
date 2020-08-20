--Фантом 2
USE Airport

begin tran

SET TRAN ISOLATION LEVEL READ UNCOMMITTED
BEGIN TRAN

DECLARE @status_out varchar(50)
EXEC Statement_1 4, '2018-10-29', '15:40', '17:05', 6, 4331, 3, 'LED', @status = @status_out OUTPUT;
PRINT @status_out;
COMMIT 

WAITFOR DELAY '00:00:07'

rollback