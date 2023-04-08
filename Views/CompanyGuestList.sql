create view CompanyGuestList as
    select CC.ClientID,CC.CompanyName, R2.StartTime ,RGL.FirstName, RGL.LastName
    from ReservationGuestList RGL
    join Reservations R2 on R2.ReservationID = RGL.ReservationID
    join Clients C on C.ClientID = R2.ClientID
    join CompanyClients CC on C.ClientID = CC.ClientID