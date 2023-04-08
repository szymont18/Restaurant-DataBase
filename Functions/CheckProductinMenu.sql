--Funkcja sprawdza czy dany produkt występuje w Menu
create function CheckProductInMenu(@ProductId as int,
                                   @Date as date)
returns bit
as begin
    if @ProductId in (select FM.ProductID from FutureMenus FM where @Date between FM.StartTime and FM.EndTime) return 1
    return 0
end