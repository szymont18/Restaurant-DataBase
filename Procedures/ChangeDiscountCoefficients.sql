CREATE PROCEDURE [dbo].[ChangeDiscountCoefficients]
	-- Add the parameters for the stored procedure here
	@Z1 int,
	@K1 decimal(18,2),
	@R1 float,
	@K2 decimal(18,2),
	@R2 float,
	@D1 int,
	@WZ decimal(18,2),
	@WK int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE Constants
	SET Z1 = @Z1,
		K1 = @K1,
		R1 = @R1,
		K2 = @K2,
		R2 = @R2,
		D1 = @D1,
		WZ = @WZ,
		WK = @WK
END
go

