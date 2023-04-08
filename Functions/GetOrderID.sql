alter function GetOrderID()
returns int
as
    begin
        Declare @MaxOrderID int = (select max(OrderID) from Orders)
        return @MaxOrderID
    end