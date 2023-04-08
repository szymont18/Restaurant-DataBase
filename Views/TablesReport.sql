create view TablesReport as
    select T.TableID, T.Size, isnull(count(RD.ReservationID),0) 'TableOccupancy'
    from Tables T
    left join ReservationDetails RD on T.TableID = RD.TableID
    group by T.TableID, T.Size