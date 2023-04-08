create view BillReportIndividual as
    select B.BillID, B.IssueDate, B.PayAmount, IC.ClientID, IC.FirstName, IC.LastName, IC.Email, IC.PhoneNumber
    from Bills B
    join Orders O on B.BillID = O.BillID
    join Clients C on O.ClientID = C.ClientID
    join IndividualClients IC on C.ClientID = IC.ClientID


