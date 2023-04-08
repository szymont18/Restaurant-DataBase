create procedure ChangeDiscountStatus(@OTDiscountID as int)
as
    begin
        set nocount on
        update OneTimeDiscounts
        set used = 1
        where OTDiscountID = @OTDiscountID
    end