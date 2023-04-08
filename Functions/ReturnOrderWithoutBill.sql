-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	The function adds all unbilled orders of a client to a bill and returns the list of those orders
-- =============================================
CREATE FUNCTION [dbo].[ReturnOrdersWithoutBill]
(
	-- Add the parameters for the function here
	@ClientID int
)
RETURNS
@OrdersWithNoBill TABLE
(
	-- Add the column definitions for the TABLE variable here
	OrderID int
)
AS
BEGIN
	-- Fill the table variable with the rows for your result set

	insert into @OrdersWithNoBill
	select OrderID
	from Orders
	where ClientID = @ClientID and BillID = null

	return
END
go

