-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION ViewOrdersOfABill
(
	-- Add the parameters for the function here
	@BillID int
)
RETURNS TABLE
AS
RETURN
(
	-- Add the SELECT statement with parameter references here
	select * from orders where BillID = @BillID
)
go

