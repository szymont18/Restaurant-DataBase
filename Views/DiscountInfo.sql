alter view DiscountInfo as
    select IC.ClientID, IC.FirstName, IC.LastName, OTD.OTDiscountID,OTD.ApplyDate, OTD.Value, OTD.used
    from IndividualClients IC
    join OneTimeDiscounts OTD on IC.ClientID = OTD.ClientID