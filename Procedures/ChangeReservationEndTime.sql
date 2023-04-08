-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ModifyReservationEndtime]
	-- Add the parameters for the stored procedure here
	@ReservationID int,
	@NewEndtime datetime
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE Reservations
	set EndTime = @NewEndtime
	where ReservationID = @ReservationID
END
go

