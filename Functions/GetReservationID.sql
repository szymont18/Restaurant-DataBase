alter function GetReservationID()
returns int
as
    begin
        Declare @MaxReservationID int = (select max(ReservationID) from Reservations)
        return @MaxReservationID
    end