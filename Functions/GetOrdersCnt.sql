create function GetOrdersCnt(@ClientID as int)
returns int
as
begin
    return (select max(OrderCounter) from OrdersCounter where ClientID = @ClientID)
end