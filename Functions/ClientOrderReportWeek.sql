-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION ClientOrderReportWeek
(
	-- Add the parameters for the function here
	@ClientID int
)
RETURNS TABLE
AS
RETURN
(
	-- Add the SELECT statement with parameter references here
	SELECT [ClientID]
      ,[isCompanyClient]
      ,[Year]
      ,[Week]
      ,[OrdersSum]
      ,[TotalMoneySpend]
	FROM [u_twardosz].[dbo].[OrderReportWeek]
	where ClientID = @ClientID
)
go

