create procedure ChangeMenuStatus(@MenuID as int,
                                  @ActualStatus as bit)
as
    begin try
        if @MenuID not in (select MenuID from Menus)
        begin
            ;throw 50001, N'There is not Menu with this ID in database', 1
        end

        if @ActualStatus = 1 and dbo.CheckMenuRequirements(@MenuID) = 0
        begin
            print N'Warning ! Changing the status of the illegal Menu to the correct one'
        end

    update Menus
    set IsLegal = @ActualStatus
    where MenuID = @MenuID

    end try
    begin catch
        Declare @msg NVARCHAR(2048) = N'Procedure ChangeMenuStatus error: '+ Error_Message();
            ;throw 50001, @msg, 1
    end catch