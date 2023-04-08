alter procedure AddToMenu @MenuID int, @ProductID int, @UnitPrice int
as
begin
begin try
    declare @active bit
    SELECT @active = active FROM Products where ProductID = @ProductID
    if (@active = 0)
        begin
            throw 50001, 'Produkt is not active',1
        end
    insert into MenuDetails (MenuID, ProductID, UnitPrice)
    values (@MenuID, @ProductID, @UnitPrice)
end try
begin catch

end catch
end

