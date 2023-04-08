-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION ViewBillsOfAClient
(
	-- Add the parameters for the function here
	@ClientID int
)
RETURNS TABLE
AS
RETURN
(
	-- Add the SELECT statement with parameter references here
	SELECT B.BillID, B.IsCollective, B.IssueDate from Bills B join Orders O on O.BillID = B.BillID  where O.ClientID = @ClientID group by B.BillID, B.IsCollective, B.IssueDate
)
go

