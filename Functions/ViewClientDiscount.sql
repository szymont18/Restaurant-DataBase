-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION ViewClientDicounts
(
	-- Add the parameters for the function here
	@ClientID int
)
RETURNS TABLE
AS
RETURN
(
	-- Add the SELECT statement with parameter references here
	SELECT *
	from OneTimeDiscounts
	where ClientID = @ClientID
)
go

