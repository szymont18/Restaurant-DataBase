alter view FutureMenus as
    select M.MenuID, M.StartTime, M.EndTime,P.ProductID, P.ProductName from Menus M
    join MenuDetails MD on M.MenuID = MD.MenuID
    join Products P on P.ProductID = MD.ProductID
    where getdate() <= M.StartTime or getdate() between M.StartTime and M.EndTime