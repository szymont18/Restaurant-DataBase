CREATE FUNCTION ViewOrderOfPayment
(
 -- Add the parameters for the function here
 @PaymentID int
)
RETURNS TABLE
AS
RETURN
(
 -- Add the SELECT statement with parameter references here
 SELECT * from Orders where OrderID = (select OrderID from Payments where
PaymentID = @PaymendID)
)