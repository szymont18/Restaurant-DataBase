create function GetOrderValue(@OrderID as int)
returns decimal(18,2)
as
    begin
    Declare @sum decimal(18,2) = (select sum(UnitPrice * OrderDetails.Quantity)*(1-max(O.AppliedDiscount)) from OrderDetails
                                                                 join Orders O on O.OrderID = OrderDetails.OrderID
                                                                 where OrderDetails.OrderID = @OrderID)
    return isnull(@sum, 0)
    end