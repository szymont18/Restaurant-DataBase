create view OrderReportWeek as
    select C.ClientID, 0 'isCompanyClient',year(O.OrderTime) as 'Year',
           DATEPART(week,O.OrderTime) 'Week', isnull(sum(O.OrderID),0) as 'OrdersSum',
           isnull(sum(OD.UnitPrice * OD.Quantity) * (1 - max(O.AppliedDiscount)),0) 'TotalMoneySpend'
    from Clients C
    join IndividualClients IC on C.ClientID = IC.ClientID
    join Orders O on C.ClientID = O.ClientID
    join OrderDetails OD on O.OrderID = OD.OrderID
    group by C.ClientID, year(O.OrderTime) ,DATEPART(week, O.OrderTime)
    union
    select C.ClientID, 1 'isCompanyClient',year(O.OrderTime) as 'Year', DATEPART(week,O.OrderTime) 'Month', isnull(sum(O.OrderID),0) as 'OrdersSum',
           isnull(sum(OD.UnitPrice * OD.Quantity) * (1 - max(O.AppliedDiscount)),0) 'TotalMoneySpend'
    from Clients C
    join CompanyClients CC on C.ClientID = CC.ClientID
    join Orders O on C.ClientID = O.ClientID
    join OrderDetails OD on O.OrderID = OD.OrderID
    group by C.ClientID,year(O.OrderTime), DATEPART(week, O.OrderTime)