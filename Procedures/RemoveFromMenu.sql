CREATE procedure RemoveFromMenu @MenuID int, @ProductID int
as
begin try
    if not EXISTS(SELECT MenuID FROM MenuDetails WHERE MenuID = @MenuID and ProductID = @ProductID)
        BEGIN
            throw 50001, 'Menu or products does not exists in database', 1

        END
    delete from MenuDetails where MenuID = @MenuID and ProductID = @ProductID;
end try
begin catch

end catch
go

