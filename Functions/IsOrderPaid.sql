-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
    CREATE FUNCTION [dbo].[IsOrderPaid]
    (
        -- Add the parameters for the function here
        @OrderID int
    )
    RETURNS bit
    AS
    BEGIN
        -- Declare the return variable here
        DECLARE @PaySum decimal(18,2) = (select sum(P.Amount) from Payments P where OrderID = @OrderID group by OrderID)
        DECLARE @OrderValue decimal(18,2) = (select sum(OD.Quantity*OD.UnitPrice)*(1-O.AppliedDiscount) from Orders O join OrderDetails OD on O.OrderID = OD.OrderID where O.OrderID = @OrderID group by O.OrderID, O.AppliedDiscount)

        -- Add the T-SQL statements to compute the return value here


        -- Return the result of the function
        RETURN convert(Bit, Case When @OrderValue = @PaySum Then 1 Else 0 End)

    END
go

