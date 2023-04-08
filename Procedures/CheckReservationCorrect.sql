alter procedure CheckReservationCorrect(@ReservationID int)
as
    begin


        Declare @MainOrderID int = (select O.OrderID from Reservations R join Orders O on R.ReservationID = O.ReservationID
                                           where R.ReservationID = @ReservationID and R.ClientID = O.ClientID)

        Declare @TotalValue float = dbo.CalculateOrderValueWithDiscounts(@MainOrderID)
        DECLARE @WZ decimal(18,2) = (select max(WZ) from Constants)

        --Check if Products Amount bigger than WZ
        if (@TotalValue < @WZ)
            begin
                Exec DeleteIncorrectReservation @ReservationID
            end
        else
        begin
            Declare @ClientID int = (select ClientID from Reservations where ReservationID = @ReservationID)
            Declare @OrderCnt int = dbo.GetOrdersCnt (@ClientID) - 1 --Without this order
            Declare @WK int = (select max(WK) from Constants)

    --         Check if number of previous Orders bigger than WK
            if (@OrderCnt < @WK)
            begin
                Exec DeleteIncorrectReservation @ReservationID
            end

            else
            begin
                update Reservations
                set Accepted = 0
                where ReservationID = @ReservationID
            end
        end
    end