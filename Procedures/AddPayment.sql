create procedure AddPayment(@Order_ID int,
                            @PayDate datetime,
                            @Percentage float)
as
    begin
        Declare @amount float = (select sum(Od.UnitPrice*od.Quantity)
                                 from Orders O join OrderDetails OD on O.OrderID = OD.OrderID
                                 where O.OrderID = @Order_ID) * @Percentage
        DECLARE @PaymentID int = (select count(*) from Payments) + 1
        insert into Payments values (@PaymentID, @Order_ID, @amount, null, @PayDate)
    end