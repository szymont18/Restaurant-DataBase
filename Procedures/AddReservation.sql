-- =============================================
-- Author:		<Author,Name, Szymon Twardosz>
-- Create date: <Create Date,, 11.01.2023>
-- Description:	<Description,,
-- The procedure allows you to add a reservation. It adds a tuple to the Reservations table with the
-- appropriate user-supplied arguments. Then it sets the Accepted flag to Null. For now, we do not know
-- anything about the tables that guests will occupy and their orders, so the database is unable to determine
-- whether the reservation is legal according to the rules prevailing in the restaurant. This indicator will be updated
-- after the customer completes the order>
-- ===========================================

alter procedure AddReservation(@ReservationID as int,
                                @ClientID as int,
                                @StartTime as datetime,
                                @EstimatedEndTime as datetime,
                                @NumberOfPeople as int)
as
    begin
        set nocount on
        begin try
            if ((select ClientID from Clients where ClientID = @ClientID) is null)
                begin
                    ;throw 50001, N'The client with this ID does not exist in the database',1
                end

            if (@EstimatedEndTime < @StartTime)
            begin
                ;throw 50001, N'Reservation ends earlier than it starts',1
            end

            if (@NumberOfPeople < 2)
            begin
                ;throw 50001, N'The number of guests should be bigger than 1', 1
            end

--          Check if Client is individual or company
        DECLARE @IsCompanyFlag bit;
        if exists(select * from CompanyClients where ClientID = @ClientID) set @IsCompanyFlag = 1;
        else set @IsCompanyFlag = 0;

--         EstimaedEndTime elongate by 1 hour
        if (@ReservationID is not null)
            begin
        insert into Reservations(ReservationID, ClientID,StartTime, EndTime, IsCompanyReservation, NumberOfPeople, Accepted)
        values (@ReservationID, @ClientID, @StartTime, DATEADD(hour,1,@EstimatedEndTime),
                                         @IsCompanyFlag, @NumberOfPeople, null)
            end

        end try

        begin catch
            Declare @msg NVARCHAR(2048) = N'Procedure error: '+ Error_Message();
            ;throw 50001, @msg, 1
        end catch
    end