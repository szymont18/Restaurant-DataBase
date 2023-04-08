create view ReservationReportMon as
    select C.ClientID, year(R.StartTime) 'Year', month(R.StartTime) as 'Month', count(R.ReservationID) as 'NumberOfReservations'
    from Reservations R
    join Clients C on C.ClientID = R.ClientID
    group by C.ClientID, year(R.StartTime), month(R.StartTime)