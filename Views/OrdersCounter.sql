alter view OrdersCounter
as
    select O.ClientID, isnull(count(O.OrderID),0) as 'OrderCounter' from Clients C
    left join Orders O on C.ClientID = O.ClientID
    group by O.ClientID