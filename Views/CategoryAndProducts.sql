create view CategoryAndProducts as
    select C.CategoryID,C.CategoryName, P.ProductName from Categories C
    join Products P on C.CategoryID = P.CategoryID
