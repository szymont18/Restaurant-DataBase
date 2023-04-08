CREATE TRIGGER DeleteDiscounts
 ON Orders
 AFTER DELETE
 AS
BEGIN
 DECLARE @Discounts int
 DECLARE @OrderID int
 SELECT @OrderID = OrderID FROM deleted
 SELECT @Discounts = count(*) FROM OneTimeDiscounts WHERE OrderID =
@OrderID
 IF (@Discounts > 0)
 BEGIN
 DELETE FROM OneTimeDiscounts WHERE OrderID=@OrderID
 END
END
go
