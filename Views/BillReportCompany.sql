create view BillReportCompany as
    select B.BillID, B.IssueDate, B.PayAmount,
           CC.ClientID, CC.CompanyName, CC.NIP, CC.Email, CC.PhoneNumber,
           CC.PostalCode, CC.City, CC.Street
    from Bills B
    join Orders O on B.BillID = O.BillID
    join Clients C on O.ClientID = C.ClientID
    join CompanyClients CC on C.ClientID = CC.ClientID