create view ActualMenu as
    select P.ProductID, P.ProductName, P.ProductDescription, P.UnitPrice
    from Menus M
    join MenuDetails MD on M.MenuID = MD.MenuID
    join Products P on P.ProductID = MD.ProductID
    where getdate() between M.StartTime and M.EndTime