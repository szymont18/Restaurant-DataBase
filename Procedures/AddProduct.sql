CREATE PROCEDURE [dbo].[AddProduct]
	-- Add the parameters for the stored procedure here
	@CategoryID int,
	@ProductName varchar(64),
	@IsImportedFlag bit,
	@UnitPrice decimal(18,2),
	@ProductDescription varchar(255),
	@Active bit
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO Products
	values (
		@CategoryID,
		@ProductName,
		@IsImportedFlag,
		@UnitPrice,
		@ProductDescription,
		@Active
	)
END
go

