alter procedure  AddOrderToReservation(@OrderID int,
                                        @ClientID int,
                                        @ReservationID int,
                                        @BillID int = null,
                                        @OTDiscount int = null)
as
    begin
        set nocount on
        begin try

            Declare @AppliedDiscount float = 0;

            if (@ClientID is not null and (select ClientID from Clients where ClientID = @ClientID) is null)
                begin
                    ;throw 50001, N'The client with this ID does not exist in the database',1
                end

            if (not exists(select * from Reservations where ReservationID = @ReservationID))
                begin
                    ;throw 50001, N'There is no reservation with this ID in the database', 1
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
                set @AppliedDiscount = isnull((select max(Value) from OneTimeDiscounts where OTDiscountID = @OTDiscount
                                                                             and ClientID = @ClientID
                                                                             and used = 0),0)
                Exec ChangeDiscountStatus @OTDiscount

            if (select PermamentDiscountLVL from IndividualClients where ClientID = @ClientID) = 1
                begin
                    if (@AppliedDiscount < (select max(R1) from Constants))
                        set @AppliedDiscount = (select max(R1) from Constants)
                end

            insert into Orders(OrderID,ClientID, ReservationID, BillID, OrderTime, TakeawayTime, AppliedDiscount, OTDiscountID)
            values (@OrderID, @ClientID, @ReservationID, @BillID, getdate(), null, @AppliedDiscount, @OTDiscount)

        end try
        begin catch
            Declare @msg NVARCHAR(2048) = N'Procedure AddOrderToReservation error: '+ Error_Message();
            ;throw 50001, @msg, 1
        end catch
    end