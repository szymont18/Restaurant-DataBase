create view ProductInfoWeek as
    select P.ProductID, P.ProductName,year(O.OrderTime) 'Year', DATEPART(week,O.OrderTime) 'Week',
           sum(OD.Quantity) as 'OrdersSum',
           sum(OD.UnitPrice * od.Quantity) * (1 - max(O.AppliedDiscount)) as 'Total income'
    from Products P
    left join OrderDetails OD on P.ProductID = OD.ProductID
    left join Orders O on O.OrderID = OD.OrderID
    group by P.ProductID, P.ProductName,year(O.OrderTime), DATEPART(week, O.OrderTime)