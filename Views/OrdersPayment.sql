create view OrdersPayment as
    select O.OrderID,O.ClientID,O.OrderTime, isnull(P.Amount, 0) as 'PaidMoney',
           cast(isnull((select sum(od.Quantity * od.UnitPrice) from OrderDetails od
                              where od.OrderID = O.OrderID),0) * (1 - O.AppliedDiscount) - isnull(P.Amount,0) as DECIMAL(10, 2)) as 'MoneyToPay'
    from Orders O
    join Payments P on O.OrderID = P.OrderID
    where P.Amount < isnull((select sum(od.Quantity * od.UnitPrice) from OrderDetails od
                              where od.OrderID = O.OrderID),0) * (1 - O.AppliedDiscount)