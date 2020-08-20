USE Airport

GO

IF EXISTS (SELECT * FROM sys.objects WHERE ([type] = 'P' AND name = 'Statement_1'))
	DROP PROCEDURE Statement_1

IF EXISTS (SELECT * FROM sys.objects WHERE ([type] = 'P' AND name = 'Statement_2'))
	DROP PROCEDURE Statement_2

IF EXISTS (SELECT * FROM sys.objects WHERE ([type] = 'P' AND name = 'Statement_3'))
	DROP PROCEDURE Statement_3

IF EXISTS (SELECT * FROM sys.objects WHERE ([type] = 'P' AND name = 'Luggage_reg'))
	DROP PROCEDURE Luggage_reg

IF EXISTS (SELECT * FROM sys.objects WHERE ([type] = 'P' AND name = 'Overweight_setup'))
	DROP PROCEDURE Overweight_setup

IF EXISTS (SELECT * FROM sys.objects WHERE ([type] = 'P' AND name = 'Gate_setup'))
	DROP PROCEDURE Gate_setup

IF EXISTS (SELECT * FROM sys.objects WHERE ([type] = 'P' AND name = 'Passenger_gate'))
	DROP PROCEDURE Passenger_gate

IF EXISTS (SELECT * FROM sys.objects WHERE ([type] = 'P' AND name = 'Registration_desk_setup'))
	DROP PROCEDURE Registration_desk_setup

IF EXISTS (SELECT * FROM sys.objects WHERE ([type] = 'P' AND name = 'Passenger_registration'))
	DROP PROCEDURE Passenger_registration

IF EXISTS (SELECT * FROM sys.objects WHERE ([type] = 'P' AND name = 'Reg_begin'))
	DROP PROCEDURE Reg_begin

IF EXISTS (SELECT * FROM sys.objects WHERE ([type] = 'P' AND name = 'Reg_end'))
	DROP PROCEDURE Reg_end

IF EXISTS (SELECT * FROM sys.objects WHERE ([type] = 'P' AND name = 'Boarding_begin'))
	DROP PROCEDURE Boarding_begin

IF EXISTS (SELECT * FROM sys.objects WHERE ([type] = 'P' AND name = 'Boarding_end'))
	DROP PROCEDURE Boarding_end

IF EXISTS (SELECT * FROM sys.objects WHERE ([type] = 'P' AND name = 'Departure'))
	DROP PROCEDURE Departure

IF EXISTS (SELECT * FROM sys.objects WHERE ([type] = 'P' AND name = 'Arrival'))
	DROP PROCEDURE Arrival

IF EXISTS (SELECT * FROM sys.objects WHERE ([type] = 'P' AND name = 'Planned'))
	DROP PROCEDURE Planned

GO

/*��������� ���������� ������*/

/*���������� �����*/
CREATE PROCEDURE Statement_1
	@air_company INT,
	@d_date DATE,
	@d_time TIME(7),
	@a_time TIME(7),
	@flight_name VARCHAR(50),
	@airplane INT,
	@model INT,
	@destination CHAR(3),
	@status varchar(50) OUTPUT
AS
BEGIN
	IF NOT EXISTS (SELECT Flight_ID FROM Flight WHERE (Flight.Flight_name = @flight_name AND Flight.Departure_date = @d_date))
	BEGIN
		IF NOT EXISTS (SELECT Airplane_number FROM Airplane WHERE Airplane.Airplane_number = @airplane)
		BEGIN
			INSERT INTO Airplane (Airplane_number, Model_ID)
				VALUES (@airplane, @model);
		END;
		INSERT INTO Flight (Air_company_ID, Departure_date, Departure_time_planned, Arrival_time_planned, Flight_name, Airplane_ID, Destination_airport)
			VALUES (@air_company, @d_date, @d_time, @a_time, @flight_name, (SELECT Airplane_ID FROM Airplane WHERE Airplane_number = @airplane), @destination);
		INSERT INTO Flight_fact (Flight_ID, Status_ID)
			VALUES (IDENT_CURRENT('Flight'), (SELECT Status_ID FROM Flight_status WHERE [Description] = '������������'));
		SET @status = CONCAT('���� ������� ��������������� � ID = ', CAST(IDENT_CURRENT('Flight') AS varchar(50)));
	END
	ELSE
	BEGIN
		SET @status = '������: ���� ��� ����������';
	END;
RETURN
END;
GO

/*���������� ���� �������*/
CREATE PROCEDURE Statement_2
	@flight INT,
	@seat VARCHAR(50),
	@class TINYINT
AS
BEGIN
	INSERT INTO Seats (Seat_name, Class_ID, Flight_ID) VALUES (@seat, @class, @flight)
END;
GO

/*���������� ���� �������� ������*/
CREATE PROCEDURE Statement_3
	@flight INT,
	@surname VARCHAR(50),
	@given_name VARCHAR(50),
	@parentage VARCHAR(50),
	@birth DATE,
	@passport VARCHAR(50),
	@class TINYINT,
	@nationality TINYINT,
	@status varchar(50) OUTPUT
AS
BEGIN
	IF NOT EXISTS (SELECT Passenger_ID FROM Passenger WHERE (Passenger.Passport = @passport AND Passenger.Flight_ID = @flight))
	BEGIN
		INSERT INTO Passenger (Flight_ID, Second_name, First_name, Middle_name, Birthdate, Passport, Class_ID, Citizenship, Status_ID)
			VALUES (@flight, @surname, @given_name, @parentage, @birth, @passport, @class, @nationality,
			 (SELECT Status_ID
																						 FROM Passenger_status
																	  WHERE Passenger_status.[Description] = '������ �����'))
		SET @status = '�������� ������� ��������������� �� ������ ����';
	END
	ELSE
	BEGIN
		SET @status = '������: �������� ��� ��������������� �� ������ ����';
	END
END;
GO

/*����������� ������*/
CREATE PROCEDURE Luggage_reg
	@passenger INT,
	@weight REAL,
	@pass_status varchar(50) OUTPUT,
	@luggage_status varchar(50) OUTPUT
AS
BEGIN
IF (SELECT Status_ID FROM Flight_fact WHERE Flight_fact.Flight_ID = 
(SELECT Flight_ID FROM Passenger WHERE Passenger_ID = @passenger)) =
	(SELECT Status_ID FROM Flight_status WHERE Flight_status.[Description] = '��� �����������')
	BEGIN
		INSERT INTO Luggage (Passenger_ID, [Weight]) VALUES (@passenger, @weight);
		IF @weight < (SELECT Overweight FROM Flight WHERE (Flight.Flight_ID = (SELECT Flight_ID FROM Passenger WHERE Passenger_ID = @passenger)))
		BEGIN
			UPDATE Passenger
			SET Passenger.Overweight = 0,
				Passenger.Status_ID = (SELECT Status_ID
										FROM Passenger_status
										WHERE Passenger_status.[Description] = '���������������')
			WHERE Passenger.Passenger_ID = @passenger;
			SET @pass_status = '�������� ������� ���������������';
			SET @luggage_status = '����� ������� ���������������';
		END;
		ELSE
		BEGIN
			UPDATE Passenger
			SET Passenger.Overweight = 1
			WHERE Passenger.Passenger_ID = @passenger;
			SET @pass_status = '��������� ���������� �������� �������';
			SET @luggage_status = '�������';
		END;
	END;
END;
GO

/*��������� ������� ��������� ��� ������� �����*/
CREATE PROCEDURE Overweight_setup
	@flight INT,
	@weight REAL
AS
BEGIN
	UPDATE Flight
	SET Overweight = @weight
	WHERE Flight.Flight_ID = @flight;
END;
GO

/*������������ ����� ������� �����*/
CREATE PROCEDURE Gate_setup
	@flight INT,
	@gate TINYINT
AS
BEGIN
	UPDATE Gate
	SET Flight_ID = @flight
	WHERE Gate.Gate_ID = @gate;
END;
GO

/*������������ ����� ������� ���������*/
CREATE PROCEDURE Passenger_gate
	@passenger INT,
	@gate TINYINT
AS
BEGIN
	UPDATE Passenger
	SET Gate_ID = @gate
	WHERE Passenger.Passenger_ID = @passenger;
END;
GO

/*������������ ������ ����������� ������� ���������*/
CREATE PROCEDURE Registration_desk_setup
	@flight INT,
	@desk INT
AS
BEGIN
	UPDATE Registration_desk
	SET Flight_ID = @flight
	WHERE Registration_desk.Desk_ID = @desk;
END;
GO

/*����������� ��������� �� ����*/
CREATE PROCEDURE Passenger_registration
	@passenger INT,
	@seat INT,
	@status varchar(50) OUTPUT
AS
BEGIN
IF (SELECT Status_ID FROM Flight_fact WHERE Flight_fact.Flight_ID = (SELECT Flight_ID FROM Passenger WHERE Passenger_ID = @passenger)) =
	(SELECT Status_ID FROM Flight_status WHERE Flight_status.[Description] = '��� �����������')
	BEGIN
		IF (SELECT Busy FROM Seats WHERE Seats.Seat_ID = @seat) IS NULL
		BEGIN
			UPDATE Passenger
			SET Seat_ID = @seat,
				Status_ID = (SELECT Status_ID
							 FROM Passenger_status
							 WHERE Passenger_status.[Description] = '�������� �����')
			WHERE Passenger.Passenger_ID = @passenger;
			SET @status = '����� ������� ��������';
			UPDATE Seats
			SET Busy = 1
			WHERE Seats.Seat_ID = @seat
		END
		ELSE
		BEGIN
			SET @status = '������: ����� ��� ������';
		END;
	END;
END;
GO

/*���������������*/
CREATE PROCEDURE Planned
	@flight INT,
	@reg_begin TIME(0),
	@reg_end TIME(0),
	@b_begin TIME(0),
	@b_end TIME(0)
AS
BEGIN
	UPDATE Flight
	SET Reg_begin_planned = @reg_begin,
		Reg_end_planned = @reg_end,
		Boarding_begin_planned = @b_begin,
		Boarding_end_planned = @b_end
	WHERE Flight_ID = @flight;
END;
GO

/*������ �����������*/
CREATE PROCEDURE Reg_begin
	@flight INT,
	@reg_begin TIME(7)
AS
BEGIN
	UPDATE Flight_fact
	SET Reg_begin_fact = @reg_begin,
		Status_ID = (SELECT Status_ID
					 FROM Flight_status
					 WHERE Flight_status.[Description] = '��� �����������')
	WHERE Flight_ID = @flight;
END;
GO

/*����� �����������*/
CREATE PROCEDURE Reg_end
	@flight INT,
	@reg_end TIME(7)
AS
BEGIN
	UPDATE Flight_fact
	SET Reg_end_fact = @reg_end,
		Status_ID = (SELECT Status_ID
					 FROM Flight_status
					 WHERE Flight_status.[Description] = '����������� ���������')
	WHERE Flight_ID = @flight;
END;
GO

/*������ �������*/
CREATE PROCEDURE Boarding_begin
	@flight INT,
	@b_begin TIME(0)
AS
BEGIN
	UPDATE Flight_fact
	SET Boarding_begin_fact = @b_begin,
		Status_ID = (SELECT Status_ID
					 FROM Flight_status
					 WHERE Flight_status.[Description] = '��� �������')
	WHERE Flight_ID = @flight;
END;
GO

/*����� �������*/
CREATE PROCEDURE Boarding_end
	@flight INT,
	@b_end TIME(0),
	@f_call TIME(0)
AS
BEGIN
	UPDATE Flight_fact
	SET Boarding_end_fact = @b_end,
		Final_call = @f_call,
		Status_ID = (SELECT Status_ID
					 FROM Flight_status
					 WHERE Flight_status.[Description] = '������� ���������')
	WHERE Flight_ID = @flight;
END;
GO

/*�����*/
CREATE PROCEDURE Departure
	@flight INT,
	@d_time TIME(0)
AS
BEGIN
	UPDATE Flight_fact
	SET Departure_time_fact = @d_time,
		Status_ID = (SELECT Status_ID
					 FROM Flight_status
					 WHERE Flight_status.[Description] = '�������')
	WHERE Flight_ID = @flight;
END;
GO

/*�����*/
CREATE PROCEDURE Arrival
	@flight INT,
	@a_time TIME(0)
AS
BEGIN
	UPDATE Flight_fact
	SET Arrival_time_fact = @a_time,
		Status_ID = (SELECT Status_ID
					 FROM Flight_status
					 WHERE Flight_status.[Description] = '�������� �������')
	WHERE Flight_ID = @flight;
END;
GO

/*
/*���������� � �������� �����*/
CREATE PROCEDURE Statement_4_1
	@flight INT,
	@d_date DATE,
	@d_time TIME(7)
AS
BEGIN
	UPDATE Flight
	SET Departure_date = @d_date,
		Departure_time_planned = @d_time
	WHERE Flight.Flight_ID = @flight,
	UPDATE Flight_fact
	SET Status_ID = 8
	WHERE Flight_fact.Flight_ID = @flight;
END;

*/
GO

/*
/*���������� � ������ �������*/
CREATE PROCEDURE Statement_4_2
	@flight INT,
	@airplane INT,
	@model INT,
	@seat VARCHAR(50),
	@class TINYINT
AS
BEGIN
	IF ((SELECT Airplane_ID FROM Flight WHERE Flight.Flight_ID = @flight) != @airplane)
	BEGIN
		UPDATE Flight
		SET Airplane_ID = @airplane
	END
	IF NOT EXISTS (SELECT Airplane_ID FROM Airplane WHERE Airplane.Airplane_ID = @airplane)
	BEGIN
		INSERT INTO Airplane (Airplane_ID, Model_ID) VALUES (@airplane, @model)
	END
	IF ((SELECT Status_ID FROM Flight_fact WHERE Flight_fact.Flight_ID = @flight) != 7)
	BEGIN
		UPDATE Flight_fact
		SET Status_ID = 9
		WHERE Flight_fact.Flight_ID = @flight;
	END
END;
*/
GO