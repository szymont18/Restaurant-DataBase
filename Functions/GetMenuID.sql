create function GetMenuID()
returns int
as
    begin
        Declare @MaxMenuID int = (select max(MenuID) from Menus)
        return @MaxMenuID + 1
    end