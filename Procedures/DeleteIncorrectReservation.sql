alter procedure DeleteIncorrectReservation(@ReservationID int)
as
begin

    set nocount on
    print N'Deleting Reservation because it is incorrect';

    delete from OrderDetails
    where OrderID in (select Orders.OrderID from Orders where ReservationID = @ReservationID)

    delete from Orders
    where ReservationID = @ReservationID

    delete from ReservationDetails
    where ReservationID = @ReservationID

    delete from Reservations
    where ReservationID = @ReservationID


end