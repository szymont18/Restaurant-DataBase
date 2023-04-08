-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION OrderPaySum
(
	-- Add the parameters for the function here
	@OrderID int
)
RETURNS decimal(18,2)
AS
BEGIN
	RETURN (select sum(P.Amount) from Payments P where OrderID = @OrderID group by OrderID)

END
go

