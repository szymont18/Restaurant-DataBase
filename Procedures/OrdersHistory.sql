create procedure OrdersHistory @ClientID int
as
select * FROM ClientToMeal WHERE ClientID = @ClientID;
go

