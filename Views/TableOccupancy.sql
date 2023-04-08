alter view TableOccupancy as
    select T.TableID, T.Size, isnull(R2.StartTime, '1900-01-12 10:30') 'StartTime', isnull(R2.EndTime, '1900-01-12 10:30') 'EndTime'
    from Tables T
    left join ReservationDetails RD on T.TableID = RD.TableID
    left join Reservations R2 on R2.ReservationID = RD.ReservationID
