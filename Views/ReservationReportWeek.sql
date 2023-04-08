alter view ReservationReportWeek as
    select C.ClientID, year(R.StartTime) 'Year', datepart(week, R.StartTime) as 'Week', count(R.ReservationID) as 'NumberOfReservations'
    from Reservations R
    join Clients C on C.ClientID = R.ClientID
    group by C.ClientID, year(R.StartTime), datepart(week, R.StartTime)