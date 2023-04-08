-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ChangePriceInProducts]
	-- Add the parameters for the stored procedure here
	@ProductID int,
	@NewPrice decimal(18,2)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE Products
	set UnitPrice = @NewPrice
	where ProductID = @ProductID
END
go

