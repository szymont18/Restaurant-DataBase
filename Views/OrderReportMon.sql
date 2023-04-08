create view OrderReportMon as
    select C.ClientID, 0 'isCompanyClient',year(O.OrderTime) 'Year',
           month(O.OrderTime) 'Month', isnull(sum(O.OrderID),0) as 'OrdersSum',
           isnull(sum(OD.UnitPrice * OD.Quantity) * (1 - max(O.AppliedDiscount)),0) 'TotalMoneySpend'
    from Clients C
    join IndividualClients IC on C.ClientID = IC.ClientID
    join Orders O on C.ClientID = O.ClientID
    join OrderDetails OD on O.OrderID = OD.OrderID
    group by C.ClientID,year(O.OrderTime), month(O.OrderTime)
    union
    select C.ClientID, 1 'isCompanyClient',year(O.OrderTime) 'Year',
           month(O.OrderTime) 'Month', isnull(sum(O.OrderID),0) as 'OrdersSum',
           isnull(sum(OD.UnitPrice * OD.Quantity) * (1 - max(O.AppliedDiscount)),0) 'TotalMoneySpend'
    from Clients C
    join CompanyClients CC on C.ClientID = CC.ClientID
    join Orders O on C.ClientID = O.ClientID
    join OrderDetails OD on O.OrderID = OD.OrderID
    group by C.ClientID, year(O.OrderTime), month(O.OrderTime)