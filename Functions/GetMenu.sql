create function GetMenu(@Date as datetime)
returns table
as
    return select * from FutureMenus where @Date between StartTime and EndTime