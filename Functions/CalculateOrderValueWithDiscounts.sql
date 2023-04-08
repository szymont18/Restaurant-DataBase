-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[CalculateOrderValueWithDiscounts]
(
	-- Add the parameters for the function here
	@OrderID int
)
RETURNS decimal(18,2)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @ReturnValue as decimal(18,2)

	-- Add the T-SQL statements to compute the return value here
	SET @ReturnValue = (
						SELECT sum(Quantity*UnitPrice)*(1-O.AppliedDiscount)
						FROM dbo.Orders O
							join dbo.OrderDetails OD on O.OrderID = OD.OrderID
						where O.OrderID = @OrderID
						group by O.OrderID, O.AppliedDiscount
						)

	-- Return the result of the function
	RETURN @ReturnValue

END
go

