create view ActualReservation as
    select *
    from Reservations
    where DATEPART(day, StartTime) = DATEPART(day, getdate())