create function FindReservationIDToOrder(@OrderID as int)
returns int
as
    begin
        Declare @ReservationID int = (select ReservationID from Orders where OrderID = @OrderID)
        return @ReservationID
    end