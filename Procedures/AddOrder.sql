alter procedure AddOrder(@OrderID as int,
                          @ClientID as int = null,
                          @GuestNumber as int = null,
                          @TakeAwayTime as datetime = null,
                          @OTDiscount as int = null )
as
    begin
        Declare @ActualDiscount as float = 0;
    begin try
        if (@ClientID is not null and (select ClientID from Clients where ClientID = @ClientID) is null)
                begin
                    ;throw 50001, N'The client with this ID does not exist in the database',1
                end

        if (@TakeAwayTime is not null and @TakeAwayTime < getdate())
            begin
                ;throw 50001, N'the customer cannot set the pick-up date to a date in the past', 1
            end

        if (@GuestNumber is not null and @GuestNumber <= 0)
            begin
                ;throw 50001, N'The number of guests should be bigger than 0', 1
            end

        if (@OTDiscount is not null)
            begin
                if not exists(select * from OneTimeDiscounts where OTDiscountID = @OTDiscount
                                                                                    and ClientID = @ClientID
                                                                                    and used = 0)
                begin
                   ;throw 50001, N'Client does not have discount with this ID', 1
                end

                if (getdate() > (select ExpireDate from OneTimeDiscounts where OTDiscountID = @OTDiscount))
                begin
                    ;throw 50001, N'Client discount expire',1
                end

            end


        else
            begin
                set @ActualDiscount = isnull((select Value from DiscountInfo where OTDiscountID = @OTDiscount),0)
                Exec ChangeDiscountStatus @OTDiscountID = @OTDiscount
            end

         if (select PermamentDiscountLVL from IndividualClients where ClientID = @ClientID) = 1
        begin
            if (@ActualDiscount < (select max(R1) from Constants))
                set @ActualDiscount = (select max(R1) from Constants)
        end

    --     TakeAwayTime is not null means that client will not eat in restaurant. Therefore it does not need a free table
    if (@TakeAwayTime is not null)
        begin
            insert into Orders(OrderID,ClientID, ReservationID, BillID, OrderTime, TakeawayTime, AppliedDiscount, OTDiscountID)
            values (@OrderID, @ClientID, null, null, getdate(), @TakeAwayTime,@ActualDiscount, @OTDiscount)
        end

--     DataBase have to reservate table for the guest
    else
        begin

            Declare @StartTime datetime = getdate()
            Declare @EndTime datetime = dateadd(hour, 1, @StartTime)
            Declare @ReservationID int = (select max(ReservationID) + 1 from Reservations) -- Can be done better

            Exec AddReservation @ClientID = @ClientID, @StartTime = @StartTime, @NumberOfPeople = @GuestNumber,
                @ReservationID = @ReservationID, @EstimatedEndTime = @EndTime

            Update Reservations
            set Accepted = 1
            where ReservationID = @ReservationID

            insert into Orders(OrderID,ClientID, ReservationID, BillID, OrderTime, TakeawayTime, AppliedDiscount, OTDiscountID)
            values (@OrderID, @ClientID, @ReservationID, null, getdate(), @TakeAwayTime,@ActualDiscount, @OTDiscount)

        end
    end try
    begin catch
         Declare @msg NVARCHAR(2048) = N'Procedure error: '+ Error_Message();
            ;throw 50001, @msg, 1
    end catch
    end
