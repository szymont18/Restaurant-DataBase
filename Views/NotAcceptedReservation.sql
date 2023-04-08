create view NotAcceptedReservation as
    select ReservationID, ClientID, StartTime, EndTime, IsCompanyReservation, NumberOfPeople
    from Reservations
    where Accepted = 0