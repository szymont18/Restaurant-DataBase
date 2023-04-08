create view TakeAwayOrders as
    select O.OrderID, ClientID, OrderTime, TakeawayTime, AppliedDiscount from Orders O
    where O.TakeawayTime is not null and getdate() < O.TakeawayTime