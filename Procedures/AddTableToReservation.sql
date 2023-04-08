alter procedure AddTableToReservation(@ReservationID as int,
                                       @TableID as int)
as
    begin
        set nocount on
        begin try
            if (not exists(select * from Reservations where ReservationID = @ReservationID))
                begin
                    ;throw 50001, N'There is no reservation with this ID in the database',1
                end

            if (not exists(select * from Tables where TableID = @TableID))
                begin
                    ;throw 50001, N'There is no table with this ID in the database',1
                end
            Declare @StartDate datetime = (select StartTime from Reservations where ReservationID = @ReservationID)
            Declare @EndTime datetime = (select EndTime from Reservations where ReservationID = @ReservationID)
            if dbo.IsTableFree(@TableID, @StartDate, @EndTime) = 0
                begin
                    ;throw 50001, N'This table is already reserved',1
                end

        insert into ReservationDetails(ReservationID, TableID)
        values (@ReservationID, @TableID)

        end try
        begin catch
             Declare @msg NVARCHAR(2048) = N'Procedure error: '+ Error_Message();
            ;throw 50001, @msg, 1
        end catch

    end