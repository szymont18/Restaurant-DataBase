-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION ClientOrdersHistory
(
	-- Add the parameters for the function here
	@ClientID int
)
RETURNS TABLE
AS
RETURN
(
	-- Add the SELECT statement with parameter references here
	select * FROM ClientToMeal WHERE ClientID = @ClientID
)
go

