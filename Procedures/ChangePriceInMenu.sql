CREATE PROCEDURE [dbo].[ChangePriceInMenu]
	-- Add the parameters for the stored procedure here
	@MenuIDArg int,
	@ProductIDArg int,
	@NewPrice decimal(18,2)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE MenuDetails
	SET UnitPrice = @NewPrice
	WHERE MenuID = @MenuIDArg and ProductID = @ProductIDArg;
END
go

